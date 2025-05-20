package com.jose.webapp.proyecto.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {
    private static final String url = "jdbc:oracle:thin:@//127.0.0.1:1521/orcl";
    private static final String user = "admin";
    private static final String password = "admin";

    public static Connection getInstance() {

        try {
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            throw new RuntimeException("Error en la conexion a base de datos: " + e.getMessage());
        }
    }
}
