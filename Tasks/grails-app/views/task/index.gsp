<%@ page import="draco.tasks.Task"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'task.label', default: 'Task')}" />
</head>
<body>
	<!-- Search -->
	<div class="g_12">
		<g:form action="search">
			<div class="g_3">
				<g:textField name="keyword" autofocus=""
					placeholder="${message(code:'default.placeholder.keyword') }" />
			</div>
			<div class="g_3">
				<g:textField name="begin" class="pick_date"
					placeholder="${message(code:'default.placeholder.begin') }" />
			</div>
			<div class="g_3">
				<g:textField name="end" class="pick_date"
					placeholder="${message(code:'default.placeholder.end') }" />
			</div>
			<div class="g_3">
				<g:actionSubmit class="simple_buttons" action="search"
					value="${message(code: 'default.button.search.label', default: 'Search')}" />
			</div>
		</g:form>
	</div>

	<div class="g_12 separator">
		<span></span>
	</div>

	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_tables">
				<g:message code="default.list.label" args="[entityName]" />
				(
				${taskInstanceList?.size() ?: '0' }
				)
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
						<tr class="${taskInstance.activate? '':'inactivate'}">
							<td><g:link controller="task" action="edit"
									id="${taskInstance.id}"
									title="${message(code:'default.button.edit.label') }">
									<span class="label"> ${fieldValue(bean: taskInstance, field: "req")}
									</span>
								</g:link></td>

							<td><span class="label"> ${fieldValue(bean: taskInstance, field: "title")}
							</span></td>

							<td class="nowrap"><span class="label"> <g:if
										test="${taskInstance.activate }">
										<g:message code="task.status.${taskInstance.status}" />
									</g:if> <g:else>
										<g:message code="task.activate.${taskInstance.activate}" />
									</g:else>
							</span></td>

							<td class="nowrap"><span class="label"> ${fieldValue(bean: taskInstance, field: "user")}
							</span></td>

							<td class="nowrap"><g:each in="${taskInstance.logs }"
									var="l">
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

							<td><span class="label"> ${taskInstance.updateDate?.format("yyyy/MM/dd") }
							</span></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>