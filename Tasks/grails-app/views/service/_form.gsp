<%@ page import="draco.tasks.Service" %>


<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="service.name.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="name" value="${serviceInstance?.name }" required="" autofocus="" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="service.description.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="description" value="${serviceInstance?.description }" required="" autofocus="" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="service.vendor.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="vendor" value="${serviceInstance?.vendor }" required="" autofocus="" />
	</div>
</div>

