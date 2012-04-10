
<%@ page import="fenix.Emprestimo; fenix.Observacao" %>
<html>
  <head>
  <g:javascript library="application" />

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Impressão de Empréstimo</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'print.css')}" />
</head>
<body>
  <div class="body">
    <h1>Detalhes do Empréstimo</h1>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop" >
            <td valign="top" class="name"><g:message code="emprestimo.id.label" default="Id" /></td>

        <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "id")}</td>

        <td valign="top" class="name"><g:message code="emprestimo.cliente.label" default="Cliente" /></td>

        <td valign="top" class="value">${emprestimoInstance?.cliente?.encodeAsHTML()}</td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></td>

        <td valign="top" class="value">${emprestimoInstance?.tipoEmprestimo?.encodeAsHTML()}</td>

        <td valign="top" class="name"><g:message code="emprestimo.especie.label" default="Especie" /></td>

        <td valign="top" class="value">${emprestimoInstance?.especie?.encodeAsHTML()}</td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.plano.label" default="Plano" /></td>

        <td valign="top" class="value">${emprestimoInstance?.plano?.encodeAsHTML()}</td>

        <td valign="top" class="name"><g:message code="emprestimo.valorLiberado.label" default="Valor Liberado" /></td>

        <td valign="top" class="value"><g:formatNumber number="${emprestimoInstance.valorLiberado}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.data.label" default="Data" /></td>

        <td valign="top" class="value"><g:formatDate date="${emprestimoInstance?.data}" format="dd/MM/yyyy" /></td>

        <td valign="top" class="name"> </td>

        <td valign="top" class="value"> </td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.status.label" default="Status" /></td>

        <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "statusStr")}</td>

        <td valign="top" class="name"><g:message code="emprestimo.valorFinanciado.label" default="Valor Financiado" /></td>

        <td valign="top" class="value"><g:formatNumber number="${emprestimoInstance.valorFinanciado}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >
          <td valign="top" class="name"><g:message code="emprestimo.valorParcela.label" default="Valor Parcela" /></td>

        <td valign="top" class="value"><g:formatNumber number="${emprestimoInstance.valorParcela}" type="currency" currencyCode="BRL" /></td>

        <td valign="top" class="name"><g:message code="emprestimo.tac.label" default="Tac" /></td>

        <td valign="top" class="value"> <g:formatNumber number="${emprestimoInstance.tac}" type="currency" currencyCode="BRL" /></td>

        </tr>

        <tr  class="prop" >

          <td valign="top" class="name"><g:message code="emprestimo.numParcelas.label" default="Num Parcelas" /></td>

        <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "numParcelas")}</td>
        <td valign="top" class="name"><g:message code="emprestimo.usuario.label" default="Usuario" /></td>

        <td valign="top" class="value">${emprestimoInstance?.usuario?.encodeAsHTML()}</td>

        </tr>

        </tbody>
      </table>
    </div>

    <g:if test="${emprestimoInstance?.placa}">
      <h1>Dados do Veículo</h1>
      <div class="dialog">
        <table>
          <tbody>



            <tr class="prop">
              <td valign="top" class="name"><g:message code="emprestimo.placa.label" default="Placa" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "placa")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.marca.label" default="Marca" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "marca")}</td>

          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="emprestimo.modelo.label" default="Modelo" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "modelo")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.anoFab.label" default="Ano Fab" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "anoFab")}</td>

          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="emprestimo.anoMod.label" default="Ano Mod" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "anoMod")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.chassi.label" default="Chassi" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "chassi")}</td>

          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="emprestimo.cor.label" default="Cor" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "cor")}</td>

          <td valign="top" class="name"><g:message code="emprestimo.tipoCombustivel.label" default="Tipo Combustivel" /></td>

          <td valign="top" class="value">${fieldValue(bean: emprestimoInstance, field: "tipoCombustivel")}</td>

          </tr>
          </tbody>
        </table>
      </div>
    </g:if>




    <g:if test="${emprestimoInstance.parcelas}">
      <h1>Parcelas</h1>

      <div class="list" id="parcelaList">
        <table>
          <thead>
            <tr>

              <th>${message(code: 'parcela.numero.label', default: 'Num. Boleto')}</th>

              <th>${message(code: 'parcela.vencimento.label', default: 'Vencimento')}</th>

              <th>${message(code: 'parcela.valorAtual.label', default: 'Valor')}</th>

              <th>${message(code: 'parcela.valorPago.label', default: 'Valor Pago')}</th>

              <th>${message(code: 'parcela.dataPagamento.label', default: 'Data Pagamento')} </th>

              <th>Recebido por</th>

            </tr>
          </thead>
          <tbody>
          <g:each in="${emprestimoInstance.parcelas}" status="i" var="parcelaInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>${parcelaInstance.numero}</td>

              <td><g:formatDate date="${parcelaInstance.vencimento}" format="dd/MM/yyyy" /></td>

            <td><g:formatNumber number="${parcelaInstance.valorAtual}" type="currency" currencyCode="BRL" /></td>

            <td><g:formatNumber number="${parcelaInstance.valorPago}" type="currency" currencyCode="BRL" /></td>

            <td><g:formatDate date="${parcelaInstance.dataPagamento}" format="dd/MM/yyyy" /></td>

            <td>${parcelaInstance.usuario}</td>

            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
    </g:if>
    <g:if test="${emprestimoInstance.obs}">
      <h2>Observações</h2>
      <g:each in="${emprestimoInstance.obs}" var="o">
        <div style="padding:4px; border-bottom: dashed thin #DDD">
          <g:formatDate date="${o.data}"/>: ${o.obs} (${o.usuario})
        </div>
      </g:each>
    </g:if>
    <br />
    <div id="rodape">
      Data: <g:formatDate date="${new Date()}" format="dd/MM/yy HH:mm"/>
    </div>
  </div>

</body>
</html>
