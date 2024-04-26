
<div style="display:flex; margin-left:80px">
{dump($apiData)}
  <div>
    {foreach from=$apiData item=category}
      <ul style='list-style : none'>
        <li style='list-style : none'>
          <input type="checkbox" id="{$category.id}" {if $category.active}checked{/if}  >
          <label for="{$category.id}">{$category.name}</label>
          {foreach from=$category.children item=subcategory}
            <ul>
              <li>
                <input type="checkbox" id="{$subcategory.id}" {if $subcategory.active}checked{/if}>
                <label for="{$subcategory.id}">{$subcategory.name}</label>
              </li>
            </ul>
          {/foreach}
        <li>
      </ul>
    {/foreach}

  </div>
</div>


<script>    
    document.addEventListener('DOMContentLoaded', function() {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            var isChecked = this.checked;
            var siblings = this.parentElement.querySelectorAll('input[type="checkbox"]');
            console.log(siblings);
            siblings.forEach(function(sibling) {
                sibling.checked = isChecked;
            });
            console.log('kaslds')
        });
    });
});
</script>


<style>
/* CSS cho các trường được chọn */
input[type="checkbox"]:checked + label {
    font-weight: bold;
    color: red;
} 
</style>