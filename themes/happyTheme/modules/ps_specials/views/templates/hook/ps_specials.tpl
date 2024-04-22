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

{if $hookName == 'displayColumn'}
  <section class="featured-products clearfix home-block-section" style="border: 1px solid #D4D4D4; border-radius: 6px;">
    <h3 class="text-uppercase text-white bg-success text-center" style="padding: 10px">
      <span>{l s='Special products' d='Shop.Theme.Catalog'}</span>
    </h3>
    <div class="products single-item-carousel" data-custom={{$customParam}}>
      {foreach from=$products item="product"}
        {include file="catalog/_partials/miniatures/product.tpl" product=$product}
      {/foreach}
    </div>
  </section>
{else}
  <section class="featured-products clearfix home-block-section">
    <h3 class="h1 products-section-title text-uppercase title-home text-center">
      <span>{l s='Special products' d='Shop.Theme.Catalog'}</span>
    </h3>
    <div class="products product_list" data-carousel-product-number="{$carousel_product_number}">
      {foreach from=$products item="product"}
        {include file="catalog/_partials/miniatures/product.tpl" product=$product}
      {/foreach}
    </div>
    {*<a class="all-product-link pull-xs-left pull-md-right h4" href="{$allSpecialProductsLink|escape:'html':'UTF-8'}">
    {l s='All sale products' d='Shop.Theme.Catalog'}<i class="material-icons">&#xE315;</i>
  </a>*}
  </section>
  {hook h='ybcCustom3'}
{/if}