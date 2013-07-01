
<%@ page import="fenix.Emprestimo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emprestimo.label', default: 'Emprestimo')}" />
        <title>Gráfico de ${entityName}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>

      <div class="body">

            <h1>Gráfico de ${entityName}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
           
            <div class="list">
   <gchart:pieChart
     title='Status Geral'
      colors="FFD700|90EE90|4682B4|FF0000|00FF00|0000FF"
      labels="${labels}"
      fill="${'bg,s,efefef'}"
      dataType='simple'
      data='${values}'
      size="${[600,300]}"
       fill="${'bg,s,efefef'}"
     />
            </div>
            <p>Total de: ${total}
            </p>
        </div>
    </body>
</html>
