package com.college.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // We read the credentials from the system variables instead of hardcoding them
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD"); 

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            if (URL == null || USER == null || PASSWORD == null) {
                System.err.println("Database Environment Variables are missing!");
                return null;
            }
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}