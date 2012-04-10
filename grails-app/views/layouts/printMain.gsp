<html>
  <head>
    <title><g:layoutTitle default="Grails" /></title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'print.css')}" />
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
  <g:layoutHead />
  <g:javascript library="application" />
</head>
<body>
    <img alt="logo"  src="${resource(dir:'images', file: 'printlogo.jpg')}" />

<g:layoutBody />
<div id="rodape">
  Data: <g:formatDate date="${new Date()}" format="dd/MM/yy HH:mm"/>
</div>

</body>
</html>