package fenix

import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder


class EmprestimoService {

    static transactional = true

    def efetivar(Long id) {
        def emprestimo = Emprestimo.get(id)
        if (emprestimo){
            if(emprestimo.status == 0){
                def session = RequestContextHolder.currentRequestAttributes().getSession()
                emprestimo.status = 1
                emprestimo.usuario = session.usuario
                if(emprestimo.save(flush:true)){
                    if(emprestimo.especie.geraBoleto){
                        //Gera boleto
                        def dataBoleto = new GregorianCalendar()
                        dataBoleto.time = emprestimo.data
                        def valorParcela = emprestimo.valorParcela
                        def boleto = null
                        def boletoAnt = null
                        for(par in 1..(emprestimo.numParcelas)){
                            boleto = new Parcela()
                            boleto.numero = par
                            boleto.emprestimo = emprestimo
                            boleto.valor = valorParcela
                            if(boletoAnt){
                                boleto.parcelaAnt = boletoAnt
                            }
                            //boleto.usuario = emprestimoInstance.usuario
                            dataBoleto.add(Calendar.MONTH,1)
                            boleto.vencimento = dataBoleto.time
                            boleto.taxaJurosAtraso = emprestimo.tipoEmprestimo.taxaJurosAtraso
                            boleto.multaAtraso = emprestimo.tipoEmprestimo.multaAtraso
                            if(!boleto.save(flush:true)){
                                new RuntimeException("Erro gerando parcelas").throw()
                            }
                            boletoAnt = boleto

                        }
                        def cliente = Cliente.get(emprestimo.cliente.id)
                        cliente.saldo -= emprestimo.montante
                        if(!cliente.save(flush:true)){
                            new RuntimeException("Erro ao atualizar saldo").throw()
                        }

                    }
                } else {
                    new RuntimeException("Erro ao mudar de status").throw()
                }
            }
        }
    }

    def atualizarStatus(){

        Emprestimo.executeUpdate("""
            update Emprestimo e
            set e.status = 6
            where e.status in (1,7) and e.id in
                (
                    select p.emprestimo.id from Parcela p
                    where (p.pago = false) and
                    p.vencimento < current_date()
                )

            """);

        Emprestimo.executeUpdate("""
            update Emprestimo e
            set e.status = 1
            where e.status = 7 and e.id in
                (
                    select p.emprestimo.id from Parcela p
                    where (p.pago = false)
                )

            """);

        Emprestimo.executeUpdate("""
            update Emprestimo e
            set e.status = 1
            where e.status = 6 and e.id not in
                (
                    select p.emprestimo.id from Parcela p
                    where (p.pago = false) and
                    p.vencimento < current_date()
                )

            """);

        Emprestimo.executeUpdate("""
            update Emprestimo e
            set e.status = 7
            where e.status > 0 and e.id not in (
                select p.emprestimo.id
                from Parcela p where (p.pago = false) 
            )
        """);

/*        def emprestimo = Emprestimo.get(id)
        if(emprestimo && emprestimo.status > 0){

            def data = new Date()
            def quitado = true

            emprestimo.parcelas.each {
                if(!it.pago){
                    quitado = false
                    if((it.vencimento - data) > 5 ){
                        atrasado = true
                    }
                }
            }

            if(quitado && emprestimo.status > 0){
                emprestimo.status = 7
                emprestimo.save(flush:true)
            }

            if(atrasado && emprestimo.status == 1){
                emprestimo.status = 6
                emprestimo.save(flush:true)
            }

        }
   */
    }
}
