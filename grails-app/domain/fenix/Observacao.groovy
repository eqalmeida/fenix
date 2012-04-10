package fenix

class Observacao {

    static belongsTo = [emprestimo:Emprestimo]

    String obs
    Usuario usuario
    Emprestimo emprestimo
    Date data = new Date()

    static constraints = {
        obs(blank:false, maxSize:255)
        usuario(nullable:false)
        data()
    }
}
