package fenix

class Log {

    Usuario usuario
    Date data = new Date()
    String descricao

    static constraints = {
        usuario()
        data()
        descricao(maxSize:300)
    }
}
