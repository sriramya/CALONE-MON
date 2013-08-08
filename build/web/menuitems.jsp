
<%@page import="static me.prettyprint.hector.api.factory.HFactory.createKeyspace"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.getOrCreateCluster"%>
<%@page import="me.prettyprint.cassandra.model.CqlQuery"%>
<%@page import="me.prettyprint.cassandra.model.CqlRows"%>
<%@page import="me.prettyprint.cassandra.serializers.StringSerializer"%>
<%@page import="me.prettyprint.hector.api.Cluster"%>
<%@page import="me.prettyprint.hector.api.beans.HColumn"%>
<%@page import="me.prettyprint.hector.api.query.QueryResult"%>
<%@include file="Cassconnect.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <title>Style 01 (Deep Sky Blue) - Menu by Apycom.com</title>
    <link type="text/css" href="CSS/menu1.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery1.js"></script>
    <script type="text/javascript" src="js/menu1.js"></script>
<script>
            window.history.forward();
        function setting1()
        {
        if (window.innerWidth && window.innerHeight)
        {
        var winW = window.innerWidth;
        var winH = window.innerHeight;
        document.getElementById("first").height= winH-62;
           document.getElementById("first").width= winW-18;
        }
        }
            function setting()
            {
            if (window.innerWidth && window.innerHeight)
            {
            var winW = window.innerWidth;
            var winH = window.innerHeight;
            document.getElementById("first").height= winH-62;
               document.getElementById("first").width= winW-9;
            }
            }
           
            window.onresize = function()
            {
                setting();
            }
           
</script>

<style>
    html { background:#95D6E6;font-family:Open Sans; }
</style>
    
</head>
<body>
<% String user = (String) session.getAttribute("user"); 

                    %>


<div id="menu">
    <ul class="menu">
        <li><a href="" class="parent"><span>Home</span></a> </li>
        <li><a href="#" class="parent"><span>Log Monitoring</span></a>
            <ul>
                <li><a href="alltenants.jsp?ten=<%="All"%>" target="first"><span>All Tenants</span></a></li>
                
            
            <%                                 
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
                          %>
            
                <li><a href="colfamilys.jsp?ten=<%=str[0]%>" target="first"><span><%=str[1]%></span></a> </li>
              
                 <%}}%>
                  </ul>
                </li>
            
            
        </li>
        <li><a href="" class="parent"><span>Net Flow Monitoring</span></a>
            <ul>
                <li><a href="allnetflowfram.jsp?ten=<%="All"%>" target="first"><span>All Tenants</span></a></li>
                <%                                 
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
                          %>
            
                <li><a href="signetflow.jsp?ten=<%=colVal1%>" target="first"><span><%=colVal1%></span></a> </li>
              
                 <%}}%>
                
               
            </ul>
        </li>
  
         <li><a href="#" class="parent"><span>Welcome <%=session.getAttribute("user")%></span></a>
                    <ul>
                        <li><a href="ExpireSession.jsp" target="_parent"><span>Sign Out</span></a></li>
                    </ul>
        </li>
    </ul>
</div>
<div id="copyright"><a href="http://apycom.com/"></a></div>
 <iframe   id="first" frameborder=0 border=0  onload="setting1();" name="first" style="color:#FFA500" >
</body>
</html>