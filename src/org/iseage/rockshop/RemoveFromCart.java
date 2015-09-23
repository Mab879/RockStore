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
public class RemoveFromCart extends HttpServlet {
     public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
         HttpSession session = request.getSession();

         Integer[] cart = (Integer[]) session.getAttribute("shopping_cart");
         Integer cartSize = (Integer) session.getAttribute("shopping_cart_size");

         if (cart == null) {
             cart = new Integer[256];
             cartSize = new Integer(0);

             response.getWriter().println("Cart did not exist!");
             response.setStatus(400);
         }

         Integer[] newCart = new Integer[256];

         int count = 0;
         for(int i = 0; i < cartSize.intValue(); i++) {
             if (cart[i].intValue() != Integer.parseInt(request.getParameter("product_id"))) {
                newCart[count++] = cart[i];
             }
         }

         session.setAttribute("shopping_cart", newCart);
         session.setAttribute("shopping_cart_size", new Integer(count));
    }
}
