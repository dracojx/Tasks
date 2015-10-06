<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:message code="project.label" default="Task Management" /></title>
<!-- The Fonts -->
<link href="http://fonts.useso.com/css?family=Oswald|Droid+Sans:400,700"
	rel="stylesheet">
<!-- The Main CSS File -->
<asset:stylesheet src="style.css" />
<!-- jQuery -->
<asset:javascript src="jQuery/jquery-1.7.2.min.js" />
<!-- The Main JS File -->
<asset:javascript src="main.js" />
</head>
<body>
	<div class="top_panel"></div>
	<div class="wrapper contents_wrapper">
		<g:each in="${flash.errors }" var="it">
			<div class="g_12">
				<div class="error iDialog">
					${it }
				</div>
			</div>
		</g:each>
		<div class="login">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_login">
					<g:message code="login.label" default="Login" />
				</h4>
			</div>
			<div class="widget_contents lgNoPadding">
				<g:form
					url="[resource:userInstance, controller:'user', action:'auth']">
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
								name="password"
								placeholder="${message(code:'user.password.label') }"
								required="" />
						</div>
						<div class="clear"></div>
					</div>
					<div class="line_grid">
						<div class="g_6">
							<g:actionSubmit class="submitIt simple_buttons" action="auth"
								value="${message(code:'login.label') }" />
						</div>
						<div class="clear"></div>
					</div>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>