package model.dao;

import modelo.Despesa;
import util.Conecta;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;

public class DespesaDAO {
    //Método para criar despesa
    public boolean criarDespesa(Despesa despesa, HttpSession session) throws SQLException {
        String sql = "INSERT INTO despesa (nome, datad, descricao, valor, id_categoria, id_user) VALUES (?, CURRENT_DATE, ?, ?, ?, ?)";

        int userId = (int) session.getAttribute("userId");

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, despesa.getNome());
            preparedStatement.setString(2, despesa.getDescricao());
            preparedStatement.setDouble(3, despesa.getValor());
            preparedStatement.setInt(4, despesa.getId_categoria());
            preparedStatement.setInt(5, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;  // Retorna true se a inserção foi bem-sucedida
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir despesa", e);
        }
    }
    
    //Método para pegar uma despesa pelo seu ID
    public Despesa getDespesa(int despesaId) throws SQLException{
       String sql = "SELECT * FROM despesa WHERE id=?";
       Despesa despesa = null;
       try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
              preparedStatement.setInt(1, despesaId);
              try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    despesa = new Despesa();
                    despesa.setId(rs.getInt("id"));
                    despesa.setNome(rs.getString("nome"));
                    despesa.setDescricao(rs.getString("descricao"));
                    despesa.setValor(rs.getDouble("valor"));
                    despesa.setData(rs.getDate("datad"));
                    despesa.setId_categoria(rs.getInt("id_categoria"));
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        }
        return despesa;
    }
    
    // Lista que contém todas as despesas mensais do user
    public List<Despesa> obterDespesasMes(int userId) throws SQLException {
        String SELECT_DESPESAS_MES_SQL = "SELECT id, nome, descricao, valor, datad, id_categoria FROM despesa WHERE id_user = ? AND MONTH(datad) = MONTH(CURRENT_DATE) AND YEAR(datad) = YEAR(CURRENT_DATE)";
        List<Despesa> despesas = new ArrayList<>();

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_DESPESAS_MES_SQL)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Despesa despesa = new Despesa();
                    despesa.setId(rs.getInt("id"));
                    despesa.setNome(rs.getString("nome"));
                    despesa.setDescricao(rs.getString("descricao"));
                    despesa.setValor(rs.getDouble("valor"));
                    despesa.setData(rs.getDate("datad"));
                    despesa.setId_categoria(rs.getInt("id_categoria"));
                    despesas.add(despesa);
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        }
        return despesas;
    }
    
    // Lista que contém soma de valores para cada categoria
    public List<Object[]> obterSomaPorCategoria(int userId) throws SQLException {
        String SOMA_POR_CATEGORIA_SQL = "SELECT categoria.id as id, categoria.categoria AS categoria, SUM(despesa.valor) AS total FROM despesa JOIN categoria ON despesa.id_categoria = categoria.id WHERE despesa.id_user = ? AND MONTH(despesa.datad) = MONTH(CURRENT_DATE) AND YEAR(despesa.datad) = YEAR(CURRENT_DATE) GROUP BY categoria.categoria";
        List<Object[]> somaPorCategoria = new ArrayList<>();

        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(SOMA_POR_CATEGORIA_SQL)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Object[] categoriaSoma = new Object[3];
                    categoriaSoma[0] = rs.getString("id");
                    categoriaSoma[1] = rs.getString("categoria");
                    categoriaSoma[2] = rs.getDouble("total");
                    somaPorCategoria.add(categoriaSoma);
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        }
        return somaPorCategoria;
    }

    // Boolean que faz o update e retorna true ou false para o resultado
    public boolean atualizarDespesa(int idDespesa, String nome, int idCategoria, String descricao, double valor) throws SQLException {
    String UPDATE_DESPESA_SQL = "UPDATE despesa SET nome = ?, descricao = ?, valor = ?, id_categoria = ? WHERE id = ?";

    try (Connection connection = Conecta.conecta();
         PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_DESPESA_SQL)) {

        preparedStatement.setString(1, nome);
        preparedStatement.setString(2, descricao);
        preparedStatement.setDouble(3, valor);
        preparedStatement.setInt(4, idCategoria);
        preparedStatement.setInt(5, idDespesa);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;  // Retorna true se a atualização foi bem-sucedida
    } catch (ClassNotFoundException e) {
        throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
    } catch (SQLException e) {
        throw new RuntimeException("Erro ao atualizar despesa", e);
    }
}

    // Método para excluir uma despesa
    public boolean excluirDespesa(int despesaId) throws SQLException {
        String DELETE_DESPESA_SQL = "DELETE FROM despesa WHERE id = ?";
        try (Connection connection = Conecta.conecta();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_DESPESA_SQL)) {

            preparedStatement.setInt(1, despesaId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Retorna true se a exclusão foi bem-sucedida
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Erro ao carregar o driver do banco de dados", e);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir despesa", e);
        }
    }
}
