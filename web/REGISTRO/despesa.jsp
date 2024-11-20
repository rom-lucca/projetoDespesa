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
    <title>Cadastrar Despesa</title>
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

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label, input, select {
            margin: 10px 0;
            font-size: 16px;
        }
        
        textarea{
            padding: 10px;
            height: 80px;
            width: 300px;   
        }
        
        select{
            width:320px;
        }
        
        input[type="text"], input[type="number"]{
            padding: 10px;
            width: 300px;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        p {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <h1>Cadastrar Despesa</h1>
    <form action="cadastrarDespesa.jsp" method="post">
        <label for="nome">Nome da Despesa:</label>
        <input type="text" id="nome" name="nome" required><br>

        <label for="descricao">Descrição:</label>
        <textarea id="descricao" name="descricao" required></textarea><br>

        <label for="valor">Valor:</label>
        <input type="number" id="valor" name="valor" step="0.01" required><br>

        <label for="id_categoria">Categoria:</label>
        <select id="id_categoria" name="id_categoria" required>
            <%
                //dropdown com todas as categorias
                for (Categoria categoria : categorias) {
                    out.println("<option value=\"" + categoria.getId() + "\">" + categoria.getCategoria() + "</option>");
                }
            %>
        </select><br>

        <input type="submit" value="Cadastrar Despesa">
    </form>
</body>
</html>
