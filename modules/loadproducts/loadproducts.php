<?php

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use Symfony\Component\HttpClient\HttpClient;

if (!defined('_PS_VERSION_')) {
    exit;
}

class LoadProducts extends Module implements WidgetInterface
{
    private $templateFile;
    private const TABLE_MOVIES = 'loadmovies';
    private const TABLE_MOVIE_LIST_EXAMPLE = 'movielistexample';

    public function __construct()
    {
        $this->name = 'loadproducts';
        $this->tab = 'front_office_features';
        $this->author = 'Cong Danh';
        $this->version = '1.0.2';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = ['min' => '1.7.7.0', 'max' => _PS_VERSION_];
        $this->bootstrap = true;

        parent::__construct();
        $this->displayName = $this->trans('Load Products', [], 'Modules.LoadProducts.Admin');
        $this->description = $this->trans('Load products from web to database', [], 'Modules.LoadProducts.Admin');
        $this->confirmUninstall = $this->trans('Are you sure you want to uninstall?', [], 'Modules.LoadProducts.Admin');

        if (!Configuration::get('LOADPRODUCTS')) {
            $this->warning = $this->trans('No name provided', [], 'Modules.LoadProducts.Admin');
        }
        $this->templateFile = 'module:loadproducts/views/templates/hook/loadproducts.tpl';
    }

    public function install()
    {
        $sqlQueries = [];
        $sqlQueries[] = 'CREATE TABLE IF NOT EXISTS ' . self::TABLE_MOVIES . '
            (
            imdb_id VARCHAR(20) NOT NULL,
            title VARCHAR(255),
            image VARCHAR(255),
            rating_star DOUBLE PRECISION NOT NULL,
            release_year INT NOT NULL,
            PRIMARY KEY (imdb_id)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=UTF8;';
        $sqlQueries[] = 'CREATE TABLE IF NOT EXISTS ' . self::TABLE_MOVIE_LIST_EXAMPLE . '
            (
            id VARCHAR(20) NOT NULL,
            name VARCHAR(255),
            PRIMARY KEY (id)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=UTF8;';

        foreach ($sqlQueries as $sqlQuery) {
            if (Db::getInstance()->execute($sqlQuery) == false) {
                return false;
            }
        }

        $this->createDataMovieListExample();
        $this->fetchDataFromAPI();
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return (
            parent::install()
            && Configuration::updateValue('LOADPRODUCTS', 'Cong Danh first module configuration')
            && $this->registerHook('displayHome')
        );
    }

    public function uninstall()
    {
        $sqlQueries = [];
        $sqlQueries[] = 'DROP TABLE IF EXISTS ' . self::TABLE_MOVIES;
        $sqlQueries[] = 'DROP TABLE IF EXISTS ' . self::TABLE_MOVIE_LIST_EXAMPLE;
        foreach ($sqlQueries as $sqlQuery) {
            if (Db::getInstance()->execute($sqlQuery) == false) {
                return false;
            }
        }
        return (
            parent::uninstall()
            && Configuration::deleteByName('LOADPRODUCTS')
        );
    }

    public function getContent()
    {
        $output = '';

        // Process form data
        // $output = $this->_postProcess();

        // Always display the form regardless of whether it was submitted or not
        return $output . $this->displayForm();
    }
    /**
     * Builds the configuration form
     * @return string HTML code
     */
    public function displayForm()
    {
        $movies = Db::getInstance()->executeS('SELECT * FROM ' . self::TABLE_MOVIE_LIST_EXAMPLE . ' ORDER BY id ASC');
        foreach ($movies as $movie) {
            $options1[] = ['id' => $movie['id'], 'name' => $movie['name']];
        }

        $type = 'select';
        $type2 = 'hidden';
        $changeMethod = Tools::isSubmit('Change');
        if ($changeMethod == 1) {
            if ($type == 'select' || $type2 == 'hidden') {
                $type = 'hidden';
                $type2 = 'text';
            } else {
                $type = 'select';
                $type2 = 'hidden';
            }
        }


        // Init Fields form array
        $formAdd = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Add movie'),
                ],
                'input' => [
                    [
                        'type' => $type,
                        'label' => $this->l('Example movie list'),
                        'name' => 'LIST_MOVIE',
                        'options' => [
                            'query' => $options1,
                            'id' => 'id',
                            'name' => 'name',
                        ],
                        'required' => false,
                    ],
                    [
                        'type' => $type2,
                        'label' => $this->l('URL(imdb.com)'),
                        'name' => 'URL',
                        'size' => 50,
                        'required' => false,
                    ],
                ],
                'submit' => [
                    'title' => $this->l('Save'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ];

        $loadProducts = Db::getInstance()->executeS('SELECT * FROM ' . self::TABLE_MOVIES . ' ORDER BY id ASC');

        $helper = new HelperForm();

        // Module, token and currentIndex
        $helper->table = $this->table;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        $helper->submit_action = 'btnSubmit';
        // Default language
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');

        return $helper->generateForm([$formAdd]);
    }

    protected function getConfigFormValues()
    {
        return array(
            'ENABLE_ADD_URL' => Tools::getValue('ENABLE_ADD_URL', Configuration::get('ENABLE_ADD_URL', true)),
        );
    }

    public function renderWidget($hookName, array $configuration)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('loadmovies'))) {
            $variables = $this->getWidgetVariables($hookName, $configuration);

            if (empty($variables)) {
                return false;
            }
            $this->smarty->assign('products', $variables); // Assign data to the template file
        }
        return $this->fetch($this->templateFile);
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        // $movies = Db::getInstance()->executeS('SELECT * FROM ' . self::TABLE_MOVIES . ' ORDER BY imdb_id ASC');
        $query = new DbQuery();
        $movies = $query
            ->select('imdb_id', 'title', 'image', 'rating_star', 'release_year')
            ->from(self::TABLE_MOVIES)
            ->orderBy('imdb_id', 'ASC');
        $movies = Db::getInstance()->executeS($movies);
        $products = [];
        if (!empty($movies)) {
            foreach ($movies as $movie) {
                $products[] = array(
                    'id' => $movie['imdb_id'],
                    'title' => $movie['title'],
                    'image' => $movie['image'],
                    'rating_star' => $movie['rating_star'],
                    'release_year' => $movie['release_year'],
                );
            }
        }
        return $products;
    }

    public function fetchDataFromAPI($url = null)
    {
        if ($url == null) {
            return $this->createNullDataLoadProducts();
        } else {
            $url = str_replace('https://www.imdb.com/title/', '', $url);
            $id = strtok($url, '/?');
            $checkID = Db::getInstance()->executeS('SELECT * FROM ' . self::TABLE_MOVIES . ' WHERE id = "' . $id . '"');
            if (!empty($checkID)) {
                return 'This movie has already existed in the database';
            }
        }
        $apiUrl = 'https://imdb-api.tienich.workers.dev/title/' . $id;

        // Create a Symfony HttpClient instance
        $httpClient = HttpClient::create();
        try {
            $response = $httpClient->request('GET', $apiUrl);
            $statusCode = $response->getStatusCode();

            if ($statusCode != 200) {
                return 'Failed to fetch movie data from API';
            }

            $content = $response->getContent();
            $content = $response->toArray();

            $this->insertDataIntoDatabase($content);
            return 'success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function insertDataIntoDatabase($data)
    {
        Db::getInstance()->insert(self::TABLE_MOVIES, [
            'imdb_id' => $data['id'],
            'title' => $data['title'],
            'image' => $data['image'],
            'rating_star' => $data['rating']['star'],
            'release_year' => $data['releaseDetailed']['year']
        ], false, true, Db::INSERT, false);
    }

    public function createDataMovieListExample()
    {
        $listMovie = [
            '' => 'Select movie',
            'tt1553656' => 'Under the Dome',
            'tt0944947' => 'Game of Thrones',
            'tt0903747' => 'Breaking Bad',
            'tt1520211' => 'The Walking Dead',
            'tt0096697' => 'The Simpsons',
            'tt3032476' => 'Better Call Saul',
            'tt2193021' => 'Arrow',
            'tt1632701' => 'Suits',
            'tt0068646' => 'The Godfather',
            'tt0071562' => 'The Godfather: Part II',
            'tt0109830' => 'Forrest Gump',
            'tt0110912' => 'Pulp Fiction',
            'tt0111161' => 'The Shawshank Redemption',
            'tt0137523' => 'Fight Club',
            'tt0120737' => 'The Lord of the Rings: The Fellowship of the Ring',
            'tt0167260' => 'The Lord of the Rings: The Return of the King',
            'tt0167261' => 'The Lord of the Rings: The Two Towers',
            'tt0468569' => 'The Dark Knight'
        ];
        foreach ($listMovie as $id => $name) {
            Db::getInstance()->insert(self::TABLE_MOVIE_LIST_EXAMPLE, [
                'id' => $id,
                'name' => $name
            ], false, true, Db::INSERT, false);
        }
    }

    public function createNullDataLoadProducts()
    {
        Db::getInstance()->insert(self::TABLE_MOVIES, [
            'imdb_id' => 'tt0000000',
            'title' => 'Chúa tể miền tây (Mien tay Lord)',
            'image' => 'https://upload.wikimedia.org/wikipedia/commons/f/fb/Coconut_Palm_Cola_Bay_Goa_Jan19_DSC00303.jpg',
            'rating_star' => 10,
            'release_year' => 2024
        ], false, true, Db::INSERT, false);
    }
}
