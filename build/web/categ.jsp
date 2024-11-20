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
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label, input {
            margin: 10px 0;
            font-size: 16px;
        }

        input[type="text"] {
            padding: 10px;
            width: 300px;
        }

        input[type="submit"], a {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }

        a {
            color: #000;
            text-decoration: none;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px 20px;
            display: inline-block;
            margin-top: 10px;
        }

        a:hover {
            background-color: #e0e0e0;
        }

        .categoria-lista {
            margin-top: 20px;
            list-style-type: none;
            padding: 0;
        }

        .categoria-lista li {
            padding: 5px 0;
        }
    </style>
</head>
<body>
    <h1>Nova Categoria</h1>

    <%
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            Integer userId = (Integer) sessao.getAttribute("userId");

            if (userId != null) {
                // Instancia os objetos DAO e lista de Categorias
                CategoriaDAO categoriaDAO = new CategoriaDAO();
                List<Categoria> categorias = categoriaDAO.obterCategoriasPorUsuario(userId);

                // Verifica se foi enviado um nome de categoria
                String categoriaNome = request.getParameter("categoriaNome");
                if (categoriaNome != null && !categoriaNome.isEmpty()) {
                    // Verifica se a categoria já existe
                    boolean categoriaExistente = false;
                    for (Categoria categoria : categorias) {
                        if (categoria.getCategoria().equalsIgnoreCase(categoriaNome)) {
                            categoriaExistente = true;
                            break;
                        }
                    }

                    if (!categoriaExistente) {
                        // Caso a categoria não exista, cria a nova categoria
                        Categoria novaCategoria = new Categoria();
                        novaCategoria.setCategoria(categoriaNome);
                        boolean sucesso = categoriaDAO.criarCategoria(novaCategoria, sessao);
                        
                        if (sucesso) {
                            out.println("<p>Categoria '" + categoriaNome + "' criada com sucesso!</p>");
                            categorias = categoriaDAO.obterCategoriasPorUsuario(userId); // Atualiza a lista de categorias
                        } else {
                            out.println("<p>Erro ao criar categoria. Tente novamente.</p>");
                        }
                    } else {
                        out.println("<p>Categoria já existe. Escolha outro nome.</p>");
                    }
                }
    %>

                <!-- Lista de categorias existentes -->
                <h2>Categorias já cadastradas:</h2>
                <ul class="categoria-lista">
                    <% for (Categoria categoria : categorias) { %>
                        <li><%= categoria.getCategoria() %></li>
                    <% } %>
                </ul>

                <!-- Formulário de cadastro -->
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
