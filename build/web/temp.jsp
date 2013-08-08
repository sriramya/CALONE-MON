
<%-- 
    Document   : allcolfamilys
    Created on : 7 Apr, 2013, 12:34:33 PM
    Author     : sriramya
--%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.*"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.createKeyspace"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.getOrCreateCluster"%>
<%@page import="me.prettyprint.cassandra.model.CqlQuery"%>
<%@page import="me.prettyprint.cassandra.model.CqlRows"%>
<%@page import="me.prettyprint.cassandra.serializers.StringSerializer"%>
<%@page import="me.prettyprint.hector.api.Cluster"%>
<%@page import="me.prettyprint.hector.api.beans.HColumn"%>
<%@page import="me.prettyprint.hector.api.query.QueryResult"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Cassconnect.jsp"%>
<!DOCTYPE html>
<html>
   <head>
        <meta charset='utf-8'>

  <title>Timepicker for jQuery &ndash; Demos and Documentation</title>
  <meta name="description" content="A lightweight, customizable jQuery timepicker plugin inspired by Google Calendar. Add a user-friendly timepicker dropdown to your app in minutes." />
  <script type="text/javascript" src="js/jquery.min.js"></script>

  <script type="text/javascript" src="js/jquery.timepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="CSS/jquery.timepicker.css" />

  <script type="text/javascript" src="js/base.js"></script>
  <link rel="stylesheet" type="text/css" href="CSS/base.css" />
  
   </head>
   <body>
       <%!
     
       private static final String HEX_DIGITS = "0123456789abcdef";

     public static String toHex(byte[] data) {
        StringBuffer buf = new StringBuffer();

        for (int i = 0; i != data.length; i++) {
            int v = data[i] & 0xff;

            buf.append(HEX_DIGITS.charAt(v >> 4));
            buf.append(HEX_DIGITS.charAt(v & 0xf));

            buf.append(" ");
        }

        return buf.toString();
    }   
  
  %>
         <table>
	<thead>
		<tr>
                    <th>Host</th>
                 
                </tr>
	</thead>
                     <%   
            Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            
            CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
            createKeyspace("netflow", c), se, se, se);
            cqlQuery1.setQuery("select * from records");
	    QueryResult<CqlRows<String, String, String>> result1 = cqlQuery1
	    .execute();
            
	    if (result1 != null && result1.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                     byte[] colVal2 = row1.getColumnSlice().getColumns().get(1).getValue().getBytes();
                         String abc =   toHex(colVal2);
                                   %>
                                   <tbody>
                                       <tr>
                                       
                                       <td><%=abc%> </td>
                                      
                                   </tr>          
             
                                   </tbody>
        <%

	        
                       }
                               }
  
            
    %>
  

       
   </body>
</html>

 d.put(colVal1, colVal1);
                              
	         } }
	    } } 
     
       
   
             for (Enumeration e = d.keys();e.hasMoreElements();){
            String param = (String) e.nextElement();%>
                 <input type="checkbox" id="net"  name="net" value="<%=param%>" onclick="fun3(this.checked);" ><%=param%><br>
            <%}%>