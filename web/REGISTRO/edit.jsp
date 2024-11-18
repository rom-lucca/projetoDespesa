<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="model.dao.CategoriaDAO" %>
<%@ page import="modelo.Despesa" %>
<%@ page import="modelo.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
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
                try {
                    // Obter todas as despesas e categorias
                    List<Despesa> despesas = despesaDAO.obterDespesasMes(userId);
                    List<Categoria> categorias = categoriaDAO.obterCategoriasPorUsuario(userId);

                    // Verificar se existem despesas e categorias
                    if (despesas != null && !despesas.isEmpty() && categorias != null && !categorias.isEmpty()) {
                        // Recuperar o ID da despesa a ser editada
                        String despesaIdStr = request.getParameter("despesaId");
                        Despesa despesaSelecionada = null;

                        // Procurar a despesa selecionada
                        if (despesaIdStr != null) {
                            int despesaId = Integer.parseInt(despesaIdStr);
                            for (Despesa despesa : despesas) {
                                if (despesa.getId() == despesaId) {
                                    despesaSelecionada = despesa;
                                    break;
                                }
                            }
                        }

                        // Verificar se encontrou a despesa
                        if (despesaSelecionada != null) {
    %>
                            <form action="update.jsp" method="post">
                                <input type="hidden" name="despesaId" value="<%= despesaSelecionada.getId() %>">
                                
                                <label for="novoNome">Novo Nome:</label>
                                <input type="text" name="novoNome" id="novoNome" value="<%= despesaSelecionada.getNome() %>" required>
                                <br><br>

                                <label for="novaCategoriaId">Nova Categoria:</label>
                                <select name="novaCategoriaId" id="novaCategoriaId" required>
                                    <% for (Categoria categoria : categorias) { %>
                                        <option value="<%= categoria.getId() %>" <%= categoria.getId() == despesaSelecionada.getId_categoria() ? "selected" : "" %>><%= categoria.getCategoria() %></option>
                                    <% } %>
                                </select>
                                <br><br>

                                <label for="novaDescricao">Nova Descrição:</label>
                                <textarea name="novaDescricao" id="novaDescricao" required><%= despesaSelecionada.getDescricao() %></textarea>
                                <br><br>

                                <label for="novoValor">Novo Valor:</label>
                                <input type="number" step="0.01" name="novoValor" id="novoValor" value="<%= despesaSelecionada.getValor() %>" required>
                                <br><br>

                                <button type="submit">Salvar Alterações</button>
                            </form>
    <%
                        } else {
                            out.println("<p>Despesa não encontrada.</p>");
                        }
                    } else {
                        out.println("<p>Não há despesas ou categorias cadastradas.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Erro ao buscar despesas ou categorias: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
    <a href="./home.jsp"><button>Voltar</button></a>
</body>
</html>
