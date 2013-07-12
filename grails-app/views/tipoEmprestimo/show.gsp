
<%@ page import="fenix.TipoEmprestimo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tipoEmprestimo.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tipoEmprestimoInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tipoEmprestimo.nome.label" default="Nome" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tipoEmprestimoInstance, field: "nome")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tipoEmprestimo.taxaJurosAtraso.label" default="taxaJurosAtraso" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tipoEmprestimoInstance, field: "taxaJurosAtraso")} %</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tipoEmprestimo.multaAtraso.label" default="Multa Atraso" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${tipoEmprestimoInstance.multaAtraso}" type="currency" currencyType="BRL" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                                <g:message code="tipoEmprestimo.multaAtrasoPercent.label" default="Multa Atraso %" />
                            </td>
                            
                            <td valign="top" class="value">
                                <span>${tipoEmprestimoInstance.multaAtrasoPercent}</span>
                                <span> %</span>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tipoEmprestimo.ativo.label" default="Ativo" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${tipoEmprestimoInstance?.ativo}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tipoEmprestimoInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <span class="button">
<g:link controller="plano" action="create" params="['tipoEmprestimo.id': tipoEmprestimoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'plano.label', default: 'Plano')])}</g:link>
                    </span>
                </g:form>
            </div>

            <g:if test="${tipoEmprestimoInstance.planos}">

        

                <div class="list">
                <table>
                <caption>Planos</caption>
                    <thead>
                        <tr>

                            <th>${message(code: 'plano.id.label', default: 'Id')}</th>
                            <th>${message(code: 'plano.numParcelas.label', default: 'Num Parcelas')}</th>
                            <th>${message(code: 'plano.coeficiente.label', default: 'Coeficiente')}</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tipoEmprestimoInstance.planos}" var="planoInstance" status="i">

                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link action="show" controller="plano" id="${planoInstance.id}">${fieldValue(bean: planoInstance, field: "id")}</g:link></td>

                            <td>${fieldValue(bean: planoInstance, field: "numParcelas")}</td>

                            <td>${formatNumber(number: planoInstance.coeficiente)}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            </g:if>

        </div>
    </body>
</html>