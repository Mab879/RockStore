package org.iseage.rockshop;

import javax.servlet.http.*;

/**
 * Created by Jake on 7/8/2015.
 */
public class Logout extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
    }
}
