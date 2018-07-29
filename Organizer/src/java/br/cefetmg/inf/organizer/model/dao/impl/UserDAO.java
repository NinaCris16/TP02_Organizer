/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.cefetmg.inf.organizer.model.dao.impl;

import br.cefetmg.inf.organizer.model.dao.IThemeDAO;
import br.cefetmg.inf.organizer.model.dao.IUserDAO;
import br.cefetmg.inf.organizer.model.domain.Theme;
import br.cefetmg.inf.organizer.model.domain.User;
import br.cefetmg.inf.util.db.ConnectionManager;
import br.cefetmg.inf.util.exception.PersistenceException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author aline
 */
public class UserDAO implements IUserDAO {

    @Override
    public boolean createUser(User user) throws PersistenceException {
        try {
            Connection connection = ConnectionManager.getInstance().getConnection();
            String sql = "INSERT INTO usuario(cod_Email,nom_Usuario,txt_Senha,seq_Tema) VALUES (?, ?, ?, ?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getCodEmail());
            preparedStatement.setString(2, user.getUserName());
            preparedStatement.setString(3, user.getUserPassword());
            preparedStatement.setInt(4, user.getCurrentTheme().getIdTheme());

            preparedStatement.execute();
            preparedStatement.close();
            connection.close();

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new PersistenceException("Ocorreu um erro na execução " + ex.getMessage());
        }
    }

    @Override
    public User readUser(User user) throws PersistenceException {
        try {
            Connection connection = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT nom_Usuario,txt_Senha,blb_Imagem,seq_Tema, length(blb_Imagem) tamanho FROM usuario WHERE cod_Email=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getCodEmail());

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                user.setUserName(rs.getString("nom_Usuario"));
                user.setUserPassword(rs.getString("txt_Senha"));

                File tempFile = new File("src/java/br/cefetmg/inf/resources/temp1.jpg");
                try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                    int len = rs.getInt("tamanho");
                    byte[] buf = rs.getBytes("blb_Imagem");
                    fos.write(buf, 0, len);
                }

                user.setUserPhoto(tempFile);

                IThemeDAO themeDAO = new ThemeDAO();
                Theme newTheme = themeDAO.readIdTheme(rs.getInt("seq_Tema"));
                user.setCurrentTheme(newTheme);

            } else {
                user = null;
            }
            rs.close();
            preparedStatement.close();
            connection.close();

            return user;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new PersistenceException("Ocorreu um erro na execução " + ex.getMessage());
        }
    }

    @Override
    public boolean updateUser(User user) throws PersistenceException {
        try {
            Connection connection = ConnectionManager.getInstance().getConnection();
            PreparedStatement preparedStatement;
            
            if (user.getUserPhoto() != null) {
                String sql = "UPDATE usuario SET cod_Email=?, nom_Usuario=?, txt_Senha=?, blb_Imagem=?, seq_Tema=? WHERE cod_Email=?";

                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, user.getCodEmail());
                preparedStatement.setString(2, user.getUserName());
                preparedStatement.setString(3, user.getUserPassword());

                try (FileInputStream fin = new FileInputStream(user.getUserPhoto())) {
                    preparedStatement.setBinaryStream(4, fin, user.getUserPhoto().length());
                } catch (IOException ex) {
                    ex.printStackTrace();
                    throw new IOException(ex.getMessage());
                }

                preparedStatement.setInt(5, user.getCurrentTheme().getIdTheme());
                preparedStatement.setString(6, user.getCodEmail());
            }else{
                String sql = "UPDATE usuario SET cod_Email=?, nom_Usuario=?, txt_Senha=?, seq_Tema=? WHERE cod_Email=?";

                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, user.getCodEmail());
                preparedStatement.setString(2, user.getUserName());
                preparedStatement.setString(3, user.getUserPassword());
                preparedStatement.setInt(4, user.getCurrentTheme().getIdTheme());
                preparedStatement.setString(5, user.getCodEmail());
            }

            preparedStatement.execute();
            preparedStatement.close();
            connection.close();

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new PersistenceException("Ocorreu um erro na execução " + ex.getMessage());
        }
    }

    @Override
    public boolean deleteUser(User user) throws PersistenceException {
        try {
            Connection connection = ConnectionManager.getInstance().getConnection();
            String sql = "DELETE FROM usuario WHERE cod_Email=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getCodEmail());

            preparedStatement.execute();
            preparedStatement.close();
            connection.close();

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new PersistenceException("Ocorreu um erro na execução " + ex.getMessage());
        }
    }

    @Override
    public User getUserLogin(String email, String password) throws PersistenceException {
        try {
            Connection connection = ConnectionManager.getInstance().getConnection();
            String sql = "SELECT cod_Email,nom_Usuario,txt_Senha,blb_Imagem,seq_Tema, length(blb_Imagem) tamanho FROM usuario WHERE cod_Email=? and txt_Senha=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();

            User user = null;
            if (rs.next()) {
                user = new User();
                user.setCodEmail(rs.getString("cod_Email"));
                user.setUserName(rs.getString("nom_Usuario"));
                user.setUserPassword(rs.getString("txt_Senha"));

                File tempFile = new File("src/java/br/cefetmg/inf/resources/temp1.jpg");
                try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                    int len = rs.getInt("tamanho");
                    byte[] buf = rs.getBytes("blb_Imagem");
                    fos.write(buf, 0, len);
                }

                user.setUserPhoto(tempFile);

                IThemeDAO themeDAO = new ThemeDAO();
                Theme newTheme = themeDAO.readIdTheme(rs.getInt("seq_Tema"));
                user.setCurrentTheme(newTheme);
            }

            rs.close();
            preparedStatement.close();
            connection.close();

            return user;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new PersistenceException("Ocorreu um erro na execução " + ex.getMessage());
        }
    }

}
