<%-- 
    Document   : colfamilys
    Created on : 7 Apr, 2013, 4:51:16 PM
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
    session.setAttribute("ksp", tname); 
 
  %>
       
<frameset cols="18%,*">
    
    <frame name="menu" target="temp" noresize="noresize" scrolling="no" src="logmon.jsp?tid=<%=tname%>" />
     <frame name="menu" target="temp" noresize="noresize" scrolling="auto" src="allcolfamilys.jsp?ksp=<%=tname%>" /> 
        <%--<frame name="menu" target="main" noresize="noresize" scrolling="no" src="temp.jsp" />--%>



</frameset>

<body>
 
</body>


</html>