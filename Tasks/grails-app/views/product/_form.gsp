<%@ page import="draco.tasks.Product" %>
<%@ page import="draco.tasks.Service" %>
<%@ page import="draco.tasks.Adapter" %>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.itemId.label"/></span>
	</div>
	<div class="g_9">
		<g:textField name="itemId" value="${productInstance.itemId }" required="" autofocus=""/>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.title.label"/></span>
	</div>
	<div class="g_9">
		<g:textField name="title" value="${productInstance.title }"/>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.remark.label"/></span>
	</div>
	<div class="g_9">
		<g:textField name="remark" value="${productInstance.remark }"/>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.mode.label"/></span>
	</div>
	<div class="g_9">
		<span class="label">
			<g:message code="product.mode.a"/>
			<input type="radio" class="simple_form" name="mode" value="a" 
				${productInstance.mode=='a'? 'checked="checked"' : '' } />
		</span>
		<span class="label">
			<g:message code="product.mode.s"/>
			<input type="radio" class="simple_form" name="mode" value="s"
				${productInstance.mode=='s'? 'checked="checked"' : '' } />
		</span>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.sender.label"/></span>
	</div>
	<div class="g_9">
		<select class="simple_form" name="sender.id">
			<option value="null" ${productInstance.sender ? '':'selected="selected"' }><g:message code="product.sender.label"/>
			<g:each in="${Service.list() }" var="s">
				<option value="${s.id }" ${productInstance.sender?.id==s.id ? 'selected="selected"':'' }>${s.encodeAsHTML() }
			</g:each>
		</select>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.receiver.label"/></span>
	</div>
	<div class="g_9">
		<select class="simple_form" name="receiver.id">
			<option value="null" ${productInstance.receiver ? '':'selected="selected"' }><g:message code="product.receiver.label"/>
			<g:each in="${Service.list() }" var="s">
				<option value="${s.id }" ${productInstance.receiver?.id==s.id ? 'selected="selected"':'' }>${s.encodeAsHTML() }
			</g:each>
		</select>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.source.label"/></span>
	</div>
	<div class="g_9">
		<select class="simple_form" name="source.id">
			<option value="null" ${productInstance.source ? '':'selected="selected"' }><g:message code="product.source.label"/>
			<g:each in="${Adapter.list() }" var="a">
				<option value="${a.id }" ${productInstance.source?.id==a.id ? 'selected="selected"':'' }>${a.encodeAsHTML() }
			</g:each>
		</select>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.target.label"/></span>
	</div>
	<div class="g_9">
		<select class="simple_form" name="target.id">
			<option value="null" ${productInstance.source ? '':'selected="selected"' }><g:message code="product.target.label"/>
			<g:each in="${Adapter.list() }" var="a">
				<option value="${a.id }" ${productInstance.target?.id==a.id ? 'selected="selected"':'' }>${a.encodeAsHTML() }
			</g:each>
		</select>
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.logs.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${productInstance.logs}" var="l">
			<g:link controller="product" action="changeLogType" resource="${productInstance}" params="${[lId:l.id] }"
				title="${message(code:'default.button.change.label') }">
				<span class="label">
					[<g:message code="log.type.${l.type}"/>]
				</span>
			</g:link>
			<g:link controller="task" action="edit" id="${l.task.id }"
				title="${message(code:'default.button.edit.label') }">
				<span class="label">${l.task?.encodeAsHTML() }</span>
			</g:link>
			<g:link controller="product" action="removeLog" resource="${productInstance}" params="${[lId:l.id] }" class="delete"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="taskReq"
			placeholder="${message(code: 'default.placeholder.add', args:[message(code:'task.label')]) }" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="product.tags.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${productInstance.tags}" var="t">
			<g:link controller="tag" action="edit" id="${t.id }" 
				title="${message(code:'default.button.edit.label') }">
				<span class="label">
					${t?.encodeAsHTML()}
				</span>
			</g:link>
			<g:link controller="product" action="removeTag" resource="${productInstance}" params="${[tId:t.id] }" class="delete"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="tagNames"
			placeholder="${message(code: 'default.placeholder.add.separated', args:[message(code:'tag.label')]) }" />
	</div>
</div>