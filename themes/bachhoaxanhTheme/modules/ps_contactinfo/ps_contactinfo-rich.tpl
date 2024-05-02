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
<div class="contact-rich">
  <h4>{l s='Store information' d='Shop.Theme.Actions'}</h4>
  <div class="block">
    <div class="icon"><i class="material-icons material-icons-location_on"></i></div>
    <div class="data">{$contact_infos.address.formatted nofilter}</div>
  </div>

  {if isset($tc_config.BLOCKCONTACT_LABEL_PHONE) && $tc_config.BLOCKCONTACT_LABEL_PHONE}
    <hr/>
    <div class="block">
      <div class="icon"><i class="material-icons material-icons-phone"></i></div>
      <div class="data">
        {l s='Call us:' d='Shop.Theme.Actions'}<br/>
        <a href="tel:{$tc_config.BLOCKCONTACTINFOS_PHONE|escape:'html':'UTF-8'}">{$tc_config.BLOCKCONTACT_LABEL_PHONE|escape:'html':'UTF-8'}</a>
       </div>
    </div>
  {/if}
  {if $contact_infos.fax}
    <hr/>
    <div class="block">
      <div class="icon"><i class="material-icons material-icons-print"></i></div>
      <div class="data">
        {l s='Fax:' d='Shop.Theme.Actions'}<br/>
        {$contact_infos.fax|escape:'html':'UTF-8'}
      </div>
    </div>
  {/if}
  {if $contact_infos.email}
    <hr/>
    <div class="block">
      <div class="icon"><i class="material-icons material-icons-mail"></i></div>
      <div class="data email">
        {l s='Email us:' d='Shop.Theme.Actions'}<br/>
       </div>
       <a href="mailto:{$contact_infos.email|escape:'html':'UTF-8'}">{$contact_infos.email|escape:'html':'UTF-8'}</a>
    </div>
  {/if}
</div>
