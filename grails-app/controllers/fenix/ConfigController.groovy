package fenix

class ConfigController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def printlogo = {}

    private File getBackupDir(){
        def webRootDir = servletContext.getRealPath("/")
        def file = new File(webRootDir, "/backups/")
        file.mkdirs()
        return(file)
    }

    def backup = {
        try
        {
            def dir = getBackupDir()
            String filename = dir.absolutePath + File.separatorChar + "bkp_"+new Date().format("dd-MM-yyyy-hhmmss")+".sql"
            filename.replace('\\','/')
/*
            String comando="mysqldump.exe";
            ProcessBuilder pb=new ProcessBuilder(
            comando,
            "--user=root",
            "--password=root",
            "fenix",
            "--result-file=\""+filename+"\""
            );
            pb.start();
*/
            String cmd = "mysqldump -u root --password=root fenix -r \""+filename+"\"";
            
//            println("Comando === " + cmd);
            //Process  p = Runtime.getRuntime().exec(cmd);
            cmd.execute()

            def inicio = new GregorianCalendar()
            inicio.add(Calendar.SECOND,2)
            while(inicio.after(new GregorianCalendar()));
            redirect(action:'backupList')
        }
        catch(Exception exc)
        {
            exc.printStackTrace();
        }


    }

    def backupList = {
        def fileResourceInstanceList = []
        def f = getBackupDir()
        //def f = new File( grailsApplication.config.images.location.toString() )
        if( f.exists() ){
            f.eachFile(){ file->
                if( !file.isDirectory() )
                fileResourceInstanceList.add( file.name )
            }
        }
        [ fileResourceInstanceList: fileResourceInstanceList]
    }

    def deleteBackup = {
        def filename = params.id.replace('###', '.')
        def file = new File(getBackupDir().absolutePath + File.separatorChar +   filename )
        //        def file = new File( grailsApplication.config.images.location.toString() + File.separatorChar +   filename )
        file.delete()
        flash.message = "file ${filename} removed"
        redirect( action:backupList )
    }



    def uploadLogo = {
        def config = Config.get(1)
        if(!config){
            config = new Config()
            config.id = 1
        }
        def f = request.getFile('myFile')
        if(!f.empty) {
            def filename = null
            def type = f.getContentType()
            if(type.contains("jpeg")){
                filename = "printlogo.jpg"
                f.transferTo( new File('web-app/images/printlogo.jpg') )
                flash.message = 'Atualizado com sucesso'
            } else {
                flash.message = "Tipo de arquivo inválido"
            }

            if (filename) {
                config.logo = filename;
                config.save(flush:true)
            }

            render(view:'edit', model:[config:config])
        }
        else {
            flash.message = 'file cannot be empty'
            render(view:'edit', model:[config:config])
        }
    }

    def index = {
        redirect(action: "edit", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [configInstanceList: Config.list(params), configInstanceTotal: Config.count()]
    }

    def create = {
        def configInstance = new Config()
        configInstance.properties = params
        return [configInstance: configInstance]
    }

    def save = {
        def configInstance = new Config(params)
        if (configInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'config.label', default: 'Config'), configInstance.id])}"
            redirect(action: "show", id: configInstance.id)
        }
        else {
            render(view: "create", model: [configInstance: configInstance])
        }
    }

    def show = {
        def configInstance = Config.get(params.id)
        if (!configInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'config.label', default: 'Config'), params.id])}"
            redirect(action: "list")
        }
        else {
            [configInstance: configInstance]
        }
    }

    def edit = {
        def configInstance = Config.get(1)
        if (!configInstance) {
            try{
                configInstance = new Config()
                configInstance.id = 1
                configInstance.empresa = "FENIX MOTO"
                configInstance.pastaBackup = "c:\\fenix\\backups"
                configInstance.save()
            }
            catch(Exception e){
                println "erro!!!"
                e.printStackTrace()
            }
        }
        return [configInstance: configInstance]
        
    }

    def update = {
        def configInstance = Config.get(params.id)
        if (configInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (configInstance.version > version) {
                    
                    configInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'config.label', default: 'Config')] as Object[], "Another user has updated this Config while you were editing")
                    render(view: "edit", model: [configInstance: configInstance])
                    return
                }
            }
            configInstance.properties = params
            if (!configInstance.hasErrors() && configInstance.save()) {
                flash.message = "Configuração atualizada"
            }
            render(view: "edit", model: [configInstance: configInstance])
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'config.label', default: 'Config'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def configInstance = Config.get(params.id)
        if (configInstance) {
            try {
                configInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'config.label', default: 'Config'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'config.label', default: 'Config'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'config.label', default: 'Config'), params.id])}"
            redirect(action: "list")
        }
    }
}
