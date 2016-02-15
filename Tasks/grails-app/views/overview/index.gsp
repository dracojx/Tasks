<%@ page import="draco.tasks.Task"%>
<%@ page import="draco.tasks.Product"%>
<%@ page import="draco.tasks.Service"%>
<%@ page import="draco.tasks.Adapter"%>
<%@ page import="draco.tasks.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="g_3 quick_stats">
		<div class="big_stats visitor_stats">
			${Task.count() }
		</div>
		<h5 class="stats_info">
			<g:message code="task.label" />
		</h5>
	</div>
	<div class="g_3 quick_stats">
		<div class="big_stats tickets_stats">
			${Product.count() }
		</div>
		<h5 class="stats_info">
			<g:message code="product.label" />
		</h5>
	</div>
	<div class="g_3 quick_stats">
		<div class="big_stats users_stats">
			${Service.count() }
		</div>
		<h5 class="stats_info">
			<g:message code="service.label" />
		</h5>
	</div>
	<div class="g_3 quick_stats">
		<div class="big_stats orders_stats">
			${Adapter.count() }
		</div>
		<h5 class="stats_info">
			<g:message code="adapter.label" />
		</h5>
	</div>

	<div class="g_12 separator under_stat">
		<span></span>
	</div>

	<g:if test="${taskInstanceList }">
		<div class="g_12">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_tables">
					<g:message code="overview.task.todo.label" />
				</h4>
			</div>
			<div class="widget_contents noPadding">

				<table class="tables">
					<thead>
						<tr>
							<th><g:message code="task.req.label" default="Req" /></th>

							<th><g:message code="task.title.label" default="Title" /></th>

							<th><g:message code="task.status.label" default="Status" /></th>

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

								<td><span class="label"> ${taskInstance.updateDate?.format("yyyy/MM/dd") }
								</span></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</g:if>

	<g:if test="${preparingList }">
		<div class="g_12">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_tables">
					<g:message code="overview.task.status.4.label" />
				</h4>
			</div>
			<div class="widget_contents noPadding">

				<table class="tables">
					<thead>
						<tr>
							<th><g:message code="task.req.label" default="Req" /></th>

							<th><g:message code="task.title.label" default="Title" /></th>

							<th><g:message code="task.logs.label" default="Products" /></th>

							<th><g:message code="task.crs.label" default="Crs" /></th>
							
							<th><g:message code="default.actions.label"/></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${preparingList}" status="i" var="taskInstance">
							<tr class="${taskInstance.activate? '':'inactivate'}">
								<td><g:link controller="task" action="edit"
										id="${taskInstance.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> ${fieldValue(bean: taskInstance, field: "req")}
										</span>
									</g:link></td>

								<td><span class="label"> ${fieldValue(bean: taskInstance, field: "title")}
								</span></td>

								<td class="nowrap"><g:each in="${taskInstance.logs }"
										var="l">
										<g:link controller="product" action="edit"
											id="${l.product.id}"
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
									<g:link controller="task" action="publish" id="${taskInstance.id}">
										<div class="simple_buttons">
											<div>
												<g:message code="default.button.publish.label" />
											</div>
										</div>
									</g:link>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</g:if>

	<g:if test="${crInstanceList }">
		<div class="g_12">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_tables">
					<g:message code="overview.cr.status.4.label" />
				</h4>
			</div>
			<div class="widget_contents noPadding">
				<table class="tables">
					<thead>
						<tr>
							<th><g:message code="cr.number.label" default="Number" /></th>

							<th><g:message code="cr.description.label"
									default="Description" /></th>

							<th><g:message code="cr.status.label" default="Status" /></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${crInstanceList}" var="crInstance">
							<tr>
								<td><g:link controller="cr" action="edit"
										id="${crInstance.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> ${fieldValue(bean: crInstance, field: "number")}
										</span>
									</g:link></td>

								<td><span class="label"> ${fieldValue(bean: crInstance, field: "description")}
								</span></td>

								<td class="nowrap"><span class="label"> <g:message
											code="cr.status.${crInstance.status}" />
								</span></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</g:if>
</body>
</html>