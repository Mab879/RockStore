<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 7/8/2015
  Time: 7:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@tag description="Item Display" pageEncoding="UTF-8"%>
<%@attribute name="productId" required="true"%>
<%@attribute name="name" required="true"%>
<%@attribute name="price" required="true"%>
<%@attribute name="inCart" required="true"%>
<%@attribute name="showCommentsLink" required="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="product_view">
  <a href="${pageContext.request.contextPath}/full/${productId}.png">
    <img src="${pageContext.request.contextPath}/thumb/${productId}.png" width="128" height="128"/>
  </a>
  <div class="product_details_container">
    <p>${name}</p>
    <p>Price: $${price}</p>
    <p
            <c:if test="${!inCart}"> class="hidden" </c:if>
            >
      <button type="button" class="btn btn-danger removeFromCart" id="${productId}">Remove From Cart</button>
    </p>

    <p
            <c:if test="${inCart}"> class="hidden" </c:if>
            >
      <button type="button" class="btn btn-success addToCart" id="${productId}">Add To Cart</button>
    </p>
  </div>
  <div class="product_desc">
    <p>
      <jsp:doBody/>
      <c:if test="${empty showCommentsLink}">
        <br/>
        <a href="${pageContext.request.contextPath}/comments?productId=${productId}">View product comments</a>
      </c:if>
    </p>
  </div>
</div>
