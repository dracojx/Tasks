<%@ page import="draco.tasks.Task"%>
<%@ page import="draco.tasks.Product"%>
<%@ page import="draco.tasks.Service"%>
<%@ page import="draco.tasks.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'task.label', default: 'Task')}" />
</head>
<body>
	<div class="g_6 contents_header">
		<h3 class="i_16_dashboard tab_label">
			<g:message code="${entityName }" />
		</h3>
		<div>
			<span class="label"><g:message code="task.summary.label" /></span>
		</div>
	</div>
	<div class="g_6 contents_options">
		<g:link controller="product" action="create"
			title="${message(code:'default.new.label',args:[message(code:'product.label')]) }">
			<div class="simple_buttons">
				<div class="bwIcon i_16_add">
					<g:message code="default.new.label"
						args="${[message(code:'product.label') ]}" />
				</div>
			</div>
		</g:link>
		<g:link controller="task" action="create"
			title="${message(code:'default.new.label',args:[message(code:'task.label')]) }">
			<div class="simple_buttons">
				<div class="bwIcon i_16_add">
					<g:message code="default.new.label"
						args="${[message(code:'task.label') ]}" />
				</div>
			</div>
		</g:link>
	</div>

	<div class="g_12 separator">
		<span></span>
	</div>

	<!-- Search -->
	<div class="g_12">
		<g:form action="search">
			<g:textField name="keyword" autofocus=""
				placeholder="${message(code:'default.placeholder.keyword') }" />
			<g:textField name="begin" class="pick_date"
				placeholder="${message(code:'default.placeholder.begin') }" />
			<g:textField name="end" class="pick_date"
				placeholder="${message(code:'default.placeholder.end') }" />
			<g:actionSubmit class="simple_buttons" action="search"
				value="${message(code: 'default.button.search.label', default: 'Search')}" />
		</g:form>
	</div>

	<div class="g_12 separator">
		<span></span>
	</div>

	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_tables">
				<g:message code="default.list.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<table class="tables">
				<thead>
					<tr>
						<th><g:message code="task.req.label" default="Req" /></th>

						<th><g:message code="task.title.label" default="Title" /></th>

						<th><g:message code="task.status.label" default="Status" /></th>

						<th><g:message code="task.user.label" default="User" /></th>

						<th><g:message code="task.logs.label" default="Products" /></th>

						<th><g:message code="task.crs.label" default="Crs" /></th>

						<th><g:message code="task.updateDate.label"
								default="Update Date" /></th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${taskInstanceList}" status="i" var="taskInstance">
						<tr
							class="${(i % 2) == 0 ? 'even' : 'odd'} ${taskInstance.activate? '':'inactivate'}">
							<td><g:link action="edit" id="${taskInstance.id}"
									title="${message(code:'default.button.edit.label') }">
									<span class="label"> ${fieldValue(bean: taskInstance, field: "req")}
									</span>
								</g:link></td>

							<td>
								${fieldValue(bean: taskInstance, field: "title")}
							</td>

							<td><g:message code="task.status.${taskInstance.status}" /></td>

							<td>
								${fieldValue(bean: taskInstance, field: "user")}
							</td>

							<td><g:each in="${taskInstance.logs }" var="l">
									<g:link controller="product" action="edit" id="${l.product.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> [<g:message
												code="log.type.${l.type }" />]${l.product.encodeAsHTML() }
										</span>
									</g:link>
									<br />
								</g:each></td>

							<td><g:each in="${taskInstance.crs }" var="c">
									<g:link controller="cr" action="edit" id="${c.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> ${c?.encodeAsHTML()}
										</span>
									</g:link>
									<br />
								</g:each></td>

							<td>
								${taskInstance.updateDate?.format("yyyy/MM/dd") }
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>