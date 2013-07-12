

<%@ page import="fenix.Parcela" %>
<html>
    <head>
        <calendar:resources lang="br" theme="tiger"/>
        <g:javascript library="scriptaculous" />
        <g:javascript library="mascara" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
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
                  <table cellpadding="0" cellspacing="0">
                  <caption>Pagamento de Parcela</caption>
                        <tbody>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                                <g:message code="parcela.emprestimo.label" default="Emprestimo" />
                            </td>

                            <td valign="top" class="value">
                                <g:link controller="emprestimo" action="show" id="${parcelaInstance?.emprestimo?.id}">
                                ${parcelaInstance?.emprestimo?.encodeAsHTML()}
                            </g:link>
                        </td>

                        </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vencimento"><g:message code="parcela.vencimento.label" default="Vencimento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'vencimento', 'errors')}">
                                  <b><g:formatDate date="${parcelaInstance.vencimento}" /></b>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dataPagamento"><g:message code="parcela.dataPagamento.label" default="Data Pagamento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'dataPagamento', 'errors')}">
                                    <calendar:datePicker
                                      dateFormat="%d/%m/%Y" showTime="false"
                                      name="dataPagamento" value="${parcelaInstance.dataPagamento}" 
                                      onChange="${remoteFunction(action:'updateDataPag',update:'valorC', params:'\'datapag=\' + this.value', id:parcelaInstance.id )}"
                                      />
                                </td>
                            </tr>


                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valor"><g:message code="parcela.valor.label" default="Valor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'valor', 'errors')}">
                                    <g:formatNumber number="${parcelaInstance.valor}" type="currency" currencyCode="BRL"/>
                                </td>
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
                                <td valign="top" class="name">
                                  <label for="valorAtual"><g:message code="parcela.valorAtual.label" default="Valor Atual" /></label>
                                </td>
                                <td valign="top" style="font-weight: bold;">
                                <div id="valorC">
                                    <g:formatNumber number="${parcelaInstance.valorAtual}" type="currency" currencyCode="BRL"/>

                                </div>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="valorPago"><g:message code="parcela.valorPago.label" default="Valor Pago" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: parcelaInstance, field: 'valorPago', 'errors')}">
                                    <g:textField name="valorPago" onkeypress="mascara(this,moeda)" 
									value="${g.formatNumber(number: parcelaInstance?.valorPago, format: '#,##0.00')}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button">
                        <g:actionSubmit
                            onclick="return confirm('Confirma o registro do pagamento?');" 
                            class="save" 
                            action="regPagamento" 
                            value="Registrar Pagamento" />
                    </span>

                    <span class="button">
                        <g:actionSubmit
                            class="edit" 
                            action="edit" 
                            value="Editar" />
                    </span>
                </div>
            </g:form>
        </div>
    </body>
</html>
