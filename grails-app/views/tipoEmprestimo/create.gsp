

<%@ page import="fenix.TipoEmprestimo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tipoEmprestimoInstance}">
            <div class="errors">
                <g:renderErrors bean="${tipoEmprestimoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nome"><g:message code="tipoEmprestimo.nome.label" default="Nome" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'nome', 'errors')}">
                                    <g:textField name="nome" maxlength="30" value="${tipoEmprestimoInstance?.nome}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="taxaJurosAtraso"><g:message code="tipoEmprestimo.taxaJurosAtraso.label" default="taxaJurosAtraso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'taxaJurosAtraso', 'errors')}">
                                    <g:textField name="taxaJurosAtraso" value="${fieldValue(bean: tipoEmprestimoInstance, field: 'taxaJurosAtraso')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="multaAtraso"><g:message code="tipoEmprestimo.multaAtraso.label" default="Multa Atraso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'multaAtraso', 'errors')}">
                                    <g:textField name="multaAtraso" value="${fieldValue(bean: tipoEmprestimoInstance, field: 'multaAtraso')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ativo"><g:message code="tipoEmprestimo.ativo.label" default="Ativo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'ativo', 'errors')}">
                                    <g:checkBox name="ativo" value="${tipoEmprestimoInstance?.ativo}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
