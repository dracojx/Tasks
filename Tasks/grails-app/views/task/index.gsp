
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
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li>
					<g:form>
						<g:textField name="keyword"  placeholder="${message(code: 'default.textField.placeholder.keyword') }" autofocus=""/>
						<input type="date" name="begin" placeholder="${message(code: 'default.input.date.placeholder.begin') }"
							value="${begin }"/>-
						<input type="date" name="end" placeholder="${message(code: 'default.input.date.placeholder.end') }"
							value="${end }"/>
						<g:actionSubmit class="search" action="search" value="${message(code: 'default.button.search.label', default: 'Search')}" />
						<g:hiddenField name="sort" value="${params.sort }"/>
						<g:hiddenField name="order" value="${params.order }"/>
					</g:form>
				</li>
			</ul>
		</div>
		<div id="list-task" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />(${taskInstanceList?.size() ?: 0 })</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="req" title="${message(code: 'task.req.label', default: 'Req')}" 
							action="${action?:'index' }" params="${['keyword':keyword, 'begin':begin, 'end':end] }" />
					
						<g:sortableColumn property="title" title="${message(code: 'task.title.label', default: 'Title')}" 
							action="${action?:'index' }" params="${['keyword':keyword, 'begin':begin, 'end':end] }" />
					
						<g:sortableColumn property="status" title="${message(code: 'task.status.label', default: 'Status')}" 
							action="${action?:'index' }" params="${['keyword':keyword, 'begin':begin, 'end':end] }" />
					
						<th><g:message code="task.user.label" default="User" /></th>
						
						<th><g:message code="task.logs.label" default="Products" /></th>
						
						<th><g:message code="task.crs.label" default="Crs" /></th>
						
						<th><g:message code="task.tags.label" default="Tags" /></th>
					
						<g:sortableColumn property="createDate" title="${message(code: 'task.createDate.label', default: 'Create Date')}" 
							action="${action?:'index' }" params="${['keyword':keyword, 'begin':begin, 'end':end] }" />
					
						<g:sortableColumn property="updateDate" title="${message(code: 'task.updateDate.label', default: 'Update Date')}" 
							action="${action?:'index' }" params="${['keyword':keyword, 'begin':begin, 'end':end] }" />
						
						<th><g:message code="task.remark.label" default="Remark" /></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${taskInstanceList}" status="i" var="taskInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="edit" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "req")}</g:link></td>
					
						<td>${fieldValue(bean: taskInstance, field: "title")}</td>
					
						<td><g:message code="task.status.${taskInstance.status}"/></td>
					
						<td>${fieldValue(bean: taskInstance, field: "user")}</td>
						
						<td>
							<g:each in="${taskInstance.logs }" var="l">
								<g:link controller="product" action="edit" id="${l.product.id}">
									<g:message code="task.logs.log" args="${[message(code:'log.type.'+l.type), l.product.itemId]}"/>
								</g:link>
								<br/>
							</g:each>
						</td>
						
						<td>
							<g:each in="${taskInstance.crs }" var="c">
								<g:link controller="cr" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link>
								<br/>
							</g:each>
						</td>
						
						<td>
							<g:each in="${taskInstance.tags }" var="t">
								<g:link controller="tag" action="edit" id="${t.id}">${t?.encodeAsHTML()}</g:link>
								<br/>
							</g:each>
						</td>
						
						<td>${taskInstance.createDate?.format("yyyy/MM/dd") }</td>
						
						<td>${taskInstance.updateDate?.format("yyyy/MM/dd") }</td>
						
						<td>${fieldValue(bean: taskInstance, field: "remark")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
