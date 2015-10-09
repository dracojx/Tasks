<%@ page import="draco.tasks.Task"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'product.label', default: 'Product')}" />
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
				${productInstanceList?.size() ?: '0' }
				)
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<table class="tables">
				<thead>
					<tr>
						<th><g:message code="product.itemId.label"
								default="INTERFACE ID" /></th>

						<th><g:message code="product.title.label" default="Title" /></th>

						<th><g:message code="product.mode.label" default="Mode" /></th>

						<th><g:message code="product.sender.label" default="Sender" /></th>

						<th><g:message code="product.receiver.label"
								default="Receiver" /></th>

						<th><g:message code="product.logs.label" default="Logs" /></th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${productInstanceList}" var="productInstance">
						<tr class="${productInstance.activate? '':'inactivate'}">
							<td><g:link action="edit" id="${productInstance.id}"
									title="${message(code:'default.button.edit.label') }">
									<span class="label"> ${fieldValue(bean: productInstance, field: "itemId")}
									</span>
								</g:link></td>

							<td><span class="label"> ${fieldValue(bean: productInstance, field: "title")}
							</span></td>

							<td class="nowrap"><span class="label"> <g:message
										code="product.mode.${productInstance.mode}" />
							</span></td>

							<td><span class="label"> ${productInstance.sender?.encodeAsHTML() }
							</span></td>

							<td><span class="label"> ${productInstance.receiver?.encodeAsHTML() }
							</span></td>

							<td class="nowrap"><g:each in="${productInstance.logs }" var="l">
									<g:link controller="task" action="edit" id="${l.task.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> [<g:message
												code="log.type.${l.type }" />]${l.task.encodeAsHTML() }
										</span>
									</g:link>
									<br />
								</g:each></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>