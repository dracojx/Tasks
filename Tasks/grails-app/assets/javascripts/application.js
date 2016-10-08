// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require jquery-ui-1.8.21.min
//= require md5
//= require_self

if (typeof jQuery !== 'undefined') {
	$(function() {

		/* Overview ========================================== */
		$("#main").load('data/overview');

		/* Button ============================================ */

		$('[id$="_post"]').click(
				function() {
					$("#messages").html('');
					var params = $(this).attr('id').split('_', 2);
					$.post(params[0] + '/' + params[1], $('form').serialize(),
							function(data) {
								if (data.status == '0') {
									window.location.replace(data.url);
								} else if (data.status == '1') {
									for ( var x in data.messages) {
										errorDialog(data.messages[x]);
									}
								} else if (data.status == '2') {
									for ( var x in data.messages) {
										alertDialog(data.messages[x]);
									}
								}
							}, 'json');
			});
	
		$('[id$="_get"').click(function() {
			var params = $(this).attr('id').split('_', 2);
			$('#main').load(params[0] + '/' + params[1]);
		});

		/* Link ============================================== */

		$('.sidebar li').click(function() {
			var index = $(this).index();
			var h3 = $('.contents_header h3').get(index);
			var span = $('.contents_header span').get(index);
			$('.contents_header .active').removeClass('active');
			$('.sidebar .active_tab').removeClass('active_tab');
			$(this).addClass('active_tab');
			$(h3).addClass('active');
			$(span).addClass('active');
		});
	})
}

/* Inline Dialog ===================================== */
function alertDialog(msg) {
	$('#messages').append(
			$('<div>').addClass('alert iDialog').bind('click', function() {
				$(this).fadeOut('slow').promise().done(function() {
					$(this).remove();
				});
			}).html(msg));
}
function errorDialog(msg) {
	$('#messages').append(
			$('<div>').addClass('error iDialog').bind('click', function() {
				$(this).fadeOut('slow').promise().done(function() {
					$(this).remove();
				});
			}).html(msg));
}
