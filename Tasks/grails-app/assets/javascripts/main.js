// JavaScript Document

$(function () {
	
/* Inline Dialog ===================================== */

	$(".iDialog").on("click", function(){
		$(this).fadeOut("slow").promise().done(function(){
			$(this).parent().remove();
		});
	});
});