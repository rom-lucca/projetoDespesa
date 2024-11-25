<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.dao.CategoriaDAO"%>
<%@page import="modelo.Categoria"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categoria Criada</title>
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
            justify-content: center;
            height: 100vh;
            text-align: center;
            padding: 2rem;
        }

        h1 {
            color: #27ae60;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 1.5rem;
        }

        a {
            text-decoration: none;
            color: #fff;
            background-color: #27ae60;
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #219150;
        }
    </style>
</head>
<body>
    <%
        // Instancia o objeto Categoria e pega o nome da categoria do formulário
        Categoria categoria = new Categoria();
        categoria.setCategoria(request.getParameter("categoriaNome"));

        // Instancia o DAO e tenta criar a categoria
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        boolean sucesso = categoriaDAO.criarCategoria(categoria, request.getSession());

        if (sucesso) {
    %>
        <h1>Categoria criada com sucesso!</h1>
        <p>A categoria <strong><%= request.getParameter("categoriaNome") %></strong> foi adicionada ao sistema.</p>
        <a href="home.jsp">Voltar ao Menu Principal</a>
    <%
        } else {
    %>
        <h1>Erro ao criar categoria</h1>
        <p>Ocorreu um problema ao tentar criar a categoria. Por favor, tente novamente.</p>
        <a href="home.jsp">Voltar ao Menu Principal</a>
    <%
        }
    %>
</body>
</html>
