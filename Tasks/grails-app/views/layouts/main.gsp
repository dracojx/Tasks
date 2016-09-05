<%@ page import="draco.tasks.User"%>
<%@ page import="draco.tasks.Task"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:message code="project.label" default="Task Management" /></title>
<!-- The Fonts -->
<!-- <link href='http://fonts.useso.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'> -->
<!-- The Main CSS File -->
<asset:stylesheet src="style.css" />
<!-- jQuery -->
<asset:javascript src="jQuery/jquery-1.7.2.min.js" />
<!-- jQuryUI -->
<asset:javascript src="jQueryUI/jquery-ui-1.8.21.min.js" />
<!-- Uniform -->
<asset:javascript src="Uniform/jquery.uniform.js" />
<!-- MD5 -->
<asset:javascript src="jQuery/md5.js" />
<!-- The Main JS File -->
<asset:javascript src="main.js" />
<!-- Favicon -->
<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
<g:layoutHead />
</head>
<body>
	<div class="top_panel">
		<g:if test="${session?.userId }">
			<div class="wrapper">
				<g:link controller="user" action="edit" id="${session.userId }" title="${message(code:'default.button.edit.label') }">
					<div class="user">
						<asset:image src="user_avatar.png" class="user_avatar"
							alt="user_avatar" />
						<span class="label"> ${session.name }
						</span>
					</div>
				</g:link>
				<div class="top_links">
					<ul>
						<li class="i_22_logout">
							<g:link controller="user" action="logout">
								<span class="label"><g:message code="logout.label" /></span>
							</g:link>
						</li>
						<g:if test="${!session.system }">
							<li class="i_22_forms">
								<g:link controller="user" action="reset" id="${session.userId }">
									<span class="label"><g:message code="default.button.reset.label" /></span>
								</g:link>
							</li>
						</g:if>
					</ul>
				</div>
			</div>
		</g:if>
	</div>
	<div class="wrapper small_menu">
		<ul class="menu_small_buttons">
			<li>
				<g:link title="${message(code:'overview.summary.label') }" controller="overview"
				 	class="i_22_dashboard  ${params.controller=='overview' ? 'smActive':'' }"></g:link>
			</li>
			<g:if test="${!session.system }">
				<li>
					<g:link title="${message(code:'task.summary.label') }" controller="task"
					 	class="i_22_tasks ${params.controller=='task' ? 'smActive':'' }"></g:link>
				</li>
				<li>
					<g:link title="${message(code:'product.summary.label') }" controller="product"
					 	class="i_22_forms ${params.controller=='product' ? 'smActive':'' }"></g:link>
				</li>
				<li>
					<g:link title="${message(code:'cr.summary.label') }" controller="cr"
					 	class="i_22_inbox ${params.controller=='cr' ? 'smActive':'' }"></g:link>
				</li>
			</g:if>
			<li>
				<g:link title="${message(code:'setting.summary.label') }" controller="setting"
				 	class="i_22_settings ${(params.controller in ['user','adapter','service','setting']) ? 'smActive':'' }"></g:link>
			</li>
		</ul>
	</div>
	<div class="wrapper contents_wrapper">
		<aside class="sidebar">
			<ul class="tab_nav">
				<li
					class="i_32_dashboard ${params.controller=='overview' ? 'active_tab':'' }">
					<g:link controller="overview"
						title="${message(code:'overview.summary.label') }">
						<span class="tab_label"><g:message code="overview.label" /></span>
						<span class="tab_info"><g:message
								code="overview.summary.label" /></span>
					</g:link>
				</li>
				<g:if test="${!session.system }">
					<li
						class="i_32_tasks ${params.controller=='task'? 'active_tab':'' }">
						<g:link controller="task"
							title="${message(code:'task.summary.label') }">
							<span class="tab_label"><g:message code="task.label" /></span>
							<span class="tab_info"><g:message code="task.summary.label" /></span>
						</g:link>
					</li>
					<li
						class="i_32_forms ${params.controller=='product'? 'active_tab':'' }">
						<g:link controller="product"
							title="${message(code:'product.summary.label') }">
							<span class="tab_label"><g:message code="product.label" /></span>
							<span class="tab_info"><g:message code="product.summary.label" /></span>
						</g:link>
					</li>
					<li
						class="i_32_inbox ${params.controller=='cr'? 'active_tab':'' }">
						<g:link controller="cr"
							title="${message(code:'cr.summary.label') }">
							<span class="tab_label"><g:message code="cr.label" /></span>
							<span class="tab_info"><g:message code="cr.summary.label" /></span>
						</g:link>
					</li>
				</g:if>
				<li
					class="i_32_settings ${(params.controller in ['user','adapter','service','setting']) ? 'active_tab':'' }">
					<g:link controller="setting"
						title="${message(code:'setting.summary.label') }">
						<span class="tab_label"><g:message code="setting.label" /></span>
						<span class="tab_info"><g:message code="setting.summary.label" /></span>
					</g:link>
				</li>
			</ul>
		</aside>
		<div class="contents">
			<div class="grid_wrapper">
				<div class="g_6 contents_header">
					<g:if test="${params.controller=='overview' }">
						<h3 class="i_16_dashboard tab_label">
								<g:message code="overview.label" />
						</h3>
						<div>
							<span class="label"><g:message code="overview.summary.label" /></span>
						</div>
					</g:if>
					<g:elseif test="${params.controller=='task'}">
						<h3 class="i_16_tasks tab_label">
								<g:message code="task.label" />
						</h3>
						<div>
							<span class="label"><g:message code="task.summary.label" /></span>
						</div>
					</g:elseif>
					<g:elseif test="${params.controller=='product'}">
						<h3 class="i_16_forms tab_label">
								<g:message code="product.label" />
						</h3>
						<div>
							<span class="label"><g:message code="product.summary.label" /></span>
						</div>
					</g:elseif>
					<g:elseif test="${params.controller=='cr'}">
						<h3 class="i_16_message tab_label">
								<g:message code="cr.label" />
						</h3>
						<div>
							<span class="label"><g:message code="cr.summary.label" /></span>
						</div>
					</g:elseif>
					<g:elseif test="${params.controller in ['user','adapter','service','setting']}">
						<h3 class="i_16_settings tab_label">
								<g:message code="setting.label" />
						</h3>
						<div>
							<span class="label"><g:message code="setting.summary.label" /></span>
						</div>
					</g:elseif>
				</div>
				<div class="g_6 contents_options">
					<g:if test="${params.controller in ['overview', 'task', 'product'] && !session.system}">
						<g:link controller="product" action="create"
							title="${message(code:'default.new.label',args:[message(code:'product.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'product.label') ]}" />
								</div>
							</div>
						</g:link>
						<g:link controller="task" action="create"
							title="${message(code:'default.new.label',args:[message(code:'task.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'task.label') ]}" />
								</div>
							</div>
						</g:link>
					</g:if>
					<g:elseif test="${params.controller=='cr'}">
						<g:link controller="cr" action="create"
							title="${message(code:'default.new.label',args:[message(code:'cr.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label" args="${[message(code:'cr.label') ]}" />
								</div>
							</div>
						</g:link>
					</g:elseif>
					<g:elseif test="${params.controller in ['user','adapter','service','setting']}">
						<g:link controller="adapter" action="create"
							title="${message(code:'default.new.label',args:[message(code:'adapter.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'adapter.label') ]}" />
								</div>
							</div>
						</g:link>
						<g:link controller="service" action="create"
							title="${message(code:'default.new.label',args:[message(code:'service.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'service.label') ]}" />
								</div>
							</div>
						</g:link>
						<g:if test="${session.system }">
							<g:link controller="user" action="create"
								title="${message(code:'default.new.label',args:[message(code:'user.label')]) }">
								<div class="simple_buttons">
									<div class="bwIcon i_16_add">
										<g:message code="default.new.label"
											args="${[message(code:'user.label') ]}" />
									</div>
								</div>
							</g:link>
						</g:if>
					</g:elseif>
				</div>
				
				<div class="g_12 separator">
					<span></span>
				</div>
			
				<g:hasErrors bean="${adapterInstance}">
					<div class="g_12">
						<g:eachError bean="${adapterInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
			
				<g:hasErrors bean="${crInstance}">
					<div class="g_12">
						<g:eachError bean="${crInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
			
				<g:hasErrors bean="${productInstance}">
					<div class="g_12">
						<g:eachError bean="${productInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
			
				<g:hasErrors bean="${serviceInstance}">
					<div class="g_12">
						<g:eachError bean="${serviceInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
			
				<g:hasErrors bean="${taskInstance}">
					<div class="g_12">
						<g:eachError bean="${taskInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
			
				<g:hasErrors bean="${userInstance}">
					<div class="g_12">
						<g:eachError bean="${userInstance}" var="error">
							<div class="alert iDialog"><g:message error="${error}"/></div>
						</g:eachError>
					</div>
				</g:hasErrors>
				
				<g:if test="${flash.errors }">
					<div class="g_12">
						<g:each in="${flash.errors }" var="error">
							<div class="alert iDialog">${error }</div>
						</g:each>
					</div>
				</g:if>
				
				<g:if test="${flash.message }">
					<div class="g_12">
						<div class="success iDialog">${flash.message }</div>
					</div>
				</g:if>
				
				<g:layoutBody />
			</div>
		</div>
	</div>
</body>
</html>
