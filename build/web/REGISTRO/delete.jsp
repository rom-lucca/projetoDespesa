<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Deleta o registro pelo ID
    int despesaId = Integer.parseInt(request.getParameter("despesaId"));

    DespesaDAO despesaDAO = new DespesaDAO();
    try {
        despesaDAO.excluirDespesa(despesaId);
        out.println("<p>Despesa excluída com sucesso!</p>");
    } catch (SQLException e) {
        out.println("<p>Erro ao excluir despesa: " + e + "</p>");
    }
%>
<a href="./home.jsp"><button>Voltar</button></a>
