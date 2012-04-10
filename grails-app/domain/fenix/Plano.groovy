package fenix

class Plano {

    int id
    TipoEmprestimo tipoEmprestimo
    BigDecimal tac = 0
    BigDecimal coeficiente
    int numParcelas

    static constraints = {
        tipoEmprestimo()
        numParcelas(range:1..120, unique:'tipoEmprestimo')
        tac(nullable:false, scale:2)
        coeficiente(nullable:false, scale: 6 )

    }

    String toString(){"${this.numParcelas}x"}
}
