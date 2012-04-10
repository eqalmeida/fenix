class SecurityFilters {

    def filters = {
        acesso(controller:"*", action:"*"){
            before = {

                if(!actionName && !controllerName){
                    return true
                }
                if (!session.usuario && !(actionName in ["login"])){
                    redirect(controller:"usuario", action:"login")
                    return false
                }

                if(session.usuario?.perfil != "admin"){

                    def neg = (
                       actionName == "delete" ||
                       (controllerName == "parcela" && actionName in ["create","save","edit","update","delete"]) ||
                       (controllerName == "usuario" && actionName in ["create","save","edit","update","delete"]) ||
                       (controllerName == "especie" && actionName in ["create","save","edit","update","delete"]) ||
                       (controllerName == "plano" && actionName in ["create","save","edit","update","delete"]) ||
                       (controllerName == "tipoEmprestimo" && actionName in ["create","save","edit","update","delete"]) ||
                       (controllerName == "tipoEmprestimo" && actionName in ["create","save","edit","update","delete"])
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

