package fenix

class TipoEmprestimoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoEmprestimoInstanceList: TipoEmprestimo.list(params), tipoEmprestimoInstanceTotal: TipoEmprestimo.count()]
    }

    def create = {
        def tipoEmprestimoInstance = new TipoEmprestimo()
        tipoEmprestimoInstance.properties = params
        return [tipoEmprestimoInstance: tipoEmprestimoInstance]
    }

    def save = {
        def tipoEmprestimoInstance = new TipoEmprestimo(params)
        if (tipoEmprestimoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), tipoEmprestimoInstance.id])}"
            redirect(action: "show", id: tipoEmprestimoInstance.id)
        }
        else {
            render(view: "create", model: [tipoEmprestimoInstance: tipoEmprestimoInstance])
        }
    }

    def show = {
        def tipoEmprestimoInstance = TipoEmprestimo.get(params.id)
        if (!tipoEmprestimoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tipoEmprestimoInstance: tipoEmprestimoInstance]
        }
    }

    def edit = {
        def tipoEmprestimoInstance = TipoEmprestimo.get(params.id)
        if (!tipoEmprestimoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tipoEmprestimoInstance: tipoEmprestimoInstance]
        }
    }

    def update = {
        def tipoEmprestimoInstance = TipoEmprestimo.get(params.id)
        if (tipoEmprestimoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoEmprestimoInstance.version > version) {
                    
                    tipoEmprestimoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo')] as Object[], "Another user has updated this TipoEmprestimo while you were editing")
                    render(view: "edit", model: [tipoEmprestimoInstance: tipoEmprestimoInstance])
                    return
                }
            }
            tipoEmprestimoInstance.properties = params
            if (!tipoEmprestimoInstance.hasErrors() && tipoEmprestimoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), tipoEmprestimoInstance.id])}"
                redirect(action: "show", id: tipoEmprestimoInstance.id)
            }
            else {
                render(view: "edit", model: [tipoEmprestimoInstance: tipoEmprestimoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tipoEmprestimoInstance = TipoEmprestimo.get(params.id)
        if (tipoEmprestimoInstance) {
            try {
                tipoEmprestimoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo'), params.id])}"
            redirect(action: "list")
        }
    }
}
