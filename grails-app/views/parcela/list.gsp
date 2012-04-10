
<%@ page import="fenix.Parcela" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'parcela.label', default: 'Parcela')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'parcela.id.label', default: 'Id')}" />
                        
                            <th><g:message code="parcela.emprestimo.label" default="Emprestimo" /></th>
                        
                            <g:sortableColumn property="numero" title="${message(code: 'parcela.numero.label', default: 'Numero')}" />
                        
                            <g:sortableColumn property="vencimento" title="${message(code: 'parcela.vencimento.label', default: 'Vencimento')}" />
                        
                            <g:sortableColumn property="valor" title="${message(code: 'parcela.valor.label', default: 'Valor')}" />
                        
                            <g:sortableColumn property="taxaJurosAtraso" title="${message(code: 'parcela.taxaJurosAtraso.label', default: 'taxaJurosAtraso')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${parcelaInstanceList}" status="i" var="parcelaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${parcelaInstance.id}">${fieldValue(bean: parcelaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: parcelaInstance, field: "emprestimo")}</td>
                        
                            <td>${fieldValue(bean: parcelaInstance, field: "numero")}</td>
                        
                            <td><g:formatDate date="${parcelaInstance.vencimento}" /></td>
                        
                            <td>${fieldValue(bean: parcelaInstance, field: "valor")}</td>
                        
                            <td>${fieldValue(bean: parcelaInstance, field: "taxaJurosAtraso")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${parcelaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
