<!DOCTYPE html>
<html>
<head>
<title><g:message code="project.label"/></title>

<!-- The Main CSS File -->
<asset:stylesheet src="application.css" />
<!-- The Main JS File -->
<asset:javascript src="application.js" />
<!-- Favicon -->
<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
</head>
<body>
	<div class="top_panel"></div>
	<div class="wrapper contents_wrapper">
		<div id="messages" class="g_12">
		</div>
		<div class="login">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_login">
					<g:message code="login.label" />
				</h4>
			</div>
			<div class="widget_contents lgNoPadding">
				<g:form id="login_form"
					url="[resource:userInstance, controller:'user', action:'auth']"
					method="post">
					<div class="line_grid">
						<div class="g_10">
							<g:textField class="simple_field" name="username"
								placeholder="${message(code:'user.username.label') }"
								required="" autofocus="" />
						</div>
						<div class="clear"></div>
					</div>
					<div class="line_grid">
						<div class="g_10">
							<g:passwordField class="simple_field" name="password"
								placeholder="${message(code:'user.password.label') }"
								required="" />
						</div>
						<div class="clear"></div>
					</div>
					<div class="line_grid">
						<div class="g_6">
							<input id="user_login_post" type="button"
								class="submitIt simple_buttons"
								value="${message(code:'default.button.login.label') }" />
						</div>
						<div class="clear"></div>
					</div>
				</g:form>
			</div>
		</div>
	</div>

</body>
</html>
