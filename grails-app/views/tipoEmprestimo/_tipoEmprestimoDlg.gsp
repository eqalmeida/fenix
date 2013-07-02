<div class="dialog">
    <table>
        <tbody>
        
            <tr class="prop">
                <td valign="top" class="name">
                  <label for="nome"><g:message code="tipoEmprestimo.nome.label" default="Nome" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'nome', 'errors')}">
                    <g:textField name="nome" maxlength="30" value="${tipoEmprestimoInstance?.nome}" />
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                  <label for="taxaJurosAtraso"><g:message code="tipoEmprestimo.taxaJurosAtraso.label" default="taxaJurosAtraso" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'taxaJurosAtraso', 'errors')}">
                    <g:textField name="taxaJurosAtraso" value="${fieldValue(bean: tipoEmprestimoInstance, field: 'taxaJurosAtraso')}" />
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                  <label for="multaAtraso"><g:message code="tipoEmprestimo.multaAtraso.label" default="Multa Atraso" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'multaAtraso', 'errors')}">
                    <g:textField name="multaAtraso" value="${fieldValue(bean: tipoEmprestimoInstance, field: 'multaAtraso')}" />
                </td>
            </tr>

        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="multaAtrasoPercent"><g:message code="tipoEmprestimo.multaAtrasoPercent.label" default="Multa Atraso % " /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'multaAtrasoPercent', 'errors')}">
                    <g:textField name="multaAtrasoPercent" value="${fieldValue(bean: tipoEmprestimoInstance, field: 'multaAtrasoPercent')}" />
                </td>
            </tr>
        
        
            <tr class="prop">
                <td valign="top" class="name">
                  <label for="ativo"><g:message code="tipoEmprestimo.ativo.label" default="Ativo" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: tipoEmprestimoInstance, field: 'ativo', 'errors')}">
                    <g:checkBox name="ativo" value="${tipoEmprestimoInstance?.ativo}" />
                </td>
            </tr>
                                
        </tbody>
    </table>
</div>
