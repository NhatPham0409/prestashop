<?php

/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
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
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 */
class IndexControllerCore extends FrontController
{
    /** @var string */
    public $php_self = 'index';

    /**
     * Assign template vars related to page content.
     *
     * @see FrontController::initContent()
     * 
     */
  
    public function initContent()
    {
        parent::initContent();
        function getCustomParam() 
        {
            $nameValueArray = [];
            $customParam = Db::getInstance()->executeS("SELECT name, value FROM ps_configuration
            WHERE name IN ('MWG_IMAGEWIDTH', 'MWG_ISSLIDE', 'MWG_LAYOUT', 'MWG_NUMOFPRODUCT');");
            foreach ($customParam as $row) {
                $nameValueArray[$row['name']] = $row['value'];
            }
            return $nameValueArray;
        }
        $customParam = getCustomParam();
        $this->context->smarty->assign('customParam', $customParam);
        $this->context->smarty->assign([
            'HOOK_HOME' => Hook::exec('displayHome'),
        ]);
        $this->setTemplate('index');
    }

    
    /**
     * {@inheritdoc}
     */
    public function getCanonicalURL()
    {
        return $this->context->link->getPageLink('index');
    }
}
