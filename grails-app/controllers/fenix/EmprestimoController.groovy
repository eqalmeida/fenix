package fenix

import grails.converters.*

class EmprestimoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def EmprestimoService

    def nomes = [0:"Não Efetivados",1:"Ativos",2:"Cancelados",3:"Congelados",4:"em Acordo",5:"em Protesto",6:"Em Atraso", 7:"Quitados"]

    def mudarStatusModal = {
        def emprestimo = Emprestimo.get(params.id)
        [emprestimoInstance: emprestimo]
    }

    def mudarStatus = {
        def emprestimo = Emprestimo.get(params.id)
        if (emprestimo){

            def newStatus = params.newStatus.toInteger()

            if(newStatus != emprestimo.status){

                def log = new Log()
                log.usuario = session.usuario
                log.data = new Date()
                log.descricao = "Mudanca de Status do emprestimo:${emprestimo.id}, do cliente: ${emprestimo.cliente.nome} - Anterior: ${emprestimo.status} - Novo: ${newStatus}"
                log.save(flush:true)

                emprestimo.status = newStatus
                emprestimo.save(flush:true)



            }

            redirect(action: "show", id: emprestimo.id)
        }
    }

    def listPlanos = {
        def tipo = TipoEmprestimo.get(params.id)
        render tipo?.planos as JSON
    }

    def addObs = {
        def emprestimo = Emprestimo.get(params.id)
        def obs = new Observacao()
        obs.emprestimo = emprestimo
        obs.usuario = session.usuario
        obs.data = new Date()
        obs.obs = params.observ
        if (!obs.save(flush:true)){
            flash.erros = "Não foi possível gravar"
        }
        redirect(action: "show", id:emprestimo.id)
    }

    def efetivar = {
        def emprestimoInstance = Emprestimo.get(params.id)

        try{
            emprestimoInstance.efetivar()
            flash.message = "Emprestimo efetivado!"
        }
        catch(Exception e){
            flash.message = "Não foi possível efetivar!"
        }
        redirect(action: "show", id: emprestimoInstance.id)

    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        EmprestimoService.atualizarStatus()
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def emp = Emprestimo.findAllByStatus(params.status, params)
        def stat = ""
        if(params.status){
            stat = nomes[params.status.toInteger()]
        }
        [emprestimoInstanceList: emp, emprestimoInstanceTotal: Emprestimo.count(), stat: stat]
    }

    def create = {
        def emprestimoInstance = new Emprestimo()
        emprestimoInstance.properties = params
        return [emprestimoInstance: emprestimoInstance]
    }

    def save = {
      
        def emprestimoInstance = new Emprestimo(params)
        emprestimoInstance.usuario = session.usuario

        if(emprestimoInstance.plano){
            def val = emprestimoInstance.valorLiberado?emprestimoInstance.valorLiberado:0
            emprestimoInstance.tac = emprestimoInstance.plano.tac
            emprestimoInstance.valorParcela = (emprestimoInstance.tac + val) * emprestimoInstance.plano.coeficiente
            emprestimoInstance.numParcelas = emprestimoInstance.plano.numParcelas
        }
        if (emprestimoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), emprestimoInstance.id])}"
            redirect(action: "show", id: emprestimoInstance.id)
        }
        else {
            render(view: "create", model: [emprestimoInstance: emprestimoInstance])
        }
    }

    def show = {
        EmprestimoService.atualizarStatus()
        def emprestimoInstance = Emprestimo.get(params.id)
        if (!emprestimoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
            redirect(action: "list")
        }
        else {
            [emprestimoInstance: emprestimoInstance]
        }
    }

    def print = {
        EmprestimoService.atualizarStatus()
        def emprestimoInstance = Emprestimo.get(params.id)
        if (!emprestimoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
            redirect(action: "list")
        }
        else {
            [emprestimoInstance: emprestimoInstance]
        }
    }

    def edit = {
        def emprestimoInstance = Emprestimo.get(params.id)
        if (!emprestimoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
            redirect(action: "list")
        }
  /*      else if (emprestimoInstance.status != 0) {
            flash.message = "Empréstimo efetivado não pode ser editado!"
            redirect(action: "show", id:emprestimoInstance.id)
        }
  */      else {
            return [emprestimoInstance: emprestimoInstance]
        }
    }

    def update = {
        def emprestimoInstance = Emprestimo.get(params.id)
        if (emprestimoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (emprestimoInstance.version > version) {
                    
                    emprestimoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'emprestimo.label', default: 'Emprestimo')] as Object[], "Another user has updated this Emprestimo while you were editing")
                    render(view: "edit", model: [emprestimoInstance: emprestimoInstance])
                    return
                }
            }
            emprestimoInstance.properties = params
            emprestimoInstance.usuario = session.usuario

            if(emprestimoInstance.plano){
                emprestimoInstance.tac = emprestimoInstance.plano.tac
                emprestimoInstance.valorParcela = (emprestimoInstance.tac + emprestimoInstance.valorLiberado) * emprestimoInstance.plano.coeficiente
                emprestimoInstance.numParcelas = emprestimoInstance.plano.numParcelas
            }
            if (!emprestimoInstance.hasErrors() && emprestimoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), emprestimoInstance.id])}"
                redirect(action: "show", id: emprestimoInstance.id)
            }
            else {
                render(view: "edit", model: [emprestimoInstance: emprestimoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def emprestimoInstance = Emprestimo.get(params.id)
        if (emprestimoInstance) {
            try {
                emprestimoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emprestimo.label', default: 'Emprestimo'), params.id])}"
            redirect(action: "list")
        }
    }
}
