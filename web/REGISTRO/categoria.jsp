
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.dao.CategoriaDAO"%>
<%@page import="modelo.Categoria"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

        h1 {
            text-align: center;
        }

        p, a {
            font-size: 18px;
            margin: 10px 0;
            text-align: center;
        }

        a {
            color: #000;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        a:hover {
            background-color: #e0e0e0;
        }
    </style>
    </head>
    <body>
        <h1>Categoria criada com sucesso</h1>
        <%
        // Instancia de objeto
        Categoria categoria = new Categoria();
        categoria.setCategoria(request.getParameter("categoriaNome")); // Pega o nome da categoria do formulário

        CategoriaDAO categoriaDAO = new CategoriaDAO();
        boolean sucesso = categoriaDAO.criarCategoria(categoria, request.getSession());

        if (sucesso) {
            out.println("Categoria " + request.getParameter("categoriaNome")+ " foi criada com sucesso!");
            out.println("<a href='home.jsp'>Voltar ao menu</a>");
        } else {
            out.println("Erro ao criar categoria.");
        }

        %>
    </body>
</html>
