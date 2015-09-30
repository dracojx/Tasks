<%@ page import="draco.tasks.Adapter" %>



<div class="fieldcontain ${hasErrors(bean: adapterInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="adapter.name.label" default="Name" />
	</label>
	<g:textField name="name" required="" value="${adapterInstance?.name}" autofocus="" />

</div>

