package org.iseage.rockshop;

/**
 * Created by Jake on 7/8/2015.
 */
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.Properties;

public class Helper {
    HttpServletRequest request;
    HttpServletResponse response;

    public Helper(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    public boolean isLoggedIn() {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            return false;
        } else if (session.getAttribute("username").equals(""))
            return false;

        return true;
    }

    public String getUsername() {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        return username == null ? "" : username;
    }

    public static Connection getConnection() throws SQLException, NamingException {
        Connection conn = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webstore", "root", "cdc");

        return conn;
    }
    public static boolean isInCart(String productId, HttpServletRequest request){
        int id = Integer.parseInt(productId);

        Integer[] cart = (Integer[]) request.getSession().getAttribute("shopping_cart");
        Integer cartSize = (Integer) request.getSession().getAttribute("shopping_cart_size");

        if (cart == null) {
            request.getSession().setAttribute("shopping_cart", new Integer[200]);
            request.getSession().setAttribute("shopping_cart_size", new Integer(0));
            return false;
        }

        for (int i = 0; i < cartSize.intValue(); i++) {
            if (id == cart[i].intValue())
                return true;
        }
        return false;
    }
}
