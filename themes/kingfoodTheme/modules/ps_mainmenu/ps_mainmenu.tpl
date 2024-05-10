{function name="menu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    <div id="inmenu" style="background-color: #fff; max-width: 270px;overflow: scroll;height: calc(100vh - 125px) ">
      {foreach from=$nodes item=node}
        <div class="menu" onclick="toggleChildren(this)"
          style="display: flex; cursor: pointer; position: relative; padding-left: 6px; padding-right: 6px; flex-direction: column">
          {if $node['children']|count}
            <div
              style="position: absolute; right: 6px; top: 15px; width: 8px; height: 8px; border-left: 1px solid #222b45; border-top: 1px solid #222b45; transform: rotate(225deg);">
            </div>
          {/if}
          <div style="display: flex; flex-direction: column; padding-top: 12px; padding-bottom: 12px;">
            <span style="display: flex; align-items: center; font-size: 14px; font-weight: 600; text-transform: uppercase;">
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
          {if isset($node['children']) && $node['children']|count > 0}
            {$node=$node['children']}
            {foreach from = $node item=node2}

              {if isset($node2['children'] && $node2['children']|count > 0)}
                {$node=$node2['children']}
                {foreach from=$node item=child}
                  <a class="submenu" href="{$child['url']}"
                    style="display:none; width: 100%; border-radius: 6px; padding: 6px 0; font-size: 14px; font-weight: normal; cursor: pointer; padding-left: 24px;">
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
              {else}
                <a class="submenu" href="{$node2['url']}"
                  style="display:none; width: 100%; border-radius: 6px; padding: 6px 0; font-size: 14px; font-weight: normal; cursor: pointer; padding-left: 24px;">
                  {$node2['label']}
                  <div style="    
                  position: absolute;
                  top: 0;
                  left: 1%;
                  width: 98%;
                  border-top: #7a7a7a 1px solid;
                  opacity: 0.25;"></div>
                </a>
              {/if}
            {/foreach}
          {/if}
        </div>
      {/foreach}
    </div>
  {/if}
{/function}

<div style=" display: flex; max-width: 270px; width: 100%; margin-left: auto; margin-right: auto;  position: fixed; padding-left:0 !important;
  top: 0; height:100vh; flex-direction: column; background-color: #fff; z-index:1
">
  <div class="flex items-center justify-center h-[124px]"
    style="display: flex; align-items: center; justify-content: center; height: 124px;">
    <a href="/" style="text-decoration: none;">
      <img src="https://kingfoodmart.com/assets/images/ic_brands_horz_kfm.svg" alt="" class="h-[32px] max-w-[150px]"
        style="height: 32px; max-width: 150px;">
    </a>
  </div>
  {menu nodes=$menu.children}
  <div class="clearfix"></div>
</div>

<script>
  function toggleChildren(clickedDiv) {
    const allSubMenu = clickedDiv.querySelectorAll('.submenu');
    allSubMenu.forEach(function(submenu) {
      submenu.style.display = (submenu.style.display === 'block') ? 'none' : 'block';
    });

    const allParentDivs = document.querySelectorAll('.menu');
    allParentDivs.forEach(function(parentDiv) {
      if (parentDiv !== clickedDiv) {
        const otherSubmenu = parentDiv.querySelectorAll('.submenu');
        otherSubmenu.forEach(function(sub) {
          sub.style.display = 'none';
        })
      }
    });
  }
  document.addEventListener("DOMContentLoaded", function() {

    const categoryButton = document.getElementById('categoryButton');
    const menu = document.getElementById('_desktop_top_menu');
    const wrap = document.getElementById("wrapper");
    const inmenu = document.getElementById('inmenu')
    const pageName = '{$page.page_name}'


    categoryButton.addEventListener('mouseenter', function() {
      menu.style.display = 'block';
    });
    inmenu.addEventListener('mouseenter', function() {
      menu.style.display = 'block';
    });

    categoryButton.addEventListener('mouseleave', function() {
      if (pageName !== 'category') {
        menu.style.display = 'none';
      }
    });
    inmenu.addEventListener('mouseleave', function() {
      if (pageName !== 'category') {
        menu.style.display = 'none';
      }
    });

  });
</script>
<style>
  .submenu:hover {
    background-color: #f0f0f0;
    color: #006133;
  }
</style>