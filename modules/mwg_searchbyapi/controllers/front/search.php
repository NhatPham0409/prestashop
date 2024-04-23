<?php
class Mwg_SearchByApiSearchModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        $search_string = Tools::getValue('s');
        $results = $this->performAPISearch($search_string);

        $this->context->smarty->assign(array(
            'results' => $results,
        ));

        $this->setTemplate('module:mwg_searchbyapi/views/templates/front/search_results.tpl');
    }

    public function getDataByApi($search_string)
    {
        $url = Configuration::get('SEARCH_API');
        $response = Tools::file_get_contents($url . $search_string);
        if ($response !== false) {
            $data = json_decode($response, true); // Chuyển đổi dữ liệu JSON thành mảng PHP
            return $data;
        } else {
            echo 'Không thể kết nối đến API.';
            return false;
        }
    }

    protected function performAPISearch($search_string)
    {
        $data = $this->getDataByApi($search_string);
        if ($data) {
            dump($data); // Hiển thị dữ liệu trả về từ API
            return $data;
        } else {
            return false;
        }
    }
}
