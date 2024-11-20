<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Despesa"%>
<%@ page import="model.dao.DespesaDAO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Confere se a sessão do cliente está ativa
    HttpSession sessao = request.getSession();
    int userId = (int) sessao.getAttribute("userId");

    // Criação do objeto Despesa
    Despesa despesa = new Despesa();
    despesa.setNome(request.getParameter("nome"));
    despesa.setDescricao(request.getParameter("descricao"));
    despesa.setValor(Double.parseDouble(request.getParameter("valor")));
    despesa.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
    despesa.setId_user(userId); // Define o ID do usuário a partir da sessão

    DespesaDAO despesaDAO = new DespesaDAO();

    try {
        boolean sucesso = despesaDAO.criarDespesa(despesa, session);

        if (sucesso) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Despesa cadastrada com sucesso!');");
            out.println("window.location.href = './home.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Erro ao cadastrar despesa.');");
            out.println("window.history.back();");
            out.println("</script>");
        }
    } catch (SQLException e) {
        out.println("<script type='text/javascript'>");
        out.println("alert('Erro ao cadastrar despesa: " + e.getMessage() + "');");
        out.println("window.history.back();");
        out.println("</script>");
    }
%>
