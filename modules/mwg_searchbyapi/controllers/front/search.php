<?php
class Mwg_SearchByApiSearchModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        $query = Tools::getValue('s');
        $results = $this->performAPISearch($query);

        $this->context->smarty->assign(array(
            'results' => $results,
        ));

        $this->setTemplate('module:mwg_searchbyapi/views/templates/front/search_results.tpl');
    }

    protected function performAPISearch($query)
    {
        $apiUrl = Configuration::get("SEARCH_API");
        // Nếu cần thì có thể cung cấp API key vào đây
        // $apiKey = 'YOUR_API_KEY';

        // Tạo query string từ dữ liệu tìm kiếm
        $queryString = http_build_query(['query' => $query]);

        // Gửi yêu cầu HTTP GET đến API
        $response = file_get_contents($apiUrl . '?' . $queryString);

        // Kiểm tra xem có dữ liệu trả về không
        if ($response !== false) {
            // Chuyển đổi dữ liệu JSON thành mảng kết quả
            $data = json_decode($response, true);

            // Kiểm tra xem có dữ liệu hợp lệ không
            if ($data !== null) {
                // Trả về dữ liệu kết quả từ API
                return $data;
            } else {
                // Xử lý trường hợp lỗi khi không thể phân tích dữ liệu JSON
                return ['error' => 'Unable to parse API response'];
            }
        } else {
            // Xử lý trường hợp lỗi khi không thể kết nối tới API
            return ['error' => 'Failed to connect to the API'];
        }
    }
}
