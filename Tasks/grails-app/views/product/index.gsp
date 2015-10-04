
<%@ page import="draco.tasks.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<style type="text/css">
			table tr.inactivate {
				text-decoration:line-through;
			}
		</style>
	</head>
	<body>
		<a href="#list-product" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li>
					<g:form action="search" >
						<g:textField name="keyword"  placeholder="${message(code: 'default.textField.placeholder.keyword') }" autofocus="" />
						<g:actionSubmit class="search" action="search" value="${message(code: 'default.button.search.label', default: 'Search')}" />
						<g:hiddenField name="sort" value="${params.sort }"/>
						<g:hiddenField name="order" value="${params.order }"/>
					</g:form>
				</li>
			</ul>
		</div>
		<div id="list-product" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" />(${productInstanceList?.size() ?: 0  })</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="itemId" title="${message(code: 'product.itemId.label', default: 'Item Id')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="title" title="${message(code: 'product.title.label', default: 'Title')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="mode" title="${message(code: 'product.mode.label', default: 'Mode')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="sender" title="${message(code: 'product.sender.label', default: 'Sender')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
					
						<g:sortableColumn property="receiver" title="${message(code: 'product.receiver.label', default: 'Receiver')}" 
							action="${action?:'index' }" params="${['keyword':keyword] }" />
						
						<th><g:message code="task.logs.label" default="Logs" /></th>
						
						<th><g:message code="task.tags.label" default="Tags" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${productInstanceList}" status="i" var="productInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'} ${productInstance.activate? '':'inactivate'}">
					
						<td><g:link action="edit" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "itemId")}</g:link></td>
					
						<td>${fieldValue(bean: productInstance, field: "title")}</td>
					
						<td><g:message code="product.mode.${fieldValue(bean: productInstance, field: "mode")}"/></td>
					
						<td>${fieldValue(bean: productInstance, field: "sender")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "receiver")}</td>
						
						<td>
							<g:each in="${productInstance.logs }" var="l">
								<g:link controller="Task" action="edit" id="${l.task.id}">
									<g:message code="product.logs.log" args="${[message(code:'log.type.'+l.type), l.task.req, l.user.name]}"/>
								</g:link>
								<br/>
							</g:each>
						</td>
						
						<td>
							<g:each in="${productInstance.tags }" var="t">
								<g:link controller="tag" action="edit" id="${t.id}">${t?.encodeAsHTML()}</g:link>
								<br/>
							</g:each>
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
