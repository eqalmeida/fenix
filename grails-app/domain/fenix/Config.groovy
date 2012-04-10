package fenix

class Config {

    String empresa
    Date data = new Date()
    String liberacao = "ok"
    String logo = "xxx"
    String pastaBackup

    static constraints = {
        empresa(maxSize:100, blank:true,nullable:true)
        data(nullable:true)
        liberacao(maxSize:20, blank:true,nullable:true)
        logo(blank:true,nullable:true)
        pastaBackup(blank:true,nullable:true)
    }
}
