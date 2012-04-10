
<%@ page import="fenix.Cliente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Detalhes do Cliente Cód: ${fieldValue(bean: clienteInstance, field: "id")}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.nome.label" default="Nome" /></td>
                            
                            <td valign="top" colspan="3" class="value" nowrap="true">${fieldValue(bean: clienteInstance, field: "nome")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.rg.label" default="Rg" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "rg")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.cpf.label" default="Cpf" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "cpf")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.telefoneRes.label" default="Telefone Res" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "telefoneRes")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.telefoneCom.label" default="Telefone Com" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "telefoneCom")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.telefoneCel.label" default="Telefone Cel" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "telefoneCel")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.fax.label" default="Fax" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "fax")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.endereco.label" default="Endereco" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "endereco")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.cep.label" default="Cep" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "cep")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.bairro.label" default="Bairro" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "bairro")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.cidade.label" default="Cidade" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "cidade")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.estado.label" default="Estado" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "estado")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.ptoReferencia.label" default="Pto Referencia" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "ptoReferencia")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.residencia.label" default="Residencia" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "residencia")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.empresa.label" default="Empresa" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "empresa")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.cargo.label" default="Cargo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "cargo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.enderecoEmpresa.label" default="Endereco Empresa" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "enderecoEmpresa")}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.renda.label" default="Renda" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "renda")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.tempoServico.label" default="Tempo de Serviço" /></td>
                            
                            <td valign="top" class="value">${clienteInstance?.tempoServico}</td>
                            
                            <td valign="top" class="name"><g:message code="cliente.webPage.label" default="Web Page" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: clienteInstance, field: "webPage")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cliente.anotacoes.label" default="Anotacoes" /></td>

                            <td valign="top" colspan="3" class="value">${fieldValue(bean: clienteInstance, field: "anotacoes")}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${clienteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <span class="button"><g:link controller="emprestimo" action="create" params="['cliente.id':clienteInstance.id]">Nova Transação</g:link></span>
                </g:form>
            </div>

            <g:if test="${clienteInstance.emprestimos}">

            <h1>Transações do Cliente</h1>
            <div class="list">
                <table>
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="${message(code: 'emprestimo.id.label', default: 'Id')}" />

                            <th><g:message code="emprestimo.cliente.data" default="Data" /></th>

                            <th><g:message code="emprestimo.tipoEmprestimo.label" default="Tipo Emprestimo" /></th>

                            <th><g:message code="emprestimo.especie.label" default="Especie" /></th>

                            <th><g:message code="emprestimo.plano.label" default="Plano" /></th>

                            <th><g:message code="emprestimo.status.label" default="Status" /></th>

                            <g:sortableColumn property="valorLiberado" title="${message(code: 'emprestimo.valorLiberado.label', default: 'Valor Liberado')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${clienteInstance.emprestimos}" status="i" var="emprestimoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link controller="emprestimo" action="show" id="${emprestimoInstance.id}">${fieldValue(bean: emprestimoInstance, field: "id")}</g:link></td>

                            <td> <g:formatDate date="${emprestimoInstance.data}"/> </td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "tipoEmprestimo")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "especie")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "plano")}</td>

                            <td>${fieldValue(bean: emprestimoInstance, field: "statusStr")}</td>

                            <td><g:formatNumber number="${emprestimoInstance.valorLiberado}" type="currency" currencyCode="BRL" /></td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
<br />
            </g:if>
        </div>
    </body>
</html>
