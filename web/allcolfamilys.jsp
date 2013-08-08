
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
  
  <script language="javaScript" type="text/javascript">
        function validate(){
            var elems = window.document.form1.getElementsByTagName("input");
            var len = elems.length,c=0;
            if(elems[0].value == "" | elems[1].value == "" | elems[2].value == "" | elems[3].value == ""){
                if(elems[0].value != ""){
                    alert("Select Date and Time");
                    return false;
                }
                else if(elems[1].value != ""){
                    alert("Select Date and Time");
                    return false;
                }
                else if(elems[2].value != ""){
                    alert("Select Date and Time");
                    return false;
                }
                else if(elems[3].value != ""){
                    alert("Select Date and Time");
                    return false;
                }
                
                else { 
                        var i;
                       for(i=4; i< len;i++) {
                           if(elems[i].checked == true){
                               c=1;
                           }
                         }
                        if (c != 0 ){
                            return true;
                        }
                        else{
                            alert("Select query");
                            return false;
                        }
                }
            }
            
            
                
         }
      
      
         function fun1(a){  
            var elems = window.document.form1.getElementsByTagName("input");
            var elemsLength = elems.length; 
            if (a) {
                for(i=4;i<13;i++){
                    elems[i].checked = true;
                }
            }
            else{
                for(i=4;i<13;i++){
                         elems[i].checked = false;
                     }               
            }
            
            }
         function to(a){
             
            var elems = window.document.form1.getElementsByTagName("input");
            var elemsLength = elems.length; 
              
              var radio = window.document.form1.allsev;
              
                 if (!a) {
                     
                      radio.checked = false;
                 }
                 
                 else if ( elems[5].checked == true &&
                     elems[6].checked == true &&
                     elems[7].checked == true &&
                     elems[8].checked == true &&
                     elems[9].checked == true &&
                     elems[10].checked == true && 
                     elems[11].checked == true && 
                     elems[12].checked == true) {
                     
                     radio.checked = true;
                 }
                
                
            }
            function fun3(a)
             {  
                  var elems = window.document.form1.getElementsByTagName("input");
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
            function fun2(a)
             {   
                 var elems = window.document.form1.getElementsByTagName("input");
                 var elemsLength = elems.length;
                 if(elemsLength-15 == 0) {
                     elems[13].disabled = true;
                 }
                 else {
                     for(i=14; i<elemsLength; i++)
                      {
                        if(elems[i].id == "net")
                               elems[i].checked = true; 
                        if(elems[i-1].checked == false && elems[i].id =="net") 
                               elems[i].checked = false;
                      }
                 }
            }
       
            
        
      
        </script>
        <style>
               
h1 {
	color: #003366;
        background:#CCFFFF;
	font-family:Open Sans; 
	font-size: 25px;
	font-weight: 100;
	
}
           

html { background:#B2F0FF; }


div#menu {

}
div#copyright { display: none; }

fon{
    font-family:Open Sans; 
    font-size: 18px;
    font-weight: 100;
}

logi{
    
	width: 300px;
	margin: 0 auto;
	position: relative;

	box-shadow:  #56c2e1;  
	background: #56c2e1;
        color: white;
	border: 1px solid #56c2e1;
	border-radius: 5px;
	
}



        </style>
   </head>
   <body>
       

      
       <form name="form1" action="allcfdata.jsp" onsubmit="return validate();" target="first"> <%--  onsubmit="return validate();"--%>
       	<br/><br/>
	
		<script src="js/datepair.js"></script>
		<h1>Select Date And Time</h1>  

                
                <p class="datepair" data-language="javascript"> <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/><fon> From</fon>
			<input id="sdate" placeholder="Date"  name="startdate"type="text"  class="date start" />
                        <input id="stime" placeholder="Time"  name="starttime"type="text"  class="time start" />
                <th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/>
                <fon>  To </fon>
			<input id="etime" placeholder="Time"  name="endtime"type="text"   class="time end" />
			<input id="edate" placeholder="Date"  name="enddate"type="text"   class="date end" />
		</p>
		
	
        	<br/>
      
  
    <h1>Select Severity</h1>
 <fon><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/>
           <input type="checkbox" id="all1" name="allsev" value="all" onclick="fun1(this.checked);"><b>All</b> <th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="emerg" onclick="to(this.checked);">emerg<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="alert" onclick="to(this.checked);">alert<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="crit" onclick="to(this.checked);">crit<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="error" onclick="to(this.checked);">error<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="warning" onclick="to(this.checked);">warning<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="notice" onclick="to(this.checked);">notice<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="info" onclick="to(this.checked);">info<th>&nbsp;<th/>
            <input type="checkbox" id="severity" name="severity" value="debug" onclick="to(this.checked);">debug<br><th>&nbsp;</fon>
         
        </br>
    	<br/>
       <h1>Select Component</h1> 
             
              <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/>  <fon>     
                     <input type="checkbox" id="network" name="network" value="network" onclick="fun2(this.checked);" ><b>All</b>
        <div style="overflow: auto; width:650px; height:90px;  border: 1px solid #336699; padding-left: 35px">
            
                     <%      
                       Dictionary d = new Hashtable();     
                       String ksp=request.getParameter("ksp");
                            // session.setAttribute("ksp", ksp);
            Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace(ksp, c), se, se, se);
            cqlQuery.setQuery("select * from statistics");
	    QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
	    .execute();
	    if (result1 != null && result1.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                     int count = row1.getColumnSlice().getColumns().size() ;
                                     
                                     while(--count > 0) {
                                     String colVal1 = row1.getColumnSlice().getColumns().get(count).getName();
                                   %>
                 <input type="checkbox" id="net"  name="net" value="<%=colVal1%>" onclick="fun3(this.checked);" ><%=colVal1%><br>
          
            <%               
                     }
	    } } 
       %>
       
   
            
</fon>
 </div>
  <br/>   <br/>   <br/>    
         
         
  <center><input style="background-color: #56c2e1; box-shadow: #56c2e1; color: white; " type="submit" value="Submit" target="_top" ""/> </center>
</form>
       
   </body>
</html>

