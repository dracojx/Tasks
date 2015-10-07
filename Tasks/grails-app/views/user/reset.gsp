<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'user.password.label', default: 'Password')}" />
</head>
<body>
	
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.reset.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:userInstance, action:'resetPass']" id="user_reset_form">
				<g:render template="form" model="${[userInstance:userInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:submitButton name="create" class="simple_buttons"
							 value="${message(code: 'default.button.reset.label', default: 'Reset')}" />
					</div>
				</div>
			</g:form>
		</div>	
	</div>
</body>
</html>
