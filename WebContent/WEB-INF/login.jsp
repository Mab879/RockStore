<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 7/8/2015
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<tags:layout activeNav="nav_home">
  <div class="centered-outer">
    <div class="centered-inner">
      <form action="${pageContext.request.contextPath}/login" method="POST">
        Username: <input type="text" name="username"> <br/>
        Password: <input type="password" name="password"> <br/>
        <input type="submit" value="Sign In"> <br/>
        <a id="forgot-password" href="https://iscore.iseage.org/green/teaminfo">Forgot password?</a>
      </form>
    </div>
  </div>
</tags:layout>
