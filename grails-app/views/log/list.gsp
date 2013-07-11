
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
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                <caption>Log de operações</caption>
                    <tbody>
                    <g:each in="${logInstanceList}" status="i" var="logInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>
                                <p>${fieldValue(bean: logInstance, field: "descricao")}</p>
                                <p style="color: #999;">
                                    <strong><g:formatDate date="${logInstance.data}" /></strong>
                                    <span> - </span>
                                    ${fieldValue(bean: logInstance, field: "usuario")}
                                </p>
                            </td>
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
