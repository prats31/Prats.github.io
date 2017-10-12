/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ConClass;

import java.sql.*;
import java.sql.DriverManager;

/**
 *
 * @author Harish
 */
public class CClass {
          private static Connection con = null;

        public static Connection getConnection() throws Exception {
                if (con != null)
                        return con;
                else {
                        // Store the database URL in a string

       Class.forName("com.mysql.jdbc.Driver");
         
                        // set the url, username and password for the databse
                con  = DriverManager.getConnection("jdbc:mysql://localhost:3306/projectdatabase?autoReconnect=true&amp;zeroDateTimeBehavior=convertToNull", "root", "root123");
                                 return con;
                }
        }
}
