package tasks



import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def login() {
		def username = params.username
		def password = params.password

		User user = User.findByUsernameAndPassword(username, password)

		if(!user) {
			render ([
				status:'1',
				messages:[
					message(code:'login.failed.message')]
			] as JSON)
		} else if(!user.getEnabled()) {
			render ([
				status:'1',
				messages:[
					message(code:'default.disabled.message', args:[user.getUsername()])]
			] as JSON)
		} else if(user.getReset()){
			//TODO
		} else {
			session.userId = user.getId()
			session.name = user.getName()
			session.role = user.getRole()
			render ([
				status:'0',
				url:'index'
			] as JSON)
		}
	}

	def logout() {
		session.invalidate()
		render ([status:'0', url:'login'] as JSON)
	}

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond User.list(params), model:[userInstanceCount: User.count()]
	}

	def create() {
		render (view:'create', model:[userInstance: new User()])
	}

	@Transactional
	def save(User userInstance) {
		if(userInstance.hasErrors()) {
			def errors = []
			userInstance.errors.getFieldErrors().each { errors.add(message(error: it)) }
			render ([
				status:'2',
				messages:errors
			] as JSON)
		}

		userInstance.save flush:true
		render ([
			status:'0',
			messages:[
				message(code:'default.created.message', args: [userInstance.getUsername()])
			],
			userInstance: userInstance
		] as JSON)

		//        if (userInstance == null) {
		//            notFound()
		//            return
		//        }
		//
		//        if (userInstance.hasErrors()) {
		//            respond userInstance.errors, view:'create'
		//            return
		//        }
		//
		//
		//        request.withFormat {
		//            form multipartForm {
		//                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
		//                redirect userInstance
		//            }
		//            '*' { respond userInstance, [status: CREATED] }
		//        }
	}

	def edit(User userInstance) {
		respond userInstance
	}

	@Transactional
	def update(User userInstance) {
		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'edit'
			return
		}

		userInstance.save flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'User.label', default: 'User'),
					userInstance.id
				])
				redirect userInstance
			}
			'*'{ respond userInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(User userInstance) {

		if (userInstance == null) {
			notFound()
			return
		}

		userInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'User.label', default: 'User'),
					userInstance.id
				])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'user.label', default: 'User'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
