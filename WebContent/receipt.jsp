<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.StringWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 8/20/2015
  Time: 12:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
            Connection conn = org.iseage.rockshop.Helper.getConnection();

            String[] proofArray = new String[1000];
            String[] nameArray = new String[1000];
            String[] costArray = new String[1000];

            Integer[] cart = (Integer[]) request.getSession().getAttribute("shopping_cart");
            Integer cartSize = (Integer) request.getSession().getAttribute("shopping_cart_size");

            for (int j = 0; j < cartSize.intValue(); j++) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE id=" + cart[j].toString() + ";");
                while (rs.next()) {
                    proofArray[j] = rs.getString("proof");
                    costArray[j] = rs.getString("cost");
                    nameArray[j] = rs.getString("name");
                    Statement stmt2 = conn.createStatement();
                    stmt2.executeUpdate("UPDATE products SET purchased=1 WHERE id=" + cart[j].toString() + ";");
                }
            }
            request.getSession().invalidate();

            StringWriter writer = new StringWriter();
            writer.write("RECEIPT - KEEP FOR YOUR RECORDS\n");
            writer.write("     ITEM      |      PAID     |      PROOF OF PURCHASE      \n");
            writer.write("--------------------------------------------------------------------------\n");
            for (int j = 0; j < cartSize.intValue(); j++) {
                writer.write(nameArray[j]);
                writer.write(" | ");
                writer.write(costArray[j]);
                writer.write(" | ");
                writer.write(proofArray[j]);
                writer.write("\n");
            }
            String receipt = writer.toString();
            request.setAttribute("receipt_text", receipt);
            request.setAttribute("receipt_size", cartSize);
%>
<tags:layout activeNav="nav_home">
    <h1>Your Receipt</h1>
    <textarea disabled="true" cols="80" rows="${receipt_size + 10}">
${receipt_text}
     </textarea>
</tags:layout>