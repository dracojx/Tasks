package tasks

import org.springframework.web.servlet.support.RequestContextUtils

import draco.tasks.Task
import draco.tasks.User

class AuthFilters {
	def messageSource
	def filters = {
		auth(controller:'*', action:'*', controllerExclude:'assets') {
			before = {
				if((session.userId && !session.reset) ||  
					actionName=='login' || actionName=='auth' || actionName=='logout' ||
					((actionName=='reset' || actionName=='resetPass')&&session.reset)) {
					return true
				} else if(session.userId && session.reset) {
					redirect(controller:'user', action:'reset', id:session.userId)
					return false
				} else {
					redirect(controller:'user', action:'login')
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}

		authTask(controller:'task', action:'update|delete|activate|deactivate|prev|next|changeLogType|removeCr|removeLog|removeTag') {
			before = {
				User user = User.get(session.userId)
				Task task = Task.get(params.id as Long)
				if(!session.admin && !task.getUser().equals(user)) {
					flash.errors = [
						messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))
					]
					redirect controller:'task', action:'edit',id:params.id
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}
		
		authProduct(controller:'product', action:'delete') {
			before = {
				if(!session.admin) {
					flash.errors = [
						messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))
					]
					redirect controller:'product', action:'edit',id:params.id
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}

		authSystem(controller:'task|product|cr', action:'*') {
			before = {
				if(!session.system) {
					return true
				} else {
					flash.errors = [
						messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))
					]
					redirect url:'/'
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}

		authUpload(controller:'setting', action:'upload') {
			before = {
				if(!session.system) {
					return true
				} else {
					flash.errors = [
						messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))
					]
					redirect url:'/'
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}
		
		authUser(controller:'user', action:'activate|create|delete|removeAdmin|save|setAdmin') {
			before = {
				if(session.system) {
					return true
				} else {
					flash.errors = [
						messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))
					]
					redirect url:'/'
					return false
				}
			}
			after = { Map model ->
			}
			afterView = { Exception e ->
			}
		}
	}
}
