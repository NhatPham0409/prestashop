<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class Mwg_ThemeCustom extends Module
{
    const MWG_ISSLIDE = 'HOMEPAGE_PRODUCT_SLIDER';

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

        $this->displayName = $this->trans('MWG theme custom', [], 'Modules.Mwgthemecustom.Admin');
        $this->description = $this->trans('Customize theme module.', [], 'Modules.Mwgthemecustom.Admin');

    }

    public function install()
    {
        if (Configuration::get('MWG_IMAGEWIDTH') != null || Configuration::get('MWG_LAYOUT') != null || Configuration::get('MWG_ISSLIDE') != null || Configuration::get('MWG_NUMOFPRODUCT') != null) {
            $this->_errors[] = Context::getContext()->getTranslator()->trans('Khong the cai module do trung key config.', [], 'Admin.Modules.Notification');
        }
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }
        return (
            parent::install()
            && $this->registerHook(['displayHome', 'MWG_LEFTHOOK', 'MWG_RIGHTHOOK'])
            && Configuration::updateValue('MWG_IMAGEWIDTH', 'normal')
            && Configuration::updateValue('MWG_LAYOUT', 'none_column')
            && Configuration::updateValue('MWG_ISSLIDE', 0)
            && Configuration::updateValue('MWG_NUMOFPRODUCT', 4)
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

        //this part is  executed only when the form is submitted
        if (Tools::isSubmit('submit' . $this->name)) {
            //retrieve the value set by the user
            $imageWidth = (string)Tools::getValue('MWG_IMAGEWIDTH');
            $layout = (string)Tools::getValue('MWG_LAYOUT');
            $isslide = (boolean)Tools::getValue('MWG_ISSLIDE');
            $numofproduct = (int)Tools::getValue('MWG_NUMOFPRODUCT');

            //check that the value is valid
            if (!Validate::isGenericName($imageWidth) || !Validate::isGenericName($layout)) {
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Configuration value'));
            }

            elseif ($numofproduct < 4 || $numofproduct > 10) {
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Number of product value'));
            }

            else {
                // value is ok, update it and display a confirmation message
                Configuration::updateValue('MWG_IMAGEWIDTH', $imageWidth);
                Configuration::updateValue('MWG_LAYOUT', $layout);
                Configuration::updateValue('MWG_ISSLIDE', $isslide);
                Configuration::updateValue('MWG_NUMOFPRODUCT', $numofproduct);
                $output = $this->displayConfirmation($this->displayConfirmation($this->l('Settings updated')));
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
                        'type' => 'switch',
                        'label' => $this->l('Homepage Product Slide'),
                        'name' => 'MWG_ISSLIDE',
                        'is_bool' => true,
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
                            "Number of products to display in slider. Min is 4. Max is 10",
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
        $helper->fields_value['MWG_IMAGEWIDTH'] = Tools::getValue('MWG_IMAGEWIDTH', Configuration::get('MWG_IMAGEWIDTH'));
        $helper->fields_value['MWG_LAYOUT'] = Tools::getValue('MWG_LAYOUT', Configuration::get('MWG_LAYOUT'));
        $helper->fields_value['MWG_ISSLIDE'] = Tools::getValue('MWG_ISSLIDE', Configuration::get('MWG_ISSLIDE'));
        $helper->fields_value['MWG_NUMOFPRODUCT'] = Tools::getValue('MWG_NUMOFPRODUCT', Configuration::get('MWG_NUMOFPRODUCT'));

        return $helper->generateForm([$form]);
    }
}
