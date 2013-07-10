
<%@ page import="fenix.Emprestimo; fenix.Observacao" %>
<html>
  <head>
  <g:javascript library="application" />
  <modalbox:modalIncludes />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'emprestimo.label', default: 'Emprestimo')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span class="menuButton"><g:link class="list" id="${emprestimoInstance.id}" target="_blank" action="print">Imprimir</g:link></span>
  </div>
  <div class="body">
    <h1>Detalhes da Transação Nº ${fieldValue(bean: emprestimoInstance, field: "id")}</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

          <tr  class="prop" >

            <td valign="top" class="name"><g:message code="emprestimo.cliente.label" default="Cliente" /></td>

        <td valign="top" colspan="3" class="value"><g:link controller="cliente" action="show" id="${emprestimoInstance?.cliente?.id}">${emprestimoInstance?.cliente?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></td>

        <td valign="top" class="value"><g:link controller="tipoEmprestimo" action="show" id="${emprestimoInstance?.tipoEmprestimo?.id}">${emprestimoInstance?.tipoEmprestimo?.encodeAsHTML()}</g:link></td>

        <td valign="top" class="name"><g:message code="emprestimo.especie.label" default="Especie" /></td>

        <td valign="top" class="value"><g:link controller="especie" action="show" id="${emprestimoInstance?.especie?.id}">${emprestimoInstance?.especie?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.plano.label" default="Plano" /></td>

        <td valign="top" class="value"><g:link controller="plano" action="show" id="${emprestimoInstance?.plano?.id}">${emprestimoInstance?.plano?.encodeAsHTML()}</g:link></td>

        <td valign="top" class="name"><g:message code="emprestimo.valorLiberado.label" default="Valor Liberado" /></td>

        <td valign="top" class="value"><g:formatNumber number="${emprestimoInstance.valorLiberado}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.data.label" default="Data" /></td>

        <td valign="top" class="value"><g:formatDate date="${emprestimoInstance?.data}" format="dd/MM/yyyy" /></td>

        <td valign="top" class="name"><g:message code="emprestimo.dataReg.label" default="Cadastrado em" /></td>

        <td valign="top" class="value"><g:formatDate date="${emprestimoInstance?.dataReg}" format="dd/MM/yyyy" /></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.status.label" default="Status" /></td>

        <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "statusStr")}</td>

        <td valign="top" class="name"><g:message code="emprestimo.valorFinanciado.label" default="Valor Financiado" /></td>

        <td valign="top" class="value"><g:formatNumber number="${emprestimoInstance.valorFinanciado}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >
        <g:if test="${emprestimoInstance.valorParcela > 0.0}">

          <td valign="top" class="name">
          <g:message code="emprestimo.valorParcela.label" default="Valor Parcela" />
          </td>
          <td valign="top" class="value">
          <g:formatNumber number="${emprestimoInstance.valorParcela}" type="currency" currencyCode="BRL" />
          </td>

        </g:if>
        <g:else>

          <td valign="top" class="name">
          <g:message code="emprestimo.valorParcelaEstimado.label" default="Valor Parcela (estimado)" />
          </td>
          <td valign="top" class="value">
          <g:formatNumber number="${emprestimoInstance.valorParcelaEstimado}" type="currency" currencyCode="BRL" />
          </td>

        </g:else>

        <td valign="top" class="name"><g:message code="emprestimo.tac.label" default="Tac" /></td>
        <td valign="top" class="value"> <g:formatNumber number="${emprestimoInstance.tac}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >

          <td valign="top" class="name"><g:message code="emprestimo.numParcelas.label" default="Num Parcelas" /></td>

        <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "numParcelas")}</td>
        <td valign="top" class="name"><g:message code="emprestimo.usuario.label" default="Usuario" /></td>

        <td valign="top" class="value"><g:link controller="usuario" action="show" id="${emprestimoInstance?.usuario?.id}">${emprestimoInstance?.usuario?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr  class="prop" >

          <td valign="top" class="name"><g:message code="emprestimo.intervalo.label" default="Intervalo" /></td>

        <td valign="top" class="value">
          ${fieldValue(bean: emprestimoInstance, field: "intervalo")}
        </td>

          <td valign="top" class="name">Tolerância</td>

        <td valign="top" class="value">
          ${fieldValue(bean: emprestimoInstance, field: "diasTolerancia")} dias
        </td>

        </tr>

        </tbody>
      </table>
    </div>
    <g:if test="${emprestimoInstance?.placa}">
      <h2>Dados do Veículo</h2>
      <div class="dialog">
        <table>
          <tbody>



            <tr>
              <td valign="top" class="name"><g:message code="emprestimo.placa.label" default="Placa" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "placa")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.marca.label" default="Marca" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "marca")}</td>

          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="emprestimo.modelo.label" default="Modelo" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "modelo")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.anoFab.label" default="Ano Fab" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "anoFab")}</td>

          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="emprestimo.anoMod.label" default="Ano Mod" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "anoMod")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.chassi.label" default="Chassi" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "chassi")}</td>

          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="emprestimo.cor.label" default="Cor" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "cor")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.tipoCombustivel.label" default="Tipo Combustivel" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "tipoCombustivel")}</td>

          </tr>
          </tbody>
        </table>
      </div>
    </g:if>



    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${emprestimoInstance?.id}" />
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>

        <g:if test="${emprestimoInstance?.status == 0}">
          <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
          <span class="button"><g:actionSubmit class="edit" action="efetivar" value="Efetivar" onclick="return confirm('O empréstimo atual será efetivado! Confirma?');" /></span>
        </g:if>

        <g:if test="${emprestimoInstance?.status > 0}">
        <span> | </span>
          <span class="button">
          <span class="edit">

            <modalbox:createLink
              controller="emprestimo"
              action="mudarStatusModal"
              id="${emprestimoInstance.id}"
              title="Alterar status!" width="500">Alterar Status</modalbox:createLink>
          </span>
          </span>

        </g:if>
      </g:form>
    </div>


    <g:if test="${emprestimoInstance.parcelas}">
      <h1>Parcelas</h1>

      <div class="list" id="parcelaList">
      
        <table class='lista'>
          <thead>
            <tr>

              <th>
                ${message(code: 'parcela.numero.label', default: 'Num. Boleto')}
              </th>

              <th>
                ${message(code: 'parcela.vencimento.label', default: 'Vencimento')}
              </th>

              <th>
                ${message(code: 'parcela.valor.label', default: 'Valor')}
              </th>

              <th>${message(code: 'parcela.acrescimos.label', default: 'Acrescimos')}</th>

              <th>Total</th>

              <th>${message(code: 'parcela.valorPago.label', default: 'Valor Pago')}</th>

              <th>${message(code: 'parcela.dataPagamento.label', default: 'Data Pagamento')} </th>

              <th>Recebido por</th>

              <th>Opções</th>

            </tr>
          </thead>
          <tbody>
          <g:each in="${emprestimoInstance.listaParcelas}" status="i" var="parcelaInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>
                <g:link title="Exibir detalhes da parcela" action="show" controller="parcela" id="${parcelaInstance.id}">
                ${parcelaInstance.numero}
              </g:link>
              </td>

              <td>
                <div class="label ${parcelaInstance.pago?'greenlabel':(new Date() > parcelaInstance.vencimento)?'redlabel':'infolabel'}">
                  <g:formatDate date="${parcelaInstance.vencimento}" format="dd/MM/yyyy" />
                </div>
              </td>

            <td><g:formatNumber number="${parcelaInstance.valor}" type="currency" currencyCode="BRL" /></td>

            <td>
              <g:if test="${parcelaInstance.pago}">
                <g:formatNumber number="${parcelaInstance.acrescimos}" type="currency" currencyCode="BRL" />
              </g:if>
            </td>

            <td>
              <g:if test="${parcelaInstance.pago}">
                <g:formatNumber number="${parcelaInstance.valorAtual}" type="currency" currencyCode="BRL" />
              </g:if>
            </td>

            <td><g:formatNumber number="${parcelaInstance.valorPago}" type="currency" currencyCode="BRL" /></td>

            <td><g:formatDate date="${parcelaInstance.dataPagamento}" format="dd/MM/yyyy" /></td>

            <td>${parcelaInstance.usuario}</td>

            <td align="center" nowrap='nowrap'>
              <span class="tbuttons">
            <g:if test="${!parcelaInstance.pago}">
              <g:link title="Registrar Pagamento" action="pagar" class="pag" controller="parcela" id="${parcelaInstance.id}"></g:link>
            </g:if><g:else>
              <span class="pag-d"></span>
          </g:else>
            <span>  </span>

            <g:link 
              title="Imprimir parcela"
              class="list" 
              id="${parcelaInstance?.id}" 
              target="_blank" controller="parcela" action="print" class="print"></g:link>


              </span>


            </td>

            </tr>
          </g:each>
          </tbody>
        </table>
        
      </div>
    </g:if>

    <h2>Observações</h2>
    
    <div id="obsInc">
      <g:render template="obs" model="[emprestimoInstance: emprestimoInstance, obsList:obsList]" />
    </div>


</body>
</html>
