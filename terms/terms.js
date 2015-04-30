var height;
var top1;
var sidebar_offset_top;
var anchor;

$(function() {
        sidebarHeight();
        sidebarPosition();
        sidebar_offset_top = $('#sidebar').offset().top;
        
        $("a[href^=#]").on('click focus', function(e) { 
                e.preventDefault(); 
                scrollTo($(this).attr("href"));         
        });
        
        /*$('#sidebar>ul>li').on('focusin', function() {
            $(this).addClass('active');
        });
        $('#sidebar>ul>li').on('focusout', function() {
            $(this).removeClass('active');
        });*/
        
        anchor = location.href.substr(location.href.indexOf('#'));
        if (anchor.length > 0) {
            scrollTo(anchor);
        }

});

$(window).scroll(function() {
        sidebarHeight();
        sidebarPosition();
});

$(window).resize(function() {
        sidebarHeight();
        sidebarPosition();
});

function sidebarHeight() {
    height = $(window).height() - 50;
    if ($(window).scrollTop() < parseInt($('.jumbotron').css('height')) + parseInt($('.jumbotron').css('margin-bottom')) + 50) {

            height = height - parseInt($('.jumbotron').css('height')) - parseInt($('.jumbotron').css('margin-bottom')) + $(window).scrollTop() + 30;
    }
    $('#sidebar').css("height", height + "px");
}

function sidebarPosition() {
    if ($(window).width() > 768) {
        if ($(window).scrollTop() > sidebar_offset_top) {
                top1 = $(window).scrollTop() - sidebar_offset_top + 20;
                //top1 = (sidebar_offset_top - $(window).scrollTop()) - sidebar_offset_top;
                $('#sidebar>ul>li>a[href=#top]').show();
        }
        else {
                top1 = -30;
                $('#sidebar>ul>li>a[href=#top]').hide();
        }
    }
    else {
        top1 = -30;
    }
    $('#sidebar').css({"top": top1 + "px"});
}

function scrollTo(href){
        $('html,body').animate({
                scrollTop: $(href).offset().top - 70},
                'fast');
}

