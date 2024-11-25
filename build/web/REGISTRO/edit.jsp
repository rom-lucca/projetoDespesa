<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="model.dao.CategoriaDAO" %>
<%@ page import="modelo.Despesa" %>
<%@ page import="modelo.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Despesa</title>
</head>
<body>
    <h1>Editar Despesa</h1>
    <%
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            Integer userId = (Integer) sessao.getAttribute("userId");
            if (userId != null) {
                DespesaDAO despesaDAO = new DespesaDAO();
                CategoriaDAO categoriaDAO = new CategoriaDAO();

                List<Despesa> despesas = despesaDAO.obterDespesasMes(userId);
                List<Categoria> categorias = categoriaDAO.obterCategoriasPorUsuario(userId);

                if (despesas != null && !despesas.isEmpty()) {
                    Despesa despesaSelecionada = null;
                    String despesaIdStr = request.getParameter("despesaId");

                    if (despesaIdStr != null && !despesaIdStr.isEmpty()) {
                        try {
                            int despesaId = Integer.parseInt(despesaIdStr);
                            despesaSelecionada = despesaDAO.getDespesa(despesaId); // Busca a despesa selecionada
                        } catch (NumberFormatException e) {
                            out.println("<p>ID de despesa inválido.</p>");
                        }
                    }
    %>

                    <!-- Dropdown de seleção -->
                    <form method="get">
                        <label for="despesa">Escolha uma despesa:</label>
                        <select name="despesaId" id="despesa" onchange="this.form.submit()">
                            <option value="">Selecione...</option>
                            <% for (Despesa despesa : despesas) { %>
                                <option value="<%= despesa.getId() %>" 
                                    <%= (despesaSelecionada != null && despesa.getId() == despesaSelecionada.getId()) ? "selected" : "" %>>
                                    <%= despesa.getNome() %>
                                </option>
                            <% } %>
                        </select>
                    </form>

                    <!-- Formulário de edição -->
                    <% if (despesaSelecionada != null) { %>
                        <form action="update.jsp" method="post">
                            <input type="hidden" name="despesaId" value="<%= despesaSelecionada.getId() %>">

                            <label for="novoNome">Novo Nome:</label>
                            <input type="text" name="novoNome" id="novoNome" 
                                value="<%= despesaSelecionada.getNome() %>">
                            <br><br>

                            <label for="novaCategoriaId">Nova Categoria:</label>
                            <select name="novaCategoriaId" id="novaCategoriaId">
                                <% for (Categoria categoria : categorias) { %>
                                    <option value="<%= categoria.getId() %>" 
                                        <%= (categoria.getId() == despesaSelecionada.getId_categoria()) ? "selected" : "" %>>
                                        <%= categoria.getCategoria() %>
                                    </option>
                                <% } %>
                            </select>
                            <br><br>

                            <label for="novaDescricao">Nova Descrição:</label>
                            <textarea name="novaDescricao" id="novaDescricao"><%= despesaSelecionada.getDescricao() %></textarea>
                            <br><br>

                            <label for="novoValor">Novo Valor:</label>
                            <input type="number" step="0.01" name="novoValor" id="novoValor" 
                                value="<%= despesaSelecionada.getValor() %>">
                            <br><br>

                            <button type="submit">Salvar Alterações</button>
                        </form>
                    <% } else { %>
                        <p>Selecione uma despesa para editar.</p>
                    <% } %>
                <% } else { %>
                    <p>Não há despesas cadastradas.</p>
                <% } %>
    <%      } else { %>
                <p>Você precisa estar logado para acessar esta página.</p>
    <%      } %>
        <% } else { %>
            <p>Sessão não iniciada. Faça login.</p>
        <% } %>
    <a href="./home.jsp"><button>Voltar</button></a>
</body>
</html>
