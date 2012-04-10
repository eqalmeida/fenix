package fenix

class Config {

    String empresa
    Date data = new Date()
    String liberacao


    static constraints = {
        empresa(maxSize:100)
        data()
        liberacao(maxSize:20)
    }
}
