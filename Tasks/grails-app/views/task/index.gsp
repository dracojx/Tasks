
<%@ page import="draco.tasks.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-task" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="req" title="${message(code: 'task.req.label', default: 'Req')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'task.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="remark" title="${message(code: 'task.remark.label', default: 'Remark')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'task.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="stage" title="${message(code: 'task.stage.label', default: 'Stage')}" />
					
						<th><g:message code="task.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${taskInstanceList}" status="i" var="taskInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "req")}</g:link></td>
					
						<td>${fieldValue(bean: taskInstance, field: "title")}</td>
					
						<td>${fieldValue(bean: taskInstance, field: "remark")}</td>
					
						<td>${fieldValue(bean: taskInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: taskInstance, field: "stage")}</td>
					
						<td>${fieldValue(bean: taskInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${taskInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
