package fenix

class UsuarioController {

    def codigo = "2JA8XGR6K9WS8AHS8X"

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def acessoNegado ={}

    def login = {
        if(params.login && params.password)
        {
            def usuario = Usuario.findByLoginAndSenha(params.login, params.password)
            if (usuario){
                session.usuario = usuario
                /*
                def config = Config.get(1)
                if(config?.liberacao != this.codigo){
                    def data = new GregorianCalendar()
                    data.add(Calendar.MONTH,5)
                    if(data.time > new Date()){
                        redirect(controller:"usuario", action:"liberacao")
                        return
                    }
                }
                */
                redirect(controller:"cliente", action:"list")
            }else{
                flash.message = "Login inválido!"
               // redirect(controller:"usuario", action:"login")
            }
        }
    }

    def logout = {
        session.usuario = null
        redirect(controller:"usuario", action:"login")
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [usuarioInstanceList: Usuario.list(params), usuarioInstanceTotal: Usuario.count()]
    }

    def create = {
        def usuarioInstance = new Usuario()
        usuarioInstance.properties = params
        return [usuarioInstance: usuarioInstance]
    }

    def save = {
        def usuarioInstance = new Usuario(params)
        if (usuarioInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuarioInstance.id])}"
            redirect(action: "show", id: usuarioInstance.id)
        }
        else {
            render(view: "create", model: [usuarioInstance: usuarioInstance])
        }
    }

    def show = {
        def usuarioInstance = Usuario.get(params.id)
        if (!usuarioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
            redirect(action: "list")
        }
        else {
            [usuarioInstance: usuarioInstance]
        }
    }

    def liberacao = {
        def configInstance = Config.get(1)
        if (!configInstance) {
            flash.message = "Configuração não disponível"
            redirect(action: "list")
        }
        else {
            [configInstance: configInstance]
        }
    }

    def liberar = {
        def config = Config.get(1)
        if(config){
            if(params.liberacao != this.codigo){
                flash.message = "Código inválido"
            } else {
                config.liberacao = params.liberacao
                config.save(flush:true)
                flash.message = "Aplicativo liberado com sucesso!"
            }
            render(view: "liberacao", model: [configInstance: config])
        }
    }

    def edit = {
        def usuarioInstance = Usuario.get(params.id)
        if (!usuarioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [usuarioInstance: usuarioInstance]
        }
    }

    def update = {
        def usuarioInstance = Usuario.get(params.id)
        if (usuarioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (usuarioInstance.version > version) {
                    
                    usuarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'usuario.label', default: 'Usuario')] as Object[], "Another user has updated this Usuario while you were editing")
                    render(view: "edit", model: [usuarioInstance: usuarioInstance])
                    return
                }
            }
            usuarioInstance.properties = params
            if (!usuarioInstance.hasErrors() && usuarioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuarioInstance.id])}"
                redirect(action: "show", id: usuarioInstance.id)
            }
            else {
                render(view: "edit", model: [usuarioInstance: usuarioInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def usuarioInstance = Usuario.get(params.id)
        if (usuarioInstance) {
            try {
                usuarioInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])}"
            redirect(action: "list")
        }
    }
}
