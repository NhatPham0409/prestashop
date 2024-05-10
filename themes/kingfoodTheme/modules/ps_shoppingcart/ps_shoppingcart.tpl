{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
<div style="margin-right: 16px; margin-left: 16px">
  <a href="{$cart_url}" style="text-decoration: none;">
    <div style="display: flex; align-items: center;">
      <div style="position: relative;">
        <button type="button" class="cart-button"
          style="display: flex; height: 40px; align-items: center; justify-content: center; padding: 0; font-weight: bold; font-size: 16px; border: none; width: 40px; flex-shrink: 0; background: transparent; ">
          <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="22" width="22"
            xmlns="http://www.w3.org/2000/svg">
            <g>
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path
                d="M4 6.414L.757 3.172l1.415-1.415L5.414 5h15.242a1 1 0 0 1 .958 1.287l-2.4 8a1 1 0 0 1-.958.713H6v2h11v2H5a1 1 0 0 1-1-1V6.414zM6 7v6h11.512l1.8-6H6zm-.5 16a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm12 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z">
              </path>
            </g>
          </svg>
        </button>
        <div
          style="position: absolute; top: 0; right: -1px; display: flex; height: 16px; align-items: center; justify-content: center; border-radius: 50%; border: 1px solid #ffffff; background-color: #f00; padding: 1px; font-weight: bold; font-size: 14px; color: #ffffff; transform: scale(1);">
          0</div>
      </div>
      <div style="font-size: 14px; line-height: 20px; font-weight: bold; color: #ffffff; ">Giỏ hàng</div>
    </div>
  </a>
</div>

<style>
  .cart-button {
    color: #ffffff;
  }

  .cart-button :hover {
    color: #40a9ff;
    cursor: pointer;
  }
</style>