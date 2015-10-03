
<%@ page import="draco.tasks.Adapter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'adapter.label', default: 'Adapter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-adapter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/index')}"><g:message code="default.home.label"/></a></li>
				<li>
					<g:form action="upload" enctype="multipart/form-data">
						<input type="file" name="excelFile" />
						<g:actionSubmit action="upload" value="Submit"/>
					</g:form>
				</li>
			</ul>
		</div>
		<div id="list-adapter" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
				<ul class="errors" role="alert">
					<li>${flash.error }</li>
				</ul>
			</g:if>
		</div>
	</body>
</html>
