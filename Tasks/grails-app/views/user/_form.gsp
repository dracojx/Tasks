<%@ page import="draco.tasks.User"%>

<g:if test="${params.action=='reset' }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.username.label" /></span>
		</div>
		<div class="g_9">
			${userInstance?.username }
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.name.label" /></span>
		</div>
		<div class="g_9">
			${userInstance?.name }
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.password.label" /></span>
		</div>
		<div class="g_9">
			<g:passwordField name="password" required=""/>
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.repeat.label" /></span>
		</div>
		<div class="g_9">
			<input type="password" id="repeat" >
		</div>
	</div>
</g:if>
<g:else>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.username.label" /></span>
		</div>
		<div class="g_9">
			<g:textField name="username" value="${userInstance?.username }" required="" autofocus="" />
		</div>
	</div>
	
	<g:if test="${params.action in ['create','save'] }">
		<div class="line_grid">
			<div class="g_3">
				<span class="label"><g:message code="user.password.label" /></span>
			</div>
			<div class="g_9">
				<g:textField name="password" value="${userInstance?.password }" required=""/>
			</div>
		</div>
	</g:if>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.name.label" /></span>
		</div>
		<div class="g_9">
			<g:textField name="name" value="${userInstance?.name }" required="" />
		</div>
	</div>
</g:else>

