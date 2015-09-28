<%@ page import="draco.tasks.Task" %>



<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'req', 'error')} required">
	<label for="req">
		<g:message code="task.req.label" default="Req" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="req" required="" value="${taskInstance?.req}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="task.title.label" default="Title" />
	</label>
	<g:textField name="title" value="${taskInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="task.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${taskInstance?.remark}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="task.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="status" from="${taskInstance.constraints.status.inList}" required="" value="${taskInstance?.status}" valueMessagePrefix="task.status"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="task.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${draco.tasks.User.list()}" optionKey="id" required="" value="${taskInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain">
	<label for="cr">
		<g:message code="cr.label" default="Cr" />
		
	</label>
	<g:textField name="cr" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>

<div class="fieldcontain">
	<label for="product">
		<g:message code="product.label" default="Product" />
		
	</label>
	<g:textField name="product" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>
