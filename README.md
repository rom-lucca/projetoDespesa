## **Projeto Despesa**!

📊 Sistema para gerenciamento de despesas desenvolvido em **Java** e integrado ao banco de dados **MySQL**. <br>  
🌐 Tecnologias usadas: Java, JSP, JDBC, MySQL, Apache Tomcat.  

---

## 💻 Tecnologias Utilizadas
<div style="display: inline-block"><br>

### FrontEnd e FrameWorks  
> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width="5%"/>
> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" width="5%"/>
> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apache/apache-original-wordmark.svg" width="5%")

### BackEnd e Frameworks
![Java](https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg)  
![JSP](https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg)  
![MySQL](https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.svg)  

---

## 📋 Funcionalidades

- **Autenticação de Usuários**: Login e validação com CPF e senha.
- **Cadastro de Despesas**: Inserção de novos registros de despesas vinculados a um usuário.
- **Listagem de Despesas**: Exibição das despesas cadastradas por usuário.
- **Validação de Sessão**: Utilização de `HttpSession` para identificar e manter o usuário logado.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

Certifique-se de ter instalado:

- [Java JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) (versão 11 ou superior).
- [MySQL](https://dev.mysql.com/downloads/mysql/) (configurado e rodando).
- IDE Java (como [IntelliJ IDEA](https://www.jetbrains.com/idea/) ou [Eclipse](https://www.eclipse.org/downloads/)).
- Servidor Web (como [Apache Tomcat](https://tomcat.apache.org/)).

### Passos

1. **Clone o Repositório**
    ```bash
    git clone https://github.com/rom-lucca/projetoDespesa.git
    ```
    Navegue até o diretório do projeto:
    ```bash
    cd projetoDespesa
    ```

2. **Configure o Banco de Dados**
    - Importe o script SQL localizado em `src/main/resources/database.sql` para criar as tabelas no banco de dados.
    - Configure as credenciais de conexão no arquivo `DatabaseConnection.java`.

3. **Compile e Execute o Projeto**
    - Importe o projeto para sua IDE.
    - Configure o Apache Tomcat como servidor de aplicação.
    - Compile e execute o projeto.

4. **Acesse o Sistema**
    Abra o navegador e acesse:
    ```
    http://localhost:8080/projetoDespesa
    ```

---

## 🗂 Estrutura do Projeto

- `src/`: Código-fonte do projeto.
  - `dao/`: Classes de acesso ao banco de dados (ex.: `DespesaDAO`).
  - `model/`: Classes de modelo (ex.: `Despesa` e `Usuario`).
  - `controller/`: Lógica para gerenciar requisições do usuário.
- `web/`: Páginas JSP e recursos estáticos (HTML/CSS).

---

## 📄 Licença

Este projeto é licenciado sob os termos da [MIT License](LICENSE).
