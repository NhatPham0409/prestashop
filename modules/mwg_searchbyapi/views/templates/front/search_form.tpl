<!-- /modules/search_api/views/templates/front/search_form.tpl -->

<form action="{$search_api_action_url}" method="get">
    {dump($search_api_action_url)}
    <input type="text" name="s" value="" placeholder="{l s='Search for products' d='Shop.Theme.Catalog'}" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
    <button type="submit">{l s='Search' d='Shop.Theme.Actions'}</button>
</form>