

<%@ page import="fenix.Emprestimo" %>
<html>
  <head>
  <calendar:resources lang="br" theme="tiger"/>
  <g:javascript library="mascara" />
  <g:javascript library="prototype"/>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'emprestimo.label', default: 'Emprestimo')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
  </div>
  <div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${emprestimoInstance}">
      <div class="errors">
        <g:renderErrors bean="${emprestimoInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${emprestimoInstance?.id}" />
      <g:hiddenField name="version" value="${emprestimoInstance?.version}" />
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="cliente"><g:message code="emprestimo.cliente.label" default="Cliente" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'cliente', 'errors')}">
          <g:hiddenField name="cliente.id" value="${emprestimoInstance?.cliente?.id}"  />
${emprestimoInstance?.cliente}
          </td>
          </tr>

          <g:if test="${emprestimoInstance?.status == 0}">

            <tr class="prop">
              <td valign="top" class="name">
                <label for="data"><g:message code="parcela.data.label" default="Data" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'data', 'errors')}">
            <calendar:datePicker name="data" dateFormat="%d/%m/%Y" showTime="false" value="${emprestimoInstance?.data}"  />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="primeiroVencimento"><g:message code="emprestimo.primeiroVencimento.label" default="Primeiro Vencimento" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'primeiroVencimento', 'errors')}">
            <calendar:datePicker name="primeiroVencimento" dateFormat="%d/%m/%Y" showTime="false" value="${emprestimoInstance?.primeiroVencimento}"  />
            </td>
            </tr>



            <tr class="prop">
              <td valign="top" class="name">
                <label for="tipoEmprestimo"><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'tipoEmprestimo', 'errors')}">
            <g:select
              onchange="${remoteFunction(action:'listPlanos', params:'\'id=\' + escape(this.value)', update:'listP')}"
              name="tipoEmprestimo.id"
              from="${fenix.TipoEmprestimo.findAllByAtivo(true)}"
              optionKey="id"
              value="${emprestimoInstance?.tipoEmprestimo?.id}"  />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="plano"><g:message code="emprestimo.plano.label" default="Plano" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'plano', 'errors')}">
                <div id="listP">
                  <g:select name="plano.id" from="${emprestimoInstance?.tipoEmprestimo.planos}" optionKey="id" value="${emprestimoInstance?.plano?.id}"  />
                </div>
              </td>
            </tr>


            <tr class="prop">
              <td valign="top" class="name">
                <label for="especie"><g:message code="emprestimo.especie.label" default="Especie" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'especie', 'errors')}">
            <g:select name="especie.id" from="${fenix.Especie.list()}" optionKey="id" value="${emprestimoInstance?.especie?.id}"  />
            </td>
            </tr>


            <tr class="prop">
              <td valign="top" class="name">
                <label for="tac"><g:message code="emprestimo.tac.label" default="Tac" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'tac', 'errors')}">
            <g:textField name="tac" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: emprestimoInstance, field: 'tac')}" />

            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="intervalo"><g:message code="emprestimo.intervalo.label" default="Intervalo" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'intervalo', 'errors')}">
            <g:select name="intervalo" from="${emprestimoInstance.constraints.intervalo.inList}" value="${emprestimoInstance?.intervalo}" valueMessagePrefix="emprestimo.intervalo" noSelection="['': 'Selecione...']" />
            </td>
            </tr>

            </g:if>


          <tr class="prop">
            <td valign="top" class="name">
              <label for="especie">Dias de Tolerância</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'diasTolerancia', 'errors')}">
            
              <g:textField name="diasTolerancia" value="${fieldValue(bean: emprestimoInstance, field: 'diasTolerancia')}" />

          </td>
          </tr>

            <g:if test="${emprestimoInstance?.status == 0}">


            <tr class="prop">
              <td valign="top" class="name">
                <label for="valorLiberado"><g:message code="emprestimo.valorLiberado.label" default="Valor Liberado" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'valorLiberado', 'errors')}">
            <g:textField name="valorLiberado" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: emprestimoInstance, field: 'valorLiberado')}" />

            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="valorParcela"><g:message code="emprestimo.valorParcela.label" default="Valor Parcela" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'valorParcela', 'errors')}">
            <g:textField name="valorParcela" onkeypress="mascara(this,moeda)" value="${fieldValue(bean: emprestimoInstance, field: 'valorParcela')}" />

            </td>
            </tr>

          </g:if>
          </tbody>
        </table>
      </div>

      <h2>Dados do Veículo</h2>
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="placa"><g:message code="emprestimo.placa.label" default="Placa" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'placa', 'errors')}">
          <g:textField name="placa" maxlength="10" value="${emprestimoInstance?.placa}" />
          </td>
          <td valign="top" class="name">
            <label for="marca"><g:message code="emprestimo.marca.label" default="Marca" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'marca', 'errors')}">
          <g:textField name="marca" maxlength="20" value="${emprestimoInstance?.marca}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="modelo"><g:message code="emprestimo.modelo.label" default="Modelo" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'modelo', 'errors')}">
          <g:textField name="modelo" maxlength="20" value="${emprestimoInstance?.modelo}" />
          </td>
          <td valign="top" class="name">
            <label for="anoFab"><g:message code="emprestimo.anoFab.label" default="Ano Fab" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'anoFab', 'errors')}">
          <g:textField name="anoFab" maxlength="4" value="${emprestimoInstance?.anoFab}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="anoMod"><g:message code="emprestimo.anoMod.label" default="Ano Mod" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'anoMod', 'errors')}">
          <g:textField name="anoMod" maxlength="4" value="${emprestimoInstance?.anoMod}" />
          </td>
          <td valign="top" class="name">
            <label for="chassi"><g:message code="emprestimo.chassi.label" default="Chassi" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'chassi', 'errors')}">
          <g:textField name="chassi" maxlength="20" value="${emprestimoInstance?.chassi}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="cor"><g:message code="emprestimo.cor.label" default="Cor" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'cor', 'errors')}">
          <g:textField name="cor" maxlength="15" value="${emprestimoInstance?.cor}" />
          </td>
          <td valign="top" class="name">
            <label for="tipoCombustivel"><g:message code="emprestimo.tipoCombustivel.label" default="Tipo Combustivel" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: emprestimoInstance, field: 'tipoCombustivel', 'errors')}">
          <g:select name="tipoCombustivel" from="${emprestimoInstance.constraints.tipoCombustivel.inList}" value="${emprestimoInstance?.tipoCombustivel}" valueMessagePrefix="emprestimo.tipoCombustivel" noSelection="['': '']" />
          </td>
          </tr>


          </tbody>
        </table>
      </div>




      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </div>
    </g:form>
  </div>
</body>
</html>
