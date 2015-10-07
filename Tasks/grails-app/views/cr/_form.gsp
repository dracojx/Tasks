<%@ page import="draco.tasks.Cr" %>


<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="cr.number.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="number" value="${crInstance?.number }" required="" autofocus="" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="cr.description.label" /></span>
	</div>
	<div class="g_9">
		<g:textField name="description" value="${crInstance?.description }" required="" autofocus="" />
	</div>
</div>

<div class="line_grid">
	<div class="g_3">
		<span class="label"><g:message code="cr.products.label"/></span>
	</div>
	<div class="g_9">
		<g:each in="${crInstance.products}" var="p">
			<g:link controller="product" action="edit" id="${p.id }"
				title="${message(code:'default.button.edit.label') }">
				<span class="label">${p.encodeAsHTML() }</span>
			</g:link>
			<g:link controller="product" action="removeProduct" resource="${crInstance}" params="${[pId:p.id] }" class="delete"
				title="${message(code:'default.button.delete.label') }">
				<asset:image src="Icons/16/i_16_close.png"/>
			</g:link>
			<br />
		</g:each>
		<g:textField name="productItemIds" class="add"
			placeholder="${message(code: 'default.placeholder.add.separated', args:[message(code:'product.label')]) }" />
	</div>
</div>

<g:if test="${params.action in ['edit', 'update'] }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="cr.status.label" /></span>
		</div>
		<div class="g_9">
			<g:message code="cr.status.${crInstance?.status}" />
		</div>
	</div>
</g:if>