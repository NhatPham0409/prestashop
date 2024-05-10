<?php
/**
 * 2007-2024 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2024 PrestaShop SA
 * @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

use GuzzleHttp\Client;
use GuzzleHttp\Psr7\Request;

if (!defined('_PS_VERSION_')) {
    exit;
}
ini_set('max_execution_time', 30000);

class MWG_CRAWLDATA extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'mwg_crawldata';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Giang Nam';
        $this->need_instance = 1;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Crawl Data');
        $this->description = $this->l("Don't think I can do it :))");

        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        Configuration::updateValue('MWG_CRAWLDATA_LIVE_MODE', false);

        return parent::install() &&
            $this->registerHook('header') &&
            $this->registerHook('displayBackOfficeHeader');
    }

    public function uninstall()
    {
        Configuration::deleteByName('MWG_CRAWLDATA_LIVE_MODE');

        return parent::uninstall();
    }

    /**
     * Load the configuration form
     */
    public function getContent()
    {
        /**
         * If values have been submitted in the form, process.
         */
        $output = '';
        if (((bool)Tools::isSubmit('submitMWG_CRAWLDATAModule')) == true) {
            $option = Tools::getValue('DISPLAY_STORE');
            $timeOut = Tools::getValue('TIME_OUT');
            $categoryOption = Tools::getValue('DISPLAY_CATEGORY');
            if (!Validate::isUnsignedInt($timeOut)) {
                $errors[] = $this->trans(
                    'There is an invalid number of elements.',
                    array()
                );

            } else {
                if ($option == 'BHX') {
                    $categories = $this->getCategoryBHX($timeOut);
                    $path = 'dataBHX';

                    if (!file_exists($path)){
                        mkdir($path, 0777, true);
                    }
                    foreach ($categories['menus'] as $category){
                        if ($categoryOption == 'ALL' || $category['id'] == $categoryOption) {
                            if (isset($category['childrens'])) {
                                foreach ($category['childrens'] as $child) {
                                    $this->crawlDataProductBHX($timeOut, $path, $category['name'], $child['name'], $child['id']);
                                }
                            }
                        }
                    }
                }
                $this->postProcess();
            }

        }
        if (isset($errors) && count($errors)) {
            $output .= $this->displayError(implode('<br />', $errors));
        } else {
            $output .= $this->displayConfirmation($this->trans(
                'Crawl Data Success.',
                array()
            ));
        }

        return $output.$this->renderForm();
    }

    protected function getCategoryBHX($timeOut)
    {
        if (filesize('dataCrawlCategory.json') == 0){
            $categories = $this->crawlDataCategoryBHX($timeOut);
        } else {
            $file = fopen('dataCrawlCategory.json', "r") or die("Unable to open file!");
            $data = fread($file, filesize('dataCrawlCategory.json'));
            $data = json_decode($data,true);
            $categories = $data;
        }
        array_pop($categories['menus']);
        return $categories;
    }

    protected function crawlDataCategoryBHX($timeOut){

        $client = new Client();
        $headers = [
            'authorization' => 'Bearer BB6840856014B35E4F409635D32E2338',
            'deviceid' => '117a26e5-fead-4a21-afee-42082c41a9e5',
            'reversehost' => 'http://bhxapi.live',
        ];
        try{
        $request = new Request('GET', 'https://apibhx.tgdd.vn/Menu/GetMenu?ProvinceId=3&WardId=0&StoreId=7300', $headers);
        $res = $client->sendAsync($request, ['timeout' => $timeOut, 'connect_timeout' => 60.0])->wait();
            if ($res->getBody() != null) {
                $this->writeContentToFile('/', 'dataCrawlCategory.json', $res);
                return json_decode($res->getBody())['data'];
            } else {
                return null;
            }
        } catch(\GuzzleHttp\Exception\GuzzleException $exception){
            dump($exception->getMessage());
            return "Error";
        }
    }

    protected function crawlDataProductBHX($timeOut,$path, $parentCategoryName, $categoryName, $categoryId)
    {
        if (file_exists($path .'/' .$this->locdautiengviet(str_replace(',','',$parentCategoryName)) .'/data_crawl_' .$this->locdautiengviet(str_replace(',','',$categoryName)) .'.json')){
//            dump("File exist");
            return;
        }
        $client = new Client();
        $headers = [
            'Content-Type' => 'application/json',
            'authorization' => 'Bearer 80B434D0F64A371D1543CDDA1DA02064',
            'deviceid' => '18d38973-8952-4032-900c-2baee15d3cfc',
            'reversehost' => 'http://bhxapi.live',
        ];
        $body = '{
          "provinceId": 3,
          "wardId": 27127,
          "districtId": 2087,
          "storeId": 4946,
          "CategoryId": ' .$categoryId .',
          "SelectedBrandId": "",
          "Phone": "",
          "CateListFilter": "",
          "PropertyIdList": "",
          "PageIndex": 0,
          "PageSize": 10000,
          "IsLoadVideo": true,
          "IsPromotion": false,
          "SortStr": "",
          "IsV2": true,
          "PrioritySortIds": "194540,220521,324673,316270,306410,237562,234943,213856,212820,212821,201145,231428,224595,238035,210186",
          "PriorityProductIds": "194540,220521,324673,316270,306410,237562,234943,213856,212820,212821,201145,231428,224595,238035,210186",
          "ExcludeProductIds": "194540,220521,324673,316270,306410,237562,234943,213856,212820,212821,201145,231428,224595,238035,210186,237563,196451,309460,162388,242899",
          "SortPropValueIDs": "",
          "IsPreFresh": false,
          "isDisplaysASpecification": false,
          "specificationDisplay": 0
        }';
        try {
            $request = new Request('POST', 'https://apibhx.tgdd.vn/Category/AjaxProduct', $headers, $body);
            $res = $client->sendAsync($request, ['timeout' => $timeOut, 'connect_timeout' => 60.0])->wait();
            if ($res->getBody() != null) {
                $result = json_decode($res->getBody(), true)['data']['products'];
                if ($result != null) {
                    foreach ($result as $key => $product) {
                        $arr = explode('/', $product['url']);
                        $detailProduct = $this->crawlDataDetailProductBHX($timeOut,$arr[1], $arr[2]);
                        $result[$key]['productDetail'] = $detailProduct;
                    }
                    $this->writeContentToFile($path . '/' . $this->locdautiengviet(str_replace(',', '', $parentCategoryName)), '/data_crawl_' . $this->locdautiengviet(str_replace(',', '', $categoryName)) . '.json', $result);
                } else {
//                    dump("Result error");
                    return "Error";
                }
            }
        } catch (\GuzzleHttp\Exception\GuzzleException $exception){
                dump($exception->getMessage());
                return "Error";
        }
    }

    protected function crawlDataDetailProductBHX($timeOut,$categoryUrl, $productUrl){
        $client = new Client();
        $headers = [
            'authorization' => 'Bearer 80B434D0F64A371D1543CDDA1DA02064',
            'deviceid' => '18d38973-8952-4032-900c-2baee15d3cfc',
            'reversehost' => 'http://bhxapi.live',
        ];
        try {
            $request = new Request('GET', 'https://apibhx.tgdd.vn/Product/GetProductDetail?provinceId=3&wardId=27127&districtId=2087&storeId=4946&CategoryUrl=' . $categoryUrl . '&ProductUrl=' . $productUrl, $headers);
            $res = $client->sendAsync($request, ['timeout' => $timeOut, 'connect_timeout' => 60.0])->wait();
            if ($res->getBody() != null) {
                $result = json_decode($res->getBody(), true)['data'];
                if ($result != null){
                    $image = $this->crawlDataImageProductBHX($timeOut, $result['id']);
                    $result['productGalleriesItem'] = $image['productGalleriesItem'];
                    return $result;
                }
                else {
                    return "Error";
                }
            } else {
                return null;
            }
        } catch(\GuzzleHttp\Exception\GuzzleException $exception){
            dump($exception->getMessage());
            return "Error";
        }
    }

    protected function crawlDataImageProductBHX($timeOut, $productId){
        $client = new Client();
        $headers = [
            'authorization' => 'Bearer 80B434D0F64A371D1543CDDA1DA02064',
            'deviceid' => '18d38973-8952-4032-900c-2baee15d3cfc',
            'reversehost' => 'http://bhxapi.live',
        ];
        $request = new Request('GET', 'https://apibhx.tgdd.vn/Product/GetGalleryProduct?provinceId=3&wardId=27127&districtId=2087&storeId=4937&ProductId=' .$productId, $headers);
        $res = $client->sendAsync($request, ['timeout' => $timeOut, 'connect_timeout' => 60.0])->wait();
        if ($res->getBody() != null){
            $result = json_decode($res->getBody(), true)['data'];
            if ($result != null)
                return $result;
            else
                return "Error";
        }
    }

    protected function writeContentToFile($directory, $fileName, $res){
        $directory = strtolower($directory);
        $fileName = strtolower($fileName);
        if (!file_exists($directory)){
            mkdir($directory, 0777, true);
        }
        $fileName = $directory .'/' .$fileName;
        if (!file_exists($fileName)){
            $createFile = fopen($fileName, "a");
            fclose($createFile);
        }
        $file = fopen($fileName, "r") or die("Unable to open file!");
        $data = "";
        if (is_array($res)){
            $result = $res;
        } else {
            try {
                if ($res->getBody() != null)
                    $result = json_decode($res->getBody(), true);
                else
                    return "Error";
            } catch (\GuzzleHttp\Exception\GuzzleException $exception){
                return "Error";
            }
        }
        if (filesize($fileName) != 0){
            $data = fread($file, filesize($fileName));
            $data = json_decode($data,true);
            if (!is_array($res)) {
                if (isset($data['products']) && isset($result['data']) && isset($result['data']['products']))
                    $data['products'][] = $result['data']['products'];
            } else {
                $data['products'][] = $result;
            }
        } else {
            if (!is_array($res)) {
                if (isset($result['data']))
                    $data = $result['data'];
            } else {
                $data = $result;
            }
        }
        fclose($file);
        $file = fopen($fileName, "w") or die("Unable to open file!");
        fwrite($file, json_encode($data));
        fclose($file);
    }

    function locdautiengviet($str){
        $str = strtolower($str); //chuyển chữ hoa thành chữ thường
        $unicode = array(
            'a'=>'á|à|ả|ã|ạ|ă|ắ|ặ|ằ|ẳ|ẵ|â|ấ|ầ|ẩ|ẫ|ậ',
            'd'=>'đ',
            'e'=>'é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ',
            'i'=>'í|ì|ỉ|ĩ|ị',
            'o'=>'ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ',
            'u'=>'ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự',
            'y'=>'ý|ỳ|ỷ|ỹ|ỵ',
            'A'=>'Á|À|Ả|Ã|Ạ|Ă|Ắ|Ặ|Ằ|Ẳ|Ẵ|Â|Ấ|Ầ|Ẩ|Ẫ|Ậ',
            'D'=>'Đ',
            'E'=>'É|È|Ẻ|Ẽ|Ẹ|Ê|Ế|Ề|Ể|Ễ|Ệ',
            'I'=>'Í|Ì|Ỉ|Ĩ|Ị',
            'O'=>'Ó|Ò|Ỏ|Õ|Ọ|Ô|Ố|Ồ|Ổ|Ỗ|Ộ|Ơ|Ớ|Ờ|Ở|Ỡ|Ợ',
            'U'=>'Ú|Ù|Ủ|Ũ|Ụ|Ư|Ứ|Ừ|Ử|Ữ|Ự',
            'Y'=>'Ý|Ỳ|Ỷ|Ỹ|Ỵ',
        );
        foreach($unicode as $nonUnicode=>$uni){
            $str = preg_replace("/($uni)/i", $nonUnicode, $str);
        }
        $str = str_replace(' ','_',$str);
        return $str;
    }
    /**
     * Create the form that will be displayed in the configuration of your module.
     */
    protected function renderForm()
    {
        $helper = new HelperForm();

        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);

        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitMWG_CRAWLDATAModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFormValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,

        );

        return $helper->generateForm(array($this->getConfigForm()));
    }

    /**
     * Create the structure of your form.
     */
    protected function getConfigForm()
    {
        $categories = $this->getCategoryBHX(120);
        $categoryList[] = array(
            'id' => 'ALL',
            'name' => $this->trans(
                'All',
                array()
            ),
        );
        foreach($categories['menus'] as $category){
            $categoryList[] = array(
                'id' => $category['id'],
                'name' => $this->trans(
                    $category['name'],
                    array(),
                ),
            );
        }
        $categoryList[] = array(
            'id' => 'Unilever',
            'name' => $this->trans(
                'Unilever',
                array()
            ),
        );
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans(
                        'Settings',
                        array(),
                        'Admin.Global'
                    ),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'select',
                        'label' => $this->trans(
                            'Store',
                            array()
                        ),
                        'name' => 'DISPLAY_STORE',
                        'required' => true,
                        'options' => array(
                            'query' => array(
                                array(
                                    'id' => 'BHX',
                                    'name' => $this->trans(
                                        'BHX',
                                        array()
                                    ),
                                ),
                                array(
                                    'id' => 'TGDD',
                                    'name' => $this->trans(
                                        'TGDD',
                                        array()
                                    ),
                                ),
                            ),
                            'id' => 'id',
                            'name' => 'name',
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans(
                            'Time out',
                            array()
                        ),
                        'desc' => $this->trans(
                            'Low time out will be miss data',
                            array()
                        ),
                        'name' => 'TIME_OUT',
                        'class' => 'fixed-width-xs'
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->trans(
                            'Category',
                            array()
                        ),
                        'name' => 'DISPLAY_CATEGORY',
                        'required' => false,
                        'options' => array(
                            'query' => $categoryList,
                            'id' => 'id',
                            'name' => 'name',
                        ),
                    )
                ),
                'submit' => array(
                    'title' => $this->trans(
                        'Sync',
                        array(),
                        'Admin.Actions'
                    ),
                ),
            ),
        );
        return $fields_form;
    }

    /**
     * Set values for the inputs.
     */
    protected function getConfigFormValues()
    {
        return array(
//            'MWG_CRAWLDATA_LIVE_MODE' => Configuration::get('MWG_CRAWLDATA_LIVE_MODE', true),
//            'MWG_CRAWLDATA_ACCOUNT_EMAIL' => Configuration::get('MWG_CRAWLDATA_ACCOUNT_EMAIL', 'contact@prestashop.com'),
//            'MWG_CRAWLDATA_ACCOUNT_PASSWORD' => Configuration::get('MWG_CRAWLDATA_ACCOUNT_PASSWORD', null),
            'TIME_OUT' => 60
        );
    }

    /**
     * Save form data.
     */
    protected function postProcess()
    {
        $form_values = $this->getConfigFormValues();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    /**
     * Add the CSS & JavaScript files you want to be loaded in the BO.
     */
    public function hookDisplayBackOfficeHeader()
    {
        if (Tools::getValue('configure') == $this->name) {
            $this->context->controller->addJS($this->_path . 'views/js/back.js');
            $this->context->controller->addCSS($this->_path . 'views/css/back.css');
        }
    }

    /**
     * Add the CSS & JavaScript files you want to be added on the FO.
     */
    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path . '/views/js/front.js');
        $this->context->controller->addCSS($this->_path . '/views/css/front.css');
    }
}
