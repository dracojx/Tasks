<%@ page import="draco.tasks.User"%>


<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="user.username.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="username" value="${userAdapter?.username }" required="" autofocus="" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="user.name.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="name" value="${userAdapter?.name }" required="" />
	</div>
</div>

