{*
* 2007-2022 ETS-Soft
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses. 
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
* 
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs, please contact us for extra customization service at an affordable price
*
*  @author ETS-Soft <etssoft.jsc@gmail.com>
*  @copyright  2007-2022 ETS-Soft
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of ETS-Soft
*}
{extends file=$layout}

{block name='head_seo' prepend}
  <link rel="canonical" href="{$product.canonical_url|escape:'html':'UTF-8'}">
{/block}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta property="og:url" content="{$urls.current_url|escape:'html':'UTF-8'}">
  <meta property="og:title" content="{$page.meta.title|escape:'html':'UTF-8'}">
  <meta property="og:site_name" content="{$shop.name|escape:'html':'UTF-8'}">
  <meta property="og:description" content="{$page.meta.description|escape:'html':'UTF-8'}">
  <meta property="og:image" content="{$product.cover.large.url|escape:'html':'UTF-8'}">
  <meta property="product:pretax_price:amount" content="{$product.price_tax_exc|escape:'html':'UTF-8'}">
  <meta property="product:pretax_price:currency" content="{$currency.iso_code|escape:'html':'UTF-8'}">
  <meta property="product:price:amount" content="{$product.price_amount|escape:'html':'UTF-8'}">
  <meta property="product:price:currency" content="{$currency.iso_code|escape:'html':'UTF-8'}">
  {if isset($product.weight) && ($product.weight != 0)}
    <meta property="product:weight:value" content="{$product.weight|escape:'html':'UTF-8'}">
    <meta property="product:weight:units" content="{$product.weight_unit|escape:'html':'UTF-8'}">
  {/if}
{/block}

{block name='content'}

  <div id="main" itemscope itemtype="https://schema.org/Product"
    style="background-color: rgb(233 237 240/1);display:flex">
    <meta itemprop="url" content="{$product.url|escape:'html':'UTF-8'}">
    <div style="display: flex; flex-direction: column; flex: 7">
      <div style="position: relative;border-top-left-radius: 0.5rem;
      border-top-right-radius: 0.5rem;background-color: #fff;padding-top: 0.5rem;
      padding-bottom: 0.5rem; ">
        {block name='page_content_container'}
          <div class="page-content" id="content">
            {block name='page_content'}

              {block name='product_cover_thumbnails'}
                {include file='catalog/_partials/product-cover-thumbnails.tpl'}

              {/block}
            {/block}
          </div>

        {/block}
      </div>
      <div style="
        padding-bottom: 12px; font-family: Arial, Helvetica">
        <div class="tab-pane fade in{if $product.description} active{/if}" id="description">
          {block name='product_description'}
            <div class="product-description">{$product.description nofilter}</div>
          {/block}
        </div>

        {block name='product_details'}
          {include file='catalog/_partials/product-details.tpl'}
        {/block}
        {block name='product_attachments'}
          {if $product.attachments}
            <div class="tab-pane fade in" id="attachments">
              <section class="product-attachments">
                <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
                {foreach from=$product.attachments item=attachment}
                  <div class="attachment">
                    <h4><a
                        href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name|escape:'html':'UTF-8'}</a>
                    </h4>
                    <p>{$attachment.description|escape:'html':'UTF-8'}</p <a
                      href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                    {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted|escape:'html':'UTF-8'})
                    </a>
                  </div>
                {/foreach}
              </section>
            </div>
          {/if}
        {/block}
        {foreach from=$product.extraContent item=extra key=extraKey}
          <div class="tab-pane fade in {$extra.attr.class|escape:'html':'UTF-8'}"
            id="extra-{$extraKey|escape:'html':'UTF-8'}" {foreach $extra.attr as $key => $val}
            {$key|escape:'html':'UTF-8'}="{$val|escape:'html':'UTF-8'}" {/foreach}>
            {$extra.content nofilter}
          </div>
        {/foreach}
        {hook h='productTabContent' product=$product}
      </div>
    </div>
    <div 
      style="position: sticky;top: 18px; z-index: 10; margin-left: 10px;max-height: calc(100vh - 300px);flex: 1;overflow: auto;border-radius: 0.5rem;border-width: 2px; border-color: #D1D5DB;background-color: #fff;padding: 0.625rem; flex:4">
      {block name='page_header_container'}
        {block name='page_header'}
          <h1 class="h1 page-heading-product" itemprop="name" style="font-family: none; text-transform: none;">
            {block name='page_title'}{$product.name|escape:'html':'UTF-8'}{/block}</h1>
        {/block}
      {/block}
      <div style="display: flex; align-items: center; justify-content: flex-end ">
        <i class="fa fa-link"></i>
        <button class="btn btn-link" style="padding: 2px; color: #007aff">Chia sẻ</button>
      </div>
      <div style="margin-bottom: 46px; display: flex; align-items: center;">
        <div style="font-size: 20px; font-weight: bold; color: rgb(177 14 14 /1)">{$product.price}</div>
      </div>
      <div>
        <div style="outline: none; width: 117px;">
          <div>
            <div style="width: 100%; display: inline-block;cursor: pointer; border-radius: 8px; width: 112px;">
              <div
                style="position: relative; overflow:hidden; border-radius: 0.375rem;border-style: solid; border-width: 1px; border-color: #E4E9F2; text-align: center">
                <div class="relative inline-block" style="width: 110px; height: 110px;"><img alt="Chai 796ml"
                    loading="lazy" width="0" height="0" decoding="async" data-nimg="1" class="opacity-100"
                    src={$product.cover.bySize.home_default.url|escape:'html':'UTF-8'}
                    style="color: transparent; width: 100%; height: auto;"></div>
                <div
                  style="background-color: #00AC5B; text-align: center; font-size: 12px; font-weight: bold; line-height: 16px; color: white">
                  Black</div>
              </div>
              <div style="display: flex; align-items: center; justify-content: center; height: 30px">
                <input type="radio" style="color: #00AC5B;">
              </div>
              <div style="display: flex; flex-direction: column; justify-content: flex-start; min-height: 45px; ">
                <div style="text-align: center; font-size: 12px; font-weight: bold; color: #222B45;">
                  {$product.price}
                </div>
                <div style="display: flex; justify-content: center">
                  <div
                    style="text-align: center; font-size: 9px;  line-height: 1rem; color: #9da7bc; text-decoration: line-through;">
                    {$product.regular_price}</div>
                  <div
                    style="margin-left: 0.25rem; border-radius: 3px; background-color: rgb(255, 1, 1);
                      background-color: rgba(255, 1, 1, 0.7); padding-left: 0.25rem;
                      padding-right: 0.25rem; font-size: 9px;font-weight: 600; line-height: 15px;color: #fff;font-size: 12px;">
                    {$product.discount_percentage}</div>
                </div>
                <div class="text-center text-10 leading-4 text-[#9da7bc]"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {* {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block} *}

      {* <div class="product-information"> *}
      {* {block name='product_description_short'}
              <div id="product-description-short-{$product.id|escape:'html':'UTF-8'}" itemprop="description">{$product.description_short nofilter}</div>
            {/block} *}

      {* {if $product.is_customizable && count($product.customizations.fields)} *}
        {* {block name='product_customization'}
                {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
              {/block} *}
      {* {/if} *}
      {* <div class="line clearfix"></div> *}
      <div class="product-actions">
        {block name='product_buy'}
          <form action="{$urls.pages.cart|escape:'html':'UTF-8'}" method="post" id="add-to-cart-or-refresh">
            <input type="hidden" name="token" value="{$static_token|escape:'html':'UTF-8'}">
            <input type="hidden" name="id_product" value="{$product.id|escape:'html':'UTF-8'}" id="product_page_product_id">
            <input type="hidden" name="id_customization" value="{$product.id_customization|escape:'html':'UTF-8'}"
              id="product_customization_id">

            {* {block name='product_variants'}
                {include file='catalog/_partials/product-variants.tpl'}
              {/block} *}

            {* {block name='product_pack'}
                {if $packItems}
                  <section class="product-pack">
                    <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
                    {foreach from=$packItems item="product_pack"}
                      {block name='product_miniature'}
                        {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                      {/block}
                    {/foreach}
                  </section>
                {/if}
              {/block} *}

            {* {block name='product_discounts'}
                {include file='catalog/_partials/product-discounts.tpl'}
              {/block} *}
            {* <div class="line clearfix"></div> *}
            {block name='product_add_to_cart'}
              {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}

            {* <div class="line clearfix"></div> *}
            {* {if isset($tc_config.YBC_TC_SOCIAL_SHARING) && $tc_config.YBC_TC_SOCIAL_SHARING == 1}
                {hook h='displayProductButtons' product=$product}
              {/if} *}
            {* {hook h='productcustom' product=$product}

              {block name='product_additional_info'}
                {include file='catalog/_partials/product-additional-info.tpl'}
              {/block}
              {block name='product_refresh'}
                <input class="product-refresh ps-hidden-by-js" name="refresh" type="submit"
                  value="{l s='Refresh' d='Shop.Theme.Actions'}">
              {/block} *}
          </form>
        {/block}

      </div>

      {*hook h='displayReassurance'*}

    </div>
  </div>
  <div class="tabs col-md-7 col-xs-7">
    {* <ul class="nav nav-tabs">
        {if $product.description}
          <li class="nav-item">
            <a class="nav-link{if $product.description} active{/if}" data-toggle="tab"
              href="#description">{l s='Description' d='Shop.Theme.Catalog'}</a>
          </li>
        {/if}
        <li class="nav-item">
          <a class="nav-link{if !$product.description} active{/if}" data-toggle="tab"
            href="#product-details">{l s='Product Details' d='Shop.Theme.Catalog'}</a>
        </li>
        {if $product.attachments}
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#attachments">{l s='Attachments' d='Shop.Theme.Catalog'}</a>
          </li>
        {/if}
        {foreach from=$product.extraContent item=extra key=extraKey}
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab"
              href="#extra-{$extraKey|escape:'html':'UTF-8'}">{$extra.title|escape:'html':'UTF-8'}</a>
          </li>
        {/foreach}
        {hook h='productTab' product=$product}
      </ul> *}

    {* <div style=" position: relative;
      margin-top: 10px;
      background-color: #fff;
      padding-left: 10px;
      padding-right: 10px;
      padding-bottom: 12px; font-family: Arial, Helvetica">
      <div class="tab-pane fade in{if $product.description} active{/if}" id="description">
        {block name='product_description'}
          <div class="product-description">{$product.description nofilter}</div>
        {/block}
      </div>

      {block name='product_details'}
        {include file='catalog/_partials/product-details.tpl'}
      {/block}
      {block name='product_attachments'}
        {if $product.attachments}
          <div class="tab-pane fade in" id="attachments">
            <section class="product-attachments">
              <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
              {foreach from=$product.attachments item=attachment}
                <div class="attachment">
                  <h4><a
                      href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name|escape:'html':'UTF-8'}</a>
                  </h4>
                  <p>{$attachment.description|escape:'html':'UTF-8'}</p <a
                    href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                  {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted|escape:'html':'UTF-8'})
                  </a>
                </div>
              {/foreach}
            </section>
          </div>
        {/if}
      {/block}
      {foreach from=$product.extraContent item=extra key=extraKey}
        <div class="tab-pane fade in {$extra.attr.class|escape:'html':'UTF-8'}" id="extra-{$extraKey|escape:'html':'UTF-8'}"
          {foreach $extra.attr as $key => $val} {$key|escape:'html':'UTF-8'}="{$val|escape:'html':'UTF-8'}" {/foreach}>
          {$extra.content nofilter}
        </div>
      {/foreach}
      {hook h='productTabContent' product=$product}
    </div> *}
  </div>

  {block name='product_accessories'}
    {if $accessories}
      <section class="product-accessories col-xs-12 col-sm-12">
        <h3 class="h1 products-section-title text-uppercase">{l s='You might also like' d='Shop.Theme.Catalog'}</h3>
        <div class="products row">
          {foreach from=$accessories item="product_accessory"}
            {block name='product_miniature'}
              {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
            {/block}
          {/foreach}
        </div>
      </section>
    {/if}
  {/block}

  {block name='product_footer'}
    {hook h='displayFooterProduct' product=$product category=$category}
  {/block}

  {block name='product_images_modal'}
    {include file='catalog/_partials/product-images-modal.tpl'}
  {/block}

  {block name='page_footer_container'}
    <footer class="page-footer">
      {block name='page_footer'}
        <!-- Footer content -->
      {/block}
    </footer>
  {/block}
  </div>
  </div>

{/block}