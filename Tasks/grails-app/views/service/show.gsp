
<%@ page import="draco.tasks.Service" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'service.label', default: 'Service')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-service" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-service" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list service">
			
				<g:if test="${serviceInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="service.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${serviceInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="service.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${serviceInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${serviceInstance?.vendor}">
				<li class="fieldcontain">
					<span id="vendor-label" class="property-label"><g:message code="service.vendor.label" default="Vendor" /></span>
					
						<span class="property-value" aria-labelledby="vendor-label"><g:fieldValue bean="${serviceInstance}" field="vendor"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:serviceInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${serviceInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
