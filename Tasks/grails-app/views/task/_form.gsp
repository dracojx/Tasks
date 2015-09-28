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

<div class="fieldcontain">
	<label for=crNumbers>
		<g:message code="default.add.label" default="Add" args="${[message(code:'cr.label', default:'CR') ]}" />
		
	</label>
	<g:textField name="crNumbers" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>

<div class="fieldcontain">
	<label for="productItemIds">
		<g:message code="default.add.label" default="Add" args="${[message(code:'product.label', default:'Product') ]}" />
		
	</label>
	<g:textField name="productItemIds" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>
<g:hiddenField name="user.id" value="${session.userId }"/>
