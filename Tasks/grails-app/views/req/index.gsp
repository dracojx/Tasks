
<%@ page import="draco.tasks.Req" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'req.label', default: 'Req')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-req" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-req" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="req" title="${message(code: 'req.req.label', default: 'Req')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'req.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="remark" title="${message(code: 'req.remark.label', default: 'Remark')}" />
					
						<g:sortableColumn property="cr" title="${message(code: 'req.cr.label', default: 'Cr')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'req.status.label', default: 'Status')}" />
					
						<th><g:message code="req.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${reqInstanceList}" status="i" var="reqInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${reqInstance.id}">${fieldValue(bean: reqInstance, field: "req")}</g:link></td>
					
						<td>${fieldValue(bean: reqInstance, field: "title")}</td>
					
						<td>${fieldValue(bean: reqInstance, field: "remark")}</td>
					
						<td>${fieldValue(bean: reqInstance, field: "cr")}</td>
					
						<td>${fieldValue(bean: reqInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: reqInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${reqInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
