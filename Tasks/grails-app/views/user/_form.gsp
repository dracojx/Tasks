<%@ page import="tasks.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="user.role.label" default="Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="role" from="${userInstance.constraints.role.inList}" required="" value="${userInstance?.role}" valueMessagePrefix="user.role"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'available', 'error')} ">
	<label for="available">
		<g:message code="user.available.label" default="Available" />
		
	</label>
	<g:checkBox name="available" value="${userInstance?.available}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'reset', 'error')} ">
	<label for="reset">
		<g:message code="user.reset.label" default="Reset" />
		
	</label>
	<g:checkBox name="reset" value="${userInstance?.reset}" />

</div>

