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

        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        label {
            font-size: 16px;
            margin-bottom: 5px;
            display: block;
            color: #2c3e50;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            background-color: #ecf0f1;
        }

        button {
            background-color: #e74c3c;
            color: #fff;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #c0392b;
        }

        .message {
            text-align: center;
            font-size: 18px;
            color: #e74c3c;
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
                            <button type="submit">Excluir</button>
                        </form>
    <%
                    } else {
                        out.println("<p class='message'>Não há despesas cadastradas.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='message'>Erro ao buscar despesas: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
    <a href="./home.jsp" class="back-button">Voltar</a>
</body>
</html>
