package fenix

class EspecieController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gerar = {
        for(i in 1..1000){
            def esp = new Especie(nome:"TESTE ${i}", geraBoleto:false, ativo:true)
            esp.save(flush:true)
        }
        redirect(action: "list", params: params)
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [especieInstanceList: Especie.list(params), especieInstanceTotal: Especie.count()]
    }

    def create = {
        def especieInstance = new Especie()
        especieInstance.properties = params
        return [especieInstance: especieInstance]
    }

    def save = {
        def especieInstance = new Especie(params)
        if (especieInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'especie.label', default: 'Especie'), especieInstance.id])}"
            redirect(action: "show", id: especieInstance.id)
        }
        else {
            render(view: "create", model: [especieInstance: especieInstance])
        }
    }

    def show = {
        def especieInstance = Especie.get(params.id)
        if (!especieInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
            redirect(action: "list")
        }
        else {
            [especieInstance: especieInstance]
        }
    }

    def edit = {
        def especieInstance = Especie.get(params.id)
        if (!especieInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [especieInstance: especieInstance]
        }
    }

    def update = {
        def especieInstance = Especie.get(params.id)
        if (especieInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (especieInstance.version > version) {
                    
                    especieInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'especie.label', default: 'Especie')] as Object[], "Another user has updated this Especie while you were editing")
                    render(view: "edit", model: [especieInstance: especieInstance])
                    return
                }
            }
            especieInstance.properties = params
            if (!especieInstance.hasErrors() && especieInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'especie.label', default: 'Especie'), especieInstance.id])}"
                redirect(action: "show", id: especieInstance.id)
            }
            else {
                render(view: "edit", model: [especieInstance: especieInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def especieInstance = Especie.get(params.id)
        if (especieInstance) {
            try {
                especieInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'especie.label', default: 'Especie'), params.id])}"
            redirect(action: "list")
        }
    }
}
