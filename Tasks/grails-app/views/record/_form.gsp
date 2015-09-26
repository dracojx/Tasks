<%@ page import="draco.tasks.Record" %>



<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="record.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${recordInstance.constraints.type.inList}" required="" value="${recordInstance?.type}" valueMessagePrefix="record.type"/>

</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'req', 'error')} ">
	<label for="req">
		<g:message code="record.req.label" default="Req" />
		
	</label>
	<g:select id="req" name="req.id" from="${draco.tasks.Req.list()}" optionKey="id" value="${recordInstance?.req?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="record.product.label" default="Product" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="product" name="product.id" from="${draco.tasks.Product.list()}" optionKey="id" required="" value="${recordInstance?.product?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'updateTime', 'error')} required">
	<label for="updateTime">
		<g:message code="record.updateTime.label" default="Update Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="updateTime" precision="day"  value="${recordInstance?.updateTime}"  />

</div>

