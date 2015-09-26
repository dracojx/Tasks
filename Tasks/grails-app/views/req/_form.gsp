<%@ page import="draco.tasks.Req" %>



<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'req', 'error')} required">
	<label for="req">
		<g:message code="req.req.label" default="Req" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="req" required="" value="${reqInstance?.req}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="req.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${reqInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="req.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${reqInstance?.remark}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'cr', 'error')} ">
	<label for="cr">
		<g:message code="req.cr.label" default="Cr" />
		
	</label>
	<g:textField name="cr" value="${reqInstance?.cr}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="req.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="status" from="${reqInstance.constraints.status.inList}" required="" value="${reqInstance?.status}" valueMessagePrefix="req.status"/>

</div>

<div class="fieldcontain ${hasErrors(bean: reqInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="req.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${draco.tasks.User.list()}" optionKey="id" required="" value="${reqInstance?.user?.id}" class="many-to-one"/>

</div>

