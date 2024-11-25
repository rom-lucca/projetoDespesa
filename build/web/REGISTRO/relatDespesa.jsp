<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.CategoriaDAO" %>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="modelo.Despesa" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatório de Despesas</title>
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

    h1, h2 {
        color: #2c3e50;
        margin-bottom: 1rem;
    }

    table {
        width: 85%;
        border-collapse: collapse;
        margin: 20px 0;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    table, th, td {
        border: 1px solid black;
    }

    th, td {
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #27ae60;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #ecf0f1;
    }

    button {
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

    button:hover {
        background-color: #219150;
    }

    p {
        text-align: center;
        font-size: 18px;
        color: #7f8c8d;
    }

    .no-data {
        font-size: 18px;
        color: #e74c3c;
        text-align: center;
    }
</style>


</head>
<body>
    <h1>Relatório de Despesas</h1>
    <%
        // Obter a sessão do usuário
        HttpSession sessao = request.getSession(false);
        // Se a sessão estiver ativa
        if (sessao != null) {
            //Puxa o userId da sessao
            Integer userId = (Integer) sessao.getAttribute("userId");
            // Se tiver userId
            if (userId != null) {
    %>
                <h2>Despesas do mês atual</h2>
                <%
                try {
                    DespesaDAO despesaDAO = new DespesaDAO();
                    List<Despesa> despesasMes = despesaDAO.obterDespesasMes(userId);
                    if (despesasMes != null && !despesasMes.isEmpty()) {
                %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Descrição</th>
                                    <th>Valor</th>
                                    <th>Data</th>
                                    <th>Categoria</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for (Despesa despesa : despesasMes) {
                                %>
                                    <tr>
                                        <td><%= despesa.getNome() %></td>
                                        <td><%= despesa.getDescricao() %></td>
                                        <td>R$ <%= String.format("%.2f", despesa.getValor()) %></td>
                                        <td><%= despesa.getData() %></td>
                                        <td><%= despesa.getId_categoria() %></td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                <%
                    } else {
                        out.println("<p class='no-data'>Você não possui despesas cadastradas neste mês.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='no-data'>Erro ao buscar despesas: " + e + "</p>");
                }
                %>

                <h2>Soma de valores por categoria</h2>
                <%
                try {
                    DespesaDAO despesaDAO = new DespesaDAO();
                    List<Object[]> somaPorCategoria = despesaDAO.obterSomaPorCategoria(userId);
                    if (somaPorCategoria != null && !somaPorCategoria.isEmpty()) {
                %>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID Categoria</th>
                                    <th>Categoria</th>
                                    <th>Total Gasto</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for (Object[] categoriaSoma : somaPorCategoria) {
                                %>
                                    <tr>
                                        <td><%= categoriaSoma[0] %></td>
                                        <td><%= categoriaSoma[1] %></td>
                                        <td>R$ <%= String.format("%.2f", categoriaSoma[2]) %></td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                <%
                    } else {
                        out.println("<p class='no-data'>Não há gastos por categoria neste mês.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='no-data'>Erro ao buscar soma por categoria: " + e + "</p>");
                }
                %>
    <%
            } else {
                out.println("<p class='no-data'>Usuário não autenticado. Por favor, faça login.</p>");
            }
        } else {
            out.println("<p class='no-data'>Sessão expirada. Por favor, faça login novamente.</p>");
        }
    %>

    <a href="./home.jsp"><button>Voltar</button></a>
</body>
</html>
