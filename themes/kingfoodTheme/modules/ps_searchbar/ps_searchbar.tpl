{**
 * 2007-2020 PrestaShop SA and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
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
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<div id="search_widget" style="display: flex; align-items: center; flex:1"
  data-search-controller-url="{$search_controller_url}">
  <form method="get" action="{$search_controller_url}" style="display: flex; width:100%">
    <div style="display: flex; flex: 1; width:100%">
      <div
        style="width: 100%; display: flex; height: 36px; border-radius: 92px; border: 1px solid #e2e8f0; padding: 0.5rem; justify-content: space-between; background-color: #ffffff;"
        class="SearchBar">
        <div style="display: flex; width: 100%;">
          <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24"
            style="margin-right: 0.5rem; color:  rgb(50 128 246);" height="20" width="20"
            xmlns="http://www.w3.org/2000/svg">
            <g>
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path
                d="M18.031 16.617l4.283 4.282-1.415 1.415-4.282-4.283A8.96 8.96 0 0 1 11 20c-4.968 0-9-4.032-9-9s4.032-9 9-9 9 4.032 9 9a8.96 8.96 0 0 1-1.969 5.617zm-2.006-.742A6.977 6.977 0 0 0 18 11c0-3.868-3.133-7-7-7-3.868 0-7 3.132-7 7 0 3.867 3.132 7 7 7a6.977 6.977 0 0 0 4.875-1.975l.15-.15zm-3.847-8.699a2 2 0 1 0 2.646 2.646 4 4 0 1 1-2.646-2.646z">
              </path>
            </g>
          </svg>
          <input placeholder="Tìm sản phẩm trong Kingfoodmart"
            style="width: 100%; background-color: transparent; font-size: 0.875rem; flex: 1;" type="text; ">
        </div>

      </div>
    </div>

  </form>
</div>