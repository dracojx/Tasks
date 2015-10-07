<%@ page import="draco.tasks.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'product.label', default: 'Product')}" />
</head>
<body>
	
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.edit.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:productInstance, action:'update']" method="PUT">
				<g:render template="form" model="${[productInstance:productInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:actionSubmit action="update" class="simple_buttons"
							 value="${message(code: 'default.button.update.label', default: 'Update')}" />
						<g:if test="${productInstance.activate }">
							<g:actionSubmit action="delete" class="simple_buttons"
								 value="${message(code: 'default.button.deactivate.label', default: 'Deactivate')}" />
						</g:if>
						<g:else>
							<g:actionSubmit action="activate" class="simple_buttons"
								 value="${message(code: 'default.button.activate.label', default: 'Activate')}" />
						</g:else>
					</div>
				</div>
			</g:form>
		</div>	
	</div>
</body>
</html>
