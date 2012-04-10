package fenix

import grails.converters.*

class EmprestimoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def EmprestimoService

   // def BackupService

    def nomes = [0:"Não Efetivados",1:"Regulares",2:"Cancelados",3:"Congelados",4:"Em Acordo",5:"Em Protesto",6:"Em Atraso", 7:"Quitados"]

    def chart = {
    //BackupService.efetuarBackup()

        def labels = []
        def values = []
        def valor = 0
        def total = 0
        nomes.each {
            valor = Emprestimo.findAllByStatus(it.key).size()
            if (valor > 0){
                labels.add(it.value)
                values.add(valor)
                total += valor
            }
        }
        [labels:labels, values:values, total:total]
    }

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
        def tipo = TipoEmprestimo.get(params.int('id'))
        /*render tipo?.planos as JSON*/
        render select(from:tipo?.planos, name:'plano.id', optionKey:'id')
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
            flash.message = "Não foi possível efetivar! (${e.message})"
        }
        redirect(action: "show", id: emprestimoInstance.id)

    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        EmprestimoService.atualizarStatus()
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        def emp = null;
        def stat = ""
        def size = 0
        if(params.status){
            stat = nomes[params.status.toInteger()]
            emp = Emprestimo.findAllByStatus(params.status, params)
            size = Emprestimo.findAllByStatus(params.status).size()
        } else {
            emp = Emprestimo.list(params)
            size = Emprestimo.count()
        }
        [emprestimoInstanceList: emp, emprestimoInstanceTotal: size, stat: stat, status: params.status, statusNomes:nomes]
    }

    def create = {
        def emprestimoInstance = new Emprestimo()
        emprestimoInstance.properties = params
        emprestimoInstance.valorParcela = 0.0
        return [emprestimoInstance: emprestimoInstance]
    }

    def save = {
      
        def emprestimoInstance = new Emprestimo(params)
        emprestimoInstance.usuario = session.usuario
        emprestimoInstance.tac = emprestimoInstance.tac?emprestimoInstance.tac:0

        if(emprestimoInstance.plano){

            if(emprestimoInstance.tipoEmprestimo){
                if(emprestimoInstance.plano.tipoEmprestimo.id != emprestimoInstance.tipoEmprestimo.id || true){
                    emprestimoInstance.plano = Plano.findByNumParcelasAndTipoEmprestimo(emprestimoInstance.plano.numParcelas, emprestimoInstance.tipoEmprestimo)
                }
            }

            def val = emprestimoInstance.valorLiberado?emprestimoInstance.valorLiberado:0
            //            emprestimoInstance.tac = emprestimoInstance.plano.tac
//            emprestimoInstance.valorParcela = (emprestimoInstance.tac + val) * emprestimoInstance.plano.coeficiente
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
        def valorOld
        if (emprestimoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (emprestimoInstance.version > version) {
                    
                    emprestimoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'emprestimo.label', default: 'Emprestimo')] as Object[], "Another user has updated this Emprestimo while you were editing")
                    render(view: "edit", model: [emprestimoInstance: emprestimoInstance])
                    return
                }
            }
            valorOld = emprestimoInstance.valorParcela
            emprestimoInstance.properties = params
            emprestimoInstance.usuario = session.usuario
            emprestimoInstance.tac = emprestimoInstance.tac?emprestimoInstance.tac:0

            if(emprestimoInstance.plano){
                //                emprestimoInstance.tac = emprestimoInstance.plano.tac
//                emprestimoInstance.valorParcela = (emprestimoInstance.tac + emprestimoInstance.valorLiberado) * emprestimoInstance.plano.coeficiente
                emprestimoInstance.numParcelas = emprestimoInstance.plano.numParcelas
            }
            if (!emprestimoInstance.hasErrors() && emprestimoInstance.save(flush: true)) {

                if(valorOld != emprestimoInstance.valorParcela && emprestimoInstance.valorParcela > 0.0){
                    def log = new Log()
                    log.usuario = session.usuario
                    log.data = new Date()
                    log.descricao = "O valor de parcela de ${emprestimoInstance} foi alterado de ${valorOld} para ${emprestimoInstance.valorParcela}. O valor estimado é ${emprestimoInstance.valorParcelaEstimado}"
                    log.save(flush:true)
                }

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
