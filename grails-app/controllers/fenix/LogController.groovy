package fenix

class LogController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [logInstanceList: Log.list(params), logInstanceTotal: Log.count()]
    }

    def show = {
        def logInstance = Log.get(params.id)
        if (!logInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'log.label', default: 'Log'), params.id])}"
            redirect(action: "list")
        }
        else {
            [logInstance: logInstance]
        }
    }

}
