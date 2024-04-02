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
  <div id="search_filters">

    {block name='facets_title'}
      <h4 class="text-uppercase h6 hidden-sm-down">{l s='Filter By' d='Shop.Theme.Actions'}</h4>
    {/block}

    {block name='facets_clearall_button'}
      <div id="_desktop_search_filters_clear_all" class="hidden-sm-down clear-all-wrapper">
        <button data-search-url="{$clear_all_link|escape:'html':'UTF-8'}" class="btn btn-tertiary js-search-filters-clear-all">
          <i class="material-icons material-icons-clear"></i>
          {l s='Clear all' d='Shop.Theme.Actions'}
        </button>
      </div>
    {/block}

    {foreach from=$facets item="facet"}
      {if $facet.displayed}
        <section class="facet clearfix">
          <h3 class="h6 facet-title hidden-sm-down">{$facet.label|escape:'html':'UTF-8'}</h3>
          {assign var=_expand_id value=10|mt_rand:100000}
          {assign var=_collapse value=true}
          {foreach from=$facet.filters item="filter"}
            {if $filter.active}{assign var=_collapse value=false}{/if}
          {/foreach}
          <div class="title hidden-md-up" data-target="#facet_{$_expand_id|escape:'html':'UTF-8'}" data-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
            <h3 class="h6 facet-title">{$facet.label|escape:'html':'UTF-8'}</h3>
            <span class="pull-xs-right">
              <span class="navbar-toggler collapse-icons">
                <i class="material-icons material-icons-add add"></i>
                <i class="material-icons material-icons-remove remove"></i>
              </span>
            </span>
          </div>

          {if $facet.widgetType !== 'dropdown'}

            {block name='facet_item_other'}
              <ul id="facet_{$_expand_id|escape:'html':'UTF-8'}" class="collapse{if !$_collapse} in{/if}">
                {foreach from=$facet.filters item="filter"}
                  {if $filter.displayed}
                    <li>
                      <label class="facet-label{if $filter.active} active {/if}">
                        {if $facet.multipleSelectionAllowed}
                          <span class="custom-checkbox">
                            <input
                              data-search-url="{$filter.nextEncodedFacetsURL|escape:'html':'UTF-8'}"
                              type="checkbox"
                              {if $filter.active } checked {/if}
                            >
                            {if isset($filter.properties.color)}
                              <span class="color" style="background-color:{$filter.properties.color|escape:'html':'UTF-8'}"></span>
                              {elseif isset($filter.properties.texture)}
                                <span class="color texture" style="background-image:url({$filter.properties.texture|escape:'html':'UTF-8'})"></span>
                              {else}
                              <span {if !$js_enabled} class="ps-shown-by-js" {/if}><i class="material-icons material-icons_checkbox-checked"></i></span>
                            {/if}
                          </span>
                        {else}
                          <span class="custom-checkbox">
                            <input
                              data-search-url="{$filter.nextEncodedFacetsURL|escape:'html':'UTF-8'}"
                              type="radio"
                              name="filter {$facet.label|escape:'html':'UTF-8'}"
                              {if $filter.active } checked {/if}
                            >
                            <span {if !$js_enabled} class="ps-shown-by-js" {/if}></span>
                          </span>
                        {/if}

                        <a
                          href="{$filter.nextEncodedFacetsURL|escape:'html':'UTF-8'}"
                          class="_gray-darker search-link js-search-link"
                          rel="nofollow"
                        >
                          {$filter.label|escape:'html':'UTF-8'}
                          {if $filter.magnitude}
                            <span class="magnitude">({$filter.magnitude|escape:'html':'UTF-8'})</span>
                          {/if}
                        </a>
                      </label>
                    </li>
                  {/if}
                {/foreach}
              </ul>
            {/block}

          {else}

            {block name='facet_item_dropdown'}
              <ul id="facet_{$_expand_id|escape:'html':'UTF-8'}" class="collapse{if !$_collapse} in{/if}">
                <li>
                  <div class="col-sm-12 col-xs-12 col-md-12 facet-dropdown dropdown">
                    <a class="select-title" rel="nofollow" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      {$active_found = false}
                      <span>
                        {foreach from=$facet.filters item="filter"}
                          {if $filter.active}
                            {$filter.label|escape:'html':'UTF-8'}
                            {if $filter.magnitude}
                              ({$filter.magnitude|escape:'html':'UTF-8'})
                            {/if}
                            {$active_found = true}
                          {/if}
                        {/foreach}
                        {if !$active_found}
                          {l s='(no filter)' d='Shop.Theme.Actions'}
                        {/if}
                      </span>
                      <i class="material-icons material-icons-arrow_drop_down pull-xs-right">&#xE5C5;</i>
                    </a>
                    <div class="dropdown-menu">
                      {foreach from=$facet.filters item="filter"}
                        {if !$filter.active}
                          <a
                            rel="nofollow"
                            href="{$filter.nextEncodedFacetsURL|escape:'html':'UTF-8'}"
                            class="select-list"
                          >
                            {$filter.label|escape:'html':'UTF-8'}
                            {if $filter.magnitude}
                              ({$filter.magnitude|escape:'html':'UTF-8'})
                            {/if}
                          </a>
                        {/if}
                      {/foreach}
                    </div>
                  </div>
                </li>
              </ul>
            {/block}

          {/if}
        </section>
      {/if}
    {/foreach}
  </div>
