
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
        document.getElementById("first").height= winH-63;
           document.getElementById("first").width= winW-18;
        }
        }
            function setting()
            {
            if (window.innerWidth && window.innerHeight)
            {
            var winW = window.innerWidth;
            var winH = window.innerHeight;
            document.getElementById("first").height= winH-63;
               document.getElementById("first").width= winW-18;
            }
            }
           
            window.onresize = function()
            {
                setting();
            }
           
</script>

<style>
    html { background:#95D6E6; font-family:Open Sans; }
</style>
    
</head>
<body>
<% String user = (String) session.getAttribute("user"); 
   String ksp = (String) session.getAttribute("ksp"); 
                    %>


<div id="menu">
    <ul class="menu">
        <li><a href="newjsp.jsp" class="parent" target="first" ><span>Home</span></a> </li>
        <li><a href="colfamilys.jsp?ten=<%=ksp%>" target="first" ><span>Log Monitoring</span></a> </li>
        <li><a href="signetflow.jsp?ten=<%=ksp%>" target="first"><span>Net Flow Monitoring</span></a></li>
        <li class="last"><a href="#"><span>Welcome <%=user%></span></a>
            <ul>
                      
                        <li><a href="ExpireSession.jsp" target="_parent"><span>Sign Out</span></a></li>
	    </ul>
        </li>
    </ul>
</div>

<a href="http://apycom.com/"></a>
 <iframe   id="first" frameborder=0 border=0  onload="setting1();" name="first" style="color:white" ></iframe>
</body>
</html>