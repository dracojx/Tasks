<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<asset:stylesheet src="login.css"/>
<title><g:message code="login.label"/></title>
</head>
<body>
	<div id="page-body" role="main">
		<div id="header">
			<h1><g:message code="login.label"/></h1>
		</div>
		<div>
			<g:if test="${flash.errors}">
				<ul class="errors" role="alert">
					<g:each in="${flash.errors }" var="it">
						<li>${it }</li>
					</g:each>
				</ul>
			</g:if>
			<g:form url="[resource:userInstance, controller:'user', action:'auth']" >
				<fieldset class="form">
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
						<label for="username">
							<g:message code="user.username.label" default="Username" />
						</label>
						<g:textField name="username" required="" value="${userInstance?.username}" autofocus=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
						<label for="password">
							<g:message code="user.password.label" default="Password" />
						</label>
						<g:passwordField name="password" required="" value="${userInstance?.password}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
						<g:actionSubmit class="save" action="auth" id="loginButton" value="${message(code: 'default.button.login.label', default: 'Login')}" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>
