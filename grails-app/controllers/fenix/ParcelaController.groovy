package fenix

import java.math.*

class ParcelaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    static mesesMap = [1:'janeiro', 2:'fevereiro', 3:'março',4:'abril',5:'maio',6:'junho',7:'julho',8:'agosto',9:'setembro',10:'outubro',11:'novembro',12:'dezembro']


    def EmprestimoService
    def ParcelaService

    def updatePrevPag = {
        def parcela = Parcela.get(params.id)
        parcela.previsaoDePagamento =  Date.parse("dd/MM/yyyy",params.dataPrev)
        parcela.save(flush:true)
        render g.formatDate([date:parcela.previsaoDePagamento])

    }

    def updateDataPag = {
        
        def parcela = Parcela.read(params.id)

        def parcelaId = session["parcelaId"]

        if(parcelaId != parcela.id){
            redirect(action:"pagar", controller:"parcela", id:parcela.id)
            return
        }

        parcela.dataPagamento =  Date.parse("dd/MM/yyyy",params.datapag)
        session["dataPagamento"] = parcela.dataPagamento
        parcela.atualizaValorAtual()
        render g.formatNumber([number:parcela.valorAtual, type: "currency", currencyType:"BRL"])
    }

    def print = {
        def parcelaInstance = Parcela.get(params.id)
        if (!parcelaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
        else {
            [parcelaInstance: parcelaInstance]
        }
    }

    def pagar = {
        
        def parcelaInstance = Parcela.read(params.id)

        if (!parcelaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
        else {

            if(parcelaInstance.pago){
                session["parcelaId"] = 0
                flash.message = "A parcela selecionada já está paga!"
                redirect(action:"show", controller:"emprestimo", id:parcelaInstance.emprestimo.id)
                return true
            }

            
            if(parcelaInstance.principal){

                def anteriores = Parcela.createCriteria().list {
                    and{
                        eq('emprestimo', parcelaInstance.emprestimo)    
                        eq('pago', false)
                        eq('principal', true) 
                        lt('vencimento', parcelaInstance.vencimento)   
                    }
                }

                if(anteriores.size() > 0){
                    // session["parcelaId"] = 0
                    flash.message = "Alerta: Existem parcelas mais antigas não pagas!"
                    // redirect(action:"show", controller:"emprestimo", id:parcelaInstance.emprestimo.id)
                    // return true
                }
            }

            if( (!session["parcelaId"]) ||
                (!session["dataPagamento"]) ||
                (session["parcelaId"] != parcelaInstance.id)){
                
                session["parcelaId"] = parcelaInstance.id
                session["dataPagamento"] = new Date()
            }

            parcelaInstance.dataPagamento = session["dataPagamento"]
            parcelaInstance.atualizaValorAtual()

            [parcelaInstance: parcelaInstance]
        }
    }

    def regPagamento = {

        def parcela = Parcela.read(params.id)

        if( session["parcelaId"] != parcela?.id){
            redirect(action:"pagar", controller:"parcela", id:parcela.id)
            return
        }

        if (parcela){

            if(parcela.pago == false){

                Parcela.withTransaction { status ->

                    try{
                        parcela.properties = params;

                        if(parcela.valorPago == null || parcela.valorPago == 0){
                            parcela.errors.rejectValue("valorPago", "Favor informar o Valor Pago")
                            render(view:"pagar" , model:[parcelaInstance:parcela])
                            return
                        }

                        parcela.dataPagamento = session["dataPagamento"]
                        parcela.atualizaValorAtual()

                        def valorDev = parcela.valorAtual
                        
                        if((parcela.valorPago > valorDev)){
                            parcela.errors.rejectValue("valorPago", "O Valor pago não pode ser maior do que o valor devido")
                            render(view:"pagar" , model:[parcelaInstance:parcela])
                        }else{
                            parcela.usuario = session.usuario
                            parcela.pago = true

                            if(parcela.save(flush: true)){

                                if(parcela.valorPago < valorDev){
                                    def resto = new Parcela()

                                    resto.emprestimo = parcela.emprestimo
                                    resto.numero = parcela.numero
                                    resto.valor = (parcela.valorAtual - parcela.valorPago)
                                    resto.taxaJurosAtraso = parcela.taxaJurosAtraso
                                    resto.principal = false

                                    int diasAtraso = (parcela.dataPagamento - parcela.vencimento);
                                    
                                    if(diasAtraso > 0) {

                                        //
                                        // Se a parcela estava atrasada, a data de vencimento passa a ser a 
                                        // data de pagamento.
                                        // As multas são zeradas pois supostamente já foram cobradas.
                                        //
                                        resto.vencimento = parcela.dataPagamento
                                        resto.multaAtraso = 0.0
                                        resto.multaAtrasoPercent = 0.0
                                    }
                                    else{

                                        //
                                        // A parcela anterior não estava vencida, então mantemos a data de vencimento.
                                        // As multas também são mantidas.
                                        //
                                        resto.vencimento = parcela.vencimento
                                        resto.multaAtraso = parcela.multaAtraso
                                        resto.multaAtrasoPercent = parcela.multaAtrasoPercent
                                    }

                                    resto.save(flush: true)

                                    flash.message = "Pagamento parcial registrado!"
                                }
                                else{

                                    flash.message = "Pagamento registrado!"
                                }

                                session["parcelaId"] = 0

                                redirect(action:"show", controller:"emprestimo", id:parcela.emprestimo.id)
                            } else {
                                status.setRollbackOnly()
                                flash.message = "Falha gravando dados!"
                                redirect(action:"pagar", controller:"parcela", id:parcela.id)
                            }
                        }

                    } catch(Exception e){
                        status.setRollbackOnly()
                        flash.message = "erro"
                        redirect(action:"pagar", controller:"parcela", id:parcela.id)
                        return false
                    }
                }

            }
        } else {
            
            flash.message = "Erroooooooooooooooooooooooooooooooooooooooooooo!"
            redirect(action:"list")
        }

        

    }

    /**
     * Cancela Pagamento Registrado
     */
    def cancelPayment = {
        
        def parcela = Parcela.get(params.id)

        if(!parcela){
            flash.message = "Parcela não encontrada!"
            return
        }

        try{
            flash.message = "Pagamento da parcela ${parcela.numero} cancelado."
            parcelaService.cancelaPagamento(parcela, session)
            redirect(controller:"emprestimo", action: "show", id:parcela.emprestimo.id)
        }
        catch(ParcelaException pe){
            flash.message = pe.message
            redirect(action: "show", id:parcela.id)
        }
        
        

    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [parcelaInstanceList: Parcela.list(params), parcelaInstanceTotal: Parcela.count()]
    }

    def cobranca = {
        EmprestimoService.atualizarStatus()

        def old = Parcela.executeQuery("select year(min(pc.vencimento)) from Parcela as pc where pc.pago = false and pc.emprestimo.status > 2" )

        def hoje = new GregorianCalendar()

        if (old.size() == 0){
            old = hoje.get(Calendar.YEAR)
        }else{
            old = old[0]
        }
        def anos = hoje.get(Calendar.YEAR)..old
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.offset = params.offset?params.int('offset'):1

        if(!(params.ano && params.mes && params.mes != 'null' && params.ano != 'null')){
            params.ano = hoje.get(Calendar.YEAR)
            params.mes = hoje.get(Calendar.MONTH) + 1
        }

        def ano = params.int('ano')
        def mes = params.int('mes')
        def query = "from Parcela p where (p.emprestimo.status > 2 OR p.emprestimo.status = 1) and p.pago = false and p.vencimento <= :hoje and year(p.vencimento) = :ano and month(p.vencimento) = :mes order by p.vencimento"
        def lista = Parcela.findAll(query,[hoje:hoje.time, ano: ano, mes: mes, max:params.max, offset:params.offset])
        def size = Parcela.findAll(query, [hoje:hoje.time, ano: ano, mes: mes]).size()

        [parcelaInstanceList: lista, parcelaInstanceTotal: size, ano: params.ano, mes: params.mes, anos: anos, meses: mesesMap ]
    }

    def create = {
        def parcelaInstance = new Parcela()
        parcelaInstance.properties = params
        return [parcelaInstance: parcelaInstance]
    }

    def save = {
        def parcelaInstance = new Parcela(params)
        if (parcelaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'parcela.label', default: 'Parcela'), parcelaInstance.id])}"
            redirect(action: "show", id: parcelaInstance.id)
        }
        else {
            render(view: "create", model: [parcelaInstance: parcelaInstance])
        }
    }

    def show = {
        def parcelaInstance = Parcela.get(params.id)
        if (!parcelaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
        else {
            [parcelaInstance: parcelaInstance]
        }
    }

    def edit = {

        if(session.usuario.perfil != "admin") {
            flash.message = "Acesso negado"
            return false
        }

        def parcelaInstance = Parcela.get(params.id)
        if (!parcelaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [parcelaInstance: parcelaInstance]
        }
    }

    def update = {

        def all = (params.update_all == "on")

        if(session.usuario.perfil != "admin") {
            flash.message = "Acesso negado"
            return false
        }


        def parcelaInstance = Parcela.get(params.id)
        if (parcelaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (parcelaInstance.version > version) {
                    
                    parcelaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'parcela.label', default: 'Parcela')] as Object[], "Another user has updated this Parcela while you were editing")
                    render(view: "edit", model: [parcelaInstance: parcelaInstance])
                    return
                }
            }
            def valorOld = parcelaInstance.valor
            parcelaInstance.properties = params

            if(parcelaInstance.pago && (!parcelaInstance.dataPagamento)){
                parcelaInstance.errors.rejectValue("dataPagamento", "Favor informar a data do Pagamento")
                render(view: "edit", model: [parcelaInstance: parcelaInstance])
                return
            }

            if(parcelaInstance.pago && (!parcelaInstance.valorPago)){
                parcelaInstance.errors.rejectValue("valorPago", "Favor informar o valor pago")
                render(view: "edit", model: [parcelaInstance: parcelaInstance])
                return
            }

            if(parcelaInstance.pago && (parcelaInstance.valorPago < parcelaInstance.valor)){
                parcelaInstance.errors.rejectValue("valorPago", "O valor pago não pode ser menor que o valor da parcela")
                render(view: "edit", model: [parcelaInstance: parcelaInstance])
                return
            }

            if(!parcelaInstance.pago) {
                parcelaInstance.dataPagamento = null
                parcelaInstance.usuario = null
                parcelaInstance.valorPago = null
            } else {
                parcelaInstance.usuario = session.usuario
            }

            if (!parcelaInstance.hasErrors() && parcelaInstance.save(flush: true)) {

                if(valorOld != parcelaInstance.valor){
                    def log = new Log()
                    log.usuario = session.usuario
                    log.data = new Date()
                    log.descricao = "O valor da parcela id: ${parcelaInstance.id} do cliente: ${parcelaInstance.emprestimo.cliente.nome} foi alterada de ${valorOld} para ${parcelaInstance.valor}"
                    log.save(flush:true)
                }

                if(all) {
                    def outras = Parcela.findAllByEmprestimoAndPago(parcelaInstance.emprestimo, false)
                    outras.each {
                        it.valor = parcelaInstance.valor
                        it.multaAtraso = parcelaInstance.multaAtraso
                        it.multaAtrasoPercent = parcelaInstance.multaAtrasoPercent
                        it.taxaJurosAtraso = parcelaInstance.taxaJurosAtraso
                        it.save(flush:true)
                    }
                }
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'parcela.label', default: 'Parcela'), parcelaInstance.id])}"
                redirect(action: "show", id: parcelaInstance.id)
            }
            else {
                render(view: "edit", model: [parcelaInstance: parcelaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {

        def parcelaInstance = Parcela.get(params.id)

        try{
            def emprestimoId = parcelaInstance.emprestimo.id
            flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            parcelaService.excluir(parcelaInstance, session["usuario"])
            redirect(controller: "emprestimo" ,action: "show", id: emprestimoId)
        }
        catch(ParcelaException pe){
            flash.message = pe.message
            redirect(action: "show", id: params.id)
        }

        // if(session.usuario.perfil != "admin") {
        //     flash.message = "Acesso negado"
        //     return false
        // }


        // def parcelaInstance = Parcela.get(params.id)
        // if (parcelaInstance) {

        //     if(parcelaInstance.principal){
        //         flash.message = "Esse tipo de parcela não pode ser excluída"
        //         return false
        //     }

        //     try {
        //         def emprestimoId = parcelaInstance.emprestimo.id
        //         parcelaInstance.delete(flush: true)
        //         flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
        //         redirect(controller: "emprestimo" ,action: "show", id: emprestimoId)
        //     }
        //     catch (org.springframework.dao.DataIntegrityViolationException e) {
        //         flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
        //         redirect(action: "show", id: params.id)
        //     }
        // }
        // else {
        //     flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
        //     redirect(action: "list")
        // }
    }
}
