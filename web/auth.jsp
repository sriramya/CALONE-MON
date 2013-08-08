<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*,javax.naming.*,javax.naming.directory.*,javax.naming.ldap.*, java.sql.*" %>
<%@include file="conf.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LDAP Authentication Results</title>
	<script type="text/javascript">
	    window.history.forward();
	   
	</script>
    </head>
    <body bgcolor="#99CCFF">
        <%
        
        
	boolean stafforfaculty=false;
        String msg="";
        Connection conn = null;
	int fail=0;
        String user = request.getParameter("user");
        String password = request.getParameter("password");
        String cn1 = request.getParameter("admin");
        session.setAttribute("cn", cn1);
        //Class.forName("com.mysql.jdbc.Driver").newInstance();
	//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system","root", "");
	ResultSet rs = null;
	PreparedStatement ps=null;
	if(user==null){
		msg="Error !";
		response.sendRedirect("error.jsp?msg="+msg);
                return;
	}
	else if((user.length()>2) &&((user.equals("staff")) ||(user.equals("admin"))||user.substring(user.length()-2 ).equals("cs")))
        {
	stafforfaculty=true;
	//try{
	//String sqlOption="SELECT * FROM loginactivity where"+" userid=? ";
	//ps=conn.prepareStatement(sqlOption);
	//ps.setString(1,user);
	//rs=ps.executeQuery();
	//if(rs.next())
	//{
	//	fail=rs.getInt("failedattempts");
	//	if(fail>=10){
		//	msg="Your account is blocked, Please contact Administrator ";
	//	        response.sendRedirect("error.jsp?msg="+msg);
           //             return;
		//}
	//}

       //}
   /* catch(Exception e)
    {
      msg="Sorry ! Internal Server Error Occurred, Please Try later !";
      response.sendRedirect("Error.jsp?msg="+msg);
      return;
   // e.printStackTrace();
    }*/

}

        
       String filter = "(|(uid=" + user + ")" + "(mail=" + user + "@*))";
       // String cliEquiv = "<tt>ldapsearch -x -h " + server + " -p " +
             //   port + " -b " + basedn + " \"" + filter + "\"</tt></p>";
        %>
       
        <%
        // Connect to the LDAP server.
        Hashtable env = new Hashtable(11);
        env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "ldap://" + server + ":" + port + "/");
 
        // Search and retrieve DN.
        try {
            LdapContext ldap = new InitialLdapContext(env, null);
           //
            //out.println(cn);
           // String k= "cn="+cn+","+basedn;
          
            NamingEnumeration results = ldap.search(basedn, filter, null);
            String binddn = "None";
            
            while (results.hasMore()) {
                SearchResult sr = (SearchResult) results.next();
                binddn = sr.getName() + "," + basedn;
            }
        %>
       
        <%
            ldap.close();
          
            // Authenticate
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, binddn);
            env.put(Context.SECURITY_CREDENTIALS, password);
              
            ldap = new InitialLdapContext(env, null);
             Attributes attrs=ldap.getAttributes(binddn);
             
            String role=attrs.get("gidNumber").get().toString();
            
	if(role.equals("1000")) {	 
            role = "cloud_" ; 
            String fwdpage=role+"admin.jsp";
            response.sendRedirect(fwdpage);
        }
        else if(role.equals("2000")){
             session.setAttribute("ksp", "hcu");
	     role="tenant_";
             String fwdpage=role+"admin.jsp";
             response.sendRedirect(fwdpage);
        }
	else if(role.equals("3000")){
             session.setAttribute("ksp", "oc");
	     role="tenant_";
             String fwdpage=role+"admin.jsp";
             response.sendRedirect(fwdpage);
        }
           else 
       out.println("The username or password you entered is incorrect.");%>

        <p>Successful authentication for <%= user%>.</p>

<% session.setAttribute("user",user);
if(stafforfaculty){
	//String ip=""+request.getRemoteHost();
         String ip= request.getHeader("X-FORWARDED-FOR");
                        if(ip==null)
                            ip=request.getRemoteAddr();
	String userAgent =""+request.getHeader("user-agent");
	String date=""+new java.util.Date();
	/*try{
	String update="UPDATE loginactivity set lastlogin='"+date+"', failedattempts=0, ipaddress='"+ip+"', agent='"+userAgent+"' where userid='"+user+"'";
	Statement st1=conn.createStatement();
	st1.executeUpdate(update);
	//System.out.print(""+userAgent);
	}catch(Exception e){
		msg="Sorry, internal Server Error, Please Try later, Thank you!";
	
	}*/

}
return;

   
        } catch (AuthenticationException ae) {
 out.println("The username or password you entered is incorrect.");
	/*if(stafforfaculty){
	fail=fail+1;
       String insrt= "UPDATE loginactivity set failedattempts="+fail+" where userid='"+user+"'";
	try{
        Statement st=conn.createStatement();
        st.executeUpdate(insrt);
	}catch(Exception e){
		msg="Sorry, internal Server Error, Please Try later, Thank you!";
		response.sendRedirect("error.jsp?msg="+msg);
                return;
	}
	}
	msg="The username or password you entered is incorrect.";
	response.sendRedirect("login.jsp?msg="+msg);*/
        } catch (NamingException e) {
            out.println("The username or password you entered is incorrect.");
	//msg="Error! Please check your userid !";
	//response.sendRedirect("error.jsp?msg="+msg);
          // e.printStackTrace();
        }
        %>
        <hr /><p>Return to <a href="index.jsp">top page</a>.</p>
    </body>
</html>
