<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>FileResource List</title>
    </head>
    <body>
        <div class="nav">
   			  <span class="menuButton"><a class="home" href="/">Home</a></span>
     </div>
        <div class="body">


            <h1>Lista de Backups</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
			<div id="success"></div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="files" title="file"/>
                            <g:sortableColumn property="path" title="Opções" colspan="2"/>
                       </tr>
                    </thead>
                    <tbody>
                    <g:each in="${fileResourceInstanceList}" status="i" var="fileResourceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${fileResourceInstance.decodeURL()}</td>
                            <td><a href="${resource( dir:'backups' , file: fileResourceInstance.decodeURL())}" target="_new" onclick="alert('Para baixar clique com botão Direito > Salval destino como...');return false;"> baixar </a></td>
                            <td><g:link action="deleteBackup" id="${fileResourceInstance.replace('.','###')}" onclick="return confirm('Tem certeza?');"> excluir </g:link></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
                        <g:form>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="backup" value="Efetuar Backup" /></span>
      </div>
                        </g:form>
        </div>
    </body>
</html>
