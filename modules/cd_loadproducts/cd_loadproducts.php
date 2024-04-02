<?php
// Path: modules/cd_loadproducts/cd_loadproducts.php

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use Symfony\Component\HttpClient\HttpClient;

if (!defined('_PS_VERSION_')) {
    exit;
}

class Cd_LoadProducts extends Module implements WidgetInterface
{
    private $templateFile;

    public function __construct()
    {
        $this->name = 'cd_loadproducts';
        $this->tab = 'front_office_features';
        $this->author = 'Cong Danh';
        $this->version = '1.0.0';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = [
            'min' => '1.7.7.0',
            'max' => _PS_VERSION_,
        ];
        $this->bootstrap = true;

        parent::__construct();
        $this->displayName = $this->trans('Load Products', [], 'Modules.LoadProducts.Admin');
        $this->description = $this->trans('Load products from web to database', [], 'Modules.LoadProducts.Admin');
        $this->confirmUninstall = $this->trans('Are you sure you want to uninstall?', [], 'Modules.LoadProducts.Admin');

        if (!Configuration::get('LOADPRODUCTS')) {
            $this->warning = $this->trans('No name provided', [], 'Modules.LoadProducts.Admin');
        }
        $this->templateFile = 'module:cd_loadproducts/views/templates/hook/cd_loadproducts.tpl';
    }

    public function install()
    {
        //sql
        $sql = 'CREATE TABLE IF NOT EXISTS ' . 'cd_loadproducts
        (
            id VARCHAR(50) NOT NULL,
            title VARCHAR(255),
            image VARCHAR(255),
            rating_star FLOAT,
            release_year INT,
            PRIMARY KEY (id)
        ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=UTF8;';
        Db::getInstance()->execute($sql);

        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return (
            parent::install()
            && Configuration::updateValue('LOADPRODUCTS', 'loadproducts')
            && $this->registerHook('displayHome')
            && $this->processDataFromExternalAPI()
        );
    }

    public function uninstall()
    {
        //sql
        $sql = 'DROP TABLE IF EXISTS ' . 'cd_loadproducts';
        if (Db::getInstance()->execute($sql) == false) {
            return false;
        }

        return (
            parent::uninstall()
            && Configuration::deleteByName('LOADPRODUCTS')
        );
    }

    public function getContent()
    {
        $output = '';
        // Check which form was submitted
        if (Tools::isSubmit('submitSaveSettings')) {
            // Form Settings submitted, process its data
            $output = $this->processFormSettings();
        } elseif (Tools::isSubmit('submitSaveCustomize')) {
            // Form Customize submitted, process its data
            $output = $this->processFormCustomize();
        }
        // Always display the form regardless of whether it was submitted or not
        return $output . $this->displayForm();
    }

    function processFormSettings()
    {
        $output = '';
        $apiUrl = (string) Tools::getValue('URL_API');

        // Check if the value is valid
        if (empty($apiUrl)) {
            // Invalid value, show an error
            $output = $this->displayError($this->l('Invalid value'));
        } else {
            $flag = $this->processDataFromExternalAPI($apiUrl) == 'success' ? true : false;
            if ($flag) {
                $output = $this->displayConfirmation($this->l('Settings updated'));
            } else {
                $output = $this->displayError($this->processDataFromExternalAPI($apiUrl));
            }
        }
        return $output;
    }

    function processFormCustomize()
    {
        $output = '';
        $apiMovie = 'https://www.imdb.com/title/' . (string) Tools::getValue('LIST_MOVIE');
        $flag = $this->processDataFromExternalAPI($apiMovie) == 'success' ? true : false;
        if ($flag) {
            $output = $this->displayConfirmation($this->l('Customization saved'));
        } else {
            $output = $this->displayError($this->processDataFromExternalAPI($apiMovie));
        }
        return $output;
    }

    /**
     * Builds the configuration form
     * @return string HTML code
     */
    public function displayForm()
    {
        // Init Fields form array
        $formSettings = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Settings'),
                ],
                'input' => [
                    [
                        'type' => 'text',
                        'label' => $this->l('API URL'),
                        'name' => 'URL_API',
                        'size' => 50,
                        'required' => true,
                    ],
                ],
                'submit' => [
                    'title' => $this->l('SaveSettings'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ];

        $formCustomize = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Customize'),
                ],
                'input' => [
                    [
                        'type' => 'select',
                        'label' => $this->l('Example movie list'),
                        'name' => 'LIST_MOVIE',
                        'options' => [
                            'query' => [
                                ['id' => '', 'name' => 'Select a movie'],
                                ['id' => 'tt0111161', 'name' => 'The Shawshank Redemption'],
                                ['id' => 'tt0120737', 'name' => 'The Lord of the Rings: The Fellowship of the Ring'],
                                ['id' => 'tt0068646', 'name' => 'The Godfather'],
                                ['id' => 'tt0468569', 'name' => 'The Dark Knight'],
                                ['id' => 'tt0137523', 'name' => 'Fight Club'],
                                ['id' => 'tt0109830', 'name' => 'Forrest Gump'],
                                ['id' => 'tt0167260', 'name' => 'The Lord of the Rings: The Return of the King'],
                                ['id' => 'tt0071562', 'name' => 'The Godfather: Part II'],
                                ['id' => 'tt0167261', 'name' => 'The Lord of the Rings: The Two Towers'],
                                ['id' => 'tt0110912', 'name' => 'Pulp Fiction']
                            ],
                            'id' => 'id',
                            'name' => 'name',
                        ],
                        'required' => false,
                    ],
                ],
                'submit' => [
                    'title' => $this->l('SaveCustomize'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ];

        $helper = new HelperForm();

        // Module, token and currentIndex
        $helper->table = $this->table;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        $helper->submit_action = 'submitSaveSettings'; // for formSettings
        $helper->submit_action = 'submitSaveCustomize'; // for formCustomize
        // Default language
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');

        return $helper->generateForm([$formSettings, $formCustomize]);
    }

    public function renderWidget($hookName, array $configuration)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('cd_loadproducts'))) {
            $variables = $this->getWidgetVariables($hookName, $configuration);
            if (empty($variables)) {
                return false;
            }
            $this->smarty->assign('products', $variables); // Assign 'products' instead of individual variables
        }
        return $this->fetch($this->templateFile);
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        $movies = Db::getInstance()->executeS('SELECT * FROM ' . 'cd_loadproducts');
        $products = [];
        if (!empty($movies)) {
            foreach ($movies as $movie) {
                $products[] = array(
                    'id' => $movie['id'],
                    'title' => $movie['title'],
                    'image' => $movie['image'],
                    'rating_star' => $movie['rating_star'],
                    'release_year' => $movie['release_year'],
                );
            }
        }
        return $products;
    }

    public function processDataFromExternalAPI($url = null)
    {
        if ($url == null) {
            $id = 'tt1553656';
        } else {
            $url = str_replace('https://www.imdb.com/title/', '', $url);
            $id = strtok($url, '/?');
            $checkID = Db::getInstance()->executeS('SELECT * FROM ' . 'cd_loadproducts WHERE id = "' . $id . '"');
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

            // if ($content['message']) {
            //     return $content['message'];
            // }

            $this->insertDataIntoDatabase($content);
            return 'success';
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function insertDataIntoDatabase($data)
    {
        $sql = 'INSERT INTO ' . 'cd_loadproducts (id, title, image,rating_star, release_year) 
        VALUES ("' . $data['id'] . '", "' . $data['title'] . '", "' . $data['image'] . '", "' . $data['rating']['star'] . '", "' . $data['releaseDetailed']['year'] . '")';
        Db::getInstance()->execute($sql);
    }
}
