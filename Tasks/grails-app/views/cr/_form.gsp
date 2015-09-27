<%@ page import="draco.tasks.Cr" %>



<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="cr.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${crInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'stage', 'error')} required">
	<label for="stage">
		<g:message code="cr.stage.label" default="Stage" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="stage" from="${crInstance.constraints.stage.inList}" required="" value="${crInstance?.stage}" valueMessagePrefix="cr.stage"/>

</div>

<div class="fieldcontain ${hasErrors(bean: crInstance, field: 'products', 'error')} ">
	<label for="products">
		<g:message code="cr.products.label" default="Products" />
		
	</label>
	<g:select name="products" from="${draco.tasks.Product.list()}" multiple="multiple" optionKey="id" size="5" value="${crInstance?.products*.id}" class="many-to-many"/>

</div>

