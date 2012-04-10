package fenix

class LoginTagLib {
  def loginControl = {
    if(session.usuario){
      out << "Seja bem vindo, ${session.usuario.nome} "
      out << """[${link(action:"logout", controller:"usuario"){"Logout"}}]"""
    } else {
      out << """[${link(action:"login", controller:"usuario"){"Login"}}]"""
    }
  }
}
