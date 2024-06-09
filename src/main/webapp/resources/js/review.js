(function($){
	$(".list_share li:first-child").on("click", function(e){
		if($(this).hasClass("cmt_del")===true){
			var $parnetLi =$(this).parent().parent().parent().parent();		
//			$parnetLi.children(":last").hide("fast");
			$parnetLi.children(":last").css("display", "none");
			$(this).removeClass("cmt_del").removeClass("reply_retract").addClass("cmt_reply");
			//$(this).children("a").html("댓글");
			return false;
		}else{		
			var $parnetLi =$(this).parent().parent().parent().parent();
			//$parnetLi.children(":last").show("fast");
			$parnetLi.children(":last").css("display", "block");
			$(this).removeClass("cmt_reply").addClass("cmt_del").addClass("reply_retract");
			$(".re_write_wrap textarea").val("");			
			$(this).children("a").html("댓글취소");
			return false;
		}			
	});

	$(".sorting_wrap_a").on("click", function(e){
		return false;
	});
	
	$(".comment .image").on("click", function(e){

		if($(this).hasClass("on")===true){
			$(this).removeClass("on");
		}else{
			$(this).addClass("on");
		}
	});
	
	
})(jQuery);

function chkword(obj, maxlength) {
    var str = obj.value; // 이벤트가 일어난 컨트롤의 value 값
    var str_length = str.length; // 전체길이
 
    // 변수초기화
    var max_length = maxlength; // 제한할 글자수 크기
    var i = 0; // for문에 사용
    var ko_byte = 0; // 한글일경우는 2 그밗에는 1을 더함
    var li_len = 0; // substring하기 위해서 사용
    var one_char = ""; // 한글자씩 검사한다
    var str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.
 
    for (i = 0; i < str_length; i++) {
        // 한글자추출
        one_char = str.charAt(i);
        ko_byte++;
    }
 
        // 전체 크기가 max_length를 넘지않으면
        if (ko_byte <= max_length) {
            li_len = i + 1;
        }
    
    // 전체길이를 초과하면
    if (ko_byte > max_length) {
        alert(max_length + " 1000byte 이상 초과 할 수 없습니다. ");
        str2 = str.substr(0, max_length);
        obj.value = str2;
    }
   
    $(obj).siblings("span").children("strong").text(ko_byte);    
    obj.focus();
}







