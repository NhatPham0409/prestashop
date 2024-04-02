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
<div class="block-contact col-md-3 links wrapper">
    <h4 class="text-uppercase block-contact-title hidden-sm-down">{l s='Contact us' d='Shop.Theme.Actions'}</h4>
    <div class="title clearfix hidden-md-up" data-target="#contactinfo_footer" data-toggle="collapse">
        <span class="h3">{l s='Contact us' d='Shop.Theme.Actions'}</span>
        <span class="pull-xs-right">
          <span class="navbar-toggler collapse-icons">
            <i class="material-icons material-icons-add add"></i>
            <i class="material-icons material-icons-remove remove"></i>
          </span>
        </span>
    </div>
    <div id="contactinfo_footer" class="contactinfo_footer collapse">
      {if (isset($contact_infos.address.address1) && $contact_infos.address.address1) || (isset($contact_infos.address.address2) && $contact_infos.address.address2)}
          {if $contact_infos.address.address1}
              <div>
                <i aria-hidden="true" class="icon_pin_alt"></i>
                {l s='Address: [1]%address1%[/1]'
                  sprintf=[
                  '[1]' => '<span>',
                  '[/1]' => '</span>',
                  '%address1%' => $contact_infos.address.address1
                  ]
                  d='Shop.Theme.Actions'
                }
              </div>
          {/if}
          {if $contact_infos.address.address2}
              <div>
                <i aria-hidden="true" class="icon_pin_alt"></i>
                {l s='Address2: [1]%address2%[/1]'
                  sprintf=[
                  '[1]' => '<span>',
                  '[/1]' => '</span>',
                  '%address2%' => $contact_infos.address.address2
                  ]
                  d='Shop.Theme.Actions'
                }
              </div>
          {/if}
          
          
      {else}
        {if isset($contact_infos.address.formatted) && $contact_infos.address.formatted}
            <div>
                <i aria-hidden="true" class="icon_pin_alt"></i>
                {l s='Address: [1]%address%[/1]'
                  sprintf=[
                  '[1]' => '<span>',
                  '[/1]' => '</span>',
                  '%address%' => $contact_infos.address.formatted
                  ]
                  d='Shop.Theme.Actions'
                }
              </div>
        {/if}
      {/if}

      {if isset($tc_config) && $tc_config.BLOCKCONTACTINFOS_PHONE}
        <div><i aria-hidden="true" class="icon_phone"></i>
        {l s='Phone: [1]%phone%[/1]'
          sprintf=[
          '[1]' => '<span>',
          '[/1]' => '</span>',
          '%phone%' => $tc_config.BLOCKCONTACTINFOS_PHONE
          ]
          d='Shop.Theme.Actions'
        }</div>
        
      {/if}
      {if $contact_infos.fax}
        <div>
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Fax: [1]%fax%[/1]'
          sprintf=[
            '[1]' => '<span>',
            '[/1]' => '</span>',
            '%fax%' => $contact_infos.fax
          ]
          d='Shop.Theme.Actions'
        }
        </div>
      {/if}
      {if $contact_infos.email}
        <div><i aria-hidden="true" class="icon_mail_alt"></i>
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Email: [1]%email%[/1]'
          sprintf=[
            '[1]' => '<span>',
            '[/1]' => '</span>',
            '%email%' => $contact_infos.email
          ]
          d='Shop.Theme.Actions'
        }
        </div>
      {/if}
      {if isset($tc_config) && $tc_config.BLOCKCONTACTINFOS_SKYPE}
        <div><i class="fa fa-skype"></i>
        {l
          s='Skype: [1]%skype%[/1]'
          sprintf=[
            '[1]' => '<span>',
            '[/1]' => '</span>',
            '%skype%' => $tc_config.BLOCKCONTACTINFOS_SKYPE
          ]
          d='Shop.Theme.Actions'
        }
        </div>
      {/if}
    </div>
</div>
