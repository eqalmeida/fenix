
<%@ page import="fenix.Parcela" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Impressão de Parcela</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'print.css')}" />
    </head>
    <body>
        <div class="body">
          <g:if test="${parcelaInstance?.pago}">
          <h1>Recibo de Parcela - Cod: ${fieldValue(bean: parcelaInstance, field: "id")}</h1>
          </g:if>
          <g:else>
          <h1>Detalhes da Parcela - Cod: ${fieldValue(bean: parcelaInstance, field: "id")}</h1>
          </g:else>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Nome</td>
                            
                            <td colspan="3" valign="top" class="value">${parcelaInstance?.emprestimo?.cliente?.nome}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.numero.label" default="Numero" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: parcelaInstance, field: "numero")} de ${parcelaInstance.emprestimo.numParcelas}</td>
                            
                            <td valign="top" class="name"><g:message code="parcela.vencimento.label" default="Vencimento" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${parcelaInstance?.vencimento}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.valor.label" default="Valor" /></td>

                            <td valign="top" class="value"> <g:formatNumber number="${parcelaInstance.valor}" type="currency" currencyType="BRL" /></td>

                            <td valign="top" class="name">Cód Empréstimo</td>

                            <td valign="top" class="value"> ${parcelaInstance.emprestimo.id}</td>

                        </tr>
<g:if test="${parcelaInstance.pago}">
                        <tr class="prop">
                            
                            <td valign="top" class="name"><g:message code="parcela.valorPago.label" default="Valor Pago" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${parcelaInstance.valorPago}" type="currency" currencyType="BRL"/></td>

                            <td valign="top" class="name"><g:message code="parcela.dataPagamento.label" default="Data Pagamento" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${parcelaInstance?.dataPagamento}" /></td>

                        </tr>

                        <tr class="prop">

                            <td valign="top" class="name">Recebido por:</td>
                            
                            <td colspan="3" valign="top" class="value">${parcelaInstance?.usuario?.encodeAsHTML()}</td>
                            
                        </tr>
                            </g:if>
                    </tbody>
                </table>
            </div>
    <div id="rodape">
      Data: <g:formatDate date="${new Date()}" format="dd/MM/yy HH:mm"/>
    </div>

        </div>
    </body>
</html>
