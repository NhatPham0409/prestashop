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
    {block name='header_top'}
      <div class="header-top header-top-bg">
        <div class="container" style="padding-top: 0; padding-bottom: 0;">
          <div class="row">
            <div id="_desktop_logo" style="height: 72px; margin-top: 0;" class="col-3">
              <div class="icon_logo"></div>
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
{/if}