
<%@ page import="fenix.Emprestimo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emprestimo.label', default: 'Emprestimo')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="rel" action="chart">Gráfico de ${entityName}</g:link></span>
        </div>
        <div class="nav">
            <span class="menuButton"><g:link class="top" action="list">Todos</g:link></span>
            <g:each in="${statusNomes}" var="it1">
            <span class="menuButton"><g:link class="top" action="list" params="['status':it1.key]">${it1.value}</g:link></span>
            </g:each>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                <caption><g:message code="default.list.label" args="[entityName]" /> ${stat}</caption>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="Num." />

                            <g:sortableColumn property="data" title="${message(code: 'emprestimo.data.label', default: 'Data')}" />
                        
                            <th><g:message code="emprestimo.cliente.label" default="Cliente" /></th>
                        
                            <th><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></th>
                        
                            <th><g:message code="emprestimo.especie.label" default="Especie" /></th>
                        
                            <th><g:message code="emprestimo.plano.label" default="Plano" /></th>

                            <g:if test="${stat == ''}">
                            <th><g:message code="emprestimo.status.label" default="Status" /></th>
                            </g:if>
                        
                            <g:sortableColumn property="valorLiberado" title="${message(code: 'emprestimo.valorLiberado.label', default: 'Valor Liberado')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${emprestimoInstanceList}" status="i" var="emprestimoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td style="text-align: center;">
                                <g:link action="show" id="${emprestimoInstance.id}">${fieldValue(bean: emprestimoInstance, field: "id")}</g:link>
                            </td>
                        
                            <td>${formatDate(bean: emprestimoInstance, field: "data")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "cliente")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "tipoEmprestimo")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "especie")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "plano")}</td>

                            <g:if test="${stat == ''}">
                            <td nowrap="nowrap">
                                ${fieldValue(bean: emprestimoInstance, field: "statusStr")}
                            </td>
                            </g:if>

                            <td nowrap="nowrap">
                                <g:formatNumber number="${emprestimoInstance.valorLiberado}" type="currency" currencyType="BRL" />
                            </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${emprestimoInstanceTotal}" params="${[status: status]}" max="20" />
            </div>

        </div>
    </body>
</html>
