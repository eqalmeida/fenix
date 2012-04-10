package fenix

class Emprestimo {

    static hasMany = [parcelas: Parcela, obs: Observacao]

    static transients = [ "valorFinanciado", "montante", "statusStr"]

    static mapping = { parcelas sort:'numero' }

    Cliente cliente
    TipoEmprestimo tipoEmprestimo
    Especie especie
    Plano plano
    BigDecimal valorLiberado
    Date data = new Date()
    Date dataReg = new Date()
    int status = 0  //1:Ativo, 2:Quitado, 3:Cancelado, 4:Devolvido, 5:Atraso, 6:Congelado, 7:Protesto, 8:Acordo
    BigDecimal tac
    BigDecimal valorParcela
    int numParcelas
    Usuario usuario

    String placa
    String marca
    String modelo
    String anoFab
    String anoMod
    String chassi
    String cor
    String tipoCombustivel

    //BigDecimal valorParcela

    BigDecimal getMontante(){
        return (this.valorParcela * this.numParcelas)
    }

    String getStatusStr(){
        def nomes = [0:"Não Efetivado",1:"Ativo",2:"Cancelado",3:"Congelado",4:"Acordo",5:"Protesto",6:"Em Atraso", 7:"Quitado"]
        return nomes[this.status]
    }



    BigDecimal getValorFinanciado(){
        return(this.tac + this.valorLiberado)
    }

    static constraints = {
        cliente()
        tipoEmprestimo()
        especie()
        plano()
        valorLiberado()
        data()
        dataReg()
        status()
        tac(nullable:false, scale:2)
        valorParcela(nullable:false)
        numParcelas(range:1..50)
        usuario(nullable:false)

        placa(maxSize:10, blank:true, nullable:true)
        marca(maxSize:20, blank:true, nullable:true)
        modelo(maxSize:20, blank:true, nullable:true)
        anoFab(maxSize:4, blank:true, nullable:true)
        anoMod(maxSize:4, blank:true, nullable:true)
        chassi(maxSize:20, blank:true, nullable:true)
        cor(maxSize:15, blank:true, nullable:true)
        tipoCombustivel(inList:["Alcool","Gasolina","Gás", "Flex"], blank:true, nullable:true)

    }

    def emprestimoService

    def efetivar(){
        emprestimoService.efetivar(this.id)
    }

    String toString(){"[${this.id}]: ${this.cliente.nome}"}

}
