package fenix

class PlanoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        def tipo = TipoEmprestimo.get(params.int('tipoEmprestimo_id'));
        def planos = null
        def size = 0
        if (tipo){
            planos = Plano.findAllByTipoEmprestimo(tipo, params)
            size = Plano.findAllByTipoEmprestimo(tipo).size()
        } else {
            planos = Plano.list(params)
            size = Plano.count()
        }
        [planoInstanceList: planos,tipoList: TipoEmprestimo.list(), planoInstanceTotal: size, tipoInstance: tipo, tipoEmprestimo_id:tipo?.id]
    }

    def create = {
        def planoInstance = new Plano()
        planoInstance.properties = params
        return [planoInstance: planoInstance]
    }

    def save = {
        def planoInstance = new Plano(params)
        if (planoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'plano.label', default: 'Plano'), planoInstance.id])}"
            redirect(action: "show", id: planoInstance.id)
        }
        else {
            render(view: "create", model: [planoInstance: planoInstance])
        }
    }

    def show = {
        def planoInstance = Plano.get(params.id)
        if (!planoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
            redirect(action: "list")
        }
        else {
            [planoInstance: planoInstance]
        }
    }

    def edit = {
        def planoInstance = Plano.get(params.id)
        if (!planoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [planoInstance: planoInstance]
        }
    }

    def update = {
        def planoInstance = Plano.get(params.id)
        if (planoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (planoInstance.version > version) {
                    
                    planoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'plano.label', default: 'Plano')] as Object[], "Another user has updated this Plano while you were editing")
                    render(view: "edit", model: [planoInstance: planoInstance])
                    return
                }
            }
            planoInstance.properties = params
            if (!planoInstance.hasErrors() && planoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'plano.label', default: 'Plano'), planoInstance.id])}"
                redirect(action: "show", id: planoInstance.id)
            }
            else {
                render(view: "edit", model: [planoInstance: planoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def planoInstance = Plano.get(params.id)
        if (planoInstance) {
            try {
                planoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plano.label', default: 'Plano'), params.id])}"
            redirect(action: "list")
        }
    }
}
