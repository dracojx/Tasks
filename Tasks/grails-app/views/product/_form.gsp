<%@ page import="draco.tasks.Product" %>



<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'itemId', 'error')} required">
	<label for="itemId">
		<g:message code="product.itemId.label" default="Item Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="itemId" required="" value="${productInstance?.itemId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="product.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${productInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="product.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${productInstance?.remark}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'mode', 'error')} required">
	<label for="mode">
		<g:message code="product.mode.label" default="Mode" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="mode" from="${productInstance.constraints.mode.inList}" required="" value="${productInstance?.mode}" valueMessagePrefix="product.mode"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'sender', 'error')} ">
	<label for="sender">
		<g:message code="product.sender.label" default="Sender" />
		
	</label>
	<g:select id="sender" name="sender.id" from="${draco.tasks.Service.list()}" optionKey="id" value="${productInstance?.sender?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'receiver', 'error')} ">
	<label for="receiver">
		<g:message code="product.receiver.label" default="Receiver" />
		
	</label>
	<g:select id="receiver" name="receiver.id" from="${draco.tasks.Service.list()}" optionKey="id" value="${productInstance?.receiver?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'source', 'error')} ">
	<label for="source">
		<g:message code="product.source.label" default="Source" />
		
	</label>
	<g:select id="source" name="source.id" from="${draco.tasks.Adapter.list()}" optionKey="id" value="${productInstance?.source?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'target', 'error')} ">
	<label for="target">
		<g:message code="product.target.label" default="Target" />
		
	</label>
	<g:select id="target" name="target.id" from="${draco.tasks.Adapter.list()}" optionKey="id" value="${productInstance?.target?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'activate', 'error')} ">
	<label for="activate">
		<g:message code="product.activate.label" default="Activate" />
		
	</label>
	<g:checkBox name="activate" value="${productInstance?.activate}" />

</div>

<div class="fieldcontain">
	<label for="req">
		<g:message code="req.label" default="Req" />
		
	</label>
	<g:textField name="req" />

</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'logs', 'error')} ">
	<label for="logs">
		<g:message code="product.logs.label" default="Logs" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${productInstance?.logs?}" var="l">
    <li><g:link controller="log" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="log" action="create" params="['product.id': productInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'log.label', default: 'Log')])}</g:link>
</li>
</ul>


</div>

