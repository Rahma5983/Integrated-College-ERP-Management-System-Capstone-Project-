package com.college.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // IMPORTANT: Change 'password' below to match your real MySQL root password!
    private static final String URL = "jdbc:mysql://localhost:3306/college_erp";
    private static final String USER = "root";
    private static final String PASSWORD = "rahmakhangoenka@555"; 

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
