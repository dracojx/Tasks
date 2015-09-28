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
	<span id="status-label" class="property-label">
		<g:message code="cr.status.label" default="Status" />
	</span>
	<span class="property-value" aria-labelledby="status-label">
		<g:message code="cr.status.${crInstance?.status}" />
	</span>
<!--
	<label for="status">
		<g:message code="cr.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="status" from="${crInstance.constraints.status.inList}" required="" value="${crInstance?.status}" valueMessagePrefix="cr.status"/>
 -->
</div>
 
<g:if test="${crInstance?.products}">
	<div class="fieldcontain">
		<span id="products-label" class="property-label"><g:message code="cr.products.label" default="Products" /></span>
			<g:each in="${crInstance.products}" var="p">
				<span class="property-value" aria-labelledby="products-label">
					<g:link controller="product" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>
					<g:link controller="cr" action="removeProduct" resource="${crInstance}" params="${[pId:p.id] }">x</g:link>
				</span>
			</g:each>
	</div>
</g:if>
				
<div class="fieldcontain">
	<label for="productItemIds">
		<g:message code="default.add.label" default="Add" args="${[message(code:'product.label', default:'Product') ]}" />
		
	</label>
	<g:textField name="productItemIds" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>
<g:hiddenField name="status" value="${crInstance?.status }"/>
