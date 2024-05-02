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
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Reset your password' d='Shop.Theme.Actions'}
{/block}

{block name='page_content'}
    <form action="{$urls.pages.password|escape:'html':'UTF-8'}" method="post">

      <section class="form-fields renew-password">

        <div class="email">
          {l
            s='Email address: %email%'
            d='Shop.Theme.Actions'
            sprintf=['%email%' => $customer_email|stripslashes]}
        </div>

        <div class="container-fluid">
          <div class="row form-group">
            <label class="form-control-label col-md-3 offset-md-2">{l s='New password' d='Shop.Forms.Labels'}</label>
            <div class="col-md-4">
              <input class="form-control" type="password" data-validate="isPasswd" name="passwd" value="">
            </div>
          </div>

          <div class="row form-group">
            <label class="form-control-label col-md-3 offset-md-2">{l s='Confirmation' d='Shop.Forms.Labels'}</label>
            <div class="col-md-4">
              <input class="form-control" type="password" data-validate="isPasswd" name="confirmation" value="">
            </div>
          </div>

          <input type="hidden" name="token" id="token" value="{$customer_token|escape:'html':'UTF-8'}">
          <input type="hidden" name="id_customer" id="id_customer" value="{$id_customer|escape:'html':'UTF-8'}">
          <input type="hidden" name="reset_token" id="reset_token" value="{$reset_token|escape:'html':'UTF-8'}">

          <div class="row form-group">
            <div class="offset-md-5">
              <button class="btn btn-primary" type="submit" name="submit">
                {l s='Change Password' d='Shop.Theme.Actions'}
              </button>
            </div>
          </div>
        </div>

      </section>
    </form>
{/block}

{block name='page_footer'}
  <ul>
    <li><a href="{$urls.pages.authentication|escape:'html':'UTF-8'}">{l s='Back to Login' d='Shop.Theme.Actions'}</a></li>
  </ul>
{/block}
