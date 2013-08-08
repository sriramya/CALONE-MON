package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import static me.prettyprint.hector.api.factory.HFactory.createKeyspace;
import static me.prettyprint.hector.api.factory.HFactory.getOrCreateCluster;
import me.prettyprint.cassandra.model.CqlQuery;
import me.prettyprint.cassandra.model.CqlRows;
import me.prettyprint.cassandra.serializers.StringSerializer;
import me.prettyprint.hector.api.Cluster;
import me.prettyprint.hector.api.beans.HColumn;
import me.prettyprint.hector.api.query.QueryResult;
import me.prettyprint.cassandra.serializers.StringSerializer;

public final class menuitems_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


            private final static String CLUSTER_NAME = "Logging";
	    private final static String HOST_PORT = "10.5.0.120:9160";
	    private final static StringSerializer se = StringSerializer.get();
    
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/Cassconnect.jsp");
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("       \n");
      out.write("         ");
      out.write("\n");
      out.write("         \n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />\n");
      out.write("    <title>Style 01 (Deep Sky Blue) - Menu by Apycom.com</title>\n");
      out.write("    <link type=\"text/css\" href=\"CSS/menu1.css\" rel=\"stylesheet\" />\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jquery1.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/menu1.js\"></script>\n");
      out.write("<script>\n");
      out.write("            window.history.forward();\n");
      out.write("        function setting1()\n");
      out.write("        {\n");
      out.write("        if (window.innerWidth && window.innerHeight)\n");
      out.write("        {\n");
      out.write("        var winW = window.innerWidth;\n");
      out.write("        var winH = window.innerHeight;\n");
      out.write("        document.getElementById(\"first\").height= winH-62;\n");
      out.write("           document.getElementById(\"first\").width= winW-18;\n");
      out.write("        }\n");
      out.write("        }\n");
      out.write("            function setting()\n");
      out.write("            {\n");
      out.write("            if (window.innerWidth && window.innerHeight)\n");
      out.write("            {\n");
      out.write("            var winW = window.innerWidth;\n");
      out.write("            var winH = window.innerHeight;\n");
      out.write("            document.getElementById(\"first\").height= winH-62;\n");
      out.write("               document.getElementById(\"first\").width= winW-9;\n");
      out.write("            }\n");
      out.write("            }\n");
      out.write("           \n");
      out.write("            window.onresize = function()\n");
      out.write("            {\n");
      out.write("                setting();\n");
      out.write("            }\n");
      out.write("           \n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<style>\n");
      out.write("    html { background:#95D6E6;font-family:Open Sans; }\n");
      out.write("</style>\n");
      out.write("    \n");
      out.write("</head>\n");
      out.write("<body>\n");
 String user = (String) session.getAttribute("user"); 

                    
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<div id=\"menu\">\n");
      out.write("    <ul class=\"menu\">\n");
      out.write("        <li><a href=\"\" class=\"parent\"><span>Home</span></a> </li>\n");
      out.write("        <li><a href=\"#\" class=\"parent\"><span>Log Monitoring</span></a>\n");
      out.write("            <ul>\n");
      out.write("                <li><a href=\"alltenants.jsp?ten=");
      out.print("All");
      out.write("\" target=\"first\"><span>All Tenants</span></a></li>\n");
      out.write("                \n");
      out.write("            \n");
      out.write("            ");
                                 
            Cluster c = getOrCreateCluster("10.5.0.120", HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace("ListKeyspace", c), se, se, se);
            cqlQuery.setQuery("select * from listksp");
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery
	    .execute();
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String colVal = row.getColumnSlice().getColumns().get(1).getValue();
                            String[] str = colVal.split("-");
                          
      out.write("\n");
      out.write("            \n");
      out.write("                <li><a href=\"colfamilys.jsp?ten=");
      out.print(str[0]);
      out.write("\" target=\"first\"><span>");
      out.print(str[1]);
      out.write("</span></a> </li>\n");
      out.write("              \n");
      out.write("                 ");
}}
      out.write("\n");
      out.write("                  </ul>\n");
      out.write("                </li>\n");
      out.write("            \n");
      out.write("            \n");
      out.write("        </li>\n");
      out.write("        <li><a href=\"\" class=\"parent\"><span>Net Flow Monitoring</span></a>\n");
      out.write("            <ul>\n");
      out.write("                <li><a href=\"allnetflowfram.jsp?ten=");
      out.print("All");
      out.write("\" target=\"first\"><span>All Tenants</span></a></li>\n");
      out.write("                ");
                                 
            Cluster c1 = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
            createKeyspace("netflowlist", c), se, se, se);
            cqlQuery1.setQuery("select * from listksp");
	    QueryResult<CqlRows<String, String, String>> result1 = cqlQuery1
	    .execute();
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list1) {
                            String colVal1 = row.getColumnSlice().getColumns().get(1).getValue();
                          
      out.write("\n");
      out.write("            \n");
      out.write("                <li><a href=\"signetflow.jsp?ten=");
      out.print(colVal1);
      out.write("\" target=\"first\"><span>");
      out.print(colVal1);
      out.write("</span></a> </li>\n");
      out.write("              \n");
      out.write("                 ");
}}
      out.write("\n");
      out.write("                \n");
      out.write("               \n");
      out.write("            </ul>\n");
      out.write("        </li>\n");
      out.write("  \n");
      out.write("         <li><a href=\"#\" class=\"parent\"><span>Welcome ");
      out.print(session.getAttribute("user"));
      out.write("</span></a>\n");
      out.write("                    <ul>\n");
      out.write("                        <li><a href=\"ExpireSession.jsp\" target=\"_parent\"><span>Sign Out</span></a></li>\n");
      out.write("                    </ul>\n");
      out.write("        </li>\n");
      out.write("    </ul>\n");
      out.write("</div>\n");
      out.write("<div id=\"copyright\"><a href=\"http://apycom.com/\"></a></div>\n");
      out.write(" <iframe   id=\"first\" frameborder=0 border=0  onload=\"setting1();\" name=\"first\" style=\"color:#FFA500\" >\n");
      out.write("</body>\n");
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
