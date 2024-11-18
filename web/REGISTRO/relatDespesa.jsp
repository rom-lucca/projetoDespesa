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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1, h2 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        p {
            text-align: center;
            font-size: 18px;
            color: gray;
        }
    </style>
    <meta charset="UTF-8">
    <title>Relatório de Despesas</title>
</head>
<body>
    <h1>Relatório de Despesas</h1>
    <%
        // Obter a sessão do usuário
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            Integer userId = (Integer) sessao.getAttribute("userId");
            if (userId != null) {
                DespesaDAO despesaDAO = new DespesaDAO();
                CategoriaDAO categoriaDAO = new CategoriaDAO();
    %>
                <h2>Despesas do mês atual</h2>
                <%
                try {
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
                        out.println("<p>Você não possui despesas cadastradas neste mês.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Erro ao buscar despesas: " + e + "</p>");
                }
                %>

                <h2>Soma de valores por categoria</h2>
                <%
                try {
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
                        out.println("<p>Não há gastos por categoria neste mês.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Erro ao buscar soma por categoria: " + e + "</p>");
                }
                %>
    <%
            } else {
                out.println("<p>Usuário não autenticado. Por favor, faça login.</p>");
            }
        } else {
            out.println("<p>Sessão expirada. Por favor, faça login novamente.</p>");
        }
    %>
    <a href="./home.jsp"><button>Voltar</button></a>
</body>
</html>
