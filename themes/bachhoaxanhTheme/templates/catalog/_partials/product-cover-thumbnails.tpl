{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
 <div class="images-container js-images-container">
 {block name='product_cover'}
   <div >
     {if $product.default_image}
       <picture>
         {if !empty($product.default_image.bySize.large_default.sources.avif)}<source srcset="{$product.default_image.bySize.large_default.sources.avif}" type="image/avif">{/if}
         {if !empty($product.default_image.bySize.large_default.sources.webp)}<source srcset="{$product.default_image.bySize.large_default.sources.webp}" type="image/webp">{/if}
         <img
           class="js-qv-product-cover img-fluid"
           src="{$product.default_image.bySize.large_default.url}"
           {if !empty($product.default_image.legend)}
             alt="{$product.default_image.legend}"
             title="{$product.default_image.legend}"
           {else}
             alt="{$product.name}"
           {/if}
           loading="lazy"
           width="{$product.default_image.bySize.large_default.width}"
           height="{$product.default_image.bySize.large_default.height}"
         >
       </picture>
       
     {else}
       <picture>
         {if !empty($urls.no_picture_image.bySize.large_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.large_default.sources.avif}" type="image/avif">{/if}
         {if !empty($urls.no_picture_image.bySize.large_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.large_default.sources.webp}" type="image/webp">{/if}
         <img
           class="img-fluid"
           src="{$urls.no_picture_image.bySize.large_default.url}"
           loading="lazy"
           width="{$urls.no_picture_image.bySize.large_default.width}"
           height="{$urls.no_picture_image.bySize.large_default.height}"
         >
       </picture>
     {/if}
   </div>
 {/block}

 {block name='product_images'}
   {$product.images = [
    0 => [
      "cover" => "1",
      "id_image" => "5",
      "legend" => "Today is a good day Framed poster",
      "position" => "1",
      "bySize" => [
          "small_default" => [
              "url" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg",
              "width" => 98,
              "height" => 98,
              "sources" => [
                  "jpg" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg"
              ]
          ],
          "cart_default" => [
              "url" => "http://localhost/prestashop/5-cart_default/today-is-a-good-day-framed-poster.jpg",
              "width" => 125,
              "height" => 125,
              "sources" => [
                  "jpg" => "http://localhost/prestashop/5-cart_default/today-is-a-good-day-framed-poster.jpg"
              ]
          ],
          "home_default" => [
              "url" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg",
              "width" => 250,
              "height" => 250,
              "sources" => [
                  "jpg" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg"
              ]
          ],
          "medium_default" => [
              "url" => "http://localhost/prestashop/5-medium_default/today-is-a-good-day-framed-poster.jpg",
              "width" => 452,
              "height" => 452,
              "sources" => [
                  "jpg" => "http://localhost/prestashop/5-medium_default/today-is-a-good-day-framed-poster.jpg"
              ]
          ],
          "large_default" => [
              "url" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg",
              "width" => 800,
              "height" => 800,
              "sources" => [
                  "jpg" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg"
              ]
          ]
      ],
      "small" => [
          "url" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg",
          "width" => 98,
          "height" => 98,
          "sources" => [
              "jpg" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg"
          ]
      ],
      "medium" => [
          "url" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg",
          "width" => 250,
          "height" => 250,
          "sources" => [
              "jpg" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg"
          ]
      ],
      "large" => [
          "url" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg",
          "width" => 800,
          "height" => 800,
          "sources" => [
              "jpg" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg"
          ]
      ],
      "associatedVariants" => [
          0 => "19",
          1 => "20",
          2 => "21"
      ]
  ],
  1 => [
    "cover" => "1",
    "id_image" => "5",
    "legend" => "Today is a good day Framed poster",
    "position" => "1",
    "bySize" => [
        "small_default" => [
            "url" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg",
            "width" => 98,
            "height" => 98,
            "sources" => [
                "jpg" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg"
            ]
        ],
        "cart_default" => [
            "url" => "http://localhost/prestashop/5-cart_default/today-is-a-good-day-framed-poster.jpg",
            "width" => 125,
            "height" => 125,
            "sources" => [
                "jpg" => "http://localhost/prestashop/5-cart_default/today-is-a-good-day-framed-poster.jpg"
            ]
        ],
        "home_default" => [
            "url" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg",
            "width" => 250,
            "height" => 250,
            "sources" => [
                "jpg" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg"
            ]
        ],
        "medium_default" => [
            "url" => "http://localhost/prestashop/5-medium_default/today-is-a-good-day-framed-poster.jpg",
            "width" => 452,
            "height" => 452,
            "sources" => [
                "jpg" => "http://localhost/prestashop/5-medium_default/today-is-a-good-day-framed-poster.jpg"
            ]
        ],
        "large_default" => [
            "url" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg",
            "width" => 800,
            "height" => 800,
            "sources" => [
                "jpg" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg"
            ]
        ]
    ],
    "small" => [
        "url" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg",
        "width" => 98,
        "height" => 98,
        "sources" => [
            "jpg" => "http://localhost/prestashop/5-small_default/today-is-a-good-day-framed-poster.jpg"
        ]
    ],
    "medium" => [
        "url" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg",
        "width" => 250,
        "height" => 250,
        "sources" => [
            "jpg" => "http://localhost/prestashop/5-home_default/today-is-a-good-day-framed-poster.jpg"
        ]
    ],
    "large" => [
        "url" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg",
        "width" => 800,
        "height" => 800,
        "sources" => [
            "jpg" => "http://localhost/prestashop/5-large_default/today-is-a-good-day-framed-poster.jpg"
        ]
    ],
    "associatedVariants" => [
        0 => "19",
        1 => "20",
        2 => "21"
    ]
]
   ]}
   <div class="product-image" style="margin-top: 12px;" >
     <ul class=" js-qv-product-images" style="display: flex; gap: 12px">
       {foreach from=$product.images item=image}
         <li class="thumb-container js-thumb-container">
           <picture>
             {if !empty($image.bySize.small_default.sources.avif)}<source srcset="{$image.bySize.small_default.sources.avif}" type="image/avif">{/if}
             {if !empty($image.bySize.small_default.sources.webp)}<source srcset="{$image.bySize.small_default.sources.webp}" type="image/webp">{/if}
             <img
               class="thumb js-thumb {if $image.id_image == $product.default_image.id_image} selected js-thumb-selected {/if}"
               data-image-medium-src="{$image.bySize.medium_default.url}"
               {if !empty($image.bySize.medium_default.sources)}data-image-medium-sources="{$image.bySize.medium_default.sources|@json_encode}"{/if}
               data-image-large-src="{$image.bySize.large_default.url}"
               {if !empty($image.bySize.large_default.sources)}data-image-large-sources="{$image.bySize.large_default.sources|@json_encode}"{/if}
               src="{$image.bySize.small_default.url}"
               {if !empty($image.legend)}
                 alt="{$image.legend}"
                 title="{$image.legend}"
               {else}
                 alt="{$product.name}"
               {/if}
               loading="lazy"
               width="{$product.default_image.bySize.small_default.width}"
               height="{$product.default_image.bySize.small_default.height}"
             >
           </picture>
         </li>
       {/foreach}
     </ul>
   </div>
 {/block}
{hook h='displayAfterProductThumbs' product=$product}
</div>
