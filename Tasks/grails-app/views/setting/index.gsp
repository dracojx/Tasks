<%@ page import="draco.tasks.Service"%>
<%@ page import="draco.tasks.Adapter"%>
<%@ page import="draco.tasks.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>

	<div class="g_12">
		<g:if test="${!session.system }">
			<div class="g_2">
				<g:link controller="user" action="reset" id="${session.userId }"
					title="${message(code:'default.button.reset.label') }">
					<div class="simple_buttons">
						<div class="bwIcon i_16_spinner">
							<g:message code="default.button.reset.label" />
						</div>
					</div>
				</g:link>
			</div>
		</g:if>
		<div class="g_2">
			<g:link controller="setting" action="download"
				title="${message(code:'default.button.download.label') }">
				<div class="simple_buttons">
					<div class="bwIcon i_16_data">
						<g:message code="default.button.download.label" />
					</div>
				</div>
			</g:link>
		</div>
		<g:if test="${session.admin && !session.system }">
			<g:form action="upload" enctype="multipart/form-data">
				<div class="g_3">
					<input type="file" class="simple_form" name="excelFile" />
				</div>
				<div class="g_2">
					<g:actionSubmit class="simple_buttons" action="upload"
						value="${message(code:'default.button.upload.label') }" />
				</div>
			</g:form>
		</g:if>
	</div>

	<div class="g_12 separator">
		<span></span>
	</div>

	<g:if test="${session.system }">
		<div class="g_12">
			<div class="widget_header">
				<h4 class="widget_header_title wwIcon i_16_tables">
					<g:message code="default.list.label"
						args="${[message(code:'user.label')] }" />
					(
					${User.count() }
					)
				</h4>
			</div>
			<div class="widget_contents noPadding">
				<table class="tables">
					<thead>
						<tr>
							<th><g:message code="user.username.label" /></th>

							<th><g:message code="user.name.label" /></th>

							<th><g:message code="user.status.label" /></th>

							<th><g:message code="default.actions.label" /></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${User.list()}" var="userInstance">
							<tr>
								<td><g:link controller="user" action="edit"
										id="${userInstance.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> ${fieldValue(bean: userInstance, field: "username")}
										</span>
									</g:link></td>

								<td><span class="label"> ${fieldValue(bean: userInstance, field: "name")}
								</span></td>

								<td><span class="label"> <g:message
											code="user.activate.${userInstance.activate }" />
								</span></td>

								<td><g:if
										test="${!userInstance.system && userInstance.id != session.userId }">
										<g:if test="${userInstance.activate }">
											<g:if test="${userInstance.admin }">
												<g:link controller="user" action="removeAdmin"
													id="${userInstance.id }"
													title="${message(code:'default.button.removeAdmin.label') }">
													<div class="simple_buttons">
														<div>
															<g:message code="default.button.removeAdmin.label" />
														</div>
													</div>
												</g:link>
											</g:if>
											<g:else>
												<g:link controller="user" action="setAdmin"
													id="${userInstance.id }"
													title="${message(code:'default.button.setAdmin.label') }">
													<div class="simple_buttons">
														<div>
															<g:message code="default.button.setAdmin.label" />
														</div>
													</div>
												</g:link>
											</g:else>
											<g:link controller="user" action="delete"
												id="${userInstance.id }"
												title="${message(code:'default.button.deactivate.label') }">
												<div class="simple_buttons">
													<div>
														<g:message code="default.button.deactivate.label" />
													</div>
												</div>
											</g:link>
											<g:link controller="user" action="reset"
												id="${userInstance.id }"
												title="${message(code:'default.button.reset.label') }">
												<div class="simple_buttons">
													<div>
														<g:message code="default.button.reset.label" />
													</div>
												</div>
											</g:link>
										</g:if>
										<g:else>
											<g:link controller="user" action="activate"
												id="${userInstance.id }"
												title="${message(code:'default.button.activate.label') }">
												<div class="simple_buttons">
													<div>
														<g:message code="default.button.activate.label" />
													</div>
												</div>
											</g:link>
										</g:else>
									</g:if></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</g:if>

	<div class="g_8">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_tables">
				<g:message code="default.list.label"
					args="${[message(code:'service.label')] }" />
				(
				${Service.count() }
				)
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<table class="tables">
				<thead>
					<tr>
						<th><g:message code="service.name.label" default="Name" /></th>

						<th><g:message code="service.description.label"
								default="Description" /></th>

						<th><g:message code="service.vendor.label" default="Vendor" /></th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${Service.list()}" var="serviceInstance">
						<tr>
							<td><g:link controller="service" action="edit"
									id="${serviceInstance.id}"
									title="${message(code:'default.button.edit.label') }">
									<span class="label"> ${fieldValue(bean: serviceInstance, field: "name")}
									</span>
								</g:link></td>

							<td><span class="label"> ${fieldValue(bean: serviceInstance, field: "description")}
							</span></td>

							<td><span class="label"> ${fieldValue(bean: serviceInstance, field: "vendor")}
							</span></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>

	<div class="g_4">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_tables">
				<g:message code="default.list.label"
					args="${[message(code:'adapter.label')] }" />
				(
				${Adapter.count() }
				)
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<table class="tables">
				<thead>
					<tr>
						<th><g:message code="adapter.name.label" default="Name" /></th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${Adapter.list()}" var="adapterInstance">
						<tr>
							<td><g:link controller="adapter" action="edit"
									id="${adapterInstance.id}"
									title="${message(code:'default.button.edit.label') }">
									<span class="label"> ${fieldValue(bean: adapterInstance, field: "name")}</span>
								</g:link></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>