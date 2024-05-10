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
<div style="flex: 1;">
  <div class="user-info">
    {if $logged}
      <a class="logout hidden-sm-down" href="{$urls.actions.logout}" rel="nofollow">
        <i class="material-icons">&#xE7FF;</i>
        {l s='Sign out' d='Shop.Theme.Actions'}
      </a>
      <a class="account" href="{$urls.pages.my_account}"
        title="{l s='View my customer account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
        <i class="material-icons hidden-md-up logged">&#xE7FF;</i>
        <span class="hidden-sm-down">{$customerName}</span>
      </a>
    {else}
      <a href="{$urls.pages.authentication}?back={$urls.current_url|urlencode}"
        style="display: flex; align-items: center; text-decoration: none; float:right">
        <div style="margin-right: 0.25rem;">
          <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" style="color: #ffffff;"
            height="20" width="20" xmlns="http://www.w3.org/2000/svg">
            <g>
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path
                d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm-4.987-3.744A7.966 7.966 0 0 0 12 20c1.97 0 3.773-.712 5.167-1.892A6.979 6.979 0 0 0 12.16 16a6.981 6.981 0 0 0-5.147 2.256zM5.616 16.82A8.975 8.975 0 0 1 12.16 14a8.972 8.972 0 0 1 6.362 2.634 8 8 0 1 0-12.906.187zM12 13a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-2a2 2 0 1 0 0-4 2 2 0 0 0 0 4z">
              </path>
            </g>
          </svg>
        </div>
        <div style="display: flex; flex-direction: column">
          <div style="margin-left: 0; margin-right: 0.25rem;">
            <div style="font-size: 0.625rem; line-height: 0.75rem; font-weight: normal; color: #ffffff;">Đăng nhập</div>
          </div>
          <div>
            <div style="font-size: 0.875rem; line-height: 1.25rem; font-weight: bold; color: #ffffff;">Tài khoản</div>
          </div>
        </div>

      </a>
    {/if}
  </div>
</div>