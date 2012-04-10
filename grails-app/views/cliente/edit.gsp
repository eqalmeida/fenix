

<%@ page import="fenix.Cliente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${clienteInstance}">
            <div class="errors">
                <g:renderErrors bean="${clienteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${clienteInstance?.id}" />
                <g:hiddenField name="version" value="${clienteInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nome"><g:message code="cliente.nome.label" default="Nome" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'nome', 'errors')}">
                                    <g:textField name="nome" maxlength="100" value="${clienteInstance?.nome}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="rg"><g:message code="cliente.rg.label" default="Rg" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'rg', 'errors')}">
                                    <g:textField name="rg" maxlength="14" value="${clienteInstance?.rg}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cpf"><g:message code="cliente.cpf.label" default="Cpf" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'cpf', 'errors')}">
                                    <g:textField name="cpf" maxlength="16" value="${clienteInstance?.cpf}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="telefoneRes"><g:message code="cliente.telefoneRes.label" default="Telefone Res" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'telefoneRes', 'errors')}">
                                    <g:textField name="telefoneRes" maxlength="12" value="${clienteInstance?.telefoneRes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="telefoneCom"><g:message code="cliente.telefoneCom.label" default="Telefone Com" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'telefoneCom', 'errors')}">
                                    <g:textField name="telefoneCom" maxlength="12" value="${clienteInstance?.telefoneCom}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="telefoneCel"><g:message code="cliente.telefoneCel.label" default="Telefone Cel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'telefoneCel', 'errors')}">
                                    <g:textField name="telefoneCel" maxlength="12" value="${clienteInstance?.telefoneCel}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="cliente.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" maxlength="100" value="${clienteInstance?.email}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="fax"><g:message code="cliente.fax.label" default="Fax" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'fax', 'errors')}">
                                    <g:textField name="fax" maxlength="12" value="${clienteInstance?.fax}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="endereco"><g:message code="cliente.endereco.label" default="Endereco" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'endereco', 'errors')}">
                                    <g:textField name="endereco" maxlength="100" value="${clienteInstance?.endereco}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="cep"><g:message code="cliente.cep.label" default="Cep" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'cep', 'errors')}">
                                    <g:textField name="cep" maxlength="12" value="${clienteInstance?.cep}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bairro"><g:message code="cliente.bairro.label" default="Bairro" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'bairro', 'errors')}">
                                    <g:textField name="bairro" maxlength="100" value="${clienteInstance?.bairro}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="cidade"><g:message code="cliente.cidade.label" default="Cidade" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'cidade', 'errors')}">
                                    <g:textField name="cidade" maxlength="100" value="${clienteInstance?.cidade}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="estado"><g:message code="cliente.estado.label" default="Estado" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'estado', 'errors')}">
                                    <g:textField name="estado" maxlength="3" value="${clienteInstance?.estado}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="ptoReferencia"><g:message code="cliente.ptoReferencia.label" default="Pto Referencia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'ptoReferencia', 'errors')}">
                                    <g:textField name="ptoReferencia" maxlength="100" value="${clienteInstance?.ptoReferencia}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="residencia"><g:message code="cliente.residencia.label" default="Residencia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'residencia', 'errors')}">
                                    <g:select name="residencia" noSelection="['':'-Selecione-']" from="${clienteInstance.constraints.residencia.inList}" value="${clienteInstance?.residencia}" valueMessagePrefix="cliente.residencia"  />
                                </td>
                                <td valign="top" class="name">
                                  <label for="empresa"><g:message code="cliente.empresa.label" default="Empresa" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'empresa', 'errors')}">
                                    <g:textField name="empresa" maxlength="100" value="${clienteInstance?.empresa}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cargo"><g:message code="cliente.cargo.label" default="Cargo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'cargo', 'errors')}">
                                    <g:textField name="cargo" maxlength="50" value="${clienteInstance?.cargo}" />
                                </td>
                                <td valign="top" class="name">
                                  <label for="renda"><g:message code="cliente.renda.label" default="Renda" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'renda', 'errors')}">
                                    <g:textField name="renda" value="${fieldValue(bean: clienteInstance, field: 'renda')}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tempoServico"><g:message code="cliente.tempoServico.label" default="Tempo de Serviço" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'tempoServico', 'errors')}">
                                    <g:textField name="tempoServico" value="${clienteInstance?.tempoServico}" maxlength="12"  />
                                </td>
                                <td valign="top" class="name">
                                  <label for="webPage"><g:message code="cliente.webPage.label" default="Web Page" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: clienteInstance, field: 'webPage', 'errors')}">
                                    <g:textField name="webPage" maxlength="120" value="${clienteInstance?.webPage}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enderecoEmpresa"><g:message code="cliente.enderecoEmpresa.label" default="Endereco Empresa" /></label>
                                </td>
                                <td valign="top" colspan="3" class="value ${hasErrors(bean: clienteInstance, field: 'enderecoEmpresa', 'errors')}">
                                    <g:textArea name="enderecoEmpresa" cols="40" rows="5" value="${clienteInstance?.enderecoEmpresa}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="anotacoes"><g:message code="cliente.anotacoes.label" default="Anotacoes" /></label>
                                </td>
                                <td valign="top" colspan="3" class="value ${hasErrors(bean: clienteInstance, field: 'anotacoes', 'errors')}">
                                    <g:textArea name="anotacoes" cols="40" rows="5" value="${clienteInstance?.anotacoes}" />
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
