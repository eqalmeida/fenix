
<%@ page import="fenix.Emprestimo; fenix.Observacao" %>

<h1>Alterar Status do Empréstimo</h1>

<g:form>

  <g:hiddenField  name="id" value="${emprestimoInstance?.id}" />
  <g:radioGroup value="${emprestimoInstance?.status}" name="newStatus" labels="['Ativo','Cancelado','Congelado','Acordo','Protesto']" values="[1,2,3,4,5]" >
    <p>${it.radio} ${it.label} </p>
  </g:radioGroup>

  <g:actionSubmit value="Alterar" action="mudarStatus"/>

</g:form>