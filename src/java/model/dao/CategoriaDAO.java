package model.dao;

import modelo.Categoria;
import util.Conecta;
import java.sql.*;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;


public class CategoriaDAO {

    public boolean criarCategoria(Categoria categoria, HttpSession session) throws SQLException {
        String INSERT_CATEGORIA_SQL = "INSERT INTO categoria (categoria, id_user) VALUES (?, ?)";

        int userId = (int) session.getAttribute("userId");

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORIA_SQL)) {

            preparedStatement.setString(1, categoria.getCategoria());
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir categoria", e);
        }
    }
    
public boolean usuarioTemCategorias(int userId) throws SQLException {
    String SQL_COUNT_CATEGORIAS = "SELECT COUNT(*) FROM categoria WHERE id_user = ?";

    try (Connection connection = Conecta.conecta();
         PreparedStatement preparedStatement = connection.prepareStatement(SQL_COUNT_CATEGORIAS)) {

        preparedStatement.setInt(1, userId);

        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        }
    } catch (ClassNotFoundException e) {
        throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
    }

    return false;  // Retorna false se não encontrar nenhuma categoria
    }
    
    public List<Categoria> obterCategoriasPorUsuario(int userId) throws SQLException {
    String SELECT_CATEGORIA_SQL = "SELECT id, categoria FROM categoria WHERE id_user = ?";
    List<Categoria> categorias = new ArrayList<>();

    try (Connection connection = Conecta.conecta();
         PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CATEGORIA_SQL)) {

        preparedStatement.setInt(1, userId);
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            Categoria categoria = new Categoria();
            categoria.setId(rs.getInt("id"));
            categoria.setCategoria(rs.getString("categoria"));
            categorias.add(categoria);
        }
    } catch (ClassNotFoundException e) {
        throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
    }

    return categorias;
}

}
