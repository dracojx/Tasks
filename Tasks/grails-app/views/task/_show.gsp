<%@ page import="draco.tasks.Task"%>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.req.label" /></span>
	</div>
	<div class="g_9">
		<g:link controller="task" action="edit" id="${taskInstance.id }"
			title="${message(code:'default.button.edit.label') }">
			<span class="label"> ${taskInstance.req }
			</span>
		</g:link>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.title.label" /></span>
	</div>
	<div class="g_9">
		<span class="label"> ${taskInstance.title }
		</span>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.remark.label" /></span>
	</div>
	<div class="g_9">
		<span class="label"> ${taskInstance.remark }
		</span>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.status.label" /></span>
	</div>
	<div class="g_9">
		<span class="label"> <g:if test="${taskInstance?.activate }">
				<g:message code="task.status.${taskInstance?.status}" />
			</g:if> <g:else>
				<g:message code="task.activate.${taskInstance?.activate}" />
			</g:else>
		</span>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.user.label" /></span>
	</div>
	<div class="g_9">
		<span class="label"> ${taskInstance.user.name }
		</span>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.createDate.label" /></span>
	</div>
	<div class="g_9">
		<span class="label">
			${taskInstance.createDate.format('yyyy/MM/dd')}
		</span>
	</div>
</div>
<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="task.updateDate.label" /></span>
	</div>
	<div class="g_9">
		<span class="label">
			${taskInstance.updateDate.format('yyyy/MM/dd')}
		</span>
	</div>
</div>
<g:if test="${taskInstance.logs }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.logs.label" /></span>
		</div>
		<div class="g_9">
			<g:each in="${taskInstance.logs}" var="l">
				<g:link controller="product" action="edit" id="${l.product.id }"
					title="${message(code:'default.button.edit.label') }">
					<span class="label">[<g:message code="log.type.${l.type}"/>]${l.product?.encodeAsHTML() }</span>
				</g:link>
				<br />
			</g:each>
		</div>
	</div>
</g:if>
<g:if test="${taskInstance.crs }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.crs.label" /></span>
		</div>
		<div class="g_9">
			<g:each in="${taskInstance.crs}" var="c">
				<g:link controller="cr" action="edit" id="${c.id }"
					title="${message(code:'default.button.edit.label') }">
					<span class="label"> ${c?.encodeAsHTML()}
					</span>
				</g:link>
				<br />
			</g:each>
		</div>
	</div>
</g:if>
<g:if test="${taskInstance.tags }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="task.tags.label" /></span>
		</div>
		<div class="g_9">
			<g:each in="${taskInstance.tags}" var="t">
				<g:link controller="tag" action="edit" id="${t.id }"
					title="${message(code:'default.button.edit.label') }">
					<span class="label"> ${t?.encodeAsHTML()}
					</span>
				</g:link>
				<br />
			</g:each>
		</div>
	</div>
</g:if>