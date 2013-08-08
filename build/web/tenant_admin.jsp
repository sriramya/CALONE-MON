<%-- 
    Document   : Tenants
    Created on : 6 Apr, 2013, 3:59:27 PM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  
    <%
      String user = request.getParameter("user");
      session.setAttribute("keyspace",user);
    %>
         <frameset name="head" border="0" rows="15%,85%">
         <frame  src="title.jsp" name="title" scrolling="no" noresize="noresize">
            <frame src="tenantmenu.jsp?ksp=<%=user%>" name="menu" scrolling="auto">
         </frameset> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
  
    </body>
</html>
