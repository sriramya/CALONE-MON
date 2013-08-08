<%-- 
    Document   : alltenants
    Created on : 25 Feb, 2013, 9:58:34 PM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <%String tname = request.getParameter("ten");
  %>
       
<frameset  border="5" cols="18%,*">
    
    <frame name="menu" target="temp" noresize="noresize" scrolling="no" src="logmon.jsp?tid=<%=tname%>" />
     <frame name="menu" target="temp" noresize="noresize" scrolling="auto" src="AllTenants.jsp" /> 
        <%--<frame name="menu" target="main" noresize="noresize" scrolling="no" src="temp.jsp" />--%>



</frameset>

<body>
 
</body>


</html>
