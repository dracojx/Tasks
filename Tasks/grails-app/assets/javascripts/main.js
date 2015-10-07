// JavaScript Document

$(function () {
	
/* Inline Dialog ===================================== */
	
	$(".iDialog").on("click", function(){
		$(this).fadeOut("slow").promise().done(function(){
			$(this).parent().remove();
		});
	});
	
	
/* DatePicker ======================================== */
	
	$(".pick_date").datepicker()
	$(".pick_date").datepicker("option", "dateFormat", "yy/mm/dd")
	
	
/* Forms ============================================= */
	
	$(".simple_form").uniform(); // Style The Checkbox and Radio
	
	
/* Tab Toggle ======================================== */
	
	$(".cwhToggle").click(function(){
		// Get Height
		var wC = $(this).parents().eq(0).find('.widget_contents');
		var wH = $(this).find('.widget_header_title');
		var h = wC.height();

		if (h == 0) {
			wH.addClass("i_16_downT").removeClass("i_16_cHorizontal");
			wC.css('height','auto').removeClass('noPadding');
		}else{
			wH.addClass("i_16_cHorizontal").removeClass("i_16_downT");
			wC.css('height','0').addClass('noPadding');
		}
	})
	
	
/* MD5 ============================================= */
	
	$("#login_form").submit(function(e){
        $("#pass").val(
				$.md5($("#pass").val())
			);
	});
	
	$("#user_create_form").submit(function(e){
        $("#password").val(
				$.md5($("#password").val())
			);
	});
	
	$("#user_reset_form").submit(function(e){
		if($("#password").val() != $("#repeat").val()) {
			return false
		} else {
	        $("#password").val(
					$.md5($("#password").val())
				);
		}
	});

});