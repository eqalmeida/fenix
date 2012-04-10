
<%@ page import="fenix.Cliente" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
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
    <div class="menuButton">
      <g:form method="POST">
        <g:textField name="query" value="${query}" maxlength="100" />
        <g:submitButton name="list" value="Buscar"/>
      </g:form>
    </div>
    <div class="list">
      <table>
        <thead>
          <tr>

        <g:sortableColumn property="id" title="${message(code: 'cliente.id.label', default: 'Id')}" />

        <g:sortableColumn property="nome" title="${message(code: 'cliente.nome.label', default: 'Nome')}" />

        <g:sortableColumn property="rg" title="${message(code: 'cliente.rg.label', default: 'Rg')}" />

        <g:sortableColumn property="cpf" title="${message(code: 'cliente.cpf.label', default: 'Cpf')}" />

        <g:sortableColumn property="telefoneRes" title="${message(code: 'cliente.telefoneRes.label', default: 'Telefone Res')}" />

        <g:sortableColumn property="telefoneCom" title="${message(code: 'cliente.telefoneCom.label', default: 'Telefone Com')}" />

        <th>Opções</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${clienteInstanceList}" status="i" var="clienteInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td><g:link action="show" id="${clienteInstance.id}">${fieldValue(bean: clienteInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: clienteInstance, field: "nome")}</td>

          <td>${fieldValue(bean: clienteInstance, field: "rg")}</td>

          <td>${fieldValue(bean: clienteInstance, field: "cpf")}</td>

          <td>${fieldValue(bean: clienteInstance, field: "telefoneRes")}</td>

          <td>${fieldValue(bean: clienteInstance, field: "telefoneCom")}</td>

          <td><g:link controller="emprestimo" action="create" params="['cliente.id':clienteInstance.id]">Novo Empréstimo</g:link></td>

          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${clienteInstanceTotal}" />
    </div>
  </div>
</body>
</html>
