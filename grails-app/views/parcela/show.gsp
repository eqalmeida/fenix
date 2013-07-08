
<%@ page import="fenix.Parcela" %>
<html>
  <head>
  <calendar:resources lang="br" theme="tiger"/>
  <g:javascript library="scriptaculous" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
  <title>Pagamento de Parcela</title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><g:link class="list" id="${parcelaInstance.id}" target="_blank" action="print">Imprimir</g:link></span>
  </div>
  <div class="body">
    <h1>Detalhes da Parcela</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="parcela.id.label" default="Id" /></td>

        <td valign="top" class="value">${fieldValue(bean: parcelaInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.emprestimo.label" default="Emprestimo" /></td>

        <td valign="top" class="value"><g:link controller="emprestimo" action="show" id="${parcelaInstance?.emprestimo?.id}">${parcelaInstance?.emprestimo?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.numero.label" default="Numero" /></td>

        <td valign="top" class="value">${fieldValue(bean: parcelaInstance, field: "numero")} de ${parcelaInstance.emprestimo.numParcelas}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.vencimento.label" default="Vencimento" /></td>

        <td valign="top" class="value"><g:formatDate date="${parcelaInstance?.vencimento}" /></td>

        </tr>

        <g:if test="${!parcelaInstance?.pago}">

          <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.previsaoDePagamento.label" default="Previsão de pagamento" /></td>

        <td valign="top" class="value">
          <div id="updateMe">
            <calendar:datePicker
              dateFormat="%d/%m/%Y" showTime="false"
              name="previsaoDePagamento" value="${parcelaInstance?.previsaoDePagamento}"
              onChange="${remoteFunction(action:'updatePrevPag',update:'updateMe', params:'\'dataPrev=\' + this.value', id:parcelaInstance?.id )}"
              />
          </div>

        </td>

        </tr>
        
        </g:if>
        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.valor.label" default="Valor" /></td>

        <td valign="top" class="value"> <g:formatNumber number="${parcelaInstance.valor}" type="currency" currencyType="BRL" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parcela.multaAtraso.label" default="Multa por atraso" />
          </td>

        <td valign="top" class="value"> 
          <g:formatNumber number="${parcelaInstance.multaAtraso}" type="currency" currencyType="BRL" />
        </td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="parcela.multaAtrasoPercent.label" default="Multa por atraso (%)" />
          </td>

        <td valign="top" class="value"> 
          ${parcelaInstance.multaAtrasoPercent}
        </td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.taxaJurosAtraso.label" default="taxaJurosAtraso" /></td>

        <td valign="top" class="value">${fieldValue(bean: parcelaInstance, field: "taxaJurosAtraso")} %</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.acrescimos.label" default="Acrescimos" /></td>

        <td valign="top" class="value"><g:formatNumber number="${parcelaInstance.acrescimos}" type="currency" currencyType="BRL"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.valorPago.label" default="Valor Pago" /></td>

        <td valign="top" class="value"><g:formatNumber number="${parcelaInstance.valorPago}" type="currency" currencyType="BRL"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.dataPagamento.label" default="Data Pagamento" /></td>

        <td valign="top" class="value"><g:formatDate date="${parcelaInstance?.dataPagamento}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.pago.label" default="Pago" /></td>

        <td valign="top" class="value"><g:formatBoolean boolean="${parcelaInstance?.pago}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parcela.usuario.label" default="Usuario" /></td>

        <td valign="top" class="value"><g:link controller="usuario" action="show" id="${parcelaInstance?.usuario?.id}">${parcelaInstance?.usuario?.encodeAsHTML()}</g:link></td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${parcelaInstance?.id}" />
        <span class="button">
          <g:actionSubmit class="edit" action="edit" 
            value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
        </span>
        
        <g:if test="${parcelaInstance?.pago}">
        <span class="button">
          <g:actionSubmit class="delete" action="cancelPayment" 
            value="Cancelar Pagamento" 
            onclick="return confirm('Você está cancelando este pagamento. Tem certeza?');" />
        </span>
        </g:if>

      </g:form>
    </div>
  </div>
</body>
</html>
