<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.User"%>
<%@page import="model.dao.UserDAO"%>
<%@page import="javax.servlet.http.HttpSession"%> <!-- Importar a classe HttpSession -->

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
    </head>
    <body>
        <h1>Registro</h1>
        <%
            // Entrada                  
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String senha = request.getParameter("senha");            

            // Instância do objeto e atribuição de dados
            User usu = new User();
            usu.setNome(nome);
            usu.setCpf(cpf);
            usu.setSenha(senha);

            UserDAO usuDAO = new UserDAO();
            
            if (usuDAO.cpfExiste(cpf)){
                // Existe um CPF
                out.println("<script type='text/javascript'>");
                out.println("alert('CPF já cadastrado... Entre com sua senha.');");
                out.println("window.location.href = '../login.html';");
                out.println("</script>");
            } else {
                // Não existe CPF
                usuDAO.inserirUsuario(usu); // Insere o novo usuário no banco
                
                User registeredUser = usuDAO.getUserByCpf(cpf); // Recuperar o usuário recém-cadastrado com base no CPF
                session.setAttribute("userId", registeredUser.getId()); // Adicionar o ID do usuário na sessão

                out.println("<script type='text/javascript'>");
                out.println("window.location.href = './home.jsp';");
                out.println("</script>");
            }            
        %>
    </body>
</html>
