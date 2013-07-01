

<%@ page import="fenix.Config" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'config.label', default: 'Config')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
  </div>
  <div class="body">
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${emprestimoInstance}">
      <div class="errors">
        <g:renderErrors bean="${emprestimoInstance}" as="list" />
      </div>
    </g:hasErrors>

    <img alt="logo" height="100" src="${resource(dir:'images', file: 'printlogo.jpg')}" />

    <p>
      Arquivo de Logotipo(JPG):
    </p>
    <g:form action="uploadLogo" method="post" enctype="multipart/form-data">
      <input type="file" name="myFile" />
      <input type="submit" value="Enviar" />
    </g:form>
  </div>
</body>
</html>
