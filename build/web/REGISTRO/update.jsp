<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    int despesaId = Integer.parseInt(request.getParameter("despesaId"));
    String novoNome = request.getParameter("novoNome");
    double novoValor = Double.parseDouble(request.getParameter("novoValor"));

    DespesaDAO despesaDAO = new DespesaDAO();
    try {
        despesaDAO.atualizarDespesa(despesaId, novoNome, novoValor);
        out.println("<p>Despesa atualizada com sucesso!</p>");
    } catch (SQLException e) {
        out.println("<p>Erro ao atualizar despesa: " + e + "</p>");
    }
%>
<a href="./home.jsp"><button>Voltar</button></a>
    