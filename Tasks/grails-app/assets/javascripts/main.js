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
	

});