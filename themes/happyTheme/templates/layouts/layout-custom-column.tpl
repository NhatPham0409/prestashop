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

{assign var="layout" value=3}
{extends file='layouts/layout-both-columns.tpl'}

{if $layout == 1}
    {block name='right_column'}{/block}

    {block name='content_wrapper'}
        <div id="content-wrapper" class="left-column has_left_col col-xs-12 col-sm-8 col-md-9">
            {block name='content'}
                <p>Hello world! This is HTML5 Boilerplate.</p>
            {/block}
        </div>
    {/block}
{elseif $layout == 2}
    {block name='left_column'}{/block}
    {block name='right_column'}{/block}

    {block name='content_wrapper'}
        <div id="content-wrapper" class="left-column has_left_right_col right-column col-sm-12 col-md-12">
            {block name='content'}
                <p>Hello world! This is HTML5 Boilerplate.</p>
            {/block}
        </div>
    {/block}
{else}
    {block name='left_column'}{/block}

    {block name='content_wrapper'}
        <div id="content-wrapper" class="right-column has_right_col col-xs-12 col-sm-8 col-md-9">
            {block name='content'}
                <p>Hello world! This is HTML5 Boilerplate.</p>
            {/block}
        </div>
    {/block}
{/if}