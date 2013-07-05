package fenix

class Emprestimo {

    static hasMany = [parcelas: Parcela, obs: Observacao]

    static transients = [ "valorFinanciado", "montante", "statusStr","valorParcelaEstimado"]

    static mapping = { 
        parcelas sort:'vencimento' 
        obs sort:'data', order:'desc'
    }

    Cliente cliente
    TipoEmprestimo tipoEmprestimo
    Especie especie
    Plano plano
    BigDecimal valorLiberado
    Date data = new Date()
    Date dataReg = new Date()
    Date primeiroVencimento
    int status = 0  //1:Ativo, 2:Quitado, 3:Cancelado, 4:Devolvido, 5:Atraso, 6:Congelado, 7:Protesto, 8:Acordo
    int diasTolerancia = 0;     // Dias de tolerancia para pagamento da parcela.
    BigDecimal tac
    BigDecimal valorParcela
    String intervalo
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

    /**
     * Retorna a lista de parcelas referentes ao empréstimo
     * na ordem correta.
     */
    def getListaParcelas(){

        def lista = Parcela.createCriteria().list {
            eq('emprestimo', this)
            order('numero', 'asc')
            order('id', 'asc')
        }
        return lista
    }

    BigDecimal getMontante(){
        return (this.valorParcela * this.numParcelas)
    }

    BigDecimal getValorParcelaEstimado(){
        return ((this.tac + this.valorLiberado)* this.plano?.coeficiente)
    }

    String getStatusStr(){
        def nomes = [0:"Não Efetivado",1:"Regular",2:"Cancelado",3:"Congelado",4:"Acordo",5:"Protesto",6:"Em Atraso", 7:"Quitado"]
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
        primeiroVencimento(nullable: true)
        status()
        tac(nullable:false, scale:2)
        valorParcela(nullable: true)
        intervalo(inList:["mensal","quinzenal","semanal"])
        numParcelas(range:1..120)
        usuario(nullable:false)
        diasTolerancia range: 0..30

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
