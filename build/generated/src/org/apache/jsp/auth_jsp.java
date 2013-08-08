package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import javax.naming.*;
import javax.naming.directory.*;
import javax.naming.ldap.*;
import java.sql.*;

public final class auth_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/conf.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');


String server = "10.5.0.94";                    // Server hostname "172.16.94.223";
int port = 389;                                // Default port no
String basedn = "ou=logmonitoring,dc=dcis,dc=uohyd,dc=ernet,dc=kvdi,dc=com";   // Works with Example.ldif
String ldappasswd="krishna";

      out.write("\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"\n");
      out.write("\"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>LDAP Authentication Results</title>\n");
      out.write("\t<script type=\"text/javascript\">\n");
      out.write("\t    window.history.forward();\n");
      out.write("\t   \n");
      out.write("\t</script>\n");
      out.write("    </head>\n");
      out.write("    <body bgcolor=\"#99CCFF\">\n");
      out.write("        ");

        
        
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
        
      out.write("\n");
      out.write("       \n");
      out.write("        ");

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
        
      out.write("\n");
      out.write("       \n");
      out.write("        ");

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
       out.println("Invalid user and password");
      out.write("\n");
      out.write("\n");
      out.write("        <p>Successful authentication for ");
      out.print( user);
      out.write(".</p>\n");
      out.write("\n");
 session.setAttribute("user",user);
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
 out.println("Wrong Password");
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
	msg="Invalid User id/password";
	response.sendRedirect("login.jsp?msg="+msg);*/
        } catch (NamingException e) {
            out.println("Invalid User name");
	//msg="Error! Please check your userid !";
	//response.sendRedirect("error.jsp?msg="+msg);
          // e.printStackTrace();
        }
        
      out.write("\n");
      out.write("        <hr /><p>Return to <a href=\"index.jsp\">top page</a>.</p>\n");
      out.write("    </body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
