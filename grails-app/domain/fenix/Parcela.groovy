package fenix

class Parcela {

    def ParcelaService

    Emprestimo emprestimo
    Parcela parcelaAnt
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

    static transients = ["valorAtual", "valorFaltante"]

    static constraints = {
        emprestimo()
        parcelaAnt(nullable:true)
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
}
