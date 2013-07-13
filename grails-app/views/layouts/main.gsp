<html>
  <head>
    <title>Fenix :: Controle de Negociações</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
  <g:layoutHead />
  <g:javascript library="application" />
  <g:javascript library="jquery" plugin="jquery"/>
  <g:javascript>
    function autoFocus(){
      
      var all=document.getElementsByTagName("input");
      var total = all.length
      for(i=0; i< total ;i++){
        if(all[i].type == "text")
        {
          all[i].focus();
          break;
         }
      }

    }
  </g:javascript>
</head>
<body onLoad="autoFocus()">
  <!--
  <div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
  </div>
  -->
    <div id="top" class="tlogo">
        <h1>CONTROLE DE NEGOCIAÇÕES - FENIX MOTOS</h1>
    </div>

    <div id="menubv">
      
      <ul>
        <li><g:link controller="cliente">Clientes</g:link></li>
        <li><g:link controller="emprestimo">Transações</g:link></li>
        <li><g:link controller="parcela" action="cobranca" >Cobrança</g:link></li>
        <li><g:link controller="tipoEmprestimo">Tipos de Transação</g:link></li>
        <li><g:link controller="plano">Planos</g:link></li>
        <li><g:link controller="especie">Espécie</g:link></li>
        <li><g:link controller="usuario" >Usuários</g:link></li>
        <li><g:link controller="log" >Logs</g:link></li>
        <li><g:link controller="config" action="backupList" >Backups</g:link></li>
      </ul>

      <g:if test="${session.usuario}">
        <div id="loginHeader">
          <g:loginControl />
        </div>
      </g:if>
    </div>

    <div id="content">
      <g:layoutBody />
    </div>

</html>