<%@ page import="draco.tasks.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-task" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.error}">
				<ul class="errors" role="alert">
					<li>${flash.error }</li>
				</ul>
			</g:if>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}${flash.error}</div>
			</g:if>
			<g:hasErrors bean="${taskInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${taskInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:taskInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${taskInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:if test="${taskInstance?.status.toInteger() > 0 }">
						<g:link action="prev" resource="${taskInstance}"><g:message code="default.button.prev.label" default="Prev Stage" /></g:link>
					</g:if>
					<g:if test="${taskInstance?.status.toInteger() < 4 }">
						<g:link action="next" resource="${taskInstance}"><g:message code="default.button.next.label" default="Next Stage" /></g:link>
					</g:if>
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:if test="${taskInstance?.activate}">
						<g:link class="delete" action="delete" resource="${taskInstance}"><g:message code="default.button.close.label" default="Close" /></g:link>
					</g:if>
					<g:if test="${!taskInstance?.activate}">
						<g:link class="save" action="activate" resource="${taskInstance}"><g:message code="default.button.activate.label" default="Activate" /></g:link>
					</g:if>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
