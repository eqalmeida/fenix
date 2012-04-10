package fenix

class Cliente {

    static hasMany = [emprestimos: Emprestimo]

    static mapping = {emprestimos sort: 'id'}

    String nome
    String rg
    String cpf
    String telefoneRes
    String telefoneCom
    String telefoneCel
    String email
    String fax
    String endereco
    String cep
    String bairro
    String cidade
    String estado
    String ptoReferencia
    String residencia
    String empresa
    String cargo
    String enderecoEmpresa
    BigDecimal renda
    String tempoServico
    String webPage
    String anotacoes
    BigDecimal saldo


    static constraints = {
        nome(maxSize: 100, unique:true, blank:false, minSize:4)
        rg(maxSize: 14, minSize: 6, blank:false)
        cpf(cpf:true, maxSize:15, blank:false, unique:true)
        telefoneRes(maxSize: 15, minSize: 8)
        telefoneCom(maxSize: 15, minSize: 8)
        telefoneCel(maxSize: 15, minSize: 8)
        email(maxSize: 100, email:true)
        fax(maxSize: 12, minSize: 8)
        endereco(maxSize: 100, blank:false, minSize:5)
        cep(maxSize: 12, minSize: 5)
        bairro(maxSize: 100, blank:false, minSize:4)
        cidade(maxSize: 100, blank:false, minSize:4)
        estado(maxSize: 3)
        ptoReferencia(maxSize: 100)
        residencia(inList:["Própria","Alugada","Financiada"])
        empresa(maxSize: 100)
        cargo(maxSize: 50)
        enderecoEmpresa(maxSize: 350)
        renda(scale:2, nullable:true)
        tempoServico(nullable:true, blank:true, maxSize:12)
        webPage(maxSize: 120, url:true)
        anotacoes(maxSize: 350)
        saldo()
    }

    String toString(){"${this.nome}"}
}
