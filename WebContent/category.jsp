<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.iseage.rockshop.Helper" %>
<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 7/9/2015
  Time: 8:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String category = request.getParameter("cat"); request.setAttribute("category", category); %>
<%
    Connection conn = org.iseage.rockshop.Helper.getConnection();
    String product_ids[] = new String[1000];
    String names[] = new String[1000];
    String costs[] = new String[1000];
    String descriptions[] = new String[1000];
    Integer numProducts;

    boolean inCarts[] = new boolean[1000];

    int i = 0;

    try {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE category='" + category + "' AND NOT purchased;");
        while (rs.next()) {
            product_ids[i] = rs.getString("id");
            names[i] = rs.getString("name");
            costs[i] = rs.getString("cost");
            descriptions[i] = rs.getString("description");
            inCarts[i] = org.iseage.rockshop.Helper.isInCart(product_ids[i], request);
            i++;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    numProducts = new Integer(i);

    request.setAttribute("product_ids", product_ids);
    request.setAttribute("names", names);
    request.setAttribute("costs", costs);
    request.setAttribute("descriptions", descriptions);
    request.setAttribute("num_products", numProducts);
    request.setAttribute("inCarts", inCarts);
%>

<tags:layout activeNav="nav_${category}">
  <h1>${num_products} products in category '${category}'</h1>
        <c:if test="${num_products > 0}">
        <c:forEach var="product_count" begin="0" end="${num_products - 1}">
            <tags:item
                    productId="${product_ids[product_count]}"
                    price="${costs[product_count]}"
                    name="${names[product_count]}"
                    inCart="${inCarts[product_count]}">
                ${descriptions[product_count]}
            </tags:item>
        </c:forEach>
        </c:if>
</tags:layout>
