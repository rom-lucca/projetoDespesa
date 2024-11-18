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
        String SELECT_CPF_SQL = "SELECT cpf FROM usu WHERE cpf = ?";
        boolean existe= false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CPF_SQL)) {

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
        String SELECT_PASSWORD_SQL = "SELECT senha FROM usu WHERE cpf = ? AND senha = ?";
        boolean existe = false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PASSWORD_SQL)) {

            preparedStatement.setString(1, cpf);
            preparedStatement.setString(2, senha);

            ResultSet rs = preparedStatement.executeQuery();
            existe = rs.next(); // Se existir um resultado, a senha está correta
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return existe;
    }
    
    public boolean inserirUsuario(User usu) throws SQLException {
        String INSERT_USERS_SQL = "INSERT INTO usu (cpf, nome, senha) VALUES (?, ?, ?)";
        boolean rowInserted = false;

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {

            preparedStatement.setString(1, usu.getCpf());
            preparedStatement.setString(2, usu.getNome());
            preparedStatement.setString(3, usu.getSenha());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return rowInserted;
    }
    
    public User getUserByCpf(String cpf) throws SQLException {
    String SELECT_USER_BY_CPF_SQL = "SELECT * FROM usu WHERE cpf = ?";
    User user = null;

    try (Connection connection = Conecta.conecta();
         PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_CPF_SQL)) {
        
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
