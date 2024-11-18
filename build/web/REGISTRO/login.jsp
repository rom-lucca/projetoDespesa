<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.User"%>
<%@page import="model.dao.UserDAO"%>
<%@page import="javax.servlet.http.HttpSession"%> <!-- Importar a classe HttpSession -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login</title>
    </head>
    <body>
        <h1>Login</h1>
        <%
            // Entrada                  
            String cpf = request.getParameter("cpf");
            String senha = request.getParameter("senha");            

            // Instância do objeto e atribuição de dados
            User usu = new User();
            usu.setCpf(cpf);
            usu.setSenha(senha);
            
            UserDAO usuDAO = new UserDAO();
            
            if (usuDAO.cpfExiste(cpf)){
                // CPF existe
                if (usuDAO.authenticaSenha(cpf, senha)){
                    // Senha está correta
                    User loggedUser = usuDAO.getUserByCpf(cpf); // Recuperar o usuário com base no CPF
                    session.setAttribute("userId", loggedUser.getId()); // Adicionar o ID do usuário na sessão

                    out.println("<script type='text/javascript'>");
                    out.println("window.location.href = './home.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Ops... Usuário ou Senha incorretos, realize o cadastro novamente.');");
                    out.println("window.location.href = '../login.html';");
                    out.println("</script>");
                }
            } else {
                // Não existe
                out.println("<script type='text/javascript'>");
                out.println("alert('Ops... Usuário não encontrado, realize o registro.');");
                out.println("window.location.href = '../index.html';");
                out.println("</script>");
            }            
        %>
    </body>
</html>
