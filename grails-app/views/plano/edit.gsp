

<%@ page import="fenix.Plano" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'plano.label', default: 'Plano')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${planoInstance}">
            <div class="errors">
                <g:renderErrors bean="${planoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${planoInstance?.id}" />
                <g:hiddenField name="version" value="${planoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoEmprestimo"><g:message code="plano.tipoEmprestimo.label" default="Tipo Emprestimo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: planoInstance, field: 'tipoEmprestimo', 'errors')}">
                                    <g:select name="tipoEmprestimo.id" from="${fenix.TipoEmprestimo.list()}" optionKey="id" value="${planoInstance?.tipoEmprestimo?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numParcelas"><g:message code="plano.numParcelas.label" default="Num Parcelas" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: planoInstance, field: 'numParcelas', 'errors')}">
                                    <g:select name="numParcelas" from="${1..50}" value="${fieldValue(bean: planoInstance, field: 'numParcelas')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tac"><g:message code="plano.tac.label" default="Tac" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: planoInstance, field: 'tac', 'errors')}">
                                    <g:textField name="tac" value="${fieldValue(bean: planoInstance, field: 'tac')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="coeficiente"><g:message code="plano.coeficiente.label" default="Coeficiente" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: planoInstance, field: 'coeficiente', 'errors')}">
                                    <g:textField name="coeficiente" value="${formatNumber(number: planoInstance.coeficiente)}" />
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
