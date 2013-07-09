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

                if(!emprestimo.intervalo){
                    emprestimo.intervalo = 'mensal'
                }


                def dataBoleto = new GregorianCalendar()
                if(!emprestimo.primeiroVencimento){
                    dataBoleto.time = emprestimo.data

                    if(emprestimo.intervalo == 'mensal'){
                        dataBoleto.add(Calendar.MONTH,1)
                    } else if(emprestimo.intervalo == 'quinzenal'){
                        dataBoleto.add(Calendar.DATE,14)
                    } else if(emprestimo.intervalo == 'semanal'){
                        dataBoleto.add(Calendar.DATE,7)
                    }else {
                        throw new RuntimeException("Intervalo inválido")
                    }

                    emprestimo.primeiroVencimento = dataBoleto.time
                }
                emprestimo.status = 1
                emprestimo.usuario = session.usuario

                if(emprestimo.save(flush:true)){
                    if(emprestimo.especie.geraBoleto){
                        //Gera boleto
                        dataBoleto.time = emprestimo.primeiroVencimento
                        def valorParcela = emprestimo.valorParcela>0.0?emprestimo.valorParcela:emprestimo.valorParcelaEstimado
                        if(valorParcela * emprestimo.numParcelas < (emprestimo.valorLiberado + emprestimo.tac) ){
                                throw new RuntimeException("A soma das parcelas é inferior ao montante!");
                        }
                        def boleto = null
                        for(par in 1..(emprestimo.numParcelas)){
                            boleto = new Parcela()
                            boleto.numero = par
                            boleto.emprestimo = emprestimo
                            boleto.valor = valorParcela
                            //boleto.usuario = emprestimoInstance.usuario
                            boleto.vencimento = dataBoleto.time
                            boleto.taxaJurosAtraso = emprestimo.tipoEmprestimo.taxaJurosAtraso
                            boleto.multaAtraso = emprestimo.tipoEmprestimo.multaAtraso
                            boleto.multaAtrasoPercent = emprestimo.tipoEmprestimo.multaAtrasoPercent

                            if(emprestimo.intervalo == 'mensal'){
                                dataBoleto.add(Calendar.MONTH,1)
                            } else if(emprestimo.intervalo == 'quinzenal'){
                                dataBoleto.add(Calendar.DATE,14)
                            } else if(emprestimo.intervalo == 'semanal'){
                                dataBoleto.add(Calendar.DATE,7)
                            }else {
                                throw new RuntimeException("Intervalo inválido")
                            }

                            if(!boleto.save(flush:true)){
                                throw new RuntimeException("Erro gerando parcelas")
                            }

                        }
                        /*                        def cliente = Cliente.get(emprestimo.cliente.id)
                        cliente.saldo -= emprestimo.montante
                        if(!cliente.save(flush:true)){
                        throw new RuntimeException("Erro ao atualizar saldo")
                        }
                         */
                    }
                } else {
                    throw new RuntimeException("Erro ao mudar de status")
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
