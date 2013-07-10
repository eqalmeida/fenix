
<%@ page import="fenix.TipoEmprestimo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tipoEmprestimo.label', default: 'TipoEmprestimo')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                <caption>Tipos de Transação</caption>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'tipoEmprestimo.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nome" title="${message(code: 'tipoEmprestimo.nome.label', default: 'Nome')}" />
                        
                            <g:sortableColumn property="taxaJurosAtraso" title="${message(code: 'tipoEmprestimo.taxaJurosAtraso.label', default: 'taxaJurosAtraso')}" />
                        
                            <g:sortableColumn property="multaAtraso" title="${message(code: 'tipoEmprestimo.multaAtraso.label', default: 'Multa Atraso')}" />
                        
                            <g:sortableColumn property="multaAtrasoPercent" title="${message(code: 'tipoEmprestimo.multaAtrasoPercent.label', default: 'Multa Atraso %')}" />
                        
                            <g:sortableColumn property="ativo" title="${message(code: 'tipoEmprestimo.ativo.label', default: 'Ativo')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tipoEmprestimoInstanceList}" status="i" var="tipoEmprestimoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tipoEmprestimoInstance.id}">${fieldValue(bean: tipoEmprestimoInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: tipoEmprestimoInstance, field: "nome")}</td>
                        
                            <td>${fieldValue(bean: tipoEmprestimoInstance, field: "taxaJurosAtraso")} %</td>
                        
                            <td>
                                <g:formatNumber number="${tipoEmprestimoInstance.multaAtraso}" type="currency" currencyType="BRL" />
                            </td>
                        
                            <td>
                                <span>${tipoEmprestimoInstance.multaAtrasoPercent}</span>
                                <span> %</span>
                            </td>
                        
                            <td><g:formatBoolean boolean="${tipoEmprestimoInstance.ativo}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tipoEmprestimoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
