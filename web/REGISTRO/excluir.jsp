<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="modelo.Despesa" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Excluir Despesa</title>
</head>
<body>
    <h1>Excluir Despesa</h1>
    <%
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            Integer userId = (Integer) sessao.getAttribute("userId");
            if (userId != null) {
                DespesaDAO despesaDAO = new DespesaDAO();
                try {
                    List<Despesa> despesas = despesaDAO.obterDespesasMes(userId);
                    if (despesas != null && !despesas.isEmpty()) {
    %>
                        <form action="delete.jsp" method="post">
                            <label for="despesaId">Selecione a despesa para excluir:</label>
                            <select name="despesaId" id="despesaId" required>
                                <% for (Despesa despesa : despesas) { %>
                                    <option value="<%= despesa.getId() %>"><%= despesa.getNome() %></option>
                                <% } %>
                            </select>
                            <br><br>
                            <button type="submit">Alterar</button>
                        </form>
    <%
                    } else {
                        out.println("<p>Não há despesas cadastradas.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Erro ao buscar despesas: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
    <a href="./home.jsp"><button>Voltar</button></a>
</body>
</html>
