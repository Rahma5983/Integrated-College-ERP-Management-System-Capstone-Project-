package com.college.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Updated to use your live Railway Cloud Database details
    private static final String URL = "jdbc:mysql://viaduct.proxy.rlwy.net:3306/railway";
    private static final String USER = "root";
    private static final String PASSWORD = "iPATsNvXLjJQFrwrhfscTwfiPlEYsjax"; 

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