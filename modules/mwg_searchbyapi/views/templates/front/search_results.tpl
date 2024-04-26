<!-- /modules/search_api/views/templates/front/search_results.tpl -->

{extends file='page.tpl'}

{block name='page_content'}

    <h1>{l s='Search results' d='Shop.Theme.Catalog'}</h1>
    <div class="row">
        {if count($results.results) > 0}
            {foreach from=$results.results item="product" key="position"}
                <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                    <div class="card">
                        <a href={$product.imdb}>
                            <img src={$product.image} class="card-img-top" alt="..." style="object-fit: cover;">
                        </a>
                        <div class="card-body" style="text-align: center">
                            <p class="card-text">{$product.title}</p>
                            <p class="card-text">{$product.year}</p>
                        </div>
                    </div>
                </div>
            {/foreach}
        {else}
            <p>Không tìm được sản phẩm</p>
        {/if}

    </div>

    <div class="hidden-md-up text-xs-right up">
        <a href="#header" class="btn btn-secondary">
            {l s='Back to top' d='Shop.Theme.Actions'}
            <i class="material-icons">&#xE316;</i>
        </a>
    </div>
{/block}