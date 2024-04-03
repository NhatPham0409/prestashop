<section>
    <h1 style="text-align: center; font-size: 25px; color: #232323; font-weight: 500;margin: 40px auto;">Movie</h1>
    <div class="products" style="display: flex;">
        {foreach from=$products item="product"}
            <div class="product" style="width: 25%; text-align: center;">
                <div class="product-image"><img src="{$product.image}" alt="{$product.title}" style="width: 250px; height: 250px;"></div>
                <div class="product-detail" style="
                margin: 0px auto;
                width: 250px;
                height: 74px;
                background: #fff;
                text-align: center;">
                  <div class="product-title" style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">{$product.title}</div>
                  <div class="product-rating">Rating: {$product.rating_star}/10</div>
                  <div class="product-release-year">Release Year: {$product.release_year}</div>
                </div>
            </div>
        {/foreach}
    </div>
</section>

    