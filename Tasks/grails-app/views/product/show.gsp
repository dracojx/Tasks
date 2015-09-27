
<%@ page import="draco.tasks.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-product" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-product" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list product">
			
				<g:if test="${productInstance?.itemId}">
				<li class="fieldcontain">
					<span id="itemId-label" class="property-label"><g:message code="product.itemId.label" default="Item Id" /></span>
					
						<span class="property-value" aria-labelledby="itemId-label"><g:fieldValue bean="${productInstance}" field="itemId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="product.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${productInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="product.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${productInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.mode}">
				<li class="fieldcontain">
					<span id="mode-label" class="property-label"><g:message code="product.mode.label" default="Mode" /></span>
					
						<span class="property-value" aria-labelledby="mode-label"><g:fieldValue bean="${productInstance}" field="mode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.sender}">
				<li class="fieldcontain">
					<span id="sender-label" class="property-label"><g:message code="product.sender.label" default="Sender" /></span>
					
						<span class="property-value" aria-labelledby="sender-label"><g:link controller="service" action="show" id="${productInstance?.sender?.id}">${productInstance?.sender?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.receiver}">
				<li class="fieldcontain">
					<span id="receiver-label" class="property-label"><g:message code="product.receiver.label" default="Receiver" /></span>
					
						<span class="property-value" aria-labelledby="receiver-label"><g:link controller="service" action="show" id="${productInstance?.receiver?.id}">${productInstance?.receiver?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.source}">
				<li class="fieldcontain">
					<span id="source-label" class="property-label"><g:message code="product.source.label" default="Source" /></span>
					
						<span class="property-value" aria-labelledby="source-label"><g:link controller="adapter" action="show" id="${productInstance?.source?.id}">${productInstance?.source?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.target}">
				<li class="fieldcontain">
					<span id="target-label" class="property-label"><g:message code="product.target.label" default="Target" /></span>
					
						<span class="property-value" aria-labelledby="target-label"><g:link controller="adapter" action="show" id="${productInstance?.target?.id}">${productInstance?.target?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.activate}">
				<li class="fieldcontain">
					<span id="activate-label" class="property-label"><g:message code="product.activate.label" default="Activate" /></span>
					
						<span class="property-value" aria-labelledby="activate-label"><g:formatBoolean boolean="${productInstance?.activate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.logs}">
				<li class="fieldcontain">
					<span id="logs-label" class="property-label"><g:message code="product.logs.label" default="Logs" /></span>
					
						<g:each in="${productInstance.logs}" var="l">
						<span class="property-value" aria-labelledby="logs-label"><g:link controller="log" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:productInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${productInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>