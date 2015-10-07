<%@ page import="draco.tasks.Adapter" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'adapter.label')}" />
</head>
<body>
	
	<g:hasErrors bean="${adapterInstance}">
		<div class="g_12">
			<g:eachError bean="${adapterInstance}" var="error">
				<div class="alert iDialog"><g:message error="${error}"/></div>
			</g:eachError>
		</div>
	</g:hasErrors>
	
	<g:if test="${flash.errors }">
		<div class="g_12">
			<g:each in="${flash.errors }" var="error">
				<div class="alert iDialog">${error }</div>
			</g:each>
		</div>
	</g:if>
	
	<g:if test="${flash.message }">
		<div class="g_12">
			<div class="success iDialog">${flash.message }</div>
		</div>
	</g:if>
	
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.edit.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:adapterInstance, action:'update']" method="PUT">
				<g:render template="form" model="${[adapterInstance:adapterInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:actionSubmit action="update" class="simple_buttons"
							 value="${message(code: 'default.button.update.label', default: 'Update')}" />
					</div>
				</div>
			</g:form>
		</div>	
	</div>
</body>
</html>
