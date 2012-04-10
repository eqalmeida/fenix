import fenix.*
import grails.util.GrailsUtil

class BootStrap {

    def init = { servletContext ->
        //isso é importante:
        try{
            def adm = fenix.Usuario.findByPerfilAndAtivo("admin",true)
            if(!adm){
                def usuario = new fenix.Usuario()
                usuario.nome = "Administrador"
                usuario.perfil = "admin"
                usuario.login = "admin"
                usuario.senha = "admin"
                usuario.save(flush:true)
            }
        }catch(Exception e){
            e.printStackTrace()
        }

        try{
            def config = Config.get(1)
            if(!config){
                config = new Config()
                config.id = 1
                config.empresa = "FENIX MOTO"
                config.pastaBackup = "c:\\fenix\\backups"
                config.save(flush:true)
            }
        }catch(Exception e){
            println "erro!!!"
            e.printStackTrace()
        }
        /*
        def config = fenix.Config.get(1)
        if(!config){
        config = new Config()
        config.data = new Date()
        config.empresa = "FENIX MOTOS"
        config.save(flush:true)
        }*/
        if(GrailsUtil.environment == "development"){
            new fenix.Especie(nome: "CHEQUE" ,geraBoleto:true , ativo:true).save(flush:true)
            new fenix.Especie(nome:"BOLETO" ,geraBoleto:true , ativo:true).save(flush:true)
            new fenix.Especie(nome:"PROMISSÓRIA" ,geraBoleto:true , ativo:true).save(flush:true)

            def tipo = new fenix.TipoEmprestimo();
            tipo.taxaJurosAtraso = 10.0
            tipo.multaAtraso = 10.0
            tipo.ativo = true
            tipo.save(flush:true);
            def cliente = new fenix.Cliente()
            cliente.nome = "CLIENTE TESTE"
            cliente.save(flush:true);
            /*
            def plano = new fenix.Plano()
            plano.addTipoEmprestimo(tipo)
            plano.coeficiente = 0.2312
            plano.numParcelas = 5
            plano.tac = 100.00
            plano.save(flush:true)
             */
        }

    }
    def destroy = {
    }
}
