<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class Mwg_ThemeCustom extends Module
{
    const MWG_ISSLIDE = 'HOMEPAGE_PRODUCT_SLIDER';
    const MIN_PRODUCT_SLIDE = 1;
    const MAX_PRODUCT_SLIDE = 8;

    public function __construct()
    {
        $this->name = 'mwg_themecustom';
        $this->tab = null;
        $this->version = '1.0.0';
        $this->author = 'mwgshop';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = [
            'min' => '1.7.0.0',
            'max' => '8.99.99',
        ];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->trans('MWG theme custom', [], 'Modules.Mwg_themecustom.Admin');
        $this->description = $this->trans('Customize theme module.', [], 'Modules.Mwg_themecustom.Admin');

    }

    public function install()
    {
        if (Configuration::get('MWG_IMAGEWIDTH') != null || Configuration::get('MWG_LAYOUT') != null || Configuration::get('MWG_ISSLIDE') != null || Configuration::get('MWG_NUMOFPRODUCT') != null) {
            $this->_errors[] = Context::getContext()->getTranslator()->trans('Khong the cai module do trung key config.', [], 'Admin.Modules.Notification');
        }

        $id_shop = $this->context->shop->id;
        $id_shop_group = $this->context->shop->id_shop_group;

        return (
            parent::install()
            && Configuration::updateValue('MWG_IMAGEWIDTH', 'normal', false, $id_shop_group, $id_shop)
            && Configuration::updateValue('MWG_LAYOUT', 'none_column', false, $id_shop_group, $id_shop)
            && Configuration::updateValue('MWG_ISSLIDE', 0, false, $id_shop_group, $id_shop)
            && Configuration::updateValue('MWG_NUMOFPRODUCT', 4, false, $id_shop_group, $id_shop)
        );
    }

    public function uninstall()
    {
        return (
            parent::uninstall()
            && Configuration::deleteByName('MWG_IMAGEWIDTH')
            && Configuration::deleteByName('MWG_LAYOUT')
            && Configuration::deleteByName('MWG_ISSLIDE')
            && Configuration::deleteByName('MWG_NUMOFPRODUCT')
        );
    }

    /**
     * This method handles the module's configuration page
     * @return string The page's HTML content
     */
    public function getContent()
    {
        $output = '';
        $id_shop = $this->context->shop->id;
        $id_shop_group = $this->context->shop->id_shop_group;

        //this part is  executed only when the form is submitted
        if (Tools::isSubmit('submit' . $this->name)) {
            //retrieve the value set by the user
            $imageWidth = (string) Tools::getValue('MWG_IMAGEWIDTH');
            $layout = (string) Tools::getValue('MWG_LAYOUT');
            $isslide = (int) Tools::getValue('MWG_ISSLIDE');
            $numofproduct = (int) Tools::getValue('MWG_NUMOFPRODUCT');
            $selectedModules = (array) Tools::getValue('MWG_MODULES');

            //check that the value is valid
            if (!Validate::isGenericName($imageWidth) || !Validate::isGenericName($layout) || !Validate::isInt($numofproduct) || !Validate::isInt($isslide)) {
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Configuration value'));
            }

            if ($layout != 'none_column') {
                if (empty($selectedModules)) {
                    $output = $this->displayError($this->l('Please select at least one module'));
                }
                foreach ($selectedModules as $moduleName) {
                    $module = Module::getInstanceByName($moduleName);
                    if ($module) {
                        $module->registerHook('displayColumn');
                    }
                }
            }

            if ($numofproduct < self::MIN_PRODUCT_SLIDE || $numofproduct > self::MAX_PRODUCT_SLIDE) {
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Number of product value'));
            }

            else {
                // value is ok, update it and display a confirmation message
                Configuration::updateValue('MWG_IMAGEWIDTH', $imageWidth, false, $id_shop_group, $id_shop);
                Configuration::updateValue('MWG_LAYOUT', $layout, false, $id_shop_group, $id_shop);
                Configuration::updateValue('MWG_ISSLIDE', $isslide, false, $id_shop_group, $id_shop);
                Configuration::updateValue('MWG_NUMOFPRODUCT', $numofproduct, false, $id_shop_group, $id_shop);

                $output = $this->displayConfirmation($this->l('Settings updated'));
            }
        }

        //display any message, the the form
        return $output . $this->displayForm();
    }

    /**
     * Builds the configuration form
     * @return string HTML code
     */
    public function displayForm()
    {
        $id_shop = $this->context->shop->id;
        $id_shop_group = $this->context->shop->id_shop_group;

//        $exceptModule = Hook::getHookModuleExecList('displayHome');
//        $exceptModule = array_map(function ($module) {
//            return $module['module'];
//        }, $exceptModule);

        $modules = Module::getModulesInstalled();
//        $modules = array_filter($modules, function ($module) use ($exceptModule) {
//            return $module['active'] == 1 && in_array($module['name'], $exceptModule);
//        });

        $options = [];
        foreach ($modules as $module) {
            $options[] = [
                'id' => $module['name'],
                'name' => $module['name'],
            ];
        }

        usort($options, function($a, $b) {
            return strcmp($a['name'], $b['name']);
        });

        //Init Fields form array
        $form = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Settings'),
                ],
                'input' => [
                    [
                        'type' => 'select',
                        'label' => $this->l('Image Slider Width'),
                        'name' => 'MWG_IMAGEWIDTH',
                        'required' => false,
                        'options' => [
                            'query' => [
                                ['id' => 'full', 'name' => 'FULL'],
                                ['id' => 'normal', 'name' => 'NORMAL'],
                            ],
                            'id' => 'id',
                            'name'=> 'name',
                        ],
                    ],
                    [
                        'type' => 'select',
                        'label' => $this->l('Layout'),
                        'name' => 'MWG_LAYOUT',
                        'required' => false,
                        'options' => [
                            'query' => [
                                ['id' => 'left_column', 'name' => 'LEFT_COLUMN'],
                                ['id' => 'right_column', 'name' => 'RIGHT_COLUMN'],
                                ['id' => 'none_column', 'name' => 'NONE_COLUMN'],
                            ],
                            'id' => 'id',
                            'name'=> 'name',
                        ],
                    ],
                    [
                        'type' => 'select',
                        'label' => $this->l('MODULES'),
                        'name' => 'MWG_MODULES[]',
                        'required' => false,
                        'multiple' => true,
                        'options' => [
                            'query' => $options,
                            'id' => 'id',
                            'name'=> 'name',
                        ],
                    ],
                    [
                        'type' => 'switch',
                        'label' => $this->l('Homepage Product Slide'),
                        'name' => 'MWG_ISSLIDE',
                        'required' => false,
                        'desc' => $this->trans(
                            "Choose Yes and products in homepage will displayed as slider",
                            [],
                            'Modules.Mwgthemecustom.Admin'
                        ),
                        'values' => [
                            [
                                'id' => self::MWG_ISSLIDE . '_on',
                                'value' => 1,
                                'label' => $this->trans('Yes', [], 'Admin.Global'),
                            ],
                            [
                                'id' => self::MWG_ISSLIDE . '_off',
                                'value' => 0,
                                'label' => $this->trans('No', [], 'Admin.Global'),
                            ],
                        ],
                    ],
                    [
                        'type' => 'text',
                        'label' => $this->l('Number of slider products'),
                        'name' => 'MWG_NUMOFPRODUCT',
                        'required' => false,
                        'size' => 10,
                        'desc' => $this->trans(
                            "Number of products to display in slider. Min is 1. Max is 6",
                            [],
                            'Modules.Mwgthemecustom.Admin'
                        ),
                    ]
                ],
                'submit' => [
                    'title' => $this->l('Save'),
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

        //Load current value into the form
        $helper->fields_value['MWG_IMAGEWIDTH'] = Tools::getValue('MWG_IMAGEWIDTH', Configuration::get('MWG_IMAGEWIDTH', null, $id_shop_group, $id_shop)) ?? 'normal';
        $helper->fields_value['MWG_LAYOUT'] = Tools::getValue('MWG_LAYOUT', Configuration::get('MWG_LAYOUT', null, $id_shop_group, $id_shop)) ?? 'none_column';
        $helper->fields_value['MWG_ISSLIDE'] = Tools::getValue('MWG_ISSLIDE', Configuration::get('MWG_ISSLIDE', null, $id_shop_group, $id_shop)) ?? 0;
        $helper->fields_value['MWG_NUMOFPRODUCT'] = Tools::getValue('MWG_NUMOFPRODUCT', Configuration::get('MWG_NUMOFPRODUCT', null, $id_shop_group, $id_shop)) ?? 4;

        return $helper->generateForm([$form]);
    }
}
