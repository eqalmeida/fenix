package fenix

import java.math.*
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import java.text.DecimalFormat

class ParcelaService {

    static transactional = true

    /**
     * Calcula os acrescimos para uma parcela, na data informada.
     * @param parcela Referência a parcela.
     */
    void calculaAcrescimos(Parcela parcela){

        int diasAtraso = (parcela.dataPagamento - parcela.vencimento);
        
        if (diasAtraso > parcela.emprestimo.diasTolerancia){

            //
            // Calcula juros diário.
            //
            parcela.acrescimos = (parcela.taxaJurosAtraso * diasAtraso * parcela.valor / 100)

            //println("Dias de atraso : " + diasAtraso)
            
            //
            // Acrescenta multa por atraso.
            //
            parcela.acrescimos += parcela.multaAtraso

            //
            // Acrescenta multa percentual
            //
            parcela.acrescimos += (parcela.multaAtrasoPercent * parcela.valor / 100)

            //
            // Arredonda na escala da moeda.
            //
            parcela.acrescimos = parcela.acrescimos.setScale(2, RoundingMode.DOWN);
        } 
        else {
            parcela.acrescimos = 0.0    
        }
        
    }

    def cancelaPagamento(Parcela p, HttpSession session) {

        def parcela = Parcela.read(p.id)

        if(!parcela) {
            throw new ParcelaException(message: "Parcela inválida");
        }

        def usuario = session["usuario"]

        if(!usuario || !usuario.isAdmin()){
            throw new ParcelaException(message: "Acesso negado")
        }

        try{


            def moeda = new DecimalFormat("#,##0.00")
            def val = ""
            if(parcela.valorPago){
                val = moeda.format(parcela.valorPago)    
            }

            def log = new Log(usuario: usuario, data: new Date())
            log.descricao = "O pagamento da parcela num.: ${parcela.id} no valor:  ${val}, pago em ${parcela.dataPagamento} foi cancelado";
            log.save(flush:true)

            parcela.usuario = null
            parcela.valorPago = null
            parcela.dataPagamento = null
            parcela.pago = false

            parcela.save(flush: true)
        }
        catch(Exception e){
            throw new ParcelaException(message: e.message, parcela: parcela)
        }

    }

    /**
     * Forma segura excluir uma parcela.
     * @param p Referência a parcela.
     * @param session Referência para a sessão da aplicação.
     */
    def excluir(Parcela p, HttpSession session) {

        def parcela = Parcela.get(p.id)

        if(!parcela){
            throw new ParcelaException(message: "Parcela inexistente")
        }

        def usuario = session["usuario"]

        if(!usuario || !usuario.isAdmin()){
            throw new ParcelaException(message: "Acesso negado")
        }

        if(parcela.principal){
            throw new ParcelaException(message: "Esse tipo de parcela não pode ser excluido")
        }

        try{
            def moeda = new DecimalFormat("#,##0.00")
            def val = moeda.format(parcela.valor)    
            

            def logmessage = "A parcela n.: " + parcela.numero + " da transação n.: " + parcela.emprestimo.id + " do cliente: " + parcela.emprestimo.cliente + " no valor: " + val + " foi excluída."
            def log = new Log(usuario:usuario, data: new Date(), descricao: logmessage)

            log.save(flush: true)   
            
            parcela.delete(flush: true)     
        }
        catch(Exception ex){
            throw new ParcelaException(message: ex.message, parcela: parcela)            
        }

    }

}
