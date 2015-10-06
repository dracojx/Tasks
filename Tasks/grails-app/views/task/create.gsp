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
	
	<div class="g_12">
		<div class="widget_header">
			<h4 class="widget_header_title wwIcon i_16_forms">
				<g:message code="default.new.label" args="[entityName]" />
			</h4>
		</div>
		<div class="widget_contents noPadding">
			<g:form url="[resource:taskInstance, action:'save']">
				<g:render template="/task/form" model="${[taskInstance:taskInstance] }"></g:render>
				<div class="line_grid">
					<div class="g_3">
						<span class="label"><g:message code="default.actions.label"/></span>
					</div>
					<div class="g_9">
						<g:submitButton name="create" class="simple_buttons"
							 value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</div>
				</div>
			</g:form>
		</div>	
	</div>
</body>
</html>
