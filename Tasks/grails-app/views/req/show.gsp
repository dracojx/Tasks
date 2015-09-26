
<%@ page import="draco.tasks.Req" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'req.label', default: 'Req')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-req" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-req" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list req">
			
				<g:if test="${reqInstance?.req}">
				<li class="fieldcontain">
					<span id="req-label" class="property-label"><g:message code="req.req.label" default="Req" /></span>
					
						<span class="property-value" aria-labelledby="req-label"><g:fieldValue bean="${reqInstance}" field="req"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reqInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="req.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${reqInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reqInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="req.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${reqInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reqInstance?.cr}">
				<li class="fieldcontain">
					<span id="cr-label" class="property-label"><g:message code="req.cr.label" default="Cr" /></span>
					
						<span class="property-value" aria-labelledby="cr-label"><g:fieldValue bean="${reqInstance}" field="cr"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reqInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="req.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${reqInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reqInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="req.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${reqInstance?.user?.id}">${reqInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:reqInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${reqInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
