<%@ page import="draco.tasks.Task"%>
<%@ page import="draco.tasks.Product"%>
<%@ page import="draco.tasks.Service"%>
<%@ page import="draco.tasks.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="template" />
</head>
<body>
	<div class="contents">
		<div class="grid_wrapper">
			<div class="g_6 contents_header">
				<h3 class="i_16_dashboard tab_label">
					<g:message code="overview.label" />
				</h3>
				<div>
					<span class="label"><g:message code="overview.summary.label" /></span>
				</div>
			</div>
			<div class="g_6 contents_options">
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
			</div>

			<div class="g_12 separator">
				<span></span>
			</div>
			<div class="g_3 quick_stats">
				<div class="big_stats visitor_stats">
					${Task.count() }
				</div>
				<h5 class="stats_info">
					<g:message code="task.label" />
				</h5>
			</div>
			<div class="g_3 quick_stats">
				<div class="big_stats tickets_stats">
					${Product.count() }
				</div>
				<h5 class="stats_info">
					<g:message code="product.label" />
				</h5>
			</div>
			<div class="g_3 quick_stats">
				<div class="big_stats users_stats">
					${Service.count() }
				</div>
				<h5 class="stats_info">
					<g:message code="service.label" />
				</h5>
			</div>
			<div class="g_3 quick_stats">
				<div class="big_stats orders_stats">
					${User.count() }
				</div>
				<h5 class="stats_info">
					<g:message code="user.label" />
				</h5>
			</div>


			<div class="g_12 separator under_stat">
				<span></span>
			</div>
			<div class="g_12">
				<div class="widget_header">
					<h4 class="widget_header_title wwIcon i_16_forms">
						<g:message code="default.latest.label"
							args="${[message(code:'task.label')] }" />
					</h4>
				</div>
				<div class="widget_contents noPadding">
					<g:render controller="task" template="/task/form"
						model="${['taskInstance':Task.findByUser(User.get(session.userId),[sort:'createDate', order:'desc'])]}"></g:render>
				</div>
			</div>
		</div>
	</div>
</body>
</html>