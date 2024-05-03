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

<div class="product_bhx_card">
    <div class="product_bhx_card_item">
        <div style="display: flex;flex-direction: column;height: 100%;">
            <a style="position: relative;width: 100%;text-align: center;" id="product_112898"
                title="Sữa tắm dưỡng sáng Hazeline matcha lựu đỏ 995ml" href="{$product.url|escape:'html':'UTF-8'}">
                <div
                    style="position: relative;display: inline-block;top: 0;left: 0;margin-top: auto;height: auto; object-fit: contain; max-width: 100%;">
                    <img class="img-fluid" alt="{$product.cover.legend|escape:'html':'UTF-8'}" loading="lazy"
                        src="{$product.cover.bySize.home_default.url|escape:'html':'UTF-8'}">
                </div>
            </a>
            <div
                style="display: flex;padding-bottom: 4px;padding-left: 6px; padding-right: 6px;margin-top: 4px; width: 100%;flex: 1 1 0%;flex-direction: column;">
                <a  href={$product.url}>
                    <span
                        style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; line-height: 18px; font-size: 14px; height: 36px; color: rgb(157 167 188 /1); margin-bottom: .5rem;">
                        {$product.name}
                    </span>
                </a>
                <div style="display: block; line-height: .75rem;">
                    <div
                        style="line-height: 18px; font-size: 16px; color: rgb(25 32 56 /1); font-weight: 700; display: flex; margin-top: .125rem;">
                        {$product.price|escape:'html':'UTF-8'}
                        <sup style="font-size: 12px; position: relative; top: 5px;">₫</sup>
                    </div>
                </div>
                {if $product.has_discount}
                    <div class="mb-2px block leading-3">
                        <span
                            style="font-size: 12px;text-decoration-line: line-through; color: color: rgb(157 167 188 /1);line-height: 0px;">{$product.regular_price}₫</span>
                        <span
                            style="font-size: 11px;color: rgb(255 255 255 / 1);line-height: .75rem; font-weight: 700; text-align: center;background-color: rgba(255, 1, 1, .7);border-radius: 2px;margin-left: 3px;padding: 2px;">-{$product.discount_percentage|escape:'html':'UTF-8'}%</span>
                    </div>
                {/if}
            </div>
            <button
                style="border:none;font-size: 16px;height: 40px;color: rgb(0 126 66 /1);text-transform: uppercase;padding-top: 8px;
            padding-bottom: 8px; width: 100%;margin-top: auto;cursor: pointer;background-color: rgb(240 255 243 /1)">Mua</button>
        </div>
    </div>
</div>