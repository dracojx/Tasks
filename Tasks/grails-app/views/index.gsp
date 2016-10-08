<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:message code="project.label" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${assetPath(src: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${assetPath(src: 'apple-touch-icon-retina.png')}">
<asset:stylesheet src="application.css" />
<asset:javascript src="application.js" />
</head>
<body>
	<div class="top_panel">
		<div class="wrapper">
			<g:link controller="user" action="edit" id="${session.userId }"
				title="${message(code:'default.button.edit.label') }">
				<div class="user">
					<asset:image src="user_avatar.png" class="user_avatar"
						alt="user_avatar" />
					<span class="label"> ${session.name }
					</span>
				</div>
			</g:link>
			<div class="top_links">
				<ul>
					<li id="user_logout_post" class="i_22_logout">
							<span class="label"><g:message
									code="default.button.logout.label" /></span>
					</li>
					<g:if test="${session.role != '0' }">
						<li class="i_22_forms"><g:link controller="user"
								action="reset" id="${session.userId }">
								<span class="label"><g:message
										code="default.button.reset.label" /></span>
							</g:link></li>
					</g:if>
				</ul>
			</div>
		</div>
	</div>
	<div class="wrapper contents_wrapper">
		<aside class="sidebar">
			<ul class="tab_nav">
				<li class="i_32_dashboard active_tab"><span class="tab_label"><g:message
							code="overview.label" /></span> <span class="tab_info"><g:message
							code="overview.summary.label" /></span></li>
				<g:if test="${session.role != '0' }">
					<li class="i_32_tasks">
							<span class="tab_label"><g:message code="task.label" /></span>
							<span class="tab_info"><g:message
									code="task.summary.label" /></span>
						</li>
					<li class="i_32_forms"><span class="tab_label"><g:message
								code="product.label" /></span> <span class="tab_info"><g:message
								code="product.summary.label" /></span></li>
					<li class="i_32_inbox"><span class="tab_label"><g:message
								code="cr.label" /></span> <span class="tab_info"><g:message
								code="cr.summary.label" /></span></li>
				</g:if>
				<li class="i_32_settings"><span class="tab_label"><g:message
							code="setting.label" /></span> <span class="tab_info"><g:message
							code="setting.summary.label" /></span></li>
			</ul>
		</aside>
		<div class="contents">
			<div class="grid_wrapper">
				<div class="g_6 contents_header">
					<h3 class="i_16_dashboard tab_label active">
						<g:message code="overview.label" />
					</h3>
					<g:if test="${session.role != '0' }">
						<h3 class="i_16_tasks tab_label">
							<g:message code="task.label" />
						</h3>
						<h3 class="i_16_forms tab_label">
							<g:message code="product.label" />
						</h3>
						<h3 class="i_16_message tab_label">
							<g:message code="cr.label" />
						</h3>
					</g:if>
					<h3 class="i_16_settings tab_label">
						<g:message code="setting.label" />
					</h3>
					<div>
						<span class="label active"> <g:message
								code="overview.summary.label" /></span> <span class="label"><g:message
								code="task.summary.label" /></span> <span class="label"><g:message
								code="product.summary.label" /></span> <span class="label"><g:message
								code="cr.summary.label" /></span> <span class="label"><g:message
								code="setting.summary.label" /></span>
					</div>
				</div>

				<div class="g_6 contents_options">
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
					<g:if test="${session.role != '0' }">
						<g:link controller="cr" action="create"
							title="${message(code:'default.new.label',args:[message(code:'cr.label')]) }">
							<div class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'cr.label') ]}" />
								</div>
							</div>
						</g:link>
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
					<g:else>
							<div id="user_create_get" class="simple_buttons">
								<div class="bwIcon i_16_add">
									<g:message code="default.new.label"
										args="${[message(code:'user.label') ]}" />
								</div>
							</div>
					</g:else>
				</div>

				<div class="g_12 separator">
					<span></span>
				</div>

				<div id="messages" class="g_12"></div>

				<div id="main" class="g_12"></div>

			</div>
		</div>
	</div>
</body>
</html>
