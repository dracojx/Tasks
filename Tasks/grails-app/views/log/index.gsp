
<%@ page import="draco.tasks.Log" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'log.label', default: 'Log')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-log" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-log" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="type" title="${message(code: 'log.type.label', default: 'Type')}" />
					
						<th><g:message code="log.task.label" default="Task" /></th>
					
						<th><g:message code="log.product.label" default="Product" /></th>
					
						<g:sortableColumn property="updateTime" title="${message(code: 'log.updateTime.label', default: 'Update Time')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${logInstanceList}" status="i" var="logInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${logInstance.id}">${fieldValue(bean: logInstance, field: "type")}</g:link></td>
					
						<td>${fieldValue(bean: logInstance, field: "task")}</td>
					
						<td>${fieldValue(bean: logInstance, field: "product")}</td>
					
						<td><g:formatDate date="${logInstance.updateTime}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${logInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
