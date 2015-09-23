<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 8/29/2015
  Time: 5:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tags:layout activeNav="nav_home">
  <tags:item inCart="${in_cart}"
             productId="${product_id}"
             name="${product_name}"
             price="${price}"
             showCommentsLink="false">${description}
  </tags:item>
  <ul>
  <c:forEach items="${comments}" var="comment">
    <li>${comment}</li>
  </c:forEach>
  </ul>
  <form action="${pageContext.request.contextPath}/comments" method="POST">
    <input type="hidden" name="productId" value="${product_id}">
    Leave a comment: <input type="text" size="150" name="comment"> <input type="submit">
  </form>
</tags:layout>