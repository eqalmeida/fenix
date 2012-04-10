package fenix

class Especie {

    int id
    String nome
    boolean geraBoleto = true
    boolean ativo = true

    static constraints = {
        nome(maxSize:30, unique:true, blank:false)
        geraBoleto()
        ativo()
    }

    String toString(){"${this.nome}"}
}
