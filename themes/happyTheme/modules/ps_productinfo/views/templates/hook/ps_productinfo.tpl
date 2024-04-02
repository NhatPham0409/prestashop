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
<div class="js-productinfo m-t-1">
  {if isset($vars_nb_people)}
    <p>
      {if $vars_nb_people['%nb_people%'] == 1}
        {l s='1 person is currently watching this product.' d='Shop.Theme.Catalog'}
      {else}
        {l s='%nb_people% people are currently watching this product.' sprintf=$vars_nb_people d='Shop.Theme.Catalog'}
      {/if}
    </p>
  {/if}

  {if isset($vars_date_last_order)}
    <p>{l s='Last time this product was bought: %date_last_order%' sprintf=$vars_date_last_order d='Shop.Theme.Catalog'}</p>
  {/if}

  {if isset($vars_date_last_cart)}
    <p>{l s='Last time this product was added to a cart: %date_last_cart%' sprintf=$vars_date_last_cart d='Shop.Theme.Catalog'}</p>
  {/if}
</div>
