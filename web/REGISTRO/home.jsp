<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.CategoriaDAO" %>
<%@ page import="model.dao.DespesaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="modelo.User" %>
<%@ page import="modelo.Despesa" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        h1, h2 {
            text-align: center;
        }

        table {
            width: 80%;
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
        }
    </style>
    <meta charset="UTF-8">
    <title>Página Inicial</title>
</head>
<body>
    <h1>Bem-vindo!</h1>

    <a href="../categoria.html"><button>Cadastrar Categoria</button></a>

    <%
        // Obter a sessão do usuário
        HttpSession sessao = request.getSession(false);
        if (session != null) {
            // Obter o ID do usuário da sessão
            Integer userId = (Integer) sessao.getAttribute("userId");
            if (userId != null) {
                // Verificar se o usuário tem pelo menos uma categoria
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                DespesaDAO despesaDAO = new DespesaDAO();  // Criar uma instância do DAO
                boolean temCategorias = false;

                try {
                    temCategorias = categoriaDAO.usuarioTemCategorias(userId);
                } catch (SQLException e) {
                    out.println("Erro ao verificar categorias: " + e.getMessage());
                }

                // Exibir o botão de cadastrar despesa somente se o usuário tiver categorias
                if (temCategorias) {
    %>
                    <a href="./despesa.jsp"><button>Cadastrar Despesa</button></a>
    <%
                } else {
                    out.println("<p>Você precisa criar pelo menos uma categoria para cadastrar uma despesa.</p>");
                }
                
                            // Botão para visualizar despesas
    %>
                    <a href="./relatDespesa.jsp"><button>Visualizar Despesas</button></a>
                    <a href="./edit.jsp"><button>Editar Despesas</button></a>
                    <a href="./excluir.jsp"><button>Excluir Despesas</button></a>
    <%
            }
        }
    %>
</body>
</html>