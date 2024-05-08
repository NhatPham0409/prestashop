<?php

// themes/{your_theme_name}/modules/ps_mainmenu/ps_mainmenu.php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once _PS_MODULE_DIR_ . 'ps_mainmenu/ps_mainmenu.php';

class Ps_MainmenuOverride extends Ps_Mainmenu
{
    public function renderWidget($hookName, array $configuration)
    {
        // Cấu hình thông tin để truyền tới template
        $widgetVariables = $this->getWidgetVariables($hookName, $configuration);
        $this->context->smarty->assign([
            'newMenu' => '1',
        ]);

        // Gọi method của lớp cha và return nếu cần
        return parent::renderWidget($hookName, $configuration);
    }

}