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
<div id="js-product-list-top" class="row products-selection">
  <div class="col-md-6 hidden-sm-down total-products">
    <ul class="display hidden-xs">
        <li id="grid" class="active">
            <a rel="nofollow" href="#" title="{l s='Grid'}">
                <i class="fa fa-th"></i>
            </a>
        </li>
        <li id="list">
            <a rel="nofollow" href="#" title="{l s='List'}">
                <i class="fa fa-list"></i>
            </a>
        </li>
  </ul>
  </div>
  <div class="col-md-6">
    <div class="sort-by-row">
        {if !empty($listing.rendered_facets)}
        <div class="col-sm-3 col-xs-4 hidden-md-up filter-button">
          <button id="search_filter_toggler" class="btn btn-secondary">
            {l s='Filter' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/if}
      
      {block name='sort_by'}
        {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
      {/block}

      
    </div>
  </div>
</div>
