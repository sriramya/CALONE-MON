<%-- 
    Document   : newjsp2
    Created on : 27 Apr, 2013, 7:25:15 PM
    Author     : sriramya
--%>
<%@page import="me.prettyprint.hector.api.Keyspace"%>
<%@page import="me.prettyprint.hector.api.mutation.Mutator"%>
<%@page import="me.prettyprint.hector.api.factory.HFactory"%>
<%@page import="me.prettyprint.cassandra.serializers.CompositeSerializer"%>
<%@page import="me.prettyprint.cassandra.serializers.UUIDSerializer"%>
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
<%@page import="me.prettyprint.hector.api.beans.Composite"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Cassconnect.jsp"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        
        <%
           Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
              CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(createKeyspace("test", c), se, se, se);

            cqlQuery.setQuery("select * from compositetest where i_id>3");
                              
           
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery.execute();
            if (result != null && result.get() != null) {
                out.print(result.get());
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            //out.print(result.get());
                            out.print("<br>");
                                   
	            }
	    }
   
                     
	   %>
    </body>
</html>
