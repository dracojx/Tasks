<%@ page import="draco.tasks.Cr" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'cr.label')}" />
</head>
<body>
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.edit.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:crInstance, action:'update']" method="PUT">
				<g:render template="form" model="${[crInstance:crInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:actionSubmit action="update" class="simple_buttons"
							 value="${message(code: 'default.button.update.label', default: 'Update')}" />
						<g:if test="${crInstance?.status.toInteger() > 1 }">
							<g:actionSubmit action="prev" class="simple_buttons"
								 value="${message(code: 'default.button.prev.label', default: 'Prev Stage')}" />
						</g:if>
						<g:if test="${crInstance?.status.toInteger() < 4 }">
							<g:actionSubmit action="next" class="simple_buttons"
								 value="${message(code: 'default.button.next.label', default: 'Next Stage')}" />
						</g:if>
					</div>
				</div>
			</g:form>
		</div>	
	</div>
</body>
</html>
