package fenix

class ClienteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.query= params.query?params.query:""
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        def clientes = Cliente.findAllByNomeIlikeOrId("%"+params.query+"%",params.int('query'), params)
        def size = Cliente.findAllByNomeIlikeOrId("%"+params.query+"%",params.int('query')).size()
        [clienteInstanceList: clientes, clienteInstanceTotal: size,query:params.query,
         data: [[0, 10], [4, 5], null, [6, 2.5], [12, 10]]]
    }

    def create = {
        def clienteInstance = new Cliente()
        clienteInstance.properties = params
        return [clienteInstance: clienteInstance]
    }

    def save = {
        def clienteInstance = new Cliente(params)
        clienteInstance.saldo = 0.toBigDecimal()
        if(!clienteInstance.telefoneRes && !clienteInstance.telefoneCom && !clienteInstance.telefoneCel){

            clienteInstance.errors.rejectValue("telefoneRes", "default.allTelefone.required", "Pelo menos um dos telefones deve ser informado! ")
            render(view: "create", model: [clienteInstance: clienteInstance])
            return

        }
        else if (clienteInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'cliente.label', default: 'Cliente'), clienteInstance.id])}"
            redirect(action: "show", id: clienteInstance.id)
        }
        else {
            render(view: "create", model: [clienteInstance: clienteInstance])
        }
    }

    def show = {
        def clienteInstance = Cliente.get(params.id)
        if (!clienteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
            redirect(action: "list")
        }
        else {
            [clienteInstance: clienteInstance]
        }
    }

    def edit = {
        def clienteInstance = Cliente.get(params.id)
        if (!clienteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [clienteInstance: clienteInstance]
        }
    }

    def update = {
        def clienteInstance = Cliente.get(params.id)
        if (clienteInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (clienteInstance.version > version) {
                    
                    clienteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cliente.label', default: 'Cliente')] as Object[], "Another user has updated this Cliente while you were editing")
                    render(view: "edit", model: [clienteInstance: clienteInstance])
                    return
                }
            }
            def saldoBkp = clienteInstance.saldo
            clienteInstance.properties = params
            clienteInstance.saldo = saldoBkp

            if(!clienteInstance.telefoneRes && !clienteInstance.telefoneCom && !clienteInstance.telefoneCel){

                clienteInstance.errors.rejectValue("telefoneRes", "default.allTelefone.required", "Pelo menos um dos telefones deve ser informado! ")
                render(view: "edit", model: [clienteInstance: clienteInstance])
                return

            }


            else if (!clienteInstance.hasErrors() && clienteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cliente.label', default: 'Cliente'), clienteInstance.id])}"
                redirect(action: "show", id: clienteInstance.id)
            }
            else {
                render(view: "edit", model: [clienteInstance: clienteInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def clienteInstance = Cliente.get(params.id)
        if (clienteInstance) {
            try {
                clienteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])}"
            redirect(action: "list")
        }
    }
}
