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
<div id="_desktop_contact_link">
  <div id="contact-link" class="shop_text_nav">
    <i aria-hidden="true" class="fa fa-phone-square"></i>
    <div class="shop_text_nav_config">
      {if $contact_infos.phone}
        {l s='[1]%phone%[/1] 24/7 Online Support' sprintf=[ '[1]' => '<span>', '[/1]' => '</span>', '%phone%' => $contact_infos.phone ] d='Shop.Theme.Actions' }

      {else}
        {if isset($tc_config)}
          <a href="tel:{$tc_config.BLOCKCONTACTINFOS_PHONE|escape:'html':'UTF-8'}"><span>{$tc_config.BLOCKCONTACT_LABEL_PHONE|escape:'html':'UTF-8'}</span></a>
        {/if}
        {l s='24/7 Online Support' d='Shop.Theme.Actions' }
      {/if}
    </div>
  </div>
</div>
