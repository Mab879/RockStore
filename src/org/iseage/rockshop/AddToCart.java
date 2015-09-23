package org.iseage.rockshop;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Jake on 7/18/2015.
 */
public class AddToCart extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        Integer[] cart = (Integer[]) session.getAttribute("shopping_cart");
        Integer cartSize = (Integer) session.getAttribute("shopping_cart_size");

        if (cart == null) {
            cart = new Integer[256];
            cartSize = new Integer(0);
        }

        cart[cartSize.intValue()] = new Integer(request.getParameter("product_id"));
        cartSize = new Integer(cartSize.intValue() + 1);

        session.setAttribute("shopping_cart", cart);
        session.setAttribute("shopping_cart_size", cartSize);

        response.getWriter().println("Success");
        response.setStatus(200);
    }
}
