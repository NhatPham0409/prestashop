<div class="panel">
    <form action="{$action}" method="post" class="form-horizontal" role="form">
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
                                <option value="{$option.id|escape:'html':'UTF-8'}"
                                    {if isset($fields_value[$input.name]) && $fields_value[$input.name] == $option.id}
                                    selected="selected" {/if}>{$option.name|escape:'html':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    {elseif $input.type == 'switch'}
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
            <button type="submit" class="{$fields_form.submit.class|escape:'html':'UTF-8'}"
                name="submitmwg_themecustom">
                {$fields_form.submit.title|escape:'html':'UTF-8'}
            </button>
        </div>
    </form>
</div>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        // Gán sự kiện 'change' để lắng nghe thay đổi trên switch 'Homepage Product Slide'
        var switchHomepageProductSlide = document.querySelectorAll('input[type="radio"][name="MWG_ISSLIDE"]');
        var inputNumberOfSliderProducts = document.querySelector('input[name="MWG_NUMOFPRODUCT"]').closest(
            '.form-group');

        function toggleNumberOfSliderProductsDisplay() {
            // Kiểm tra xem giá trị của switch 'Homepage Product Slide' có phải là '1' (Yes) không
            var isSlideChecked = Array.from(switchHomepageProductSlide).some(radio => radio.checked && radio
                .value === '1');

            // Nếu Yes (1), hiển thị input 'Number of slider products'
            inputNumberOfSliderProducts.style.display = isSlideChecked ? 'block' : 'none';
        }

        // Thêm sự kiện 'change' vào mỗi radio button của switch
        switchHomepageProductSlide.forEach(function(radio) {
            radio.addEventListener('change', toggleNumberOfSliderProductsDisplay);
        });

        // Gọi hàm để thiết lập trạng thái ban đầu dựa theo giá trị được chọn trước đó
        toggleNumberOfSliderProductsDisplay();
    });
</script>