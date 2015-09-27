<%@ page import="draco.tasks.Cr" %>



<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'number', 'error')} required">
	<label for="number">
		<g:message code="cr.number.label" default="Number" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="number" required="" value="${crInstance?.number}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cr.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${crInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="cr.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="status" from="${crInstance.constraints.status.inList}" required="" value="${crInstance?.status}" valueMessagePrefix="cr.status"/>

</div>

<div class="fieldcontain">
	<label for="product">
		<g:message code="product.label" default="Product" />
		
	</label>
	<g:textField name="product" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>

