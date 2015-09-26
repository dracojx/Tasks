package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdapterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Adapter.list(params), model:[adapterInstanceCount: Adapter.count()]
    }

    def show(Adapter adapterInstance) {
        respond adapterInstance
    }

    def create() {
        respond new Adapter(params)
    }

    @Transactional
    def save(Adapter adapterInstance) {
        if (adapterInstance == null) {
            notFound()
            return
        }

        if (adapterInstance.hasErrors()) {
            respond adapterInstance.errors, view:'create'
            return
        }

        adapterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adapter.label', default: 'Adapter'), adapterInstance.id])
                redirect adapterInstance
            }
            '*' { respond adapterInstance, [status: CREATED] }
        }
    }

    def edit(Adapter adapterInstance) {
        respond adapterInstance
    }

    @Transactional
    def update(Adapter adapterInstance) {
        if (adapterInstance == null) {
            notFound()
            return
        }

        if (adapterInstance.hasErrors()) {
            respond adapterInstance.errors, view:'edit'
            return
        }

        adapterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Adapter.label', default: 'Adapter'), adapterInstance.id])
                redirect adapterInstance
            }
            '*'{ respond adapterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Adapter adapterInstance) {

        if (adapterInstance == null) {
            notFound()
            return
        }

        adapterInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Adapter.label', default: 'Adapter'), adapterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adapter.label', default: 'Adapter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
