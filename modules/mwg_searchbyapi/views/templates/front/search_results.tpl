<!-- /modules/search_api/views/templates/front/search_results.tpl -->

<h1>{l s='Search results' d='Shop.Theme.Catalog'}</h1>
<ul>
{foreach from=$results item=result}
    <li>{$result.name}: {$result.description}</li>
{/foreach}
</ul>