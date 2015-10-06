<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
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
	
	<g:hasErrors bean="${taskInstance}">
		<div class="g_12">
			<g:eachError bean="${taskInstance}" var="error">
				<div class="alert iDialog"><g:message error="${error}"/></div>
			</g:eachError>
		</div>
	</g:hasErrors>
	
	<g:if test="${flash.errors }">
		<div class="g_12">
			<g:each in="${flash.errors }" var="error">
				<div class="alert iDialog">${error }</div>
			</g:each>
		</div>
	</g:if>
	
	<g:if test="${flash.message }">
		<div class="g_12">
			<div class="success iDialog">${flash.message }</div>
		</div>
	</g:if>
	
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.edit.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:taskInstance, action:'update']" method="PUT">
				<g:render template="/task/form" model="${[taskInstance:taskInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:actionSubmit action="update" class="simple_buttons"
							 value="${message(code: 'default.button.update.label', default: 'Update')}" />
						<g:if test="${taskInstance.activate }">
							<g:actionSubmit action="delete" class="simple_buttons"
								 value="${message(code: 'default.button.deactivate.label', default: 'Deactivate')}" />
							<g:if test="${taskInstance?.status.toInteger() > 0 }">
								<g:actionSubmit action="prev" class="simple_buttons"
									 value="${message(code: 'default.button.prev.label', default: 'Prev Stage')}" />
							</g:if>
							<g:if test="${taskInstance?.status.toInteger() < 4 }">
								<g:actionSubmit action="next" class="simple_buttons"
									 value="${message(code: 'default.button.next.label', default: 'Next Stage')}" />
							</g:if>
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
