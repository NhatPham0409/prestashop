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
<section class="featured-products clearfix home-block-section">
  <div style="width: 100%; min-height: 30px;">
    <div style="width: auto; padding: 1px;">
      <div class="featured_products_bhx_banner">
        <img alt="" loading="lazy" width="0" height="0" decoding="async" data-nimg="1" class="opacity-100"
          src="https://cdn.tgdd.vn/bachhoaxanh/shopinshop/14/featureproductgroup/1/unilever-viet-nam-22022022195039.png"
          style="color: transparent; width: 100%; height: auto;">
      </div>
    </div>
    <div class="featured_products_bhx_listProduct">
      {assign var="count" value=0}
      {foreach from=$products item="product"}
        {if $count < 6}
          {include file="catalog/_partials/miniatures/product.tpl" product=$product}
          {assign var="count" value=$count+1}
        {else}
          {break}
        {/if}
      {/foreach}
    </div>
  </div>
  </div>

  {*<a class="all-product-link pull-xs-left pull-md-right h4" href="{$allProductsLink|escape:'html':'UTF-8'}">
    {l s='All products' d='Shop.Theme.Catalog'}<i class="material-icons">&#xE315;</i>
  </a>*}
</section>
{hook h='ybcCustom1'}