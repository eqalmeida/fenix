package fenix

class Parcela {

    def ParcelaService

    Emprestimo emprestimo
    int numero
    Date vencimento
    Date previsaoDePagamento
    BigDecimal valor
    BigDecimal taxaJurosAtraso
    BigDecimal multaAtraso
    BigDecimal multaAtrasoPercent = 0.0
    BigDecimal acrescimos = 0
    BigDecimal valorPago
    Date dataPagamento
    Boolean pago = false
    Usuario usuario
    Boolean principal = true

    static transients = ["valorAtual", "valorFaltante", "diasAtraso", "vencimentoStr"]

    static constraints = {
        emprestimo()
        numero(nullable:false, range:1..150)
        vencimento(blank:false)
        previsaoDePagamento(nullable: true)
        valor(blank:false, scale:2)
        taxaJurosAtraso(scale:3, nullable:false)
        multaAtrasoPercent(scale:4)
        acrescimos()
        valorPago(scale:2, nullable:true)
        dataPagamento(nullable:true)
        pago()
        usuario(nullable:true)
        principal()
    }

    def atualizaValorAtual(){
        ParcelaService.calculaAcrescimos(this)
    }


    BigDecimal getValorAtual(){
        this.valor + this.acrescimos
    }

    BigDecimal getValorFaltante(){
        if(!pago){
            return getValorAtual()
        }
        return(getValorAtual() - valorPago)
    }

    /**
     * Retorna  numero de dias de atraso relativo a uma data.
     * @param data Data de referência.
     */
    int getDiasAtraso(Date data){
        if(this.pago){
            return 0
        }

        int diasAtraso = data - this.vencimento

        return(diasAtraso > 0? diasAtraso: 0)
    }

    /**
     * Retorna  numero de dias de atraso relativo a hoje.
     */
    int getDiasAtraso(){
        return getDiasAtraso(new Date())
    }

    String getVencimentoStr(){
        def today = new Date()
        def dif = today - this.vencimento;

        if(dif == 0){
            return "Hoje"
        }
        else if(dif == 1){
            return "Ontem"
        }
        else{
            return this.vencimento.format('dd/MM/yyyy')
        }

    }

}
