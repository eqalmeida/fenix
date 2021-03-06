

<%@ page import="fenix.Especie" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'especie.label', default: 'Especie')}" />
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
            <g:hasErrors bean="${especieInstance}">
            <div class="errors">
                <g:renderErrors bean="${especieInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nome"><g:message code="especie.nome.label" default="Nome" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: especieInstance, field: 'nome', 'errors')}">
                                    <g:textField name="nome" maxlength="30" value="${especieInstance?.nome}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="geraBoleto"><g:message code="especie.geraBoleto.label" default="Gera Boleto" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: especieInstance, field: 'geraBoleto', 'errors')}">
                                    <g:checkBox name="geraBoleto" value="${especieInstance?.geraBoleto}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ativo"><g:message code="especie.ativo.label" default="Ativo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: especieInstance, field: 'ativo', 'errors')}">
                                    <g:checkBox name="ativo" value="${especieInstance?.ativo}" />
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
