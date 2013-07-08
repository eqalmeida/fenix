<%@ page import="fenix.Emprestimo; fenix.Observacao" %>
<g:each in="${obsList}" var="o">
  <div style="padding:4px; border-top: solid 1px #eee">
    <p><strong><g:formatDate date="${o.data}"/></strong> - ${o.usuario}<p/>
    <p><i>${o.obs}</i></p>
  </div>
</g:each>

<div id="coments">
  <g:if test="${flash.erros}">
    <div class="errors">
      <ul>
        <li>${flash.erros}</li>
      </ul>
    </div>
  </g:if>

  <g:form>
    <g:hiddenField name="id" value="${emprestimoInstance?.id}"/>
    <div style="width: 500px">
      <g:textArea name="observ" cols="40" rols="5" />
    </div>
    <div>
      <g:submitToRemote action="addObsAjax" class="edit" value="Gravar observação" update="obsInc"/>
    </div>
  </g:form>

  

</div>
