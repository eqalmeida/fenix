
<%@ page import="fenix.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
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
                                                
                            <g:sortableColumn property="nome" title="${message(code: 'usuario.nome.label', default: 'Nome')}" />
                        
                            <g:sortableColumn property="login" title="${message(code: 'usuario.login.label', default: 'Login')}" />
                        
                            <g:sortableColumn property="perfil" title="${message(code: 'usuario.perfil.label', default: 'Perfil')}" />
                        
                            <g:sortableColumn property="ativo" title="${message(code: 'usuario.ativo.label', default: 'Ativo')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${usuarioInstanceList}" status="i" var="usuarioInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${usuarioInstance.id}">
                            ${fieldValue(bean: usuarioInstance, field: "nome")}
                            </g:link></td>
                        
                            <td>${fieldValue(bean: usuarioInstance, field: "login")}</td>
                        
                            <td>${fieldValue(bean: usuarioInstance, field: "perfil")}</td>
                        
                            <td><g:formatBoolean boolean="${usuarioInstance.ativo}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${usuarioInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
