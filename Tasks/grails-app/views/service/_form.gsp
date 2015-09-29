<%@ page import="draco.tasks.Service" %>



<div class="fieldcontain ${hasErrors(bean: serviceInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="service.name.label" default="Name" />
	</label>
	<g:textField name="name" required="" value="${serviceInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: serviceInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="service.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${serviceInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: serviceInstance, field: 'vendor', 'error')} ">
	<label for="vendor">
		<g:message code="service.vendor.label" default="Vendor" />
		
	</label>
	<g:textField name="vendor" value="${serviceInstance?.vendor}"/>

</div>

