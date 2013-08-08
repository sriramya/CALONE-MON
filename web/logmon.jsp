<%-- 
    Document   : logmon
    Created on : 25 Feb, 2013, 10:20:34 PM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            p{
                font-size: 25px;
                color: #002952;
                font-family:Open Sans; 
            }
            one{
                font-family:Open Sans; 
                color: #002952;
            }
            
            html { background:#95D6E6; }
                </style>
    </head>
    
    <body >
    




          <%String tname = request.getParameter("tid");%> 
          
          
          <p><b>Log Monitoring</b></p>
        <one><font size="4.5">Selected Tenant: <%=tname%> </font>
      
              <br/>        <br/>
          <font size="3"><b>Description:</b></font>
         <font size="3">The displayed logs will be based on selected severity, Component and the selected time period.</font> 
        </one>
          
</body>
</html>
