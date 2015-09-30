
<%@ page import="draco.tasks.Cr" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cr.label', default: 'Cr')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cr" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li>
					<g:form action="search" >
						<g:textField name="keyword"  placeholder="${message(code: 'default.textField.placeholder.keyword') }" autofocus="" />
						<g:actionSubmit class="search" action="search" value="${message(code: 'default.button.search.label', default: 'Search')}" />
					</g:form>
				</li>
			</ul>
		</div>
		<div id="list-cr" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />(${crInstanceList.size() })</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="number" title="${message(code: 'cr.number.label', default: 'Number')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="description" title="${message(code: 'cr.description.label', default: 'Description')}"
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="status" title="${message(code: 'cr.status.label', default: 'Status')}"
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${crInstanceList}" status="i" var="crInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="edit" id="${crInstance.id}">${fieldValue(bean: crInstance, field: "number")}</g:link></td>
					
						<td>${fieldValue(bean: crInstance, field: "description")}</td>
					
						<td><g:message code="cr.status.${fieldValue(bean: crInstance, field: "status")}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
