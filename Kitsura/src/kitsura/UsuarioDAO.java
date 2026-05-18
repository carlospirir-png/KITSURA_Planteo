
package kitsura;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UsuarioDAO {

    public void insertarUsuario(int idRol, String nombre, String correo, String contrasena) {
        
        String sql = "INSERT INTO Usuario (id_rol, nombre_usuario, correo, contrasena) VALUES (?, ?, ?, ?)";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idRol);
            ps.setString(2, nombre);
            ps.setString(3, correo);
            ps.setString(4, contrasena);

            ps.executeUpdate();
            System.out.println("Usuario insertado correctamente");

        } catch (SQLException e) {
            System.out.println("Error al insertar usuario: " + e.getMessage());
        }
    }
}
