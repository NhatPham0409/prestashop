<!-- /modules/search_api/views/templates/front/search_results.tpl -->

{extends file='page.tpl'}

{block name='page_content'}
    <h1>{l s='Search results' d='Shop.Theme.Catalog'}</h1>

    {dump($results)}

    <div class="row">
        {foreach from=$results.results item="product" key="position"}
            <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                <div class="card" style="width: 18rem;">
                    <img src={$product.image} class="card-img-top" alt="...">
                    <div class="card-body text-center">
                        <p class="card-text text-center">{$product.title}</p>
                        <p class="card-text text-center">{$product.year}</p>
            </div>
        </div>
    </div>
    {/foreach}
</div>

<div class="hidden-md-up text-xs-right up">
    <a href="#header" class="btn btn-secondary">
        {l s='Back to top' d='Shop.Theme.Actions'}
            <i class="material-icons">&#xE316;</i>
        </a>
    </div>
{/block}