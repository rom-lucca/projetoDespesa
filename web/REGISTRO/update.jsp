<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Valores preenchidos ou valores antigos para os que não foram alterados
    int despesaId = Integer.parseInt(request.getParameter("despesaId"));
    String novoNome = request.getParameter("novoNome");
    double novoValor = Double.parseDouble(request.getParameter("novoValor"));
    String novaDescricao = request.getParameter("novaDescricao");
    int novaCategoriaId = Integer.parseInt(request.getParameter("novaCategoriaId"));

    DespesaDAO despesaDAO = new DespesaDAO();
    try {
        despesaDAO.atualizarDespesa(despesaId, novoNome, novaCategoriaId, novaDescricao, novoValor);
        out.println("<p>Despesa atualizada com sucesso!</p>");
        response.sendRedirect("relatDespesa.jsp");
    } catch (SQLException e) {
        out.println("<p>Erro ao atualizar despesa: " + e + "</p>");
    }
%>
<a href="./editarDespesa.jsp"><button>Voltar</button></a>
