Projeto Despesa
Este projeto é um sistema de controle de despesas desenvolvido em Java com integração ao banco de dados MySQL. O sistema permite que os usuários gerenciem suas despesas de forma eficiente, com funcionalidades que incluem autenticação de usuários, cadastro e visualização de despesas.

🛠️ Tecnologias Utilizadas
Java: Backend do sistema.
MySQL: Banco de dados para armazenar informações de usuários e despesas.
JDBC: Para conexão e manipulação do banco de dados.
JSP: Para desenvolvimento da interface web.
HTML/CSS: Para estilização básica do frontend.
📋 Funcionalidades
Autenticação de Usuários: Login e validação com CPF e senha.
Cadastro de Despesas: Inserção de novos registros de despesas vinculados a um usuário.
Listagem de Despesas: Exibição das despesas cadastradas por usuário.
Validação de Sessão: Utilização de HttpSession para identificar e manter o usuário logado.
🚀 Como Executar o Projeto
Pré-requisitos
Certifique-se de ter instalado:

Java JDK (versão 11 ou superior).
MySQL (configurado e rodando).
IDE Java (como IntelliJ IDEA ou Eclipse).
Servidor Web (como Apache Tomcat).
Passos
Clone o Repositório

bash
Copiar código
git clone https://github.com/rom-lucca/projetoDespesa.git
Navegue até o diretório do projeto:

bash
Copiar código
cd projetoDespesa
Configure o Banco de Dados

Importe o script SQL localizado em src/main/resources/database.sql para criar as tabelas no banco de dados.
Configure as credenciais de conexão no arquivo DatabaseConnection.java.
Compile e Execute o Projeto

Importe o projeto para sua IDE.
Configure o Apache Tomcat como servidor de aplicação.
Compile e execute o projeto.
Acesse o Sistema Abra o navegador e acesse:

bash
Copiar código
http://localhost:8080/projetoDespesa
🗂 Estrutura do Projeto
src/: Código-fonte do projeto.
dao/: Classes de acesso ao banco de dados (ex.: DespesaDAO).
model/: Classes de modelo (ex.: Despesa e Usuario).
controller/: Lógica para gerenciar requisições do usuário.
web/: Páginas JSP e recursos estáticos (HTML/CSS).
