package fenix

class Parcela {

    Emprestimo emprestimo
    Parcela parcelaAnt
    int numero
    Date vencimento
    Date previsaoDePagamento
    BigDecimal valor
    BigDecimal taxaJurosAtraso
    BigDecimal multaAtraso
    BigDecimal acrescimos = 0
    BigDecimal valorPago
    Date dataPagamento
    Boolean pago = false
    Usuario usuario

    static transients = ["valorAtual"]

    static constraints = {
        emprestimo()
        parcelaAnt(nullable:true)
        numero(nullable:false, range:1..150)
        vencimento(blank:false)
        previsaoDePagamento(nullable: true)
        valor(blank:false, scale:2)
        taxaJurosAtraso(scale:3, nullable:false)
        acrescimos()
        valorPago(scale:2, nullable:true)
        dataPagamento(nullable:true)
        pago()
        usuario(nullable:true)
    }


    BigDecimal getValorAtual(){
        this.valor + this.acrescimos
    }
}
