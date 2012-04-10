package fenix

class ParcelaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        def parcelaInstance = Parcela.get(params.id)
        if (!parcelaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
        else {
            if(parcelaInstance.parcelaAnt && !parcelaInstance.parcelaAnt.pago){
                flash.message = "A parcela anterior precisa ser paga primeiro!"
                redirect(action:"show", controller:"emprestimo", id:parcelaInstance.emprestimo.id)
                return true
            }
            [parcelaInstance: parcelaInstance]
        }
    }

    def regPagamento = {
        def parcela = Parcela.get(params.id)
        if (parcela){
            if(parcela.pago == false){

                try{
                    def valorPago = params.valorPago.replace(',','.').toBigDecimal()
                    valorPago = valorPago.setScale(2,BigDecimal.ROUND_HALF_DOWN);
                    def valorDev = parcela.valorAtual
                    if((valorPago - valorDev).abs() < 0.01 ){
                        parcela.valorPago = valorPago
                        parcela.dataPagamento = new Date()
                        parcela.usuario = session.usuario
                        parcela.pago = true
                        if(parcela.save(flush:true)){
                            flash.message = "Pagamento registrado!"
                            redirect(action:"show", controller:"emprestimo", id:parcela.emprestimo.id)
                            return true
                        } else {
                            flash.message = "Pagamento inválido!"
                            redirect(action:"pagar", controller:"parcela", id:parcela.id)
                            return false
                        }

                    } else {
                        flash.message = "Valor inválido!"
                        redirect(action:"pagar", controller:"parcela", id:parcela.id)
                        return false
                    }

                } catch(Exception e){
                    flash.message = "Valor inválido!"
                    redirect(action:"pagar", controller:"parcela", id:parcela.id)
                    return false
                }

            }
        } else {
            flash.message = "Erroooooooooooooooooooooooooooooooooooooooooooo!"
            redirect(action:"list")
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [parcelaInstanceList: Parcela.list(params), parcelaInstanceTotal: Parcela.count()]
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

        if(session.usuario.perfil != "admin") {
            flash.message = "Acesso negado"
            return false
        }


        def parcelaInstance = Parcela.get(params.id)
        if (parcelaInstance) {
            try {
                parcelaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'parcela.label', default: 'Parcela'), params.id])}"
            redirect(action: "list")
        }
    }
}
