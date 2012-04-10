<%@ page import="fenix.Usuario" %>

<html>
  <head>
    <meta name="layout" content="main" />
    <title>Liberação do Sistema</title>
  </head>
  <body>
    <div class="body">
      <h1>Login</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:form action="liberar" method="post" >
        <g:hiddenField name="id" value="${configInstance.id}"/>
        <div class="dialog">
          <table>
            <tbody>
              <tr class="prop">
                <td class="name">
                  <label for="liberacao">Código de Liberação:</label>
                </td>
                <td>
                  <g:textField name="liberacao" value="${configInstance.liberacao}"/>
                </td>
              </tr>

            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button">
            <input class="save" type="submit" value="Alterar" />
          </span>
        </div>
      </g:form>
    </div>
  </body>
</html>