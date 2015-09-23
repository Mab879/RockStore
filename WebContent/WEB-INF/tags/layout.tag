<%--
  Created by IntelliJ IDEA.
  User: Jake
  Date: 7/8/2015
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@tag description="Main Layout" pageEncoding="UTF-8" import="org.iseage.rockshop.Helper"%>
<%@attribute name="activeNav" required="true" %>

<% Helper helper = new Helper(request, response); %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>The Rock Store</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="custom.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">The Rock Store</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/cart.jsp">Cart</a></li>
            <% if (helper.isLoggedIn()) { %>
              <li><a href="#"><%= helper.getUsername()%></a></li>
              <li><a href="#" onclick="Logout()">Logout</a> </li>
            <% } else if (false) { %>
              <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
            <% } %>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li id="nav_home"><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li id="nav_store"><a href="#">Store</a></li>
            <li id="nav_rocks" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=rocks">Rocks</a></li>
            <li id="nav_stones" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=stones">Stones</a></li>
            <li id="nav_pebbles" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=pebbles">Pebbles</a></li>
            <li id="nav_slabs" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=slabs">Slabs</a></li>
            <li id="nav_boulders" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=boulders">Boulders</a></li>
            <li id="nav_flags" class="nested"><a href="${pageContext.request.contextPath}/category.jsp?cat=flags">Flags</a></li>
            <li id="nav_cart"><a href="${pageContext.request.contextPath}/cart.jsp">Cart</a></li>
            <li id="nav_about"><a href="#">About</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <jsp:doBody/>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <!-- Active Nav Setter -->
    <script>
      function setActiveNav() {
        var selector = "li#"+"${activeNav}";
        console.log(selector);
        $(selector).addClass("active");
      }
    </script>

    <!-- Add To Cart -->
    <script>
      function createAddToCart(button) {
        var notifySuccessRemove = function(request) {
          if ((request.readyState == 4) && (request.status == 200)) {
            $(".removeFromCart").each(function () {
              if ($(this).is("#" + $(button).attr("id"))) {
                $(this).parent().removeClass("hidden");
              };
            });
            $(button).parent().addClass("hidden");
          }
          else if (request.readyState == 4) {
            alert("Error adding product to cart!");
          }
        }
        return(function() {
          var request = new XMLHttpRequest();
          request.onreadystatechange = function() { notifySuccessRemove(request) };
          request.open("GET", "${pageContext.request.contextPath}/addToCart?product_id=" + $(button).attr("id"));
          request.send(null);
        });
      }
    </script>

    <!-- Remove From Cart -->
    <script>
      function createRemoveFromCart(button) {
        var notifySuccessRemove = function(request) {
          if ((request.readyState == 4) && (request.status == 200)) {
            $(".addToCart").each(function(){
              if ($(this).is("#"+$(button).attr("id"))) {
                $(this).parent().removeClass("hidden");
              };
            });
            $(button).parent().addClass("hidden");
          }
          else if (request.readyState == 4) {
            alert("Error removing product from cart!");
          }
        }
        return(function() {
          var request = new XMLHttpRequest();
          request.onreadystatechange = function() { notifySuccessRemove(request) };
          request.open("GET", "${pageContext.request.contextPath}/removeFromCart?product_id=" + $(button).attr("id"));
          request.send(null);
        });
      }
    </script>

    <!-- Logout Post -->
    <script>
      function Logout() {
        $.post("${pageContext.request.contextPath}/logout", {});
        window.location.reload(true);
      }
    </script>

    <!-- Onload -->
    <script>
      function setupButtonActions() {
        $("button.removeFromCart").each(function() {
          $(this).click(createRemoveFromCart(this));
        });
        $("button.addToCart").each(function() {
          $(this).click(createAddToCart(this));
        });
      }

      function setup() {
        setupButtonActions();
        setActiveNav();
      }
      window.onload = setup;
    </script>
  </body>
</html>