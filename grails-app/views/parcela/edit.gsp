

<%@ page import="fenix.Parcela" %>
<html>
    <head>
        <calendar:resources lang="br" theme="tiger"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:javascript library="mascara" />
        <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${parcelaInstance}">
            <div class="errors">
                <g:renderErrors bean="${parcelaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${parcelaInstance?.id}" />
                <g:hiddenField name="version" value="${parcelaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="emprestimo"><g:message code="parcela.emprestimo.label" default="Empréstimo" /></label>
                                </td>
                              
        <td valign="top" class="value"><g:link controller="emprestimo" action="show" id="${parcelaInstance?.emprestimo?.id}">${parcelaInstance?.emprestimo?.encodeAsHTML()}</g:link></td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vencimento"><g:message code="parcela.vencimento.label" default="Vencimento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'vencimento', 'errors')}">
                                    <calendar:datePicker name="vencimento"  dateFormat="%d/%m/%Y" showTime="false"  value="${parcelaInstance?.vencimento}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="previsaoDePagamento"><g:message code="parcela.previsaoDePagamento.label" default="Previsão de Pagamento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'previsaoDePagamento', 'errors')}">
                                    <calendar:datePicker name="previsaoDePagamento"  dateFormat="%d/%m/%Y" showTime="false"  value="${parcelaInstance?.previsaoDePagamento}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valor"><g:message code="parcela.valor.label" default="Valor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'valor', 'errors')}">
                                    <g:textField name="valor" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: parcelaInstance, field: 'valor')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="multaAtraso">
                                    <g:message code="parcela.multaAtraso.label" default="Multa por atraso" />
                                </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'multaAtraso', 'errors')}">
                                    <g:textField name="multaAtraso" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: parcelaInstance, field: 'multaAtraso')}" />
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="multaAtrasoPercent">
                                    <g:message code="parcela.multaAtrasoPercent.label" default="Multa por atraso (%)" />
                                </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'multaAtrasoPercent', 'errors')}">
                                    <g:textField name="multaAtrasoPercent" value="${fieldValue(bean: parcelaInstance, field: 'multaAtrasoPercent')}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="taxaJurosAtraso"><g:message code="parcela.taxaJurosAtraso.label" default="taxaJurosAtraso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'taxaJurosAtraso', 'errors')}">
                                    <g:textField name="taxaJurosAtraso" value="${fieldValue(bean: parcelaInstance, field: 'taxaJurosAtraso')}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valorPago"><g:message code="parcela.valorPago.label" default="Valor Pago" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'valorPago', 'errors')}">
                                    <g:textField name="valorPago" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: parcelaInstance, field: 'valorPago')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dataPagamento"><g:message code="parcela.dataPagamento.label" default="Data Pagamento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'dataPagamento', 'errors')}">
                                    <calendar:datePicker name="dataPagamento"  dateFormat="%d/%m/%Y" showTime="false" value="${parcelaInstance?.dataPagamento}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="pago"><g:message code="parcela.pago.label" default="Pago" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'pago', 'errors')}">
                                    <g:checkBox name="pago" value="${parcelaInstance?.pago}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                  <g:checkBox name="update_all" value="${false}"/>Atualizar todas parcelas
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
