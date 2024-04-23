<?php

/**
 * 2007-2020 PrestaShop SA and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

// $autoloadPath = __DIR__ . '/vendor/autoload.php';
// if (file_exists($autoloadPath)) {
//     require_once $autoloadPath;
// }

class mwg_searchbyapi extends Module
{
    /**
     * @var string Name of the module running on PS 1.6.x. Used for data migration.
     */
    const PS_16_EQUIVALENT_MODULE = 'blocksearch';


    public function __construct()
    {

        $this->name = 'mwg_searchbyapi';
        $this->tab = 'front_office_features';
        $this->author = 'NHAT_TRONG';
        $this->version = '1.0.0';
        $this->need_instance = 0;

        parent::__construct();
        $this->bootstrap = true;

        $this->displayName = $this->trans('Search By API', [], 'Modules.Searchbar.Admin');
        $this->description = $this->trans('Help your visitors find what they are looking for, add a quick search field to your store.', [], 'Modules.Searchbar.Admin');

        $this->ps_versions_compliancy = ['min' => '1.7.8.0', 'max' => _PS_VERSION_];
    }

    public function install()
    {
        // Migrate data from 1.6 equivalent module (if applicable), then uninstall
        if (Module::isInstalled(self::PS_16_EQUIVALENT_MODULE)) {
            $oldModule = Module::getInstanceByName(self::PS_16_EQUIVALENT_MODULE);
            if ($oldModule) {
                $oldModule->uninstall();
            }
        }

        return parent::install()
            && $this->registerHook('displayTop')
            && $this->registerHook('displaySearch')
            && $this->registerHook('displayHeader');
    }

    public function hookDisplayHeader()
    {
        $this->context->controller->addJqueryUI('ui.autocomplete');
        $this->context->controller->registerStylesheet('modules-searchbar', 'modules/' . $this->name . '/mwg_searchbyapi.css');
        $this->context->controller->registerJavascript('modules-searchbar', 'modules/' . $this->name . '/mwg_searchbyapi.js', ['position' => 'bottom', 'priority' => 150]);
    }

    public function getContent()
    {
        $output = '';

        // this part is executed only when the form is submitted
        if (Tools::isSubmit('submit' . $this->name)) {
            // retrieve the value set by the user
            $configValue = (string) Tools::getValue('SEARCH_API');

            // check that the value is valid

            // value is ok, update it and display a confirmation message
            Configuration::updateValue('SEARCH_API', $configValue, false, $this->context->shop->id_shop_group, $this->context->shop->id);
            $output = $this->displayConfirmation($this->l('Settings updated'));
        }

        // display any message, then the form
        return $output . $this->displayForm();
    }

    public function displayForm()
    {
        // Init Fields form array
        $form = [
            'form' => [
                'legend' => [
                    'title' => $this->l('Settings'),
                ],
                'input' => [
                    [
                        'type' => 'text',
                        'label' => $this->l('Link Search API'),
                        'name' => 'SEARCH_API',
                        'size' => 20,
                        'required' => true,
                    ],
                ],
                'submit' => [
                    'title' => $this->l('Save'),
                    'class' => 'btn btn-primary',
                ],
            ],
        ];

        $helper = new HelperForm();

        // Module, token and currentIndex
        $helper->table = $this->table;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        $helper->submit_action = 'submit' . $this->name;

        // Default language
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');

        // Load current value into the form
        $helper->fields_value['SEARCH_API'] = Tools::getValue('SEARCH_API', Configuration::get('SEARCH_API'));

        return $helper->generateForm([$form]);
    }

    public function hookDisplayTop($params)
    {
        // This is where you might add the search bar to your site.
        // For now, let's just return a simple form. Remember to create the form template file.
        $this->context->smarty->assign([
            'search_api_action_url' => $this->context->link->getModuleLink($this->name, 'search'),
        ]);
        return $this->display(__FILE__, 'views/templates/front/search_form.tpl');
    }
}
