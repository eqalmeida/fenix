import fenix.*

class BootStrap {

    def init = { servletContext ->
        //isso é importante:
        def adm = fenix.Usuario.findByPerfilAndAtivo("admin",true)
        if(!adm){
            def usuario = new fenix.Usuario()
            usuario.nome = "Administrador"
            usuario.perfil = "admin"
            usuario.login = "admin"
            usuario.senha = "admin"
            usuario.save(flush:true)
        }
/*
        def config = fenix.Config.get(1)
        if(!config){
            config = new Config()
            config.data = new Date()
            config.empresa = "FENIX MOTOS"
            config.save(flush:true)
        }

        new fenix.Especie(nome: "CHEQUE" ,geraBoleto:true , ativo:true).save(flush:true)
        new fenix.Especie(nome:"BOLETO" ,geraBoleto:true , ativo:true).save(flush:true)
        new fenix.Especie(nome:"PROMISSÓRIA" ,geraBoleto:true , ativo:true).save(flush:true)

        def tipo = new fenix.TipoEmprestimo(nome:"Empréstimo Pessoal", tac:10.00, taxa:5.32, ativo:true);
        tipo.save(flush:true);
        def cliente = new fenix.Cliente()
        cliente.nome = "CLIENTE TESTE"
        cliente.save(flush:true);
        def plano = new fenix.Plano()
        plano.tipoEmprestimo = tipo
        plano.coeficiente = 0.2312
        plano.numParcelas = 5
        plano.tac = 100.00
        plano.save(flush:true)
*/
    }
    def destroy = {
    }
}
