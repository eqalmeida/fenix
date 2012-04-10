
<%@ page import="fenix.Parcela" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
        <title>Pagamento de Parcela</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" id="${parcelaInstance.id}" target="_blank" action="print">Imprimir</g:link></span>
        </div>
        <div class="body">
            <h1>Pagamento de Parcela</h1>
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
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.valor.label" default="Valor" /></td>
                            
                            <td valign="top" class="value"> <g:formatNumber number="${parcelaInstance.valor}" type="currency" currencyType="BRL" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.multaAtraso.label" default="Multa por atraso" /></td>

                            <td valign="top" class="value"> <g:formatNumber number="${parcelaInstance.multaAtraso}" type="currency" currencyType="BRL" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.taxaJurosAtraso.label" default="taxaJurosAtraso" /></td>

                            <td valign="top" class="value">${fieldValue(bean: parcelaInstance, field: "taxaJurosAtraso")} %</td>

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
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="parcela.valorAtual.label" default="Valor Atual" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${parcelaInstance.valorAtual}" type="currency" currencyType="BRL"/></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${parcelaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
