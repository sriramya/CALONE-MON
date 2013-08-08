<%-- 
    Document   : netframe
    Created on : 9 Apr, 2013, 11:35:56 PM
    Author     : sriramya
--%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <%String network = request.getParameter("net");
  %>
       
<frameset  border="5" cols="18%,*">
    
    <frame name="menu" target="temp" noresize="noresize" scrolling="no" src="netmon.jsp?net=<%=network%>" />
     <frame name="menu" target="temp" noresize="noresize" scrolling="auto" src="singnetwork.jsp?cfn=<%=network%>" /> 
        <%--<frame name="menu" target="main" noresize="noresize" scrolling="no" src="temp.jsp" />--%>



</frameset>
