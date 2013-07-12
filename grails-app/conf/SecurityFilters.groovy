import fenix.*

class SecurityFilters {

    def filters = {
        acesso(controller:"*", action:"*"){
            before = {

                if(!actionName && !controllerName){
                    return true
                }
                if (!session.usuario && !(actionName in ["login"])){
                    session.actionName = actionName
                    session.controllerName = controllerName
                    session.params = params
                    redirect(controller:"usuario", action:"login")
                    return false
                }
                else if(session.usuario)
                {
                    def u = Usuario.get(session.usuario.id)
                    if(u.version != session.usuario.version){
                        session.usuario = u
                    }
                }

                if(session.usuario?.perfil != "admin"){

                    def neg = (
                        actionName == "delete" ||
                        (controllerName == "parcela" && actionName in ["create","save","edit","update","delete"]) ||
                        (controllerName == "usuario" && actionName in ["create","save","edit","update","delete"]) ||
                        (controllerName == "especie" && actionName in ["create","save","edit","update","delete"]) ||
                        (controllerName == "plano" && actionName in ["delete"]) ||
                        (controllerName == "config" && actionName in ["delete","edit","deleteBackup","list","create","save"]) ||
                        (controllerName == "log") ||
                        (controllerName == "tipoEmprestimo" && actionName in ["delete"])
                    );

                    if(neg){
                        flash.message = "Acesso Negado"
                        redirect(controller:"usuario", action:"acessoNegado")
                        return false
                    }
                }

            }
        }
    }
}

