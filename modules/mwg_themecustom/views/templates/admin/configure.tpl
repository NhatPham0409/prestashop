<div class="panel">
    <form action="{$action}" method="post" class="form-horizontal" role="form">
        {dump($fields_form)}
        {foreach from=$fields_form.input item=input}
            <div class="form-group">
                <label class="control-label col-lg-3">
                    {$input.label|escape:'html':'UTF-8'}{if $input.required} *{/if}
                </label>
                <div class="col-lg-9">
                    {if $input.type == 'select'}
                        <select name="{$input.name|escape:'html':'UTF-8'}" {if isset($input.multiple) && $input.multiple}
                            multiple="multiple" {/if} class="form-control">
                            {foreach from=$input.options.query item=option}
                                <option value="{$option.id|escape:'html':'UTF-8'}">{$option.name|escape:'html':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    {elseif $input.type == 'switch' }
                        <div class="switch prestashop-switch">
                            {foreach from=$input.values item=value}
                                <input type="radio" id="{$input.name}_{$value.value|escape:'html':'UTF-8'}"
                                    name="{$input.name|escape:'html':'UTF-8'}" value="{$value.value|escape:'html':'UTF-8'}"
                                    {if isset($fields_value[$input.name]) && $fields_value[$input.name] == $value.value}
                                    checked{/if}>
                                <label
                                    for="{$input.name}_{$value.value|escape:'html':'UTF-8'}">{$value.label|escape:'html':'UTF-8'}</label>
                            {/foreach}
                            <a class="slide-button btn"></a>
                        </div>
                        {if $input.desc}
                            <p class="help-block">{$input.desc|escape:'html':'UTF-8'}</p>
                        {/if}
                    {elseif $input.type == 'text'}
                        <input class="form-control" type="text" name="{$input.name|escape:'html':'UTF-8'}"
                            value="{if isset($fields_value[$input.name])}{$fields_value[$input.name]|escape:'html':'UTF-8'}{/if}"
                            size="{$input.size|default:50|escape:'html':'UTF-8'}" />
                        {if $input.desc}
                            <p class="help-block">{$input.desc|escape:'html':'UTF-8'}</p>
                        {/if}
                    {/if}
                </div>
            </div>
        {/foreach}

        <div class="panel-footer">
            <button type="submit" class="{$fields_form.submit.class|escape:'html':'UTF-8'}">
                {$fields_form.submit.title|escape:'html':'UTF-8'}
            </button>
        </div>
    </form>
</div>