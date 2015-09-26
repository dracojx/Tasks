
<%@ page import="draco.tasks.Record" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'record.label', default: 'Record')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-record" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-record" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list record">
			
				<g:if test="${recordInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="record.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${recordInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordInstance?.req}">
				<li class="fieldcontain">
					<span id="req-label" class="property-label"><g:message code="record.req.label" default="Req" /></span>
					
						<span class="property-value" aria-labelledby="req-label"><g:link controller="req" action="show" id="${recordInstance?.req?.id}">${recordInstance?.req?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordInstance?.product}">
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="record.product.label" default="Product" /></span>
					
						<span class="property-value" aria-labelledby="product-label"><g:link controller="product" action="show" id="${recordInstance?.product?.id}">${recordInstance?.product?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordInstance?.updateTime}">
				<li class="fieldcontain">
					<span id="updateTime-label" class="property-label"><g:message code="record.updateTime.label" default="Update Time" /></span>
					
						<span class="property-value" aria-labelledby="updateTime-label"><g:formatDate date="${recordInstance?.updateTime}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:recordInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${recordInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
