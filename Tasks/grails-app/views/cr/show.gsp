
<%@ page import="draco.tasks.Cr" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cr.label', default: 'Cr')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cr" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cr" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cr">
			
				<g:if test="${crInstance?.number}">
				<li class="fieldcontain">
					<span id="number-label" class="property-label"><g:message code="cr.number.label" default="Number" /></span>
					
						<span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${crInstance}" field="number"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${crInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="cr.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${crInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${crInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="cr.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:message code="cr.status.${fieldValue(bean:crInstance, field:'status') }" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${crInstance?.products}">
				<li class="fieldcontain">
					<span id="products-label" class="property-label"><g:message code="cr.products.label" default="Products" /></span>
					
						<g:each in="${crInstance.products}" var="p">
						<span class="property-value" aria-labelledby="products-label"><g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:crInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${crInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
