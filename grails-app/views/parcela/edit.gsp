

<%@ page import="fenix.Parcela" %>
<html>
    <head>
      <resource:dateChooser/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
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
                                <td valign="top" class="value">
                                    ${parcelaInstance?.emprestimo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vencimento"><g:message code="parcela.vencimento.label" default="Vencimento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'vencimento', 'errors')}">
                                    <richui:dateChooser name="vencimento" format="dd/MM/yyyy" value="${parcelaInstance?.vencimento}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valor"><g:message code="parcela.valor.label" default="Valor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'valor', 'errors')}">
                                    <g:textField name="valor" value="${fieldValue(bean: parcelaInstance, field: 'valor')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="multaAtraso"><g:message code="parcela.multaAtraso.label" default="Multa por atraso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'multaAtraso', 'errors')}">
                                    <g:textField name="multaAtraso" value="${fieldValue(bean: parcelaInstance, field: 'multaAtraso')}" />
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
                                    <g:textField name="valorPago" value="${fieldValue(bean: parcelaInstance, field: 'valorPago')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dataPagamento"><g:message code="parcela.dataPagamento.label" default="Data Pagamento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'dataPagamento', 'errors')}">
                                    <richui:dateChooser name="dataPagamento" format="dd/MM/yyyy" value="${parcelaInstance?.dataPagamento}" noSelection="['': '']" />
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
