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
{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    <div style="background-color: #fff; max-width: 270px; ">
      {foreach from=$nodes item=node}
        <a class="menu" href="{$node['url']}"
          style="display: flex; cursor: pointer; position: relative; padding-left: 6px; padding-right: 6px">
          {if $node['children']|count}
            <div
            style="position: absolute; right: 6px; top: 15px; width: 8px; height: 8px; border-left: 1px solid #222b45; border-top: 1px solid #222b45; transform: rotate(225deg);">
          </div>
          {/if}
          <div style="display: flex; flex-direction: column; padding-top: 12px; padding-bottom: 12px;">
            <span
              style="display: flex; align-items: center; font-size: 14px; font-weight: 600; text-transform: uppercase;">
              {$node['label']}
            </span>
          </div>
          <div style="    
          position: absolute;
          top: 0;
          left: 1%;
          width: 98%;
          border-top: #7a7a7a 1px solid;
          opacity: 0.25;"></div>
        </a>
        {if $node['children']|count}
          {foreach from=$node['children'] item=child}
            <a class="submenu" href="{$child['url']}"
              style="display:flex; width: 100%; border-radius: 6px; padding: 6px 0; font-size: 14px; font-weight: normal; cursor: pointer; padding-left: 24px">
              {$child['label']}
              <div style="    
              position: absolute;
              top: 0;
              left: 1%;
              width: 98%;
              border-top: #7a7a7a 1px solid;
              opacity: 0.25;"></div>
            </a>

          {/foreach}
        {/if}

      {/foreach}
    </div>

  {/if}
{/function}

<button
  style="position: relative; margin-top: 10px; display: flex; width: 270px; align-items: center; border-top-left-radius: 0.375rem; border-top-right-radius: 0.375rem; background-color: #006133; padding-left: 10px; padding-right: 10px; padding-top: 0.25rem; padding-bottom: 0.25rem; font-size: 16px; color: white; cursor: pointer;"
  disabled="" id="categoryButton">
  <div style="position: relative; display: inline-block; margin-right: 2px;"><img alt="menu" width="0" height="0"
      src="https://www.bachhoaxanh.com/static/icons/menu%20icon.svg"
      style="color: transparent; width: 100%; height: auto;"></div>DANH MỤC SẢN PHẨM
</button>

<div id="_desktop_top_menu" style="display: none; width: 100%; margin-left: auto; margin-right: auto; background-color: rgb(29 29 29/0.8); position: absolute; padding-left:0 !important;
  top: 118px;">
  {menu nodes=$menu.children}
  <div class="clearfix"></div>
</div>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const categoryButton = document.getElementById('categoryButton');
    const menu = document.getElementById('_desktop_top_menu');

    // Thêm hoặc xóa lớp CSS 'hovered' khi hover vào nút
    categoryButton.addEventListener('mouseenter', function() {
      menu.style.display = 'block';
    });
    menu.addEventListener('mouseenter', function() {
      menu.style.display = 'block';
    });

    categoryButton.addEventListener('mouseleave', function() {
      menu.style.display = 'none';
    });
    menu.addEventListener('mouseleave', function() {
      menu.style.display = 'none';
    });
  });
</script>
<style>
.menu:hover {
    background-color: #f0f0f0;
    color: #006133;
}
.submenu:hover {
    background-color: #f0f0f0;
    color: #006133;
}
</style>