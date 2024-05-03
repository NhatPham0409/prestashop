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
<div class="product-add-to-cart">
  {if !$configuration.is_catalog}

    {block name='product_quantity'}
      <div >
        <div class="qty">
          <input type="text" name="qty" id="quantity_wanted" value="{$product.quantity_wanted|escape:'html':'UTF-8'}"
            class="input-group" {*min="{$product.minimal_quantity|escape:'html':'UTF-8'}"*}>
        </div>

        <div class="add">
          <button data-button-action="add-to-cart" type="submit"
            {if !$product.add_to_cart_url} disabled {/if}
              style="cursor: pointer; gap: 0.5rem; @keyframes gradient {
                0% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
                100% {
                    background-position: 0% 50%;
                }};opacity: 0.9; display: flex; height: 40px; width: 100%; align-items: center; justify-content: center; border-radius: 5px; border: none; padding-top: 6px;
        padding-bottom: 6px; font-size: 20px;font-weight: 600;text-transform: uppercase;background-image: radial-gradient(circle, #98c230 0, #59a646 49%, #22994f 75%, #007e42 100%); color:#fff; animation: gradient 4s ease infinite;" >
            {l s='Mua' d='Shop.Theme.Actions'}
          </button>

          {block name='product_availability'}
            <span id="product-availability">
              {if $product.show_availability && $product.availability_message}
                {if $product.availability == 'available'}
                  <i class="material-icons material-icons-check product-available"></i>
                {elseif $product.availability == 'last_remaining_items'}
                  <i class="material-icons product-last-items">&#xE002;</i>
                {else}
                  <i class="material-icons product-unavailable">&#xE14B;</i>
                {/if}
                {$product.availability_message|escape:'html':'UTF-8'}
              {/if}
            </span>
          {/block}

        </div>
        {* {hook h='displayProductActions' product=$product} *}
      </div>
      {* <div class="clearfix"></div> *}
    {/block}

    {block name='product_minimal_quantity'}
      <p class="product-minimal-quantity">
        {if $product.minimal_quantity > 1}
          {l
                s='The minimum purchase order quantity for the product is %quantity%.'
                d='Shop.Theme.Checkout'
                sprintf=['%quantity%' => $product.minimal_quantity]
                }
        {/if}
      </p>
    {/block}
  {/if}
</div>