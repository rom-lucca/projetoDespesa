<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.CategoriaDAO" %>
<%@ page import="modelo.Categoria" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastrar Categoria</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        h1, h2 {
            color: #27ae60;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 1rem;
        }

        .categoria-lista {
            margin-top: 1.5rem;
            list-style-type: none;
            padding: 0;
            width: 100%;
            max-width: 400px;
        }

        .categoria-lista li {
            padding: 0.5rem;
            background-color: #fff;
            border: 1px solid #ddd;
            margin-bottom: 0.5rem;
            border-radius: 4px;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            max-width: 400px;
            margin-top: 2rem;
        }

        label {
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }

        input[type="text"] {
            width: 100%;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            padding: 0.8rem;
            font-size: 1rem;
            color: #fff;
            background-color: #27ae60;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #219150;
        }

        a {
            text-decoration: none;
            color: #fff;
            background-color: #555;
            padding: 0.8rem;
            border-radius: 4px;
            margin-top: 1rem;
            text-align: center;
            display: inline-block;
            width: 100%;
            max-width: 400px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <h1>Cadastrar Categoria</h1>

    <%
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            Integer userId = (Integer) sessao.getAttribute("userId");

            if (userId != null) {
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                List<Categoria> categorias = categoriaDAO.obterCategoriasPorUsuario(userId);

                String categoriaNome = request.getParameter("categoriaNome");
                if (categoriaNome != null && !categoriaNome.isEmpty()) {
                    boolean categoriaExistente = false;
                    for (Categoria categoria : categorias) {
                        if (categoria.getCategoria().equalsIgnoreCase(categoriaNome)) {
                            categoriaExistente = true;
                            break;
                        }
                    }

                    if (!categoriaExistente) {
                        Categoria novaCategoria = new Categoria();
                        novaCategoria.setCategoria(categoriaNome);
                        boolean sucesso = categoriaDAO.criarCategoria(novaCategoria, sessao);

                        if (sucesso) {
                            out.println("<p>Categoria '" + categoriaNome + "' criada com sucesso!</p>");
                            categorias = categoriaDAO.obterCategoriasPorUsuario(userId);
                        } else {
                            out.println("<p>Erro ao criar categoria. Tente novamente.</p>");
                        }
                    } else {
                        out.println("<p>Categoria já existe. Escolha outro nome.</p>");
                    }
                }
    %>
                <h2>Categorias já cadastradas:</h2>
                <ul class="categoria-lista">
                    <% for (Categoria categoria : categorias) { %>
                        <li><%= categoria.getCategoria() %></li>
                    <% } %>
                </ul>

                <form action="./REGISTRO/categoria.jsp" method="post">
                    <label for="categoriaNome">Nome da Categoria:</label>
                    <input type="text" id="categoriaNome" name="categoriaNome" required>
                    <input type="submit" value="Criar Categoria">
                </form>

                <a href="./REGISTRO/home.jsp">Voltar para o menu principal</a>
    <%
            } else {
                out.println("<p>Você precisa estar logado para acessar esta página.</p>");
            }
        } else {
            out.println("<p>Sessão não iniciada. Faça login.</p>");
        }
    %>
</body>
</html>
