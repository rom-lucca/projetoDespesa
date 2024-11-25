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
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            padding: 2rem;
        }

        h1 {
            font-size: 2rem;
            color: #27ae60;
            margin-bottom: 1rem;
            text-align: center;
        }

        p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 1.5rem;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            width: 100%;
            max-width: 300px;
        }

        a {
            text-decoration: none;
            display: flex;
        }

        button {
            padding: 0.8rem;
            margin: 10px;
            font-size: 1rem;
            color: #fff;
            background-color: #27ae60;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            min-width:300px; 
            text-align: center;
        }

        button:hover {
            background-color: #219150;
        }
    </style>
    <meta charset="UTF-8">
    <title>Página Inicial</title>
</head>
<body>
    <h1>Bem-vindo!</h1>

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
                
                            // Botão para visualizar, editar e excluir despesas
    %>
                    <a href="../categ.jsp"><button>Cadastrar Categoria</button></a>
                    <a href="./relatDespesa.jsp"><button>Visualizar Despesas</button></a>
                    <a href="./edit.jsp"><button>Editar Despesas</button></a>
                    <a href="./excluir.jsp"><button>Excluir Despesas</button></a>
    <%
            }
        }
    %>
</body>
</html>