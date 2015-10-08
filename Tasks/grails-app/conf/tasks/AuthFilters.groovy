package tasks

class AuthFilters {

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
    }
}
