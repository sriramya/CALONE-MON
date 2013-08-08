

<%@page import="static me.prettyprint.hector.api.factory.HFactory.createKeyspace"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.getOrCreateCluster"%>
<%@page import="me.prettyprint.cassandra.model.CqlQuery"%>
<%@page import="me.prettyprint.cassandra.model.CqlRows"%>
<%@page import="me.prettyprint.cassandra.serializers.StringSerializer"%>
<%@page import="me.prettyprint.hector.api.Cluster"%>
<%@page import="me.prettyprint.hector.api.beans.HColumn"%>
<%@page import="me.prettyprint.hector.api.query.QueryResult"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>     
                            
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript" src="js/newjavascript.js"></script>
        <script>
            window.history.forward();
        function setting1()
        {
        if (window.innerWidth && window.innerHeight)
        {
        var winW = window.innerWidth;
        var winH = window.innerHeight;
        document.getElementById("first").height= winH;
           document.getElementById("first").width= winW;
        }
        }
            function setting()
            {
            if (window.innerWidth && window.innerHeight)
            {
            var winW = window.innerWidth;
            var winH = window.innerHeight;
            document.getElementById("first").height= winH-46;
               document.getElementById("first").width= winW-9;
            }
            }
           
            window.onresize = function()
            {
                setting();
            }
           
</script>


        <style type="text/css" media="screen">

            body { font-family:Arial, Helvetica, sans-serif; }
div.header { display:block; position:relative; height:20px; }
#menu-container { display:block; position:static; width:1000px; margin:0px;  font-size:20px;left:0px; }
#drop_down_menu { display:block; position:absolute; clear:both; margin:0px; padding:0px; text-align:center; list-style-type:none; text-align:center; width:1400px; float:none; left:0px; top:0px; }
#drop_down_menu li { font-size:15px; font-weight:bold; float:left; color:white; padding:5px; cursor:pointer; background:#00ACE6; width:170px; }
#drop_down_menu li ul { margin:0px; padding:0px; list-style-type:none; padding-top:10px; }
#drop_down_menu li ul li { display:block; float:none; clear:both;  }
#drop_down_menu li ul li a { color:white; font-weight:normal; text-decoration:none; display:block; }
#drop_down_menu li ul li a:HOVER { text-decoration:underline; color:red; }
</style>
    </head>
  
    
     <body>
         
         <%!
            private final static String CLUSTER_NAME = "Logging";
	    private final static String HOST_PORT = "10.5.1.127:9160";
	    private final static StringSerializer se = StringSerializer.get();
    %>
         
      
    <table align="center">   
    <tr>
           <td>
        <div class="header">
	<div id="menu-container">	
            <ul id="drop_down_menu">
			<li><a href="temp.jsp"><font color="white">Home</font></a>
				
			</li>
                    
                    
			
                        <li class="menu" name="Logmon" value="Log Monitoring">Log Monitoring
				<ul class="links">
                                        <li><a href="alltenants.jsp?ten=<%="All"%>" target="first">All Tenants</a></li>
                         <%                   
                                         Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace("ListKeyspace", c), se, se, se);
            cqlQuery.setQuery("select * from listksp");
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery
	    .execute();
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String colVal = row.getColumnSlice().getColumns().get(1).getValue();
                          %>
                                        
                          <li><a href="singtenant.jsp?ten=<%=colVal%>" target="first"><b><%=colVal%></b></a></li>
					  <%   
                                                  
	            }
	    }
            
    %>
				</ul>
			</li>
                        <li class="menu" name="Logmon" value="Net Flow Monitoring">Net Flow Monitoring
				<ul class="links">
                                        <li><a href="refresh.jsp" target="first">All Tenants</a></li>
                                      <%                                 
            cqlQuery.setQuery("select * from CFNlist");
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String colVal = row.getColumnSlice().getColumns().get(1).getValue();
                          %>
                                        
                                        <li><a href="singtenant.jsp" target="first"><%out.println(colVal);%></a></li>
					  <%             
	            }
	    }
            
    %>
				</ul>
			</li>
                        
			 <li class="menu">Welcom <%=session.getAttribute("user")%>
				<ul class="links">
                                    <li><a href="loginactivity.jsp" target="first">Login Activity</a></li>
                                     <li><a href="changepassword.jsp" target="first">change password</a></li>
					<li><a href="ExpireSession.jsp">Sign Out</a></li>
                                       
					
				</ul>
			</li>
                         <% if(session.getAttribute("user")==null)
                           
                                                       {
                            String msg="Session Expired or You are not Logged in";
   // response.sendRedirect("error.jsp?msg="+msg);%>
                        <%--<jsp:forward page="error.jsp"/>--%>
                        <%}
                        else
       { %>
            
                       
                        
                        <%} 
                        String ip= request.getHeader("X-FORWARDED-FOR");
                        if(ip==null)
                            ip=request.getRemoteAddr();
%>
                    
               
                      
                       
                   
		</ul>
	</div>
</div>
           </td>
               
                   </tr>
                   
               
    </table>
 <iframe   id="first" frameborder=0 border=0  onload="setting1();" name="first" style="color:#FFA500" >
    </body>
    
</html>

























<%-- 
    Document   : allcolfamilys
    Created on : 7 Apr, 2013, 12:34:33 PM
    Author     : sriramya
--%>

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
  
  <script language="javaScript" type="text/javascript">
       function validate(){
           var val = 0;
           
           var text1 = document.getElementById('all1').checked,
               text2 = document.getElementById('all2').checked,
               text3 = document.getElementById('all3').checked,
               text4 = document.getElementById('all4').checked,
               text5 = document.getElementById('all5').checked,
               text6 = document.getElementById('all6').checked,
               text7 = document.getElementById('all7').checked,
               text8 = document.getElementById('all8').checked,
               text9 = document.getElementById('all9').checked;
               
           var tms1 = document.getElementById('sdate').value,
               tms2 = document.getElementById('stime').value, 
               tms3 = document.getElementById('etime').value, 
               tms4 = document.getElementById('edate').value;
               

               
               if (text1 == false && text2 == false &&  text3 == false &&  text4 == false &&  text5 == false
                   &&  text6 == false &&  text7 == false &&  text8 == false &&  text9 == false){
                   val = val+8;
               
                   
               }
               
               if(tms1 == "" || tms2 == "" || tms3 == "" || tms4 == "" || tms1 == "date" 
                   || tms2 == "time" || tms3 == "time" || tms4 == "date"){
                   val = val+4;
                 
               }
               
               if(val == 0){
                   return true;
               }
               else if(val == 12){
                   alert("Select severity and date");
                   return false;
               }
                else if(val == 8){
                   alert("Select severity ");
                   return false;
               }
                else if(val == 4){
                   alert("Select date, time");
                   return false;
               }
               
               
               
               
       }
      
      
            function fun1(a)
            {
            if (a) {
            var radio_1 = window.document.form1.severity1;
            var radio_2 = window.document.form1.severity2;
            var radio_3 = window.document.form1.severity3;
            var radio_4 = window.document.form1.severity4;
            var radio_5 = window.document.form1.severity5;
            var radio_6 = window.document.form1.severity6;
            var radio_7 = window.document.form1.severity7;
            var radio_8 = window.document.form1.severity8;
            radio_1.checked = true;
            radio_2.checked = true;
            radio_3.checked = true;
            radio_4.checked = true;
            radio_5.checked = true;
            radio_6.checked = true;
            radio_7.checked = true;
            radio_8.checked = true;
            }
            else{
            var radio_1 = window.document.form1.severity1;
            var radio_2 = window.document.form1.severity2;
            var radio_3 = window.document.form1.severity3;
            var radio_4 = window.document.form1.severity4;
            var radio_5 = window.document.form1.severity5;
            var radio_6 = window.document.form1.severity6;
            var radio_7 = window.document.form1.severity7;
            var radio_8 = window.document.form1.severity8;
            radio_1.checked = false;
            radio_2.checked = false;
            radio_3.checked = false;
            radio_4.checked = false;
            radio_5.checked = false;
            radio_6.checked = false;
            radio_7.checked = false;
            radio_8.checked = false;                
            }
           
            }
         function to(a){
             var radio_1 = window.document.form1.severity1;
                var radio_2 = window.document.form1.severity2;
                var radio_3 = window.document.form1.severity3;
                var radio_4 = window.document.form1.severity4;
                var radio_5 = window.document.form1.severity5;
                var radio_6 = window.document.form1.severity6;
                var radio_7 = window.document.form1.severity7;
                var radio_8 = window.document.form1.severity8;
                var radio = window.document.form1.allsev;
                 
                
                 if (!a) {
                     var radio = window.document.form1.allsev;
                      radio.checked = false;
                 }
                 else if (radio_1.checked == true &&
                     radio_2.checked == true &&
                     radio_3.checked == true &&
                     radio_4.checked == true &&
                     radio_5.checked == true &&
                     radio_6.checked == true &&
                     radio_7.checked == true &&
                     radio_8.checked == true) {
                     
                     radio.checked = true;
                 }
                
                
            }
            function fun2(a)
             {
                 var elems = window.document.form1.getElementsByTagName("input");
                 var elemsLength = elems.length;
                 for(i=14; i<elemsLength; i++)
                    {
                     if(elems[i].id == "net")
                            elems[i].checked = true; 
                     if(elems[i-1].checked == false && elems[i].id =="net") 
                            elems[i].checked = false;
                    }
             }
              function fun3(a)
             {
                  vahcu_adminr elems = window.document.form1.getElementsByTagName("input");
                 var elemsLength = elems.length; var count =0;
                if (!a) {
                     var radio_1 = window.document.form1.network;
                     radio_1.checked = false;
                 }
                 else {
                        for(i=14; i<elemsLength; i++)
                       {
                            if(elems[i].checked == true && elems[i].id =="net"){
                                count = count +1;
                            }        
                       }
                       if (count == (elemsLength-15)){
                           var radio_1 = window.document.form1.network;
                     radio_1.checked = true;
                       }
                 }
            }
             
          
           
          
           
         
        </script>
        <style>
            
h1 {
	color: #468;
        background:#CCFFFF;
	font-family: "Georgia",Georgia,Serif;
	font-size: 25px;
	font-weight: 100;
	letter-spacing: -2px;
	line-height: 40px;
	margin: 30px 0;
}
            h2 {
	color: #468;
	font-family: "Gill Sans",Verdana;
	font-size: 10px;
	
}


                </style>
        </style>
   </head>
   <body>
       
       
       
<style type="text/css">




div#menu {

}
div#copyright { display: none; }
</style>
      
       <form name="form1" action="DissAllTenData.jsp"   onsubmit="return validate();">
       
	
		<script src="js/datepair.js"></script>
		<h1>Select Date And Time</h1>  

                
                <p class="datepair" data-language="javascript"> <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/> From
			<input id="sdate" placeholder="Date"  name="startdate"type="text"   class="date start" />
                        <input id="stime" placeholder="Time"  name="starttime"type="text"   class="time start" />
                <th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/>
                        To
			<input id="etime" placeholder="Time"  name="endtime"type="text"   class="time end" />
			<input id="edate" placeholder="Date"  name="enddate"type="text"   class="date end" />
		</p>
		
	
        
      
  
    <h1>Select Severity</h1>
 <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/>
            <input type="checkbox" id="all1" name="allsev" value="all" onclick="fun1(this.checked);"><b>All</b> <th>&nbsp;<th/>
            <input type="checkbox" id="all2" name="severity1" value="emerg" onclick="to(this.checked);">emerg<th>&nbsp;<th/>
            <input type="checkbox" id="all3" name="severity2" value="alert" onclick="to(this.checked);">alert<th>&nbsp;<th/>
            <input type="checkbox" id="all4" name="severity3" value="crit" onclick="to(this.checked);">crit<th>&nbsp;<th/>
            <input type="checkbox" id="all5" name="severity4" value="error" onclick="to(this.checked);">error<th>&nbsp;<th/>
            <input type="checkbox" id="all6" name="severity5" value="warning" onclick="to(this.checked);">warning<th>&nbsp;<th/>
            <input type="checkbox" id="all7" name="severity6" value="notice" onclick="to(this.checked);">notice<th>&nbsp;<th/>
            <input type="checkbox" id="all8" name="severity7" value="info" onclick="to(this.checked);">info<th>&nbsp;<th/>
            <input type="checkbox" id="all9" name="severity8" value="debug" onclick="to(this.checked);">debug<br><th>&nbsp;
         <br/>
       
    
       <h1>Select Component</h1>
         

                 
              <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/>       
                     <input type="checkbox" id="network" name="network" value="network" onclick="fun2(this.checked);" ><b>All</b><br>
        <div style="overflow: auto; width:650px; height:90px;  border: 1px solid #336699; padding-left: 35px">
                     <%      String ksp=request.getParameter("ksp");
                    
            Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace(ksp, c), se, se, se);
            cqlQuery.setQuery("select * from CFNlist");
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery
	    .execute();
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String colVal = row.getColumnSlice().getColumns().get(1).getValue();
            CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
            createKeyspace(ksp, c), se, se, se);
            cqlQuery1.setQuery("select * from '"+colVal+"'");
	    QueryResult<CqlRows<String, String, String>> result1 = cqlQuery1
	    .execute();
	    if (result1 != null && result1.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                      String colVal1 = row1.getColumnSlice().getColumns().get(3).getValue();
                                
                    %>
                     <input type="checkbox" id="net"  name="net" value="net" onclick="fun3(this.checked);" ><%=colVal1%><br>
                    
               <%
	                }
                                       }
                       }
	            }
	        
    %>
 </div>
  <br/>   <br/>   <br/>   <br/>         
         
         
  <center><input  type="submit" value="Submit" target="_top" ""/> </center>
</form>
       
   </body>
</html>
