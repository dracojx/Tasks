<%@ page import="draco.tasks.Product" %>



<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'itemId', 'error')} required">
	<label for="itemId">
		<g:message code="product.itemId.label" default="Item Id" />
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
			

			
<g:if test="${productInstance?.logs}">
	<div class="fieldcontain">
		<span id="logs-label" class="property-label"><g:message code="product.logs.label" default="Logs" /></span>
		<g:each in="${productInstance.logs}" var="l">
			<span class="property-value" aria-labelledby="logs-label">
				<g:link controller="Task" action="edit" id="${l.task.id}">
					<g:message code="product.logs.log" 
						args="${[l.updateTime.format('yyyy.MM.dd HH:mm:ss'), message(code:'log.type.'+l.type), l.task.req, l.task.user.name]}"/>
				</g:link>
				<g:link controller="product" action="removeLog" resource="${productInstance}" params="${[lId:l.id] }">x</g:link>
			</span>
		</g:each>
	</div>
</g:if><g:if test="${productInstance?.tags}">
	<div class="fieldcontain">
		<span id="logs-label" class="property-label"><g:message code="product.logs.label" default="Logs" /></span>
		<g:each in="${productInstance.tags}" var="t">
			<span class="property-value" aria-labelledby="logs-label">
				<g:link controller="Tag" action="edit" id="${t.id}"><%t?.encodeAsHTML() %></g:link>
				<g:link controller="product" action="removeTag" resource="${productInstance}" params="${[tId:t.id] }">x</g:link>
			</span>
		</g:each>
	</div>
</g:if>



<div class="fieldcontain">
	<label for="taskReq">
		<g:message code="default.add.label" default="Add" args="${[message(code:'task.label', default:'Task') ]}" />
		
	</label>
	<g:textField name="taskReq" />

</div><div class="fieldcontain">
	<label for="tagNames">
		<g:message code="default.add.label" default="Add" args="${[message(code:'tag.label', default:'Tag') ]}" />
		
	</label>
	<g:textField name="tagNames" placeholder="${message(code: 'default.textField.placeholder.separated') }" />

</div>
<g:hiddenField name="activate" value="${productInstance?.activate}" />
