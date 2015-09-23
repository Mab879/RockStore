<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 8/20/2015
  Time: 11:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title></title>
</head>
<body>

<h1>Fake CashBuddy payment page!</h1>

<form action="${param['postback']}" method="post">
  <input type="hidden" name="txid" value="${param['txid']}">
  <input type="hidden" name="paid" value="true">
  <input type="submit">
</form>

</body>
</html>
