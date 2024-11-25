> ##Projeto Despesa</h1>
    <p>Este projeto é um sistema de controle de despesas desenvolvido em <strong>Java</strong> com integração ao banco de dados <strong>MySQL</strong>. O sistema permite que os usuários gerenciem suas despesas de forma eficiente, com funcionalidades que incluem autenticação de usuários, cadastro e visualização de despesas.</p>

    <h2>🛠️ Tecnologias Utilizadas</h2>
    <ul>
        <li><strong>Java</strong>: Backend do sistema.</li>
        <li><strong>MySQL</strong>: Banco de dados para armazenar informações de usuários e despesas.</li>
        <li><strong>JDBC</strong>: Para conexão e manipulação do banco de dados.</li>
        <li><strong>JSP</strong>: Para desenvolvimento da interface web.</li>
        <li><strong>HTML/CSS</strong>: Para estilização básica do frontend.</li>
    </ul>

    <h2>📋 Funcionalidades</h2>
    <ul>
        <li><strong>Autenticação de Usuários</strong>: Login e validação com CPF e senha.</li>
        <li><strong>Cadastro de Despesas</strong>: Inserção de novos registros de despesas vinculados a um usuário.</li>
        <li><strong>Listagem de Despesas</strong>: Exibição das despesas cadastradas por usuário.</li>
        <li><strong>Validação de Sessão</strong>: Utilização de <code>HttpSession</code> para identificar e manter o usuário logado.</li>
    </ul>

    <h2>🚀 Como Executar o Projeto</h2>
    <h3>Pré-requisitos</h3>
    <p>Certifique-se de ter instalado:</p>
    <ul>
        <li><a href="https://www.oracle.com/java/technologies/javase-jdk11-downloads.html" target="_blank">Java JDK</a> (versão 11 ou superior).</li>
        <li><a href="https://dev.mysql.com/downloads/mysql/" target="_blank">MySQL</a> (configurado e rodando).</li>
        <li>IDE Java (como <a href="https://www.jetbrains.com/idea/" target="_blank">IntelliJ IDEA</a> ou <a href="https://www.eclipse.org/downloads/" target="_blank">Eclipse</a>).</li>
        <li>Servidor Web (como <a href="https://tomcat.apache.org/" target="_blank">Apache Tomcat</a>).</li>
    </ul>

    <h3>Passos</h3>
    <ol>
        <li><strong>Clone o Repositório</strong>
            <pre><code>git clone https://github.com/rom-lucca/projetoDespesa.git</code></pre>
            Navegue até o diretório do projeto:
            <pre><code>cd projetoDespesa</code></pre>
        </li>
        <li><strong>Configure o Banco de Dados</strong>
            <p>Importe o script SQL localizado em <code>src/main/resources/database.sql</code> para criar as tabelas no banco de dados. Configure as credenciais de conexão no arquivo <code>DatabaseConnection.java</code>.</p>
        </li>
        <li><strong>Compile e Execute o Projeto</strong>
            <p>Importe o projeto para sua IDE. Configure o Apache Tomcat como servidor de aplicação. Compile e execute o projeto.</p>
        </li>
        <li><strong>Acesse o Sistema</strong>
            <p>Abra o navegador e acesse:</p>
            <pre><code>http://localhost:8080/projetoDespesa</code></pre>
        </li>
    </ol>

    <h2>🗂 Estrutura do Projeto</h2>
    <ul>
        <li><code>src/</code>: Código-fonte do projeto.
            <ul>
                <li><code>dao/</code>: Classes de acesso ao banco de dados (ex.: <code>DespesaDAO</code>).</li>
                <li><code>model/</code>: Classes de modelo (ex.: <code>Despesa</code> e <code>Usuario</code>).</li>
                <li><code>controller/</code>: Lógica para gerenciar requisições do usuário.</li>
            </ul>
        </li>
        <li><code>web/</code>: Páginas JSP e recursos estáticos (HTML/CSS).</li>
    </ul>
