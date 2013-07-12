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

    static transients = ["valorAtual", "valorFaltante", "diasAtraso"]

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

    int getDiasAtraso(){
        if(this.pago){
            return 0
        }

        def hoje = new Date()
        int diasAtraso = hoje - this.vencimento

        return(diasAtraso > 0? diasAtraso: 0)
    }
}