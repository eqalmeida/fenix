package fenix

class TipoEmprestimo {

    int id
    String nome
    BigDecimal taxaJurosAtraso = 0
    BigDecimal multaAtraso = 0
    BigDecimal multaAtrasoPercent = 0.0
    Boolean ativo = true

    static constraints = {
        nome(blank:false, unique:true, maxSize:30)
        taxaJurosAtraso(nullable:false, scale:4)
        multaAtraso(nullable:false)
        multaAtrasoPercent(scale:4)
        ativo()
    }

    static mapping = { planos sort:'numParcelas' }

    static hasMany = [planos: Plano]

    String toString(){"${this.nome}"}
}
