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
<div id="js-product-list">
  <div style="position: relative;" class="row">
    <div style="position: absolute;top: -6px;left: 50%;transform: translateX(-50%);">
      <div style="position: relative;display: inline-block;object-fit: contain;width: 400px;height: 33px;">
        <img alt="" fetchpriority="high" width="0" height="0" decoding="async" data-nimg="1"
          class="opacity-100 !object-contain" src="https://www.bachhoaxanh.com/static/images/green-home.svg"
          style="color: transparent; width: 100%; height: auto;">
      </div>
      <span
        style="position: absolute;left: 0;top: 2px;width: 100%;cursor: pointer;padding-left: 2.5rem; padding-right: 2.5rem;text-align: center;font-size: 18px;font-weight: 600;text-transform: uppercase;color: white;">
        Sản phẩm đang khuyến mãi
      </span>
    </div>
    <div style="min-height: 180px;border-radius: 6px;">
      <div
        style="width: 100%;height: 100%;border-radius: 6px;background-color: white;padding-bottom: 8px;padding-top: 38px;">
        {* <div class="products row"> *}
        <div style="display: flex;">
          {foreach from=$listing.products item="product"}
            {block name='product_miniature'}
              {include file='catalog/_partials/miniatures/product-sale.tpl' product=$product}
            {/block}
          {/foreach}
        </div>
        {* </div> *}
      </div>
    </div>
  </div>


  <div class="row"
    style="margin-top: 10px; display: flex; flex-wrap: wrap; padding-left: 2px;padding-right: 2px;padding-top: 4px;background-color: white;align-content: stretch;">
    {foreach from=$listing.products item="product"}
      {block name='product_miniature'}
        {include file='catalog/_partials/miniatures/product.tpl' product=$product}
      {/block}
    {/foreach}
  </div>


  {* {block name='pagination'}
      {include file='_partials/pagination.tpl' pagination=$listing.pagination}
    {/block} *}
</div>