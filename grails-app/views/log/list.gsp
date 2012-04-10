
<%@ page import="fenix.Log" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'log.label', default: 'Log')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'log.id.label', default: 'Id')}" />
                        
                            <th><g:message code="log.usuario.label" default="Usuario" /></th>
                        
                            <g:sortableColumn property="data" title="${message(code: 'log.data.label', default: 'Data')}" />
                        
                            <g:sortableColumn property="descricao" title="${message(code: 'log.descricao.label', default: 'Descricao')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logInstanceList}" status="i" var="logInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${logInstance.id}">${fieldValue(bean: logInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: logInstance, field: "usuario")}</td>
                        
                            <td><g:formatDate date="${logInstance.data}" /></td>
                        
                            <td>${fieldValue(bean: logInstance, field: "descricao")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${logInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
