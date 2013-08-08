<%-- 
    Document   : allnetflowfram
    Created on : 23 May, 2013, 10:13:10 PM
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
    
    <frame name="menu" target="temp" noresize="noresize" scrolling="no" src="netmon.jsp?tid=<%=tname%>" />
     <frame name="menu" target="temp" noresize="noresize" scrolling="auto" src="AllTenNetflow.jsp" /> 
        <%--<frame name="menu" target="main" noresize="noresize" scrolling="no" src="temp.jsp" />--%>



</frameset>

<body>
 
</body>


</html>

