
{if $psversion > "1.5.0.0"}
<div  id="categories_block_left" class="block-categories" style="clear: both;
    float: left;
    width: 100%;">
	<p class="title_block text-uppercase h6">{l s='Categories' mod='blockcategoriesi'}</p>

		<ul class="category-top-menu {if $isDhtml}dhtml{/if}">
		{foreach from=$blockCategTree.children item=child name=blockCategTree}
			{if $smarty.foreach.blockCategTree.last}
				{include file="$branche_tpl_path" node=$child last='true'}
			{else}
				{include file="$branche_tpl_path" node=$child}
			{/if}
		{/foreach}
		</ul>
		{* Javascript moved here to fix bug #PSCFI-151 *}
	

</div>
{/if}