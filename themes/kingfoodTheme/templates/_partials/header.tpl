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
{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  {* <nav class="header-nav">
    <div>
      <div class="row">
        <div class="hidden-sm-down">
          <div class="col-md-5 col-xs-12">
            {hook h='displayNav1'}
          </div>
          <div class="col-md-7 right-nav">
            {hook h='displayNav2'}
          </div>
        </div>
        <div class="hidden-md-up text-sm-center mobile">
          <div class="float-xs-left" id="menu-icon">
            <i class="material-icons d-inline">&#xE5D2;</i>
          </div>
          <div class="float-xs-right" id="_mobile_cart"></div>
          <div class="float-xs-right" id="_mobile_user_info"></div>
          <div class="top-logo" id="_mobile_logo"></div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
  </nav> *}
{/block}

{block name='header_top'}
  <div
    style="display: flex; flex-direction: row; background-color: rgb(255, 118, 0);padding-top: 16px; padding-bottom: 16px; align-items: center;"
    id="header">
    <div style="margin-left: 16px; margin-right: 16px;">
      <a href="{$urls.base_url|escape:'html':'UTF-8'}">
        <img alt="logo"
          src="https://kingfoodmart.com/_next/image?url=%2Fassets%2Fimages%2Ficons%2Fkfm_logo_xmas.png&w=384&q=75"
          width="180px" height="32px" />
      </a>
    </div>
    {hook h='displayTop'}
    {hook h='displayNav2'}

    {* <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
        <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
        <div class="js-top-menu-bottom">
          <div id="_mobile_currency_selector"></div>
          <div id="_mobile_language_selector"></div>
          <div id="_mobile_contact_link"></div>
        </div>
      </div> *}
  </div>
  <div
    style="border-bottom: 1px solid #E4E7EB; background-color: #FFFFFF; display: flex; align-items: center; padding-top: 8px; padding-bottom: 8px; padding-left: 4px; padding-right: 4px; z-index: 100; position: relative">
    <div style="flex: 1;">
      <div
        style="border-bottom: 1px solid #F4F5F7; background-color: #FFFFFF; padding-left: 4px; padding-right: 4px; padding-top: 2px; padding-bottom: 2px;">
        <div style="width: 100%;">
          <div style="display: flex; width: 100%; cursor: pointer; align-items: center; justify-content: space-between;">
            <div style="display: flex; width: 100%; align-items: center; justify-content: space-between;">
              <div style="font-size: 14px; line-height: 20px; font-weight: bold; cursor: pointer; color: #006EFF;">Bạn
                muốn
                mua hàng với hình thức nào?</div>
              <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="16" width="16"
                xmlns="http://www.w3.org/2000/svg" style="color: #000000;">
                <g>
                  <path fill="none" d="M0 0h24v24H0z"></path>
                  <path d="M12 13.172l4.95-4.95 1.414 1.414L12 16 5.636 9.636 7.05 8.222z"></path>
                </g>
              </svg>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div style="margin-left: 4px; margin-right: 4px; display: none; height: 16px; border-left: 0.5px solid #E4E7EB;">
    </div>
    <div style="flex: 1;">
      <div style="display: flex; align-items: center;">
        <div style="flex: 1;">
          <a href="/login" style="text-decoration: none;">
            <div style="display: flex; align-items: center;">
              <div style="margin-right: 2px;">
                <img alt="" src="https://kingfoodmart.com/assets/images/icons/Icon-Shipping-Method.svg" width="32"
                  height="32" decoding="async" data-nimg="1" loading="lazy" style="color: transparent;">
              </div>
              <div>
                <div class="text-[14px] leading-[20px] font-semibold text-content-secondary"
                  style="font-size: 14px; line-height: 20px; font-weight: bold; color: #6B7280;">Thẻ OneLife</div>
                <div class="text-[12px] leading-[16px] font-normal text-content-tertiary"
                  style="font-size: 12px; line-height: 16px; font-weight: normal; color: #9CA3AF;">Đăng nhập để xem số
                  dư
                </div>
              </div>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>

  {hook h='displayCat'}
{/block}