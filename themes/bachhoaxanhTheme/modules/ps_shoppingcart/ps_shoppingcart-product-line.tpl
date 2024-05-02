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
{if $product.images}
    <div class="product_cart_img">
        <img src="{$product.images.0.bySize.small_default.url|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}"/>
    </div>
{/if}

<p class="product-name"><span class="product-quantity">{$product.quantity|escape:'html':'UTF-8'}X </span>{$product.name|escape:'html':'UTF-8'}</p>
<p class="product-price">{$product.price|escape:'html':'UTF-8'}</p>
<a class="remove-from-cart" rel="nofollow" href="{$product.remove_from_cart_url|escape:'html':'UTF-8'}" data-link-action="remove-from-cart" title="{l s='remove from cart' d='Shop.Theme.Actions'}">
    <i class="material-icons">&#xE14C;</i>
</a>
{if $product.customizations|count}
    <div class="customizations">
        <ul>
            {foreach from=$product.customizations item='customization'}
                <li>
                    <span class="product-quantity">{$customization.quantity|escape:'html':'UTF-8'}</span>
                    <a href="{$customization.remove_from_cart_url|escape:'html':'UTF-8'}" title="{l s='remove from cart' d='Shop.Theme.Actions'}" class="remove-from-cart" rel="nofollow">{l s='Remove' d='Shop.Theme.Actions'}</a>
                    <ul>
                        {foreach from=$customization.fields item='field'}
                            <li>
                                <span>{$field.label|escape:'html':'UTF-8'}</span>
                                {if $field.type == 'text'}
                                    <span>{$field.text nofilter}</span>
                                {else if $field.type == 'image'}
                                    <img src="{$field.image.small.url|escape:'html':'UTF-8'}">
                                {/if}
                            </li>
                        {/foreach}
                    </ul>
                </li>
            {/foreach}
        </ul>
    </div>
{/if}
