<%@ page import="draco.tasks.Task"%>
<%@ page import="draco.tasks.Product"%>
<%@ page import="draco.tasks.Service"%>
<%@ page import="draco.tasks.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
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

	<g:each
		in="${Task.findAllByUserAndStatus(User.get(session.userId), '1') }"
		var="taskInstance">
		<div class="g_6">
			<div class="widget_header cwhToggle">
				<h4 class="widget_header_title wwIcon i_16_downT">
					<g:message code="task.incomplete.label" />
				</h4>
			</div>
			<div class="widget_contents noPadding">
				<g:render template="/task/show"
					model="${[taskInstance:taskInstance] }"></g:render>
			</div>
		</div>
	</g:each>

	<g:each
		in="${Task.findAllByUserAndStatus(User.get(session.userId), '0') }"
		var="taskInstance">
		<div class="g_6">
			<div class="widget_header cwhToggle">
				<h4 class="widget_header_title wwIcon i_16_downT">
					<g:message code="task.incomplete.label" />
				</h4>
			</div>
			<div class="widget_contents noPadding">
				<g:render template="/task/show"
					model="${[taskInstance:taskInstance] }"></g:render>
			</div>
		</div>
	</g:each>
</body>
</html>