(function ($){
	
	$('.menu_a').click(function(){     
		$(".search-close").click();
		
		var backgroundImage=$(this).css("background-image");
		
	
		 if($(this).hasClass("second_menu_active")){				
				$(this).css("color","#fbb710");
				$(this).css("background-color","#f5f7fa");
				$(this).css("width","100%");
				$(this).css("position", "inherit");
				$(this).css("left","0px");
				$(this).css("text-indent","0px");
				
		
			// alert(backgroundImage);
			 
	/*			color: #fff;
		    background: #1f6bad;
		    width: 230px;
		    left: -40px;
		    position: relative;
		    text-indent: 40px;*/
			 
			 
         }else{
        		$(".second_menu_active").css("background-color","#f5f7fa");
        		$(".second_menu_active").css("color","#959595");
         }
		 
		 
    	var value=$(this).css("background-image");
    	var findString="arrow_up.svg"
    	    		
    	if(value.indexOf(findString)!=-1){    			
    		//모바일 767 미만 화면이고
    		//하단 메뉴가 보일 경우
    		var display=$(this).next().css("display");
    	    if(display=="block"){
    	    	menuClose();
    	    	return;
    	    }    		 		
    	}
		
    	
		
		$(".menu_a").removeClass("menu_arrow");
		$('.sub_menu').removeClass("menu_active");
		$(".menu_close").removeClass("menu_close_bg");
		
		$(this).addClass("menu_arrow");
		$(this).prev().addClass("menu_close_bg");
        $(this).next().addClass("menu_active");
        
        layer_popup();
        
        $(".menu_active").fadeIn();
        
    });
	
	
	
    function layer_popup(el){

        var $el = $(el);        //레이어의 id를 $el 변수에 저장
        //var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수
        var isDim = true;

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

    }

    $('.btn-layerClose, .dimBg, .menu_close, .menu_arrow').click(function(){
    	menuClose();
        return false;
    });
  

    $(".search-nav").click(function(){
    	menuClose();
    });
    
    function menuClose(){ 
    	
		$(".second_menu_active").css("background-color","#1f6bad");
		$(".second_menu_active").css("color","#fff");
		$(".second_menu_active").css("width","230px");
		$(".second_menu_active").css("left","-40px");
		$(".second_menu_active").css("position","relative");
		$(".second_menu_active").css("text-indent","40px");
		
		
    	$('.menu_a').removeClass("menu_arrow");
    	$(".menu_active").fadeOut();    	    
    	$(".menu_close").removeClass("menu_close_bg");
    	$('.menu_a').next().removeClass("menu_active");
    	$('.dim-layer').fadeOut() ; // 닫기 버튼을 클릭하면 레이어가 닫힌다.
    }
    
    
})(jQuery);