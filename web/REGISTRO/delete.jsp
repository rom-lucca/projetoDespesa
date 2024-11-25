<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Deleta o registro pelo ID
    int despesaId = Integer.parseInt(request.getParameter("despesaId"));

    DespesaDAO despesaDAO = new DespesaDAO();
    try {
        despesaDAO.excluirDespesa(despesaId);
        out.println("<p class='success-message'>Despesa excluída com sucesso!</p>");
    } catch (SQLException e) {
        out.println("<p class='error-message'>Erro ao excluir despesa: " + e + "</p>");
    }
%>
<a href="./home.jsp" class="back-button">Voltar</a>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: 100vh;
        padding: 20px;
    }

    p {
        font-size: 18px;
        text-align: center;
    }

    .success-message {
        color: #27ae60;
        font-size: 18px;
        margin-top: 20px;
    }

    .error-message {
        color: #e74c3c;
        font-size: 18px;
        margin-top: 20px;
    }

    a {
        text-decoration: none;
        margin-top: 20px;
    }

    .back-button {
        background-color: #27ae60;
        color: #fff;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 20px;
        transition: background-color 0.3s ease;
    }

    .back-button:hover {
        background-color: #219150;
    }
</style>
