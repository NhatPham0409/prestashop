/**
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
 * needs please contact us for extra customization service at an affordable price
 *
 *  @author ETS-Soft <etssoft.jsc@gmail.com>
 *  @copyright  2007-2022 ETS-Soft
 *  @license    Valid for 1 website (or project) for each purchase of license
 *  International Registered Trademark & Property of ETS-Soft
 */

$(document).ready(function(){
    bindGrid();
    if($(".zoomContainer").length){
	      $(".zoomContainer").remove();	
	}
    wcInitImageZoom(); 
   $(document).on('click','.input-color',function(e) {
        restartElevateZoom();
    });
	$(document).on('click','.js-qv-mask img.thumb',function(e) {
        restartElevateZoom();
    });
	$(document).on('click','.input-color',function(e) {
        restartElevateZoom();
    });
    $(document).on('click','.product-cover .layer',function(e){
        setTimeout(function(){
          $('.product-images').slick('refresh');
        }, 1000);
    });
	$(document).on('click','.js-qv-mask img.thumb',function(e) {
        restartElevateZoom();
    });
    var $owl = $('.home-block-section .product_list, .product-accessories .products');
    $owl.owlCarousel({
        items : 4,
        responsive : {
                // breakpoint from 0 up
                0 : {
                    items : 1,
                    margin:0,
                },
                // breakpoint from 480 up
                480 : {
                    items : 2
                },
                // breakpoint from 768 up
                768 : {
                    items : 3
                },
                992 : {
                    items : 4
                }
            },
        nav : true,  
        loop: $(".home-block-section .product_list li").length > 1,
        rewindNav : false,
        margin:30,
        dots : false,         
        navText: ['', ''],  
        callbacks: true,
    });
    
    $(document).on('click','.toogle_search_top', function(e){
        $(this).toggleClass('open').next().toggleClass('open');
    });
    
    $(document).on('click','.toogle_nav_button .toogle_nav', function(e){
        if ($(window).width() < 768)
            $(this).toggleClass('open').next().toggleClass('open');
    });
    $(document).on('click', '.scroll_top > span',function(e) {
         $("html, body").animate({ scrollTop: 0 }, "slow");
         return false;
    });
    $(function() {
            var button_scroll_top = 300;                
            var show_button_scroll = function(){
                var scroll_top_top = $(window).scrollTop(); 
                if (scroll_top_top > button_scroll_top) {
                    $('.scroll_top').addClass('show_scroll');
                } else {
                    $('.scroll_top').removeClass('show_scroll');
                }  

            };
            
            show_button_scroll();
             
            $(window).scroll(function() {
                 show_button_scroll();
            });
    });
    /*$(document).on('click','#left-column .products-section-title, #left-column .title_block', function(){
        if ($(window).width() < 768)
            $(this).toggleClass('open').next().toggleClass('open');
            alert('x');
    });*/
    $('#left-column .products-section-title, #left-column .title_block').on('click', function(e){
        if ($(window).width() < 768)
            $(this).toggleClass('open').next().toggleClass('open');
    });

});




function autohideNavpopular(){
    var viewport = $(window).width();
    var itemCount = $('#homefeatured .ajax_block_product.item').length;
    if(
        (viewport >= 992 && itemCount > 4) //desktop
        || ((viewport >= 768 && viewport < 992) && itemCount > 3) //desktopsmall
        || ((viewport >= 480 && viewport < 768) && itemCount > 2) //tablet
        || (viewport < 479 && itemCount > 2) //mobile
    ){
         $('#homefeatured .owl-nav').show();
    }
    else
    {
         $('#homefeatured .owl-nav').hide();
    }
}


function bindGrid()
{
    var display_product= getCookie('display_product');
    if(display_product=='list')
        display('list');
    
	$(document).on('click','#grid',function(e){
		e.preventDefault();
		display('grid');
	});

	$(document).on('click','#list',function(e){
		e.preventDefault();
		display('list');
	});
}

function display(view)
{
	if (view == 'list')
	{
		if ($('body#prices-drop').length != '' ){
    		$('body#prices-drop .products').removeClass('grid').addClass('list row');
    		$('body#prices-drop .products .product-miniature').addClass('type_list_full_width');
    		$('body#prices-drop .products .product-miniature').each(function(index, element) {
    			$('body#prices-drop .image_item_product').addClass('col-sm-4 col-ms-4 col-xs-12');
                $('body#prices-drop .product-description').addClass('col-sm-8 col-ms-8 col-xs-12');
                $('body#prices-drop .product-flags').addClass('col-sm-4 col-ms-4 col-xs-12');
            });
        }

        if ($('body#search').length != '' ){
            $('body#search .products').removeClass('grid').addClass('list row');
            $('body#search .products .product-miniature').addClass('type_list_full_width');
            $('body#search .products .product-miniature').each(function(index, element) {
                $('body#search .image_item_product').addClass('col-sm-4 col-ms-4 col-xs-12');
                $('body#search .product-description').addClass('col-sm-8 col-ms-8 col-xs-12');
                $('body#search .product-flags').addClass('col-sm-4 col-ms-4 col-xs-12');
            });
        }
        
        if ($('body#new-products').length != '' ){
            $('body#new-products .products').removeClass('grid').addClass('list row');
    		$('body#new-products .products .product-miniature').addClass('type_list_full_width');
    		$('body#new-products .products .product-miniature').each(function(index, element) {
    			$('body#new-products .image_item_product').addClass('col-sm-4 col-ms-4 col-xs-12');
                $('body#new-products .product-description').addClass('col-sm-8 col-ms-8 col-xs-12');
                $('body#new-products .product-flags').addClass('col-sm-4 col-ms-4 col-xs-12');
            });
        }
        
        if ($('body#best-sales').length != '' ){
            $('body#best-sales .products').removeClass('grid').addClass('list row');
    		$('body#best-sales .products .product-miniature').addClass('type_list_full_width');
    		$('body#best-sales .products .product-miniature').each(function(index, element) {
    			$('body#best-sales .image_item_product').addClass('col-sm-4 col-ms-4 col-xs-12');
                $('body#best-sales .product-description').addClass('col-sm-8 col-ms-8 col-xs-12');
                $('body#best-sales .product-flags').addClass('col-sm-4 col-ms-4 col-xs-12');
           });
        }
        if ($('body#category').length != '' ){
            $('body#category .products').removeClass('grid').addClass('list row');
    		$('body#category .products .product-miniature').addClass('type_list_full_width');
            $('body#category .image_item_product').addClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#category .product-description').addClass('col-sm-8 col-ms-8 col-xs-12');
            $('body#category .product-flags').addClass('col-sm-4 col-ms-4 col-xs-12');
    		
        }
		$('.display').find('li#list').addClass('active');
		$('.display').find('li#grid').removeAttr('class');
        setCookie('display_product','list',1);
	}
	else
	{
		$('body#prices-drop .products').removeClass('list').addClass('grid row');
		$('body#prices-drop .products .product-miniature').removeClass('type_list_full_width');
		$('body#prices-drop .products .product-miniature').each(function(index, element) {
			$('body#prices-drop .image_item_product').removeClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#prices-drop .product-description').removeClass('col-sm-8 col-ms-4 col-xs-12');
            $('body#prices-drop .product-flags').removeClass('col-sm-4 col-ms-4 col-xs-12');
         });

        $('body#search .products').removeClass('list').addClass('grid row');
        $('body#search .products .product-miniature').removeClass('type_list_full_width');
        $('body#search .products .product-miniature').each(function(index, element) {
            $('body#search .image_item_product').removeClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#search .product-description').removeClass('col-sm-8 col-ms-4 col-xs-12');
            $('body#search .product-flags').removeClass('col-sm-4 col-ms-4 col-xs-12');
        });
        
        $('body#new-products .products').removeClass('list').addClass('grid row');
		$('body#new-products .products .product-miniature').removeClass('type_list_full_width');
		$('body#new-products .products .product-miniature').each(function(index, element) {
			$('body#new-products .image_item_product').removeClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#new-products .product-description').removeClass('col-sm-8 col-ms-4 col-xs-12');
            $('body#new-products .product-flags').removeClass('col-sm-4 col-ms-4 col-xs-12');
        });
        
        $('body#best-sales .products').removeClass('list').addClass('grid row');
		$('body#best-sales .products .product-miniature').removeClass('type_list_full_width');
		$('body#best-sales .products .product-miniature').each(function(index, element) {
			$('body#best-sales .image_item_product').removeClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#best-sales .product-description').removeClass('col-sm-8 col-ms-4 col-xs-12');
            $('body#best-sales .product-flags').removeClass('col-sm-4 col-ms-4 col-xs-12');
        });
        
        $('body#category .products').removeClass('list').addClass('grid row');
		$('body#category .products .product-miniature').removeClass('type_list_full_width');
		$('body#category .products .product-miniature').each(function(index, element) {
			$('body#category .image_item_product').removeClass('col-sm-4 col-ms-4 col-xs-12');
            $('body#category .product-description').removeClass('col-sm-8 col-ms-4 col-xs-12');
            $('body#category .product-flags').removeClass('col-sm-4 col-ms-4 col-xs-12');
        });
        
        
		$('.display').find('li#grid').addClass('active');
		$('.display').find('li#list').removeAttr('class');
        setCookie('display_product','grid',1);
		
	}
}
function wcInitImageZoom(){
    if ( $( 'div:not(.quickview) .product-cover.product-cover-zoom' ).length > 0 ) {
        var img = $( 'div:not(.quickview) .product-cover.product-cover-zoom' ), img_src = $( 'div:not(.quickview) .product-cover.product-cover-zoom' ).data( 'src' );
            img.zoom({
            touch: false,
            url: img_src
        });
    }

    if ( $( 'div:not(.quickview) .images-container-img-sync .product-cover-zoom' ).length > 0 ) {
        alert('x');
        var img = $( 'div:not(.quickview) .product-images-big .product-cover-zoom' ), img_src1 = $( 'div:not(.quickview) .product-images-big .product-cover-zoom' ).data( 'src' );
            img.zoom({
            touch: false,
            url: img_src1
        });
    }
} 
function restartElevateZoom(){
	$(".zoomImg").remove();
	wcInitImageZoom();
}   
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}  




