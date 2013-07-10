
<%@ page import="fenix.Especie" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'especie.label', default: 'Especie')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="nome" title="${message(code: 'especie.nome.label', default: 'Nome')}" />
                        
                            <g:sortableColumn property="geraBoleto" title="${message(code: 'especie.geraBoleto.label', default: 'Gera Boleto')}" />
                        
                            <g:sortableColumn property="ativo" title="${message(code: 'especie.ativo.label', default: 'Ativo')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${especieInstanceList}" status="i" var="especieInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${especieInstance.id}">
                            ${fieldValue(bean: especieInstance, field: "nome")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${especieInstance.geraBoleto}" /></td>
                        
                            <td><g:formatBoolean boolean="${especieInstance.ativo}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${especieInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
