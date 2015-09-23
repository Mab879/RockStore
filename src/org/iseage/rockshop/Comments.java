package org.iseage.rockshop;


import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Jake on 8/29/2015.
 */
public class Comments extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Connection conn = Helper.getConnection();
            String productId = request.getParameter("productId");
            String description = "";
            String productName = "";
            String price = "";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE id = '" + productId + "';");
            while (rs.next()) {
                productName = rs.getString("name");
                price = rs.getString("cost");
                description= rs.getString("description");
            }

            Boolean in_cart = new Boolean(org.iseage.rockshop.Helper.isInCart(productId, request));

            request.setAttribute("in_cart", in_cart);
            request.setAttribute("product_id", productId);
            request.setAttribute("product_name", productName);
            request.setAttribute("price", price);
            request.setAttribute("description", description);

            String[] bigCommentsArray = new String[100];
            int i = 0;
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM comments WHERE product_name= '" + productName + "';");
            while (rs.next()) {
                bigCommentsArray[i] = rs.getString("comment");
                i++;
            }
            String[] comments = new String[i];
            System.arraycopy(bigCommentsArray, 0, comments, 0, i);

            request.setAttribute("comments", comments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/comments.jsp");
            dispatcher.forward(request, response);
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Connection conn = Helper.getConnection();
            String productId = request.getParameter("productId");
            String description = "";
            String productName = "";
            String price = "";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE id = '" + productId + "';");
            while (rs.next()) {
                productName = rs.getString("name");
                price = rs.getString("cost");
                description= rs.getString("description");
            }

            Boolean in_cart = new Boolean(org.iseage.rockshop.Helper.isInCart(productId, request));

            request.setAttribute("in_cart", in_cart);
            request.setAttribute("product_id", productId);
            request.setAttribute("product_name", productName);
            request.setAttribute("price", price);
            request.setAttribute("description", description);

            String comment = request.getParameter("comment");
            stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO comments (product_name, comment) VALUES ('" + productName +
                    "', '"+ comment + "');");

            String[] bigCommentsArray = new String[100];
            int i = 0;
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM comments WHERE product_name= '" + productName + "';");
            while (rs.next()) {
                bigCommentsArray[i] = rs.getString("comment");
                i++;
            }
            String[] comments = new String[i];
            System.arraycopy(bigCommentsArray, 0, comments, 0, i);

            request.setAttribute("comments", comments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/comments.jsp");
            dispatcher.forward(request, response);
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
