<%@ page import="draco.tasks.User"%>
<%@ page import="draco.tasks.Task"%>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:message code="project.label" default="Task Management" /></title>
<!-- The Fonts -->
<link href="http://fonts.useso.com/css?family=Oswald|Droid+Sans:400,700"
	rel="stylesheet">
<!-- The Main CSS File -->
<asset:stylesheet src="style.css" />
<!-- jQuery -->
<asset:javascript src="jQuery/jquery-1.7.2.min.js" />
<!-- jQuryUI -->
<asset:javascript src="jQueryUI/jquery-ui-1.8.21.min.js" />
<!-- Uniform -->
<asset:javascript src="Uniform/jquery.uniform.js" />
<!-- The Main JS File -->
<asset:javascript src="main.js" />
<g:layoutHead />
</head>
<body>
	<div class="top_panel">
		<g:if test="${session?.userId }">
			<div class="wrapper">
				<div class="user">
					<asset:image src="user_avatar.png" class="user_avatar"
						alt="user_avatar" />
					<span class="label"> ${User.get(session.userId)?.getName() }
					</span>
				</div>
				<div class="top_links">
					<ul>
						<li class="i_22_logout"><g:link controller="user"
								action="logout">
								<span class="label"><g:message code="logout.label" /></span>
							</g:link></li>
					</ul>
				</div>
			</div>
		</g:if>
	</div>
	<div class="wrapper small_menu">
		<ul class="menu_small_buttons">
			<li>
				<g:link title="${message(code:'overview.summary.label') }" uri="/index"
				 	class="i_22_dashboard ${!params.controller&&(params.action='index') ? 'smActive':'' }"></g:link>
			</li>
			<li>
				<g:link title="${message(code:'overview.summary.label') }" controller="task" action="index"
				 	class="i_22_tasks ${params.controller=='task' ? 'smActive':'' }"></g:link>
			</li>
		</ul>
	</div>
	<div class="wrapper contents_wrapper">
		<aside class="sidebar">
			<ul class="tab_nav">
				<li
					class="i_32_dashboard ${!params.controller&&(params.action='index')? 'active_tab':'' }">
					<g:link uri="/index"
						title="${message(code:'overview.summary.label') }">
						<span class="tab_label"><g:message code="overview.label" /></span>
						<span class="tab_info"><g:message
								code="overview.summary.label" /></span>
					</g:link>
				</li>
				<li
					class="i_32_tasks ${params.controller=='task'? 'active_tab':'' }">
					<g:link controller="task" action="index"
						title="${message(code:'task.summary.label') }">
						<span class="tab_label"><g:message code="task.label" /></span>
						<span class="tab_info"><g:message code="task.summary.label" /></span>
					</g:link>
				</li>
			</ul>
		</aside>
		<div class="contents">
			<div class="grid_wrapper">
				<g:layoutBody />
			</div>
		</div>
	</div>
</body>
</html>
