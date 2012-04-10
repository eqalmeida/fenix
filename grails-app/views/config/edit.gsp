

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
  </div>
  <div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${configInstance}">
      <div class="errors">
        <g:renderErrors bean="${configInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${configInstance?.id}" />
      <g:hiddenField name="version" value="${configInstance?.version}" />
      <div class="dialog">
        <table>
          <tbody>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="nome"><g:message code="config.pastaBackup.label" default="Pasta de backup" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: configInstance, field: 'pastaBackup', 'errors')}">
          <g:textField name="pastaBackup" maxlength="100" size="50" value="${configInstance?.pastaBackup}" />
          </td>
          </tr>
          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
      </div>
    </g:form>

<br/>
    <table>
      <tbody>
        <tr class="prop">
          <td valign="top" >

            <img alt="logo" style="border:1px solid #333; padding: 5px;" height="100" src="${resource(dir:'images', file: 'printlogo.jpg')}" />
          </td>
        </tr>
        <tr class="prop">

          <td valign="top">

            Arquivo de Logotipo(JPG):<br/>
           <g:form action="uploadLogo" method="post" enctype="multipart/form-data">
        <input type="file" name="myFile" />
        <input type="submit" value="Enviar" />
      </g:form>

      </td>
      </tr>





      </tbody>
    </table>


  </div>
</body>
</html>
