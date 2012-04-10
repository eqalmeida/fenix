
<%@ page import="fenix.Plano" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'plano.label', default: 'Plano')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
  </div>
  <div class="body">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <!--
                <div class="list">
                  <table>
                    <thead>
                      <tr>
                      <th>Tipo de Transação</th>
                      </tr>
                    </thead>
                    <tbody>
                       <g:each in="${tipoList}" var="tipo">
                         <tr class="${tipo.id == tipoInstance?.id ? 'selected' : 'even'}">
                         <td><g:link params="[tipoEmprestimo_id:tipo.id]">${tipo.nome}</g:link></td>
                         </tr>
                       </g:each>
                    </tbody>
                  </table>
                </div>
    -->
    <br />

    <g:form>
      <g:select name='tipoEmprestimo_id' value="${tipoInstance?.id}"
                noSelection="${['null':'Selecione...']}"
                from='${tipoList}'
                optionKey="id" optionValue="nome" onchange="submit()"></g:select>
    </g:form>
    <br/>
    <div class="list">
      <table>
        <thead>
          <tr>

        <g:sortableColumn property="id" title="${message(code: 'plano.id.label', default: 'Id')}" />

        <th><g:message code="plano.tipoEmprestimo.label" default="Tipo Emprestimo" /></th>

        <g:sortableColumn property="numParcelas" title="${message(code: 'plano.numParcelas.label', default: 'Num Parcelas')}" />

        <g:sortableColumn property="coeficiente" title="${message(code: 'plano.coeficiente.label', default: 'Coeficiente')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${planoInstanceList}" status="i" var="planoInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td><g:link action="show" id="${planoInstance.id}">${fieldValue(bean: planoInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: planoInstance, field: "tipoEmprestimo")}</td>

          <td>${fieldValue(bean: planoInstance, field: "numParcelas")}</td>

          <td>${formatNumber(number: planoInstance.coeficiente)}</td>

          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${planoInstanceTotal}" params="${[tipoEmprestimo_id: tipoEmprestimo_id]}" max="20" />
    </div>
  </div>
</body>
</html>
