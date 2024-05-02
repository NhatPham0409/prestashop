<?php

use Symfony\Component\HttpClient\HttpClient;

session_start();

if (!defined('_PS_VERSION_')) {
    exit;
}

class MWG_LoadCatalogs extends Module
{
    public function __construct()
    {
        $this->name = 'mwg_loadcatalogs';
        $this->tab = 'others';
        $this->author = 'mwgshop';
        $this->version = '1.0.0';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = ['min' => '1.7.7.0', 'max' => _PS_VERSION_];
        $this->bootstrap = true;

        parent::__construct();
        $this->displayName = $this->trans('MWG load catalogs', [], 'Modules.MWG_LoadCatalogs.Admin');
        $this->description = $this->trans('Load catalogs api to database', [], 'Modules.MWG_LoadCatalogs.Admin');
        $this->confirmUninstall = $this->trans('Are you sure you want to uninstall?', [], 'Modules.MWG_LoadCatalogs.Admin');

        if (!Configuration::get('LOADCATALOGS')) {
            $this->warning = $this->trans('No name provided', [], 'Modules.MWG_LoadCatalogs.Admin');
        }
    }

    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return (
            parent::install()
            && $this->installNewDatabase()
        );
    }

    public function uninstall()
    {
        return (
            parent::uninstall()
            && $this->uninstallDatabase()
        );
    }

    private function installNewDatabase(): bool
    {
        $queries = [
            'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'category_map_id` (
              `id_category_table` int(11) NOT NULL,
              `id_category_api` int(11) NOT NULL,
              PRIMARY KEY (`id_category_table`,`id_category_api`)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;',
        ];

        return $this->executeQueries($queries);
    }

    private function uninstallDatabase(): bool
    {
        $queries = [
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'category_map_id`',
        ];

        return $this->executeQueries($queries);
    }

    private function executeQueries(array $queries): bool
    {
        foreach ($queries as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }
        return true;
    }

    public function getContent()
    {
        $output = null;
        $apiData = null;
        if (Tools::isSubmit('submitCheckApiData')) {
            $apiUrl = Tools::getValue('categories');

            if (empty($apiUrl)) {
                $output = $this->displayError($this->l('Invalid Configuration value'));
                return $output .= $this->renderFormSync();
            }

            $httpClient = HttpClient::create();
            $response = $httpClient->request('GET', $apiUrl);
            $statusCode = $response->getStatusCode();

            if ($statusCode != 200) {
                $output = $this->displayError('Failed to fetch categories data from API');
                return $output .= $this->renderFormSync();
            }

            try {
                $content = $response->getContent();
                $apiData = json_decode($content, true);
                $_SESSION['apiData'] = $apiData;

                if (Tools::getValue('DELETE_ALL_DATA_BEFORE_SYNC_CATEGORIES') && !empty($apiData)) {
                    $this->deleteAllCategory();
                    $this->deleteAllCategoryGroup();
                    $this->deleteAllCategoryMapId();
                }
            } catch (Exception $e) {
                $output = $this->displayError($this->l("Failed to sync categories from API\n" . $e->getMessage()));
                return $output .= $this->renderFormSync();
            }
            return $output .= $this->renderFormSync() . $this->renderFormCategoryList($apiData);
        }
        if (Tools::isSubmit('submitSave')) {
            $selectedCategories = Tools::getValue('category', []);
            $apiData = $this->addActiveField($_SESSION['apiData'], $selectedCategories);

            $this->syncCategoriesFromAPI($apiData);
            $output = $this->displayConfirmation($this->l('Save successfully'));
            return $output .= $this->renderFormSync();
        }
        return $output .= $this->renderFormSync();
    }

    private function addActiveField($apiData, $selectedCategories): array
    {
        $newApiData = $apiData;
        if (empty($newApiData)) {
            return [];
        }
        foreach ($newApiData as $key => $value) {
            if (in_array($value['id'], $selectedCategories)) {
                $newApiData[$key]['active'] = 1;
            } else {
                $newApiData[$key]['active'] = 0;
            }
            if (isset($value['children'])) {
                $newApiData[$key]['children'] = $this->addActiveField($value['children'], $selectedCategories);
            }
        }
        return $newApiData;
    }

    private function renderFormSync(): string
    {
        $form = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Fetch categories from API'),
                    'icon' => 'icon-cogs',
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
                ],
                'submit' => [
                    'name' => 'submitCheckApiData',
                    'title' => $this->l('Check API data'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],

        ];

        $helper = new HelperForm();
        $helper->table = $this->table;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        $helper->default_form_language = (int)Configuration::get('PS_LANG_DEFAULT');

        return $helper->generateForm([$form]);
    }

    private function renderFormCategoryList($data)
    {
        $form = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Checkbox Tree'),
                    'icon' => 'icon-tree',
                ],
                'input' => [
                    [
                        'type' => 'html',
                        'label' => $this->l('      '),
                        'name' => 'category_tree',
                        'html_content' => '<div class="checkbox-tree">' . $this->generateCheckboxTreeHtml($data) . '</div>',
                    ]
                ],
                'submit' => [
                    'name' => 'submitSave',
                    'title' => $this->l('Sync'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ];

        $helper = new HelperForm();
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->default_form_language = (int)Configuration::get('PS_LANG_DEFAULT');

        $cssLink = '<link rel="stylesheet" type="text/css" href="' . _MODULE_DIR_ . 'mwg_loadcatalogs/css/treebox.css">';
        $jsScript = '<script type="text/javascript" src="' . _MODULE_DIR_ . 'mwg_loadcatalogs/js/treebox.js"></script>';

        return $cssLink . $jsScript . $helper->generateForm([$form]);
    }

    /**
     * Generate HTML for the checkbox tree recursively
     *
     * @param array $data
     * @param int $level
     * @return string
     */
    private function generateCheckboxTreeHtml($data, $level = 0)
    {
        $html = '';

        foreach ($data as $item) {
            if (isset($item['active']) && $item['active'] == 0) {
                $isChecked = '';
                $treeSelected = '';
            } else {
                $isChecked = 'checked';
                $treeSelected = 'tree-selected';
            }

            $count = '';
            if (isset($item['children'])) {
                $count = ' (' . $this->countCategories($item['children']) . ' selection)';
            }

            if ($level == 0) {
                $html .= '<div class="all-select">';
                $html .= '<input type="radio" name="check-all"><label for="checkAll">Check All</label>';
                $html .= '<input type="radio" name="uncheck-all"><label for="uncheckAll">Uncheck All</label>';
                $html .= '</div>';
                $html .= '<span class="tree-box tree-selected"' . '>';
                $html .= '<text type="title" name="category[]"> ' . '<i class="icon-home"></i>' . '<label class="tree-toggler">' . htmlspecialchars((string)Category::getRootCategory()->name) . ' (' . $this->countCategories($data) . ' selection)' . '</label>' . '<br>';
                $html .= '</span>';
                $level++;
            }
            $html .= str_repeat("&nbsp;&nbsp;&nbsp;&nbsp;", $level);
            $html .= '<span class="tree-box ' . $treeSelected . '"' . '>';
            $html .= '<input type="checkbox" name="category[]" value="' . $item['id'] . '" ' . $isChecked . '> ' . '<label class="tree-toggler">' . htmlspecialchars($item['name']) . $count . '</label>' . '<br>';
            $html .= '</span>';

            if (!empty($item['children'])) {
                $html .= $this->generateCheckboxTreeHtml($item['children'], $level + 1);
            }
        }
        return $html;
    }

    private function countCategories($data): int
    {
        $count = 0;
        $queue = $data;
        if (empty($queue)) {
            return 0;
        }

        while (sizeof($queue) > 0) {
            $element = current($queue);
            $count++;
            foreach ($element['children'] as $child) {
                $queue[] = $child;
            }
            unset($queue[key($queue)]);
        }
        return $count;
    }

    private function syncCategoriesFromAPI($apiData): void
    {
        $currentShopId = Context::getContext()->shop->id;
        $currentLanguageId = Context::getContext()->language->id;
        $allCategories = Category::getCategories($currentLanguageId, true, true, "AND c.id_category NOT IN (1, 2)");

        // Create an array of keys of existing categories (name_id_parent)
        $categoriesDB_ArrayKey = [];
        foreach ($allCategories as $category_item) {
            foreach ($category_item as $item) {
                foreach ($item as $val) {
                    $categoriesDB_ArrayKey[] = $val['name'] . '_' . $val['id_parent'];
                }
            }
        }

        $stack = [];
        $categoriesAPI_ArrayKey = [];   // Array of keys of API response categories (name_id_parent)

        foreach ($apiData as $value) {
            $existingCategories = $this->searchCurrentShopCategoryByNameAndParentCategoryId($currentLanguageId, $value['name'], 2, $currentShopId);
            $categoryId = null;

            if (is_array($existingCategories) && !empty($existingCategories)) {
                $categoryId = $existingCategories['id_category'];
                $categoriesAPI_ArrayKey[] = $value['name'] . '_2';

                // Activate category existing in DB
                $updateCategory = $this->validCategory($categoryId, $value);
                $updateCategory->update();
            } else {
                $categoryId = $this->addNewCategory($value, 2);
            }

            if ($categoryId !== false) {
                if (isset($value['children'])) {
                    $stack[$categoryId] = $value;
                }

                while (sizeof($stack) > 0) {
                    $element = current($stack);

                    foreach ($element['children'] as $child) {
                        $parentId = key($stack);
                        $existingSubCategories = $this->searchCurrentShopCategoryByNameAndParentCategoryId($currentLanguageId, $child['name'], $parentId, $currentShopId);

                        if (!empty($existingSubCategories) && is_array($existingSubCategories)) {
                            $subCategoryId = $existingSubCategories['id_category'];
                            $subcategoryKey = $child['name'] . '_' . $parentId;
                            $categoriesAPI_ArrayKey[] = $subcategoryKey;

                            $updateCategory = $this->validCategory($subCategoryId, $child);
                            $updateCategory->update();
                        } else {
                            $subCategoryId = $this->addNewCategory($child, $parentId);
                        }

                        if (isset($child['children'])) {
                            $stack[$subCategoryId] = $child;
                        }
                    }
                    unset($stack[key($stack)]);
                }
            }
        }

        $categoriesToDeactivate = array_diff($categoriesDB_ArrayKey, $categoriesAPI_ArrayKey);

        foreach ($categoriesToDeactivate as $categoryNameAndParentId) {
            list($deactivateName, $deactivateParentId) = explode('_', $categoryNameAndParentId);
            $categoryToDeactivate = Category::searchByNameAndParentCategoryId(Context::getContext()->language->id, $deactivateName, $deactivateParentId);
            $categoryToDeactivate = new Category($categoryToDeactivate['id_category']);
            $categoryToDeactivate->active = 0;
            $categoryToDeactivate->update();
        }
    }

    private function validCategory($categoryId, $value)
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
     * Retrieve category by name and parent category id.
     *
     * @param int $idLang Language ID
     * @param string $categoryName Searched category name
     * @param int $idParentCategory parent category ID
     *
     * @return array Corresponding category
     */
    private function searchCurrentShopCategoryByNameAndParentCategoryId($idLang, $categoryName, $idParentCategory, $idShop)
    {
        return Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow('
		SELECT c.*, cl.*
		FROM `' . _DB_PREFIX_ . 'category` c
		LEFT JOIN `' . _DB_PREFIX_ . 'category_lang` cl
			ON (c.`id_category` = cl.`id_category`
			AND `id_lang` = ' . (int)$idLang . Shop::addSqlRestrictionOnLang('cl') . ')
		WHERE `name` = \'' . pSQL($categoryName) . '\'
			AND c.`id_category` != ' . (int)Configuration::get('PS_HOME_CATEGORY') . '
			AND c.`id_parent` = ' . (int)$idParentCategory . '
			AND c.`id_shop_default` = ' . (int)$idShop);
    }

    private function addNewCategory($value, $parentId)
    {
        $currentShopId = Context::getContext()->shop->id;
        $currentLanguageId = Context::getContext()->language->id;

        $category = $this->validCategory(null, $value);
        $category->id_parent = $parentId;
        $category->link_rewrite = array($currentLanguageId => Tools::str2url($value['name']));
        $category->name = array($currentLanguageId => $value['name']);

        $category->id_shop_list = array($currentShopId);
        $category->id_shop_default = (int)$currentShopId;

        if ($category->add()) {
            $newCategory = $this->searchCurrentShopCategoryByNameAndParentCategoryId($currentLanguageId, $value['name'], $parentId, $currentShopId);

            foreach ($this->context->shop->getShops() as $shop) {
                if ($shop['id_shop'] != $currentShopId) {
                    $sql1 = Db::getInstance()->delete('category_shop', 'id_category = ' . $newCategory['id_category'] . ' AND id_shop = ' . $shop['id_shop']);
                    $sql2 = Db::getInstance()->delete('category_lang', 'id_category = ' . $newCategory['id_category'] . ' AND id_shop = ' . $shop['id_shop']);

                    if (!$sql1 || !$sql2) {
                        return false;
                    }
                }
            }

            $sql = DB::getInstance()->insert('category_map_id', ['id_category_table' => $newCategory['id_category'], 'id_category_api' => $value['id']]);

            if (!$sql) {
                return false;
            }

            return $newCategory['id_category'];
        }

        return false;
    }

    private function deleteAllCategory(): void
    {
        $importDeleter = $this->get('prestashop.adapter.import.entity_deleter');
        $importDeleter->deleteAll(0);
    }

    private function deleteAllCategoryGroup(): void
    {
        DB::getInstance()->delete('category_group', 'id_category > 2');
    }

    private function deleteAllCategoryMapId(): void
    {
        DB::getInstance()->delete('category_map_id');
    }
}
