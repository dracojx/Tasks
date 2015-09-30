
<%@ page import="draco.tasks.Service" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'service.label', default: 'Service')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-service" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
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
		<div id="list-service" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />(${serviceInstanceList?.size() ?: 0  })</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'service.name.label', default: 'Name')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="description" title="${message(code: 'service.description.label', default: 'Description')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="vendor" title="${message(code: 'service.vendor.label', default: 'Vendor')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${serviceInstanceList}" status="i" var="serviceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="edit" id="${serviceInstance.id}">${fieldValue(bean: serviceInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: serviceInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: serviceInstance, field: "vendor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
