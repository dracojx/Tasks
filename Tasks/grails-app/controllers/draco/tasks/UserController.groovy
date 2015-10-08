package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", auth: "POST"]

    def reset(){
        respond User.get(params.id as Long)
	}

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', userInstance.getName()])
	            redirect action: 'edit', id: userInstance.getId()
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
		if((!session.admin && (params.id as long != session.userId)) || userInstance.isSystem()) {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
			return
		}
        respond userInstance
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }
		
		if((!session.admin && (params.id as long != session.userId)) || userInstance.isSystem()) {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
			return
		}

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
                redirect action: 'edit', id: userInstance.getId()
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete() {
		if(User.get(session.userId)?.isAdmin()) {
			User userInstance = User.get(params.id)
			if(userInstance.isSystem()) {
				flash.errors = [message(code: 'default.unauthorized.message')]
				redirect controller:'setting', action:'index'
				return
			}
			if(userInstance) {
				userInstance.setActivate(false)
				userInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
				redirect controller:'setting', action:'index'
			} else {
                flash.errors = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
				redirect controller:'setting', action:'index'
			}
		} else {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
		}
    }
	
	def login() {
		
	}
	
	def logout() {
		session.invalidate()
		redirect action:'login'
	}

    def auth() {
		User user = User.findByUsernameAndPassword(params.user?.trim().toUpperCase(), params.pass)
	
	    if (user == null) {
	        wrongUser()
	        return
	    }
		
		session.userId = user.getId()
		session.name = user.getName()
		session.admin = user.isAdmin()
		
		if(user.isReset()) {
		    flash.message = message(code: 'user.password.needchange.message')
			redirect action:'reset', id:user.id
			return
		} else {
		    request.withFormat {
		        form multipartForm {
		            flash.message = message(code: 'default.welcome.message', args:[user.getName()])
		            redirect url: "/"
		        }
		        '*'{ render status: NO_CONTENT }
		    }
		}
	}
	
	def setAdmin() {
		if(User.get(session.userId)?.isAdmin()) {
			User userInstance = User.get(params.id)
			if(userInstance) {
				if(!userInstance.isActivate()) {
					flash.errors = [message(code:'default.update.failed.message', 
						args:[message(code:'default.deactivated.message', args:[userInstance.getName()])])]
					redirect controller:'setting', action:'index'
					return
				}
				if(userInstance.isSystem()) {
					flash.errors = [message(code: 'default.unauthorized.message')]
					redirect controller:'setting', action:'index'
					return
				}
				userInstance.setAdmin(true)
				userInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
				redirect controller:'setting', action:'index'
			} else {
                flash.errors = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
				redirect controller:'setting', action:'index'
			}
		} else {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
		}
	}
	
	def removeAdmin() {
		if(User.get(session.userId)?.isAdmin()) {
			User userInstance = User.get(params.id)
			if(userInstance) {
				if(!userInstance.isActivate()) {
					flash.errors = [message(code:'default.update.failed.message', 
						args:[message(code:'default.deactivated.message', args:[userInstance.getName()])])]
					redirect controller:'setting', action:'index'
					return
				}
				if(userInstance.isSystem()) {
					flash.errors = [message(code: 'default.unauthorized.message')]
					redirect controller:'setting', action:'index'
					return
				}
				userInstance.setAdmin(false)
				userInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
				redirect controller:'setting', action:'index'
			} else {
                flash.errors = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
				redirect controller:'setting', action:'index'
			}
		} else {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
		}
	}

    @Transactional
    def activate() {
		if(User.get(session.userId)?.isAdmin()) {
			User userInstance = User.get(params.id)
			if(userInstance) {
				if(userInstance.isSystem()) {
					flash.errors = message(code: 'default.unauthorized.message')
					redirect controller:'setting', action:'index'
				}
				userInstance.setActivate(true)
				userInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
				redirect controller:'setting', action:'index'
			} else {
                flash.errors = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
				redirect controller:'setting', action:'index'
			}
		} else {
			flash.errors = message(code: 'default.unauthorized.message')
			redirect controller:'setting', action:'index'
		}
    }
	
	@Transactional
	def resetPass(User userInstance) {
		if((!session.admin && (userInstance.id != session.userId)) || userInstance.isSystem()) {
			flash.errors = [message(code: 'default.unauthorized.message')]
			redirect controller:'setting', action:'index'
			return
		}
		
		if(userInstance.id == session.userId) {
			userInstance.setReset(false)
			userInstance.save flush:true
			flash.message = message(code: 'default.welcome.message', args: [userInstance.getName()])
			redirect url:'/'
		} else {
			userInstance.setReset(true)
			userInstance.save flush:true
			flash.message = message(code: 'default.updated.message', args: ['', userInstance.getName()])
			redirect controller:'setting', action:'index'
		}
		
	}

	protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	protected void wrongUser() {
        request.withFormat {
            form multipartForm {
                flash.errors = [message(code: 'default.wrong.user.message', default:'Username or password is incorrect')]
                redirect action: "login", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
	}
}
