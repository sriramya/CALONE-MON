<html>
       <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout page</title>
    </head>
    <body bgcolor="#99CCFF">
       <%
	session.removeAttribute("user");
	session.invalidate();%>
       <h1>Thank You !</h1>
	<p>You have been successfully logged out from CALONE-MON. </p>
        <hr /><p>Return to <a href="index.jsp" >Login Page</a>.</p>
    </body>
</html>