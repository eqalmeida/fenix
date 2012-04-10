
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
            <span class="menuButton"><g:link class="list" action="list" params="['status':0]">Não Efetivados</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':1]">Ativos</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':2]">Cancelados</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':3]">Congelados</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':4]">Acordo</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':5]">Protesto</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':6]">Em Atraso</g:link></span>
            <span class="menuButton"><g:link class="list" action="list" params="['status':7]">Quitados</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /> ${stat}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'emprestimo.id.label', default: 'Id')}" />

                            <g:sortableColumn property="data" title="${message(code: 'emprestimo.data.label', default: 'Data')}" />
                        
                            <th><g:message code="emprestimo.cliente.label" default="Cliente" /></th>
                        
                            <th><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></th>
                        
                            <th><g:message code="emprestimo.especie.label" default="Especie" /></th>
                        
                            <th><g:message code="emprestimo.plano.label" default="Plano" /></th>

                            <th><g:message code="emprestimo.status.label" default="Status" /></th>
                        
                            <g:sortableColumn property="valorLiberado" title="${message(code: 'emprestimo.valorLiberado.label', default: 'Valor Liberado')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${emprestimoInstanceList}" status="i" var="emprestimoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${emprestimoInstance.id}">${fieldValue(bean: emprestimoInstance, field: "id")}</g:link></td>
                        
                            <td>${formatDate(bean: emprestimoInstance, field: "data")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "cliente")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "tipoEmprestimo")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "especie")}</td>
                        
                            <td>${fieldValue(bean: emprestimoInstance, field: "plano")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "statusStr")}</td>

                            <td><g:formatNumber number="${emprestimoInstance.valorLiberado}" type="currency" currencyType="BRL" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${emprestimoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
