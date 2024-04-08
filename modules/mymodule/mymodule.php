<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class MyModule extends Module
{
    public function __construct()
    {
        $this->name = 'mymodule';
        $this->tab = 'administration';
        $this->version = '2.0.1';
        $this->author = 'Minh Huy';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = [
            'min' => '1.7.0.0',
            'max' => '8.99.99',
        ];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->trans('My module', [], 'Modules.Mymodule.Admin');
        $this->description = $this->trans('Description of my module.', [], 'Modules.Mymodule.Admin');

    }

    public function install()
    {
        if (Configuration::get('MYMODULE_NAME') != null) {
            $this->_errors[] = Context::getContext()->getTranslator()->trans('Khong the cai module do trung key config.', [], 'Admin.Modules.Notification');
        }
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }
        return (
            parent::install()
            && Configuration::updateValue('MYMODULE_NAME', 'first value')
            && $this->registerHook('actionModuleInstallAfter')
        );
    }
    public function hookActionModuleInstallAfter()
    {
        // Prevent automatic installation after upload
        // You can display a message or perform any other action here
        die('Module installation disabled. Please manually install modules.');
    }

    public function uninstall()
    {
        return (
            parent::uninstall()
            && Configuration::deleteByName('MYMODULE_NAME')
        );
    }

    /**
     * This method handles the module's configuration page
     * @return string The page's HTML content
     */
    public  function getContent()
    {
        $output = '';

        //this part is  executed only when the form is submitted
        if(Tools::isSubmit('submit'.$this->name)){
            //retrieve the value set by the user
            $configValue = (string)Tools::getValue('MYMODULE_NAME');

            //check that the value is valid
            if(empty($configValue) || !Validate::isGenericName($configValue)){
                //invalid value, show an error
                $output = $this->displayError($this->l('Invalid Configuration value'));
            } else {
                // value is ok, update it and display a confirmation message
                Configuration::updateValue('MYMODULE_NAME',$configValue);
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
                        'type' => 'text',
                        'label' => $this->l('Configuration value'),
                        'name' => 'MYMODULE_NAME',
                        'size' => 20,
                        'required' => true,
                    ],
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
        $helper->submit_action = 'submit'. $this->name;

        //Default language
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');

        //Load current value into the form
        $helper->fields_value['MYMODULE_NAME'] = Tools::getValue('MYMODULE_NAME',Configuration::get('MYMODULE_NAME'));

        return $helper->generateForm([$form]);
    }
}
