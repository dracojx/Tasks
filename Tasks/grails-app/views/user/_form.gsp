<%@ page import="draco.tasks.User"%>

<g:if test="${params.action=='reset' }">
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.username.label" /></span>
		</div>
		<div class="g_9">
			<span class="label">
				${userInstance?.username }
			</span>
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.name.label" /></span>
		</div>
		<div class="g_9">
			<span class="label">
				${userInstance?.name }
			</span>
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.password.label" /></span>
		</div>
		<div class="g_9">
			<g:passwordField name="password" class="simple_field" required=""/>
		</div>
	</div>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.repeat.label" /></span>
		</div>
		<div class="g_9">
			<input type="password" id="repeat" class="simple_field" />
		</div>
	</div>
</g:if>
<g:else>
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.username.label" /></span>
		</div>
		<div class="g_9">
			<g:textField name="username" value="${userInstance?.username }" class="simple_field" required="" autofocus="" />
		</div>
	</div>
	
	<g:if test="${params.action in ['create','save'] }">
		<div class="line_grid">
			<div class="g_3">
				<span class="label"><g:message code="user.password.label" /></span>
			</div>
			<div class="g_9">
				<g:textField name="password" value="${userInstance?.password }" class="simple_field" required=""/>
			</div>
		</div>
	</g:if>
	
	<div class="line_grid">
		<div class="g_3">
			<span class="label"><g:message code="user.name.label" /></span>
		</div>
		<div class="g_9">
			<g:textField name="name" value="${userInstance?.name }" class="simple_field" required="" />
		</div>
	</div>
</g:else>

