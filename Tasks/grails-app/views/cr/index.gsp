<%@ page import="draco.tasks.Cr" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'cr.label', default: 'CR')}" />
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
					( ${crInstanceList?.size() ?: '0' } )
				</h4>
			</div>
			<div class="widget_contents noPadding">
				<table class="tables">
					<thead>
						<tr>
							<th><g:message code="cr.number.label" default="Number" /></th>
	
							<th><g:message code="cr.description.label" default="Description" /></th>
	
							<th><g:message code="cr.status.label" default="Status" /></th>
	
							<th><g:message code="cr.products.label" default="Products" /></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${crInstanceList}" var="crInstance">
							<tr>
								<td>
									<g:link action="edit" id="${crInstance.id}"
										title="${message(code:'default.button.edit.label') }">
										<span class="label"> ${fieldValue(bean: crInstance, field: "number")}
										</span>
									</g:link>
								</td>
	
								<td>
									${fieldValue(bean: crInstance, field: "description")}
								</td>
	
								<td><g:message code="cr.status.${crInstance.status}" /></td>
								
								<td>
									<g:each in="${crInstance.products }" var="p">
										<g:link controller="product" action="edit" id="${p.id}"
											title="${message(code:'default.button.edit.label') }">
											<span class="label">
												${p.encodeAsHTML() }
											</span>
										</g:link>
										<br />
									</g:each>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	
	</body>
</html>
