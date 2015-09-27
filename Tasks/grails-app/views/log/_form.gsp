<%@ page import="draco.tasks.Log" %>



<div class="fieldcontain ${hasErrors(bean: logInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="log.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${logInstance.constraints.type.inList}" required="" value="${logInstance?.type}" valueMessagePrefix="log.type"/>

</div>

<div class="fieldcontain ${hasErrors(bean: logInstance, field: 'task', 'error')} ">
	<label for="task">
		<g:message code="log.task.label" default="Task" />
		
	</label>
	<g:select id="task" name="task.id" from="${draco.tasks.Task.list()}" optionKey="id" value="${logInstance?.task?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: logInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="log.product.label" default="Product" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="product" name="product.id" from="${draco.tasks.Product.list()}" optionKey="id" required="" value="${logInstance?.product?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: logInstance, field: 'updateTime', 'error')} required">
	<label for="updateTime">
		<g:message code="log.updateTime.label" default="Update Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="updateTime" precision="day"  value="${logInstance?.updateTime}"  />

</div>

