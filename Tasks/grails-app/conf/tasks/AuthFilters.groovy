package tasks

import org.springframework.web.servlet.support.RequestContextUtils

import draco.tasks.Task
import draco.tasks.User

class AuthFilters {
	def messageSource
    def filters = {
        auth(controller:'*', action:'*', controllerExclude:'assets') {
            before = {
				if(session.userId || actionName=='login' || actionName=='auth') {
					return true
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
		
		authTask(controller:'task', action:'update|delete|activate|prev|next|changeLogType|removeCr|removeLog|removeTag') {
            before = {
				User user = User.get(session.userId)
				Task task = Task.get(params.id as Long)
				if(!user.isAdmin() && !task.getUser().equals(user)) {
					flash.errors = [messageSource.getMessage('default.unauthorized.message', null, RequestContextUtils.getLocale(request))]
					redirect controller:'task', action:'edit',id:params.id
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
