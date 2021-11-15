(function($){
    "use strict";
    
        
        /*=============================================
        =            mobile menu activation            =
        =============================================*/
        $('#mobile-menu-trigger').on('click', function(){
            $('#offcanvas-mobile-menu').removeClass('inactive').addClass('active');
        });
        
        
        $('#offcanvas-menu-close-trigger').on('click', function(){
            $('#offcanvas-mobile-menu').removeClass('active').addClass('inactive');
        });
    
        $('body').on('click', function(e){
            var $target = e.target;
            if (!$($target).is('.offcanvas-wrapper') && !$($target).parents().is('.offcanvas-wrapper') && !$($target).is('#mobile-menu-trigger') && !$($target).parents().is('#mobile-menu-trigger') && $('.offcanvas-mobile-menu').hasClass('active')) {
                $('.offcanvas-mobile-menu').removeClass('active');
            }
        });
        /*=====  End of mobile menu activation  ======*/
    
        /*=============================================
        =            offcanvas menu            =
        =============================================*/
        var $offCanvasNav = $('.offcanvas-navigation'),
            $offCanvasNavSubMenu = $offCanvasNav.find('.sub-menu');
        
        /*Add Toggle Button With Off Canvas Sub Menu*/
        $offCanvasNavSubMenu.parent().prepend('<span class="menu-expand"><i></i></span>');
        
        /*Close Off Canvas Sub Menu*/
        $offCanvasNavSubMenu.slideUp();
        
        /*Category Sub Menu Toggle*/
        $offCanvasNav.on('click', 'li a, li .menu-expand', function(e) {
            var $this = $(this);
            if ( ($this.parent().attr('class').match(/\b(menu-item-has-children|has-children|has-sub-menu)\b/)) && ($this.attr('href') === '#' || $this.hasClass('menu-expand')) ) {
                e.preventDefault();
                if ($this.siblings('ul:visible').length){
                    $this.parent('li').removeClass('active');
                    $this.siblings('ul').slideUp();
                } else {
                    $this.parent('li').addClass('active');
                    $this.closest('li').siblings('li').removeClass('active').find('li').removeClass('active');
                    $this.closest('li').siblings('li').find('ul:visible').slideUp();
                    $this.siblings('ul').slideDown();
                }
            }
        });
        /*=====  End of offcanvas menu  ======*/
    
        /*-- 
           Open Close Trigger
        --------------------------------------------*/
        function parlo_close_open( $openTrigger, $endTrigger, $conTainer ) {
            $openTrigger.on('click', function() {
                $conTainer.addClass('open');
            });
            $endTrigger.on('click', function() {
                $conTainer.removeClass('open');
            }); 
        };
    
        // Header Search Form
        parlo_close_open( $(".search-toggle"), $("button.search-close"), $('.main-search-active') );
    
    
        if ($('.parlo-dropdown').length) {
            var $body = $('body'),
                $parloDropdown = $('.parlo-dropdown'),
                $parloDropdownMenu = $parloDropdown.find('.parlo-dropdown-menu');
            $parloDropdown.on('click', '.parlo-dropdown-toggle', function(e){
                e.preventDefault();
                var $this = $(this);
                
                if(!$this.parent().hasClass('show')) {
                    $parloDropdown.removeClass('show');
                    $parloDropdownMenu.removeClass('show').slideUp();
                    $this.siblings('.parlo-dropdown-menu').addClass('show').slideDown().parent().addClass('show');
                } else{
                    $this.siblings('.parlo-dropdown-menu').removeClass('show').slideUp().parent().removeClass('show');
                }
    
            });
            /*Close When Click Close Button*/
            $parloDropdown.on('click', '.parlo-dropdown-close', function(e){
                e.preventDefault();
                var $this = $(this);
                $this.closest('.parlo-dropdown').removeClass('show').find('.parlo-dropdown-menu').removeClass('show').slideUp();
            });
            /*Close When Click Outside*/
            $body.on('click', function(e){
                var $target = e.target;
                if (!$($target).is('.parlo-dropdown') && !$($target).parents().is('.parlo-dropdown') && $parloDropdown.hasClass('show')) {
                    $parloDropdown.removeClass('show');
                    $parloDropdownMenu.removeClass('show').slideUp();
                }
            });
        }
    
        // Shop Page Custom tab
        var $customTabLinks = $('.parlo-cus-tab-links');
        $customTabLinks.on('click', 'a', function(e){
            e.preventDefault();
            var $this = $(this),
                $target = $this.attr('href');
            $this.addClass('cusactive').parent().siblings().children('a').removeClass('cusactive');
            $('.parlo-cus-tab-pane' + $target).addClass('cusactive').siblings().removeClass('cusactive');
        });
    
    
    
        var WidgetSliderHandler = function ($scope, $) {
    
            var slider_elem = $scope.find('.parlo-slider').eq(0);
    
            if ( slider_elem.length > 0) {
    
                var settings = slider_elem.data('settings');
                var arrows = settings['arrows'];
                var dots = settings['dots'];
                var autoplay = settings['autoplay'];
                var autoplay_speed = parseInt(settings['autoplay_speed']) || 3000;
                var animation_speed = parseInt(settings['animation_speed']) || 300;
                var fade = settings['fade'];
                var pause_on_hover = settings['pause_on_hover'];
                var display_columns = parseInt(settings['product_items']) || 1;
                var scroll_columns = parseInt(settings['scroll_columns']) || 4;
                var tablet_width = parseInt(settings['tablet_width']) || 800;
                var tablet_display_columns = parseInt(settings['tablet_display_columns']) || 1;
                var tablet_scroll_columns = parseInt(settings['tablet_scroll_columns']) || 1;
                var mobile_width = parseInt(settings['mobile_width']) || 480;
                var mobile_display_columns = parseInt(settings['mobile_display_columns']) || 1;
                var mobile_scroll_columns = parseInt(settings['mobile_scroll_columns']) || 1;
    
                slider_elem.slick({
                    arrows: arrows,
                    prevArrow: '<button type="button" class="slick-prev"><i class="sli sli-arrow-left"></i></button>',
                    nextArrow: '<button type="button" class="slick-next"><i class="sli sli-arrow-right"></i></button>',
                    dots: dots,
                    infinite: true,
                    autoplay: autoplay,
                    autoplaySpeed: autoplay_speed,
                    speed: animation_speed,
                    fade: false,
                    pauseOnHover: pause_on_hover,
                    slidesToShow: display_columns,
                    slidesToScroll: scroll_columns,
                    responsive: [
                        {
                            breakpoint: tablet_width,
                            settings: {
                                slidesToShow: tablet_display_columns,
                                slidesToScroll: tablet_scroll_columns
                            }
                        },
                        {
                            breakpoint: mobile_width,
                            settings: {
                                slidesToShow: mobile_display_columns,
                                slidesToScroll: mobile_scroll_columns
                            }
                        }
                    ]
                });
                
            };
        };
    
    
        // Run this code under Elementor.
        $(window).on('elementor/frontend/init', function () {
            elementorFrontend.hooks.addAction( 'frontend/element_ready/parlo-testimonial-addons.default', WidgetSliderHandler);
        });
    
    })(jQuery);