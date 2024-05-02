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
<div id="block_myaccount_infos" class="myaccount-footer col-xs-12 col-sm-3 links wrapper">
  <h3 class="myaccount-title hidden-sm-down text-uppercase">
    <a class="text-uppercase" href="{$urls.pages.my_account|escape:'html':'UTF-8'}" rel="nofollow">
      {l s='Your account' d='Shop.Theme.Actions'}
    </a>
  </h3>
  <div class="title clearfix hidden-md-up" data-target="#footer_account_list" data-toggle="collapse">
    <span class="h3">{l s='Your account' d='Shop.Theme.Actions'}</span>
    <span class="pull-xs-right">
      <span class="navbar-toggler collapse-icons">
        <i class="material-icons material-icons-add add"></i>
        <i class="material-icons material-icons-remove remove"></i>
      </span>
    </span>
  </div>
  <ul class="account-list collapse" id="footer_account_list">
    {foreach from=$my_account_urls item=my_account_url}
        <li>
          <a href="{$my_account_url.url|escape:'html':'UTF-8'}" title="{$my_account_url.title|escape:'html':'UTF-8'}" rel="nofollow">
            {$my_account_url.title|escape:'html':'UTF-8'}
          </a>
        </li>
    {/foreach}
    {hook h='displayMyAccountBlock'}
	</ul>
</div>
