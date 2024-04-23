<?php
class Mwg_SearchByApiSearchModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        echo("123");

        $query = Tools::getValue('s');
        $results = $this->performAPISearch($query);

        $this->context->smarty->assign(array(
            'results' => $results,
        ));

        $this->setTemplate('module:mwg_searchbyapi/views/templates/front/search_results.tpl');
    }

    protected function performAPISearch($query)
    {
        // Implement the logic to call the external API and return results.
        // This is a pseudo-code example to simulate an API response.
        // You would use curl or another HTTP client here.
        $apiUrl = 'https://api.example.com/search';
        $apiKey = 'YOUR_API_KEY';

        // Simulated API response
        return [
            ['name' => 'Product 1', 'description' => 'A great product'],
            ['name' => 'Product 2', 'description' => 'Another great product'],
        ];
    }
}