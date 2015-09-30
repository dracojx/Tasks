<%@ page import="draco.tasks.Tag" %>



<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="tag.name.label" default="Name" />
	</label>
	<g:textField name="name" required="" value="${tagInstance?.name}" autofocus="" />

</div>

