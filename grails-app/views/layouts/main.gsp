<html>
  <head>
    <title><g:layoutTitle default="Grails" /></title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
  <g:layoutHead />
  <g:javascript library="application" />
</head>
<body style="margin:0px">
  <div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
  </div>
  <!--
    <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" border="0" /></a></div>
  -->
  <div id="top">
    <div style="float:left">
      <h1>CONTROLE DE EMPRÉSTIMOS - FENIX MOTOS</h1>
    </div>
    <g:if test="${session.usuario}">
      <div id="loginHeader">
        <g:loginControl />
      </div>
    </g:if>

  </div>
  <table cellpadding="0px" cellspacing="0px" border="0" style="border:none">
    <tr valign="top">
      <td valign="top" width="160" style="padding: 0px; border: none; margin: 0px">
        <div id="menubv">
          <ul id="menuver">
            <li><g:link controller="cliente">Clientes</g:link></li>
            <li><g:link controller="emprestimo">Empréstimos</g:link></li>
            <li><g:link controller="tipoEmprestimo">Tipos de empréstimos</g:link></li>
            <li><g:link controller="plano">Planos</g:link></li>
            <li><g:link controller="especie">Espécie</g:link></li>
            <li><g:link controller="usuario">Usuários</g:link></li>
            <li><g:link controller="log">Logs</g:link></li>
          </ul>


        </div>

      </td>
      <td valign="top" style="padding: 0px">
        <div id="content">
          <g:layoutBody />
        </div>
      </td>
    </tr>
  </table>
  </div>
</html>