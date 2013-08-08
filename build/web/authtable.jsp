<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>auth table Results</title>
	<script type="text/javascript">
	    window.history.forward();
	   
	</script>
    </head>
    <body bgcolor="#99CCFF">
        <%
	
        String user = request.getParameter("user");
       System.out.println(user);
        String password = request.getParameter("password");
            if(user.equals("Ramya")){
                 session.setAttribute("user", user);
            String role = "cloud_" ; 
            String fwdpage=role+"admin.jsp";
response.sendRedirect(fwdpage);

        }
        if(user.equals("lakshman")){
             session.setAttribute("user", user);
            session.setAttribute("ksp", "hcu");
           String role = "tenant_" ;
           String fwdpage=role+"admin.jsp";
         response.sendRedirect(fwdpage);

        }
        
	if(user.equals("krishna")){
             session.setAttribute("us", user);
             session.setAttribute("ksp", "oc");
           String role = "tenant_" ;
           String fwdpage=role+"admin.jsp";
         response.sendRedirect(fwdpage);

        }
        if(user.equals("Nirmoy")){
             session.setAttribute("user", user);
            session.setAttribute("ksp", "controller");
           String role = "tenant_" ;
           String fwdpage=role+"admin.jsp";
         response.sendRedirect(fwdpage);

        }


	
        %>
        <hr /><p>Return to <a href="index1.jsp">top page</a>.</p>
    </body>
</html>
