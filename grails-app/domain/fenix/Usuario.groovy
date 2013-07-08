package fenix

class Usuario {

    int id
    String nome
    String login
    String senha
    String perfil
    boolean ativo = true

    static constraints = {
        nome(maxSize:60, blank:false, unique:true)
        login(maxSize:12, blank:false, unique:true)
        senha(password:true, minSize:2, maxSize:12, blank: false)
        perfil(inList:["operador","operador-av","admin"])
    }

    String toString(){"${this.nome}"}

    Boolean isAdmin(){
        (this.perfil == "admin") 
    }

}
