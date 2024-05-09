
{if $psversion > "1.5.0.0" && $psversion > "1.7.0.0"}
<li class="category_{$node.id}{if isset($last) && $last == 'true'} last{/if}">
<img src="{$link->getCatImageLink($node.name, $node.id, 'small_default')}" align="absmiddle" width="{$image}" style="margin-left:3px; margin-bottom:3px; float:right">

	<a href="{$node.link|escape:'html':'UTF-8'}" {if isset($currentCategoryId) && $node.id == $currentCategoryId}class="selected"{/if}
		title="{$node.desc|strip_tags|trim|truncate:255:'...'|escape:'html':'UTF-8'}">{$node.name|escape:'html':'UTF-8'}</a>
	{if $node.children|@count > 0}
		<ul>
		{foreach from=$node.children item=child name=categoryTreeBranch}
			{if $smarty.foreach.categoryTreeBranch.last}
				{include file="$branche_tpl_path" node=$child last='true'}
			{else}
				{include file="$branche_tpl_path" node=$child last='false'}
			{/if}
		{/foreach}
		</ul>
	{/if}
</li>
{/if}


