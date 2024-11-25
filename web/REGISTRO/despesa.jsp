<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Despesa"%>
<%@ page import="model.dao.DespesaDAO"%>
<%@ page import="model.dao.CategoriaDAO"%>
<%@ page import="modelo.Categoria"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    HttpSession sessao = request.getSession();
    int userId = (int) sessao.getAttribute("userId");
    
    // Instanciar DAO para categorias e obter categorias do usuário
    CategoriaDAO categoriaDAO = new CategoriaDAO();
    List<Categoria> categorias = categoriaDAO.obterCategoriasPorUsuario(userId);
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Despesa</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 2rem;
            text-align: center;
        }

        h1 {
            color: #34495e;
            margin-bottom: 1.5rem;
        }

        form {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #555;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        input[type="submit"] {
            background-color: #27ae60;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #219150;
        }

        textarea {
            resize: none;
        }

        p {
            color: red;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <h1>Cadastrar Despesa</h1>
    <form action="cadastrarDespesa.jsp" method="post">
        <label for="nome">Nome da Despesa:</label>
        <input type="text" id="nome" name="nome" placeholder="Ex.: Conta de luz" required>

        <label for="descricao">Descrição:</label>
        <textarea id="descricao" name="descricao" placeholder="Ex.: Despesa mensal de eletricidade" required></textarea>

        <label for="valor">Valor:</label>
        <input type="number" id="valor" name="valor" step="0.01" placeholder="Ex.: 150.00" required>

        <label for="id_categoria">Categoria:</label>
        <select id="id_categoria" name="id_categoria" required>
            <%
                // Preencher o dropdown com as categorias do usuário
                for (Categoria categoria : categorias) {
                    out.println("<option value=\"" + categoria.getId() + "\">" + categoria.getCategoria() + "</option>");
                }
            %>
        </select>

        <input type="submit" value="Cadastrar Despesa">
    </form>
</body>
</html>
