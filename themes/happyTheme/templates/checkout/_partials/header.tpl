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
{if isset($tc_config.YBC_TC_LAYOUT) && $tc_config.YBC_TC_LAYOUT == 'layouthome2'}
    {include file='_partials/header/header2.tpl'}
{else if isset($tc_config.YBC_TC_LAYOUT) && $tc_config.YBC_TC_LAYOUT == 'layouthome3'}
    {include file='_partials/header/header3.tpl'}
{else}
<div class="header_content">
{block name='header_nav'}
  <nav class="header-nav">
    <div class="container">
        <div class="nav">
            <div class="left-nav">
              {hook h='ybcCustom4'}
            </div>
            
            <div class="toogle_nav_button">
                <span class="toogle_nav">
                    <i class="material-icons">&#xE8B8;</i>
                    {l s='Settings' d='Shop.Theme.Action'}
                </span>
                <div class="toogle_nav_content">
                   {hook h='displayNav2'}
                </div>
            </div>
            <div class="ybc_myaccout">
                <div class="toogle_user">
                    <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='My account' d='Shop.Theme.Actions'}" rel="nofollow" >
                        <i class="material-icons">&#xE7FF;</i>
                        <span>{l s='My account' d='Shop.Theme.Actions'}</span>
                    </a>
                </div>
            </div>

            {if $customer.is_logged}
              <a class="logout userinfor" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}" rel="nofollow" >
                <i class="fa fa-unlock"></i>
                {l s='Sign out' d='Shop.Theme.Actions'}
              </a>
            {else}
              <a class="login userinfor" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='Log in to your customer account' d='Shop.Theme.Actions'}" rel="nofollow" >
                
                <i class="fa fa-key"></i>
                <span>{l s='Sign in' d='Shop.Theme.Actions'}</span>
              </a>
            {/if}
        </div>
    </div>
  </nav>
{/block}

    {block name='header_top'}
        <div class="header-top">
            <div class="container">
                <div class="row">
                    <div id="_desktop_logo">
                        <a href="{$urls.base_url|escape:'html':'UTF-8'}">
                            <img class="logo img-responsive" src="{if isset($tc_dev_mode) && $tc_dev_mode && isset($logo_url)&&$logo_url}{$logo_url|escape:'html':'UTF-8'}{else}{$shop.logo|escape:'html':'UTF-8'}{/if}" alt="{$shop.name|escape:'html':'UTF-8'}">
                        </a>
                    </div>
                    {hook h='displayNav1'}
                    {hook h='displayTop'}
                </div>
            </div>
        </div>
        {hook h='displayNavFullWidth'}
        {hook h='displayMegaMenu'}
    {/block}
</div>

{if $page.page_name == 'index'}
    <div id="slider_row">
        <div id="top_column" class="container">
            <div id="ybc-nivo-slider-wrapper" class="theme-default">
                {hook h='displayMLS'}
            </div>
            {hook h='displaytopcolumn'}
        </div>
    </div>
{/if}
{/if}
