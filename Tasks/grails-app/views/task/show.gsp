
<%@ page import="draco.tasks.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-task" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list task">
			
				<g:if test="${taskInstance?.req}">
				<li class="fieldcontain">
					<span id="req-label" class="property-label"><g:message code="task.req.label" default="Req" /></span>
					
						<span class="property-value" aria-labelledby="req-label"><g:fieldValue bean="${taskInstance}" field="req"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="task.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${taskInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="task.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${taskInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="task.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:message code="task.status.${fieldValue(bean:taskInstance, field:'status') }" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="task.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${taskInstance?.user?.id}">${taskInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.crs}">
				<li class="fieldcontain">
					<span id="crs-label" class="property-label"><g:message code="task.crs.label" default="Crs" /></span>
					
						<g:each in="${taskInstance.crs}" var="c">
							<span class="property-value" aria-labelledby="crs-label">
								<g:link controller="cr" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link>
								<g:link controller="task" action="removeCr" resource="${taskInstance}" params="${[cId:c.id] }">x</g:link>
							</span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.logs}">
				<li class="fieldcontain">
					<span id="products-label" class="property-label"><g:message code="task.products.label" default="Products" /></span>
					
						<g:each in="${taskInstance.logs}" var="l">
							<span class="property-value" aria-labelledby="products-label">
								<g:link controller="product" action="show" id="${l.product.id}">${l?.product?.encodeAsHTML()}</g:link>
								<g:link controller="task" action="removeLog" resource="${taskInstance}" params="${[lId:l.id] }">x</g:link>
							</span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:taskInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:if test="${taskInstance?.status.compareTo('4') < 0 }">
						<g:link class="next" action="next" resource="${taskInstance}"><g:message code="default.button.next.label" default="Next Stage" /></g:link>
					</g:if>
					<g:link class="edit" action="edit" resource="${taskInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
