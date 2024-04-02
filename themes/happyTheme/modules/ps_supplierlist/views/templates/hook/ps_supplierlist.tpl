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
<div id="search_filters_suppliers">
  <section class="facet">
    <h1 class="h6 text-uppercase facet-label">
      {if $display_link_supplier}<a href="{$page_link|escape:'html':'UTF-8'}" title="{l s='Suppliers' d='Shop.Theme.Catalog'}">{/if}
        {l s='Suppliers' d='Shop.Theme.Catalog'}
      {if $display_link_supplier}</a>{/if}
    </h1>
    <div>
      {if $suppliers}
        {include file="module:ps_supplierlist/views/templates/_partials/$supplier_display_type.tpl" suppliers=$suppliers}
      {else}
        <p>{l s='No supplier' d='Shop.Theme.Catalog'}</p>
      {/if}
    </div>
  </section>
</div>
