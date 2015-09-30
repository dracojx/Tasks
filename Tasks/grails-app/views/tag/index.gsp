
<%@ page import="draco.tasks.Tag" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tag.label', default: 'Tag')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tag" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
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
		<div id="list-tag" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />(${tagInstanceList.size() })</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'tag.name.label', default: 'Name')}"
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tagInstanceList}" status="i" var="tagInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="edit" id="${tagInstance.id}">${fieldValue(bean: tagInstance, field: "name")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
