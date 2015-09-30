<%@ page import="draco.tasks.Task"%>



<div
	class="fieldcontain ${hasErrors(bean: taskInstance, field: 'req', 'error')} required">
	<label for="req"> <g:message code="task.req.label"
			default="Req" />
	</label>
	<g:textField name="req" required="" value="${taskInstance?.req}" autofocus="" />

</div>

<div
	class="fieldcontain ${hasErrors(bean: taskInstance, field: 'title', 'error')} ">
	<label for="title"> <g:message code="task.title.label"
			default="Title" />
	</label>
	<g:textField name="title" value="${taskInstance?.title}" />

</div>



<g:if test="${taskInstance?.logs}">
	<div class="fieldcontain">
		<span id="products-label" class="property-label">
			<g:message code="task.products.label" default="Products" />
		</span>
		<g:each in="${taskInstance.logs}" var="l">
			<span class="property-value" aria-labelledby="products-label"> 
				<g:link controller="product" action="edit" id="${l.product.id}"><%l?.product?.encodeAsHTML()%></g:link>
				<g:link controller="task" action="removeLog" resource="${taskInstance}" params="${[lId:l.id] }">x</g:link>
			</span>
		</g:each>
	</div>
</g:if>

<g:if test="${taskInstance?.crs}">
	<div class="fieldcontain">
		<span id="crs-label" class="property-label">
			<g:message code="task.crs.label" default="Crs" />
		</span>
		<g:each in="${taskInstance.crs}" var="c">
			<span class="property-value" aria-labelledby="crs-label"> 
				<g:link controller="cr" action="edit" id="${c.id}">${c?.encodeAsHTML()}</g:link>
				<g:link controller="task" action="removeCr" resource="${taskInstance}" params="${[cId:c.id] }">x</g:link>
			</span>
		</g:each>
	</div>
</g:if>



<g:if test="${taskInstance?.tags}">
	<div class="fieldcontain">
		<span id="tags-label" class="property-label">
			<g:message code="task.tags.label" default="Tags" />
		</span>
		<g:each in="${taskInstance.tags}" var="t">
			<span class="property-value" aria-labelledby="tags-label"> 
				<g:link controller="tag" action="edit" id="${t.id}">${t?.encodeAsHTML()}</g:link>
				<g:link controller="task" action="removeTag" resource="${taskInstance}" params="${[tId:t.id] }">x</g:link>
			</span>
		</g:each>
	</div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'remark', 'error')} ">
	<label for="remark"> <g:message code="task.remark.label" default="Remark" />

	</label>
	<g:textField name="remark" value="${taskInstance?.remark}" />

</div>

<div class="fieldcontain">
	<label for="productItemIds"> <g:message code="default.add.label" default="Add" args="${[message(code:'product.label', default:'Product') ]}" />
	</label>
	<g:textField name="productItemIds" placeholder="${message(code: 'default.textField.placeholder.separated') }" />
</div><div class="fieldcontain">
	<label for=crNumbers> <g:message code="default.add.label"
			default="Add" args="${[message(code:'cr.label', default:'CR') ]}" />
	</label>
	<g:textField name="crNumbers"	
		placeholder="${message(code: 'default.textField.placeholder.separated') }" />
</div>



<div class="fieldcontain">
	<label for="tagNames"><g:message code="default.add.label" default="Add"
			args="${[message(code:'tag.label', default:'Tag') ]}" />
	</label>
	<g:textField name="tagNames"
		placeholder="${message(code: 'default.textField.placeholder.separated') }" />
</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'status', 'error')}">
	<span id="status-label" class="property-label"><g:message code="task.status.label" default="Status" /></span>
	<span class="property-value" aria-labelledby="status-label"><g:message code="task.status.${taskInstance?.status}" /></span>
</div><g:hiddenField name="user.id" value="${session.userId }" />
<g:hiddenField name="status" value="${taskInstance?.status }"/>
<g:hiddenField name="activate" value="${taskInstance?.activate}" />
