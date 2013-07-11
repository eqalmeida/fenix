
<%@ page import="fenix.Parcela" %>
<html>
  <head>
  <calendar:resources lang="br" theme="tiger"/>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
  <title>Parcelas em Atraso</title>
</head>
<body>
  <div class="body">
    <h1>Parcelas em Atraso</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <br/>
    <g:form action="cobranca">
      <g:select name='ano' value="${ano}"
                from='${anos}'
                onchange="submit()"/>
      <g:select name='mes' value="${mes}"
                optionKey="key" optionValue="value"
                from='${meses}'
                onchange="submit()"/>
    </g:form>
    <br/>
    <div class="list">
      <table>
        <thead>
          <tr>

        <g:sortableColumn property="numero" title="${message(code: 'parcela.numero.label', default: 'Numero')}" />


            <th><g:message code="parcela.emprestimo.label" default="Emprestimo" /></th>

        <th>Status</th>

        <th>Espécie</th>

        <g:sortableColumn property="vencimento" title="${message(code: 'parcela.vencimento.label', default: 'Vencimento')}" />

        <g:sortableColumn property="previsaoDePagamento" title="${message(code: 'parcela.previsaoDePagamento.label', default: 'Previsão de pagamento')}" />

        <g:sortableColumn property="valor" title="${message(code: 'parcela.valor.label', default: 'Valor')}" />

        <th>Opções</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${parcelaInstanceList}" status="i" var="parcelaInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td>
              <g:link title="Ver parcela" action="show" controller="parcela" id="${parcelaInstance?.id}">
                ${fieldValue(bean: parcelaInstance, field: "numero")}
              </g:link>
            </td>

            <td>
              <g:link title="Ver transação" action="show" controller="emprestimo" id="${parcelaInstance?.emprestimo.id}">
                ${fieldValue(bean: parcelaInstance, field: "emprestimo")}
              </g:link>
            </td>

            <td>${fieldValue(bean: parcelaInstance, field: "emprestimo.statusStr")}</td>

            <td>${fieldValue(bean: parcelaInstance, field: "emprestimo.especie")}</td>

            <td><g:formatDate date="${parcelaInstance?.vencimento}" /></td>

          <td><g:formatDate date="${parcelaInstance?.previsaoDePagamento}" /></td>

          <td><g:formatNumber number="${parcelaInstance?.valor}" type="currency" currencyType="BRL" /></td>

          <td nowrap="nowrap">

              <span class="tbuttons">

          <g:if test="${!parcelaInstance?.pago}">
            <g:link 
              title="Registrar Pagamento"
              class="pag" 
              action="pagar" 
              controller="parcela" id="${parcelaInstance?.id}"/>
          </g:if>

          <g:link title="Imprimir" class="print" id="${parcelaInstance?.id}" target="_blank" controller="parcela" action="print"/>

              </span>

          </td>

          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${parcelaInstanceTotal}" max="20" params="${[ano: ano, mes:mes]}"/>
    </div>
  </div>
</body>
</html>
