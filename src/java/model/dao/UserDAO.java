package model.dao;



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import modelo.User;
import util.Conecta;
import java.sql.*;
/**
 *
 * @author lukv7
 */

public class UserDAO {
    // Método para verificar se o CPF existe no banco de dados
    public boolean cpfExiste(String cpf) throws SQLException {
        String sql = "SELECT cpf FROM usu WHERE cpf = ?";
        boolean existe= false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, cpf);

            ResultSet rs = preparedStatement.executeQuery();
            existe = rs.next(); // Se existir um resultado, o CPF existe
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return existe;
    }

    // Método para autenticar a senha caso o CPF exista
    public boolean authenticaSenha(String cpf, String senha) throws SQLException {
        String sql = "SELECT senha FROM usu WHERE cpf = ? AND senha = ?";
        boolean existe = false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, cpf);
            preparedStatement.setString(2, senha);

            ResultSet rs = preparedStatement.executeQuery();
            existe = rs.next(); // Se existir um resultado, a senha está correta
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return existe;
    }
    
    //Método para inserir Usuário no banco
    public boolean inserirUsuario(User usu) throws SQLException {
        String sql = "INSERT INTO usu (cpf, nome, senha) VALUES (?, ?, ?)";
        boolean rowInserted = false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, usu.getCpf());
            preparedStatement.setString(2, usu.getNome());
            preparedStatement.setString(3, usu.getSenha());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return rowInserted;
    }
    
    //Método para puxar os dados do user do banco via CPF
    public User getUserByCpf(String cpf) throws SQLException {
    String sql = "SELECT * FROM usu WHERE cpf = ?";
    User user = null;

    try (Connection connection = Conecta.conecta();
         PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        
        preparedStatement.setString(1, cpf);
        ResultSet rs = preparedStatement.executeQuery();

        if (rs.next()) {
            user = new User();
            user.setId(rs.getInt("id"));
            user.setNome(rs.getString("nome"));
            user.setCpf(rs.getString("cpf"));
            user.setSenha(rs.getString("senha"));
        }
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
    return user;
}
}
