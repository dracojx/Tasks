<%@ page import="draco.tasks.Task"%>

<g:if test="${!params.controller }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.req.label"/></span>
		</div>
		<div class="g_9">
			<g:link controller="task" action="edit" id="${taskInstance.id }" title="${message(code:'default.button.edit.label') }">
				<span class="label">${taskInstance.req }</span>
			</g:link>
		</div>
	</div>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.title.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">${taskInstance.title }</span>
		</div>
	</div>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.remark.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">${taskInstance.remark }</span>
		</div>
	</div>
</g:if>
<g:else>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.req.label"/></span>
		</div>
		<div class="g_9">
			<g:textField name="req" value="${taskInstance.req }" required="" autofocus=""/>
		</div>
	</div>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.title.label"/></span>
		</div>
		<div class="g_9">
			<g:textField name="title" value="${taskInstance.title }"/>
		</div>
	</div>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.remark.label"/></span>
		</div>
		<div class="g_9">
			<g:textField name="remark" value="${taskInstance.remark }"/>
		</div>
	</div>
</g:else>
<g:if test="${taskInstance.user }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.user.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">${taskInstance.user.name }</span>
		</div>
	</div>
</g:if>
<g:if test="${taskInstance.status }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.status.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">
				<g:if test="${taskInstance?.activate }">
					<g:message code="task.status.${taskInstance?.status}" />
				</g:if>
				<g:else>
					<g:message code="task.activate.${taskInstance?.activate}" />
				</g:else>
			</span>
		</div>
	</div>
</g:if>
<g:if test="${taskInstance.createDate }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.createDate.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">${taskInstance.createDate.format('yyyy/MM/dd')}</span>
		</div>
	</div>
</g:if>
<g:if test="${taskInstance.updateDate }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.updateDate.label"/></span>
		</div>
		<div class="g_9">
			<span class="label">${taskInstance.updateDate.format('yyyy/MM/dd')}</span>
		</div>
	</div>
</g:if>
<g:if test="${params.controller }">
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.logs.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${taskInstance.logs}" var="l">
			<g:link controller="product" action="edit" id="${l.product.id }" 
				title="${message(code:'default.button.edit.label') }">
				<span class="label">
					<g:message code="task.logs.log" args="${[message(code:'log.type.'+l.type), l.product.itemId]}"/>
				</span>
			</g:link>
			<g:link controller="task" action="removeLog" resource="${taskInstance}" params="${[lId:l.id] }"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="productItemIds" class="add"
			placeholder="${message(code: 'default.placeholder.add.separated', args:[message(code:'product.label')]) }" />
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.crs.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${taskInstance.crs}" var="c">
			<g:link controller="cr" action="edit" id="${c.id }" 
				title="${message(code:'default.button.edit.label') }">
				<span class="label">
					${c?.encodeAsHTML()}
				</span>
			</g:link>
			<g:link controller="task" action="removeCr" resource="${taskInstance}" params="${[cId:c.id] }"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="crNumbers" class="add"
			placeholder="${message(code: 'default.placeholder.add.separated', args:[message(code:'cr.label')]) }" />
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.tags.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${taskInstance.tags}" var="t">
			<g:link controller="tag" action="edit" id="${t.id }" 
				title="${message(code:'default.button.edit.label') }">
				<span class="label">
					${t?.encodeAsHTML()}
				</span>
			</g:link>
			<g:link controller="task" action="removeTag" resource="${taskInstance}" params="${[tId:t.id] }"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="tagNames" class="add"
			placeholder="${message(code: 'default.placeholder.add.separated', args:[message(code:'tag.label')]) }" />
	</div>
</div>
</g:if>
