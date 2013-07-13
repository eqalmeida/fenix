<g:setProvider library="jquery"/>

<%@ page import="fenix.Emprestimo; fenix.Observacao" %>

<script type="text/javascript">

$(document).ready(function() {
    $(".deleted").hide();
    $("#btnHide").hide();

    $("#btnShow").click(function(){
      $("#btnHide").show();
      $("#btnShow").hide();
      $(".deleted").show(1000);
    });

    $("#btnHide").click(function(){
      $("#btnHide").hide();
      $("#btnShow").show();
      $(".deleted").hide();
    });
});  

</script>


<div class="list">
<table>
<caption>Observações</caption>
<g:each in="${obsList}" var="o" status="i">
  <tr class="${o.ativo ? '' : 'deleted'}">
    <td width="100%">
    <div class="obs-text ${o.ativo ? '' : 'cancelado'}">${o.obs}</div>
    <div style="color:#777;">
      <strong><g:formatDate date="${o.data}"/></strong> / ${o.usuario}
    </div>
      

    </td>
    <td nowrap="nowrap">
      
      <span class="linkn">
      <g:if test="${o.ativo}">
        <g:remoteLink 
          action="deleteObsAjax" 
          update="obsInc" 
          params="[id:o.id]">Cancelar</g:remoteLink>
        </g:if>
        <g:else>
        <g:remoteLink 
          action="undeleteObsAjax" 
          update="obsInc" 
          params="[id:o.id]">Reativar</g:remoteLink>
        </g:else>
      </span>

    </td>
  </tr>
</g:each>
</table>
</div>
<br/>
<button id="btnShow">Exibir excluídas</button>
<button id="btnHide">Ocultar excluídas</button>



<div id="coments">
  <g:if test="${flash.erros}">
    <div class="errors">
      <ul>
        <li>${flash.erros}</li>
      </ul>
    </div>
  </g:if>

  <br/>

  <g:form>
    <g:hiddenField name="id" value="${emprestimoInstance?.id}"/>
    <div style="width: 500px">
      <g:textArea name="observ" cols="40" rols="5" value="${observ}"/>
    </div>
    <div>
      <g:submitToRemote action="addObsAjax" class="edit" value="Gravar observação" update="obsInc"/>
    </div>
  </g:form>

</div>
