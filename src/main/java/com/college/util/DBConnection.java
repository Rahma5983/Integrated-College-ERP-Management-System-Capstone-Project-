package com.college.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Fixed: Added jdbc: to the start of the URL string
    private static final String URL = "jdbc:mysql://mysql-39c4db68-rahmakhan2022-ae3a.h.aivencloud.com:24795/defaultdb?ssl-mode=REQUIRED";
    private static final String USER = "avnadmin";
    private static final String PASSWORD = "AVNS_dAoLVZsfu3XvjggcZTz"; 

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