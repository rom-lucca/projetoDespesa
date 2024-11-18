package util;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.sql.*;

/*
create table usu(
	id int auto_increment primary key,
    nome varchar(255) not null,
    cpf char(14) not null unique,
    senha varchar(30) not null
);
create table categoria(
	id int auto_increment primary key,
    categoria varchar(120) not null,
    id_user int not null
);

create table despesa(
	id int auto_increment primary key,
    nome varchar(255) not null,
    datad date not null,
    descricao text not null,
    valor double not null,
    id_categoria int not null,
    id_user int not null
);

ALTER TABLE categoria ADD constraint categoria_usu fOrEiGn kEy (id_user) references usu(id);
ALTER TABLE despesa ADD constraint despesa_usu fOrEiGn kEy (id_user) references usu(id);
ALTER TABLE despesa ADD constraint despesa_categoria fOrEiGn kEy (id_categoria) references categoria(id);
*/

/**
 *
 * @author lukv
 */
public class Conecta {
    public static Connection conecta() throws ClassNotFoundException{
        Connection conexao = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/projeto_despesas","root","");
            return conexao;
        }catch(SQLException ex){ 
            System.out.println("Error: " + ex);
        }                  
        return conexao;        
    }
}
