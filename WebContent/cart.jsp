<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 7/18/2015
  Time: 4:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    Connection conn = org.iseage.rockshop.Helper.getConnection();
    String product_ids[] = new String[1000];
    String names[] = new String[1000];
    String costs[] = new String[1000];
    String descriptions[] = new String[1000];
    boolean inCarts[] = new boolean[1000];
    Integer numProducts;

    Integer[] cart = (Integer[]) request.getSession().getAttribute("shopping_cart");
    Integer cartSize = (Integer) request.getSession().getAttribute("shopping_cart_size");

    if (cart == null) {
        cartSize = new Integer(0);
    }

    int i = 0;

    for (int j = 0; j < cartSize.intValue(); j++ ) {
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE id=" + cart[j].toString() + ";");
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
    }

    numProducts = new Integer(i);

    request.setAttribute("product_ids", product_ids);
    request.setAttribute("names", names);
    request.setAttribute("costs", costs);
    request.setAttribute("descriptions", descriptions);
    request.setAttribute("num_products", numProducts);
    request.setAttribute("inCarts", inCarts);

    int total = 0;

    for(int j = 0; j < i; j++) {
        total += Integer.parseInt(costs[j]);
    }

    request.setAttribute("cart_total", new Integer(total));
%>

<tags:layout activeNav="nav_cart">
    <c:if test="${num_products == 0}">
            <h1>Your cart is empty!</h1>
    </c:if>

    <c:if test="${num_products > 0}">
    <h1>Your shopping cart:</h1>
    <h2>Total: $${cart_total}</h2>

        <!-- For testing <form action="${pageContext.request.contextPath}/PayStub.jsp" method="POST"> -->
        <form action="http://pay.teamN.isucdc.com/begin_transaction" method="POST">
            <input type="hidden" name="amount" value="${cart_total}">
            <input type="hidden" name="postback" value="rocks.teamN.isucdc.com/rockstore/receipt.jsp">
            <input type="hidden" name="txid" value="1">
            <button type="button" class="btn btn-success" onclick="form.submit()">Pay at CashBuddy</button>
        </form>
    <c:forEach var="i" begin="0" end="${num_products - 1}">
        <tags:item
                productId="${product_ids[i]}"
                price="${costs[i]}"
                name="${names[i]}"
                inCart="${inCarts[i]}" >
            ${descriptions[i]}
        </tags:item>
    </c:forEach>
    </c:if>
</tags:layout>