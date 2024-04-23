<?php

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use Symfony\Component\HttpClient\HttpClient;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

if (!defined('_PS_VERSION_')) {
    exit;
}

class LoadCatalogs extends Module implements WidgetInterface
{
    private $templateFile;

    public function __construct()
    {
        $this->name = 'loadcatalogs';
        $this->tab = 'front_office_features';
        $this->author = 'Cong Danh';
        $this->version = '1.0.0';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = ['min' => '1.7.7.0', 'max' => _PS_VERSION_];
        $this->bootstrap = true;

        parent::__construct();
        $this->displayName = $this->trans('Load Catalogs', [], 'Modules.LoadCatalogs.Admin');
        $this->description = $this->trans('Load catalogs from web to database', [], 'Modules.LoadCatalogs.Admin');
        $this->confirmUninstall = $this->trans('Are you sure you want to uninstall?', [], 'Modules.LoadCatalogs.Admin');

        if (!Configuration::get('LOADCATALOGS')) {
            $this->warning = $this->trans('No name provided', [], 'Modules.LoadCatalogs.Admin');
        }
        $this->templateFile = 'module:loadcatalogs/loadcatalogs.tpl';
    }

    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return (
            parent::install()
            && Configuration::updateValue('LOADCATALOGS', 'Cong Danh first module configuration')
        );
    }

    public function uninstall()
    {
        return (
            parent::uninstall()
            && Configuration::deleteByName('LOADCATALOGS')
        );
    }

    public function renderWidget($hookName, array $configuration)
    {
        // $this->smarty->assign([
        //     'menu' => $this->getWidgetVariables($hookName, $configuration),
        // ]);

        // return $this->fetch('module:ps_mainmenu/ps_mainmenu.tpl');
        return $this->fetch($this->templateFile);
    }

    // public function getWidgetVariables($hookName, array $configuration)
    // {
    //     $query = new DbQuery();
    //     $movies = $query
    //         ->select('imdb_id', 'title', 'image', 'rating_star', 'release_year')
    //         ->from(self::TABLE_MOVIES)
    //         ->orderBy('imdb_id', 'ASC');
    //     $movies = Db::getInstance()->executeS($movies);
    //     $products = [];
    //     if (!empty($movies)) {
    //         foreach ($movies as $movie) {
    //             $products[] = array(
    //                 'id' => $movie['imdb_id'],
    //                 'title' => $movie['title'],
    //                 'image' => $movie['image'],
    //                 'rating_star' => $movie['rating_star'],
    //                 'release_year' => $movie['release_year'],
    //             );
    //         }
    //     }
    //     return $products;
    // }
    private function getCurrentPageIdentifier()
    {
        $controllerName = Dispatcher::getInstance()->getController();
        if ($controllerName === 'cms' && ($id = Tools::getValue('id_cms'))) {
            return 'cms-page-' . $id;
        } elseif ($controllerName === 'category' && ($id = Tools::getValue('id_category'))) {
            return 'category-' . $id;
        } elseif ($controllerName === 'cms' && ($id = Tools::getValue('id_cms_category'))) {
            return 'cms-category-' . $id;
        } elseif ($controllerName === 'manufacturer' && ($id = Tools::getValue('id_manufacturer'))) {
            return 'manufacturer-' . $id;
        } elseif ($controllerName === 'manufacturer') {
            return 'manufacturers';
        } elseif ($controllerName === 'supplier' && ($id = Tools::getValue('id_supplier'))) {
            return 'supplier-' . $id;
        } elseif ($controllerName === 'supplier') {
            return 'suppliers';
        } elseif ($controllerName === 'product' && ($id = Tools::getValue('id_product'))) {
            return 'product-' . $id;
        } elseif ($controllerName === 'index') {
            return 'shop-' . $this->context->shop->id;
        } else {
            $scheme = 'http';
            if (array_key_exists('REQUEST_SCHEME', $_SERVER)) {
                $scheme = $_SERVER['REQUEST_SCHEME'];
            }

            return "$scheme://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        }
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        $id_lang = $this->context->language->id;
        $id_shop = $this->context->shop->id;

        // $this->user_groups = Customer::getGroupsStatic($this->context->customer->id);
        // $groupsKey = empty($this->user_groups) ? '' : '_' . join('_', $this->user_groups);
        // $key = self::MENU_JSON_CACHE_KEY . '_' . $id_lang . '_' . $id_shop . $groupsKey . '.json';
        $cacheDir = $this->getCacheDirectory();
        $cacheFile = $cacheDir . DIRECTORY_SEPARATOR . $key;
        $menu = json_decode(@file_get_contents($cacheFile), true);
        if (!is_array($menu) || json_last_error() !== JSON_ERROR_NONE) {
            $menu = $this->makeMenu();
            if (!is_dir($cacheDir)) {
                mkdir($cacheDir);
            }
            file_put_contents($cacheFile, json_encode($menu));
        }

        $page_identifier = $this->getCurrentPageIdentifier();
        // Mark the current page
        return $this->mapTree(function (array $node) use ($page_identifier) {
            $node['current'] = ($page_identifier === $node['page_identifier']);

            return $node;
        }, $menu);
    }

    function getContent()
    {
        $output = null;

        //this part is  executed only when the form is submitted
        if (Tools::isSubmit('submit' . $this->name)) {
            //retrieve the value set by the user
            $apiUrl = Tools::getValue('categories');

            if (empty($apiUrl)) {
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Configuration value'));
                return $output .= $this->renderFormSync() . $this->renderFormCategoryList();
            }

            $httpClient = HttpClient::create();
            $response = $httpClient->request('GET', $apiUrl);
            $statusCode = $response->getStatusCode();

            if ($statusCode != 200) {
                $output = $this->displayError('Failed to fetch movie data from API');
                return $output .= $this->renderFormSync() . $this->renderFormCategoryList();
            }

            try {
                $content = $response->getContent();
                $apiData = json_decode($content, true);

                if (Tools::getValue('DELETE_ALL_DATA_BEFORE_SYNC_CATEGORIES')) {
                    $this->deleteAllCategory();
                }
                $this->syncCategoriesFromAPI($apiData);
            } catch (ClientExceptionInterface | ServerExceptionInterface | RedirectionExceptionInterface | TransportExceptionInterface | Exception $e) {
                $output = $this->displayError($this->l("Failed to sync categories from API\n" . $e->getMessage()));
                return $output .= $this->renderFormSync() . $this->renderFormCategoryList();
            }
            $output = $this->displayConfirmation($this->l('Sync successfully'));
        }

        //display any message,
        return $output .= $this->renderFormSync() . $this->renderFormCategoryList();
    }

    /**
     * Builds the configuration form
     * @return string HTML code
     */
    public function renderFormSync(): string
    {
        //Init Fields form array
        $form = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Sync categories from API'),
                ],
                'input' => [
                    [
                        'type' => 'text',
                        'label' => $this->l('Categories API URL'),
                        'name' => 'categories',
                        'size' => 2000,
                        'required' => true,
                    ],
                    [
                        'type' => 'switch',
                        'label' => $this->trans('Delete all category before sync data', [], ''),
                        'name' => 'DELETE_ALL_DATA_BEFORE_SYNC_CATEGORIES',
                        'desc' => $this->trans('', [], ''),
                        'values' => [
                            [
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Yes', [], ''),
                            ],
                            [
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('No', [], ''),
                            ],
                        ],
                    ],
                    [
                        'type' => 'switch',
                        'label' => $this->trans('Force all ID numbers', [], ''),
                        'name' => 'FORCE_ALL_ID_NUMBERS',
                        'desc' => $this->trans('Enable this option to keep your category ID number as is. Otherwise, ID will be ignored and create auto-incremented ID numbers.', [], ''),
                        'values' => [
                            [
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Yes', [], ''),
                            ],
                            [
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('No', [], ''),
                            ],
                        ],
                    ],
                ],
                'submit' => [
                    'title' => $this->l('Sync'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],

        ];

        $helper = new HelperForm();

        //Module, token and currentIndex
        $helper->table = $this->table;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        $helper->submit_action = 'submit' . $this->name;

        //Default language
        $helper->default_form_language = (int)Configuration::get('PS_LANG_DEFAULT');

        return $helper->generateForm([$form]);
    }
    public function renderFormCategoryList()
    {
        $shops = Shop::getContextListShopID();

        if (count($shops) == 1) {
            $fields_form = [
                'form' => [
                    'legend' => [
                        'title' => $this->trans('Api Data', [], 'Modules.LoadCatalogs.Admin'),
                    ],
                    'input' => [
                        [
                            'type' => 'checkbox',
                            'label' => '',
                            'name' => 'link',
                            'lang' => true,
                        ],
                    ],
                    'submit' => [
                        'name' => 'submitBlocktopmenu',
                        'title' => $this->trans('Save', [], 'Admin.Actions'),
                    ],
                ],
            ];
        } else {
            $fields_form = [
                'form' => [
                    'legend' => [
                        'title' => $this->trans('Api Data', [], 'Modules.LoadCatalogs.Admin'),
                    ],
                    'info' => '<div class="alert alert-warning">' .
                        $this->trans('All active products combinations quantities will be changed', [], 'Modules.LoadCatalogs.Admin') . '</div>',
                    'submit' => [
                        'name' => 'submitBlocktopmenu',
                        'title' => $this->trans('Apply', [], 'Admin.Actions'),
                    ],
                ],
            ];
        }

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int) Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->module = $this;
        $helper->identifier = $this->identifier;
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false) .
            '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = [
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'choices' => $this->renderChoicesSelect(),
        ];

        return $helper->generateForm([$fields_form]);
    }

    public function renderChoicesSelect()
    {

        // $html = '<select multiple="multiple" id="availableItems" style="width: 300px; height: 160px;">';

        // BEGIN Categories
        $html = '<div label="' . $this->trans('Categories', [], 'Admin.Global') . '">';
        $shops_to_get = Shop::getContextListShopID();

        foreach ($shops_to_get as $shop_id) {
            $html .= $this->generateCategoriesOption($this->checkboxGetNestedCategories());
        }
        $html .= '</div>';
        // $html .= '</select>';

        return $html;
    }

    protected function generateCategoriesOption($categories)
    {
        $html = '';

        foreach ($categories as $key => $category) {

            (object) Shop::getShop((int) $category['id_shop']);
            // $html .= '<option value="CAT' . (int) $category['id_category'] . '">'
            //     . str_repeat('&nbsp;', 5 * (int) $category['level_depth']) . $category['name'] . ' (' . $shop->name . ')</option>';
            $html .= '<input type="checkbox" value="CAT' . (int) $category['id_category'] . '">'
                . str_repeat('&nbsp;', 5 * (int) $category['level_depth']) . $category['name'] . '</input>';
            $html .= '<br>';


            if (isset($category['children']) && !empty($category['children'])) {
                $html .= $this->generateCategoriesOption($category['children']);
            }
        }

        return $html;
    }

   /**
     * @throws PrestaShopException
     * @throws PrestaShopDatabaseException
     */
    private function checkboxGetNestedCategories($root_category = null, $active = true, $groups = null, $sql_sort = '')
    {
        $currentLanguageId = Context::getContext()->language->id;
        $currentShopId = Context::getContext()->shop->id;

        if (isset($root_category) && !Validate::isInt($root_category)) {
            exit(Tools::displayError());
        }

        if (!Validate::isBool($active)) {
            exit(Tools::displayError());
        }

        if (isset($groups) && Group::isFeatureActive() && !is_array($groups)) {
            $groups = (array)$groups;
        }

        $cache_id = 'Category::checkboxGetNestedCategories_' . md5($currentShopId . (int)$root_category . $currentLanguageId . (int)$active
                . (isset($groups) && Group::isFeatureActive() ? implode('', $groups) : ''));

        if (!Cache::isStored($cache_id)) {
            $result = Db::getInstance()->executeS('
       SELECT c.*, cl.*
    FROM ' . _DB_PREFIX_ . 'category c
    INNER JOIN ' . _DB_PREFIX_ . 'category_shop category_shop ON (category_shop.`id_category` = c.`id_category` AND category_shop.`id_shop` = ' . $currentShopId . ')
    LEFT JOIN ' . _DB_PREFIX_ . 'category_lang cl ON (c.`id_category` = cl.`id_category` AND cl.`id_shop` = "' . $currentShopId . '")
    WHERE cl.`id_lang` = ' . $currentLanguageId . '
    ' . ($active ? ' AND (c.`active` = 1 OR c.`is_root_category` = 1)' : '') . '
    ' . (isset($groups) && Group::isFeatureActive() ? ' AND cg.`id_group` IN (' . implode(',', $groups) . ')' : '') . '
    ' . ((isset($groups) && Group::isFeatureActive()) ? ' GROUP BY c.`id_category`' : '') . '
    ' . ($sql_sort != '' ? $sql_sort : ' ORDER BY c.`level_depth` ASC') . '
    ' . ($sql_sort == '' ? ', category_shop.`position` ASC' : '')
            );

            $categories = [];
            $buff = [];

            foreach ($result as $row) {
                $current = &$buff[$row['id_category']];
                $current = $row;

                if ($row['id_parent'] == 0) {
                    $categories[$row['id_category']] = &$current;
                } else {
                    $buff[$row['id_parent']]['children'][$row['id_category']] = &$current;
                }
            }

            Cache::store($cache_id, $categories);
        }

        return Cache::retrieve($cache_id);
    }

    /**
     * @throws Exception
     */
    private function syncCategoriesFromAPI($apiData): void
    {
        $allCategories = Category::getCategories(Context::getContext()->language->id, true, true, "AND c.id_category NOT IN (1, 2)");

        // Create an array of keys of existing categories (name_id_parent)
        $categoriesDB_ArrayKey = [];
        foreach ($allCategories as $category_item) {
            foreach ($category_item as $info => $item) {
                foreach ($item as $key => $val) {
                    $categoriesDB_ArrayKey[] = $val['name'] . '_' . $val['id_parent'];
                }
            }
        }

        $stack = [];
        $categoriesAPI_ArrayKey = [];   // Array of keys of API response categories (name_id_parent)

        foreach ($apiData as $value) {
            $existingCategories = Category::searchByNameAndParentCategoryId(Context::getContext()->language->id, $value['name'], 2);
            $categoryId = null;

            if (is_array($existingCategories)) {
                $categoryId = $existingCategories['id_category'];
                $categoriesAPI_ArrayKey[] = $value['name'] . '_2';

                // Activate category existing in DB
                $updatedCategory = $this->validCategory($categoryId, $value);
                $updatedCategory->update();
            } else {
                $categoryId = $this->addNewCategory($value, 2);
            }

            if ($categoryId !== false) {
                if (isset($value['childs'])) {
                    $stack[$categoryId] = $value;
                }

                while (sizeof($stack) > 0) {
                    $element = current($stack);

                    foreach ($element['childs'] as $child) {
                        $parentId = key($stack);
                        $existingSubCategories = Category::searchByNameAndParentCategoryId(Context::getContext()->language->id, $child['name'], $parentId);

                        if (!empty($existingSubCategories)) {
                            $subCategoryId = $existingSubCategories['id_category'];
                            $subcategoryKey = $child['name'] . '_' . $parentId;
                            $categoriesAPI_ArrayKey[] = $subcategoryKey;
                            $updatedCategory = $this->validCategory($subCategoryId, $child);
                            $updatedCategory->update();
                        } else {
                            $subCategoryId = $this->addNewCategory($child, $parentId);
                        }

                        if (isset($child['childs'])) {
                            $stack[$subCategoryId] = $child;
                        }
                    }
                    unset($stack[key($stack)]);
                }
            }
        }

        // Compare categories in DB and API response
        // Get rest of categories that are not in the API response
        $categoriesToDeactivate = array_diff($categoriesDB_ArrayKey, $categoriesAPI_ArrayKey);

        // Deactivate categories that are not in the API response
        foreach ($categoriesToDeactivate as $categoryNameAndParentId) {
            list($deactivateName, $deactivateParentId) = explode('_', $categoryNameAndParentId);
            $categoryToDeactivate = Category::searchByNameAndParentCategoryId(Context::getContext()->language->id, $deactivateName, $deactivateParentId);
            $categoryToDeactivate = new Category($categoryToDeactivate['id_category']);
            $categoryToDeactivate->active = 0;
            $categoryToDeactivate->update();
        }
    }

    /**
     * @throws Exception
     */
    protected function validCategory($categoryId, $value)
    {
        if ($categoryId == null) {
            $category = new Category(null, null, Context::getContext()->shop->id);
        } else {
            $category = new Category($categoryId);
        }
        $category->active = isset($value['active']) ? $value['active'] : 1;

        $invalid = '<>;=#{}';

        if (isset($value['description']) && !strpbrk($value['description'], $invalid))
            $category->description = array(Context::getContext()->language->id => "<p>" . $value['description']);

        if (isset($value['additional_description']) && !strpbrk($value['additional_description'], $invalid))
            $category->additional_description = array(Context::getContext()->language->id => "<p>" . $value['additional_description']);

        if (isset($value['meta_title']))
            $category->meta_title = array(Context::getContext()->language->id => $value['meta_title']);

        if (isset($value['meta_description']))
            $category->meta_description = array(Context::getContext()->language->id => $value['meta_description']);

        if (isset($value['meta_keywords']))
            $category->meta_keywords = array(Context::getContext()->language->id => $value['meta_keywords']);
        return $category;
    }

    /**
     * @throws Exception
     */
    protected function addNewCategory($value, $parentId)
    {
        // $category = new Category(null, null, Context::getContext()->shop->id);
        $category = $this->validCategory(null, $value);
        $category->id_parent = $parentId;
        $category->link_rewrite = array(Context::getContext()->language->id => Tools::str2url($value['name']));
        $category->name = array(Context::getContext()->language->id => $value['name']);
        $category->id_shop_list = array($this->context->shop->id);
        $category->id_shop_default = (int) Context::getContext()->shop->id;

        if ($category->add()) {
            $newCategory = Category::searchByNameAndParentCategoryId(Context::getContext()->language->id, $value['name'], $parentId);

            foreach ($this->context->shop->getShops(true) as $shop) {
                if ($shop['id_shop'] != Context::getContext()->shop->id) {
                    $sql = Db::getInstance()->delete('category_shop', 'id_category = ' . $newCategory['id_category'] . ' AND id_shop = ' . $shop['id_shop']);

                    if (!$sql) {
                        return false;
                    }
                }
            }
            return $newCategory['id_category'];
        }
    }

    /**
     * @throws Exception
     */
    protected function deleteAllCategory(): void
    {
        $importDeleter = $this->get('prestashop.adapter.import.entity_deleter');
        $importDeleter->deleteAll(0);
    }
}
