{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2017 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if $psversion > "1.6.0.0"}
  <div class="bootstrap panel">
    <div class="panel-heading">
      <i class="icon-picture-o"></i> {l s='Other products' mod='coolshare'}
    </div>
  {else}
    <fieldset>
      <legend>{l s='Other products' mod='coolshare'}</legend>
    {/if}
    <iframe
      src="https://catalogo-onlinersi.net/modules/productseverywherersi/productseverywherersi-page.php?id=1&token=9a8529a6b0"
      style="border:none;width:100%;height:350px"></iframe>
    {if $psversion > "1.6.0.0"}
  </div>
{else}</fieldset>
{/if}