<html>
  <head>
    <meta name="layout" content="main" />
    <title>Login</title>
  </head>
  <body>
    <div class="body">
      <h1>Login</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <h1>Acesso negado a este recurso!</h1>
      <h2>Entre em contato com o Administrador</h2>
    </div>
  </body>
</html>