package kitsura;

public class Kitsura {

    public static void main(String[] args) {
        System.out.println("Inicio del sistema KITSURA");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.insertarUsuario(
            1,
            "juan123",
            "juan@gmail.com",
            "123456"
        );
    }
}