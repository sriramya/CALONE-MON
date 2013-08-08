<%-- 
    Document   : Vallksp
    Created on : 7 May, 2013, 11:58:01 PM
    Author     : sriramya
--%>


<%@page import="java.util.Enumeration"%>
<%@page import="java.util.*"%>

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
<html lang="en">
<head>
 <meta charset='utf-8'>

  <title>Timepicker</title>
  <meta name="description" content="A lightweight, customizable jQuery timepicker plugin inspired by Google Calendar. Add a user-friendly timepicker dropdown to your app in minutes." />
  <script type="text/javascript" src="js/jquery.min.js"></script>

  <script type="text/javascript" src="js/jquery.timepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="CSS/jquery.timepicker.css" />

  <script type="text/javascript" src="js/base.js"></script>
  <link rel="stylesheet" type="text/css" href="CSS/base.css" />
  
  <link rel="stylesheet" href="CSS/tempstyle.css" />

<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


<script>
$(function() {
$( "#accordion" ).accordion();
});
</script>
<script language="javaScript" type="text/javascript">
       function validate(){
           var sev = 1, time=1;
           
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
                    sev = 0;
               }
               
               if(tms1 == "" || tms2 == "" || tms3 == "" || tms4 == "" || tms1 == "date" 
                   || tms2 == "time" || tms3 == "time" || tms4 == "date"){
                   time=0;
               }
               
               if(sev == 1 | time == 1) {
                   return true;
               }
               else{
                   alert("Select date or Time");
                   return false;
               }
               
               
               
       }
      
      
         
            function fun1(a)
            {  
            var elems = window.document.form1.getElementsByTagName("input");
            var elemsLength = elems.length; 
              if(a) {
                  
                  for(i=0; i<4; i++){
                        elems[i].value = null; 
                      }
                 for(i=13; i < elemsLength ; i++){
                        elems[i].checked = false; 
                      }  
              }
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
             
            var elems = window.document.form1.getElementsByTagName("input");
            var elemsLength = elems.length; 
              
              if(a) {
                  
                  for(i=0; i<4; i++){
                        elems[i].value = null; 
                      }
                 for(i=13; i < elemsLength ; i++){
                        elems[i].checked = false; 
                      }  
              }
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
            function fun3(a)
             {  
                  var elems = window.document.form1.getElementsByTagName("input");
                 var elemsLength = elems.length; var count =0;
                
                   if(a) {
                  
                    for(i=0; i<4; i++){
                        elems[i].value = null; 
                      }
                    for(i=4; i < 13 ; i++){
                        elems[i].checked = false; 
                      }  
                   }
                 
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
                 if(a) {
                  
                    for(i=0; i<4; i++){
                        elems[i].value = null; 
                      }
                    for(i=4; i < 13 ; i++){
                        elems[i].checked = false; 
                      }  
                   }
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
        function  diss1() {
            var elems = window.document.form1.getElementsByTagName("input");
            var elemsLength = elems.length;
             for(i=4; i<elemsLength; i++){
                        elems[i].checked = false; 
                        
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
                </style>
        </style>
</head>
<body>
       
       <form name="form1" action="VallkspData.jsp" target="first">
    
<div id="accordion">
<h3>Select Date And Time</h3>
<div>

                         <script src="js/datepair.js"></script>
                              
                <p class="datepair" data-language="javascript"> <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/> <fon>From</fon>
                <input id="sdate" placeholder="Date" name="startdate"type="text" onclick="diss1();"  class="date start" />
                        <input id="stime" placeholder="Time" name="starttime"type="text"  onclick="diss1();" class="time start" />
                <th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/><th>&nbsp;<th/>
                      <fon>  To </fon>
                        <input id="etime" placeholder="Time" name="endtime"type="text" onclick="diss1();"  class="time end" />
                        <input id="edate" placeholder="Date" name="enddate"type="text" onclick="diss1();"  class="date end" />
		</p>
</div>
<h3>Select Severity</h3>
<div>
<p>

       <fon>   
           <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/>
            <input type="checkbox" id="all1" name="allsev" value="all" onclick="fun1(this.checked);" ><b>All</b> <th>&nbsp;<th/>
            <input type="checkbox" id="all2" name="severity1" value="emerg" onclick="to(this.checked);">emerg<th>&nbsp;<th/>
            <input type="checkbox" id="all3" name="severity2" value="alert" onclick="to(this.checked);">alert<th>&nbsp;<th/>
            <input type="checkbox" id="all4" name="severity3" value="crit" onclick="to(this.checked);">crit<th>&nbsp;<th/>
            <input type="checkbox" id="all5" name="severity4" value="error" onclick="to(this.checked);">error<th>&nbsp;<th/>
            <input type="checkbox" id="all6" name="severity5" value="warning" onclick="to(this.checked);">warning<th>&nbsp;<th/>
            <input type="checkbox" id="all7" name="severity6" value="notice" onclick="to(this.checked);">notice<th>&nbsp;<th/>
            <input type="checkbox" id="all8" name="severity7" value="info" onclick="to(this.checked);">info<th>&nbsp;<th/>
            <input type="checkbox" id="all9" name="severity8" value="debug" onclick="to(this.checked);">debug<br><th>&nbsp;
       </fon>
</p>
</div>
<h3>Select Component</h3>
<div>
<p>

             
               <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th/> <fon>     
                     <input type="checkbox" id="network" name="component" value="component" onclick="fun2(this.checked);" ><b>All</b>
        <div style="overflow: auto; width:650px; height:90px;  border: 1px solid #336699; padding-left: 35px">
            <%      
                      Dictionary d = new Hashtable();     
           Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace("ListKeyspace", c), se, se, se);
            cqlQuery.setQuery("select * from listksp");
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery
	    .execute();
             if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String keyspace = row.getColumnSlice().getColumns().get(1).getValue();
                    CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
                    createKeyspace(keyspace, c), se, se, se);
                    cqlQuery1.setQuery("select * from CFNlist");
                    QueryResult<CqlRows<String, String, String>> result1 = cqlQuery1
                    .execute();
                     if (result1 != null && result1.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                            String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                            CqlQuery<String, String, String> cqlQuery2 = new CqlQuery<String, String, String>(
                            createKeyspace(keyspace, c), se, se, se);
                              cqlQuery2.setQuery("select * from "+colfam+"");
                          QueryResult<CqlRows<String, String, String>> result2 = cqlQuery2
                            .execute();
                             if (result2 != null && result2.get() != null) {
                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                            for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                     String colVal = row2.getColumnSlice().getColumns().get(3).getValue();
                                     String colVal1 = row2.getColumnSlice().getColumns().get(1).getValue();
                            d.put(colVal+"/"+colVal1, colVal+"/"+colVal1);
                              
	         } }
	    } } 
      }}
       
   
             for (Enumeration e = d.keys();e.hasMoreElements();){
            String param = (String) e.nextElement();%>
                 <input type="checkbox" id="net"  name="net" value="<%=param%>" onclick="fun3(this.checked);" ><%=param%><br>
            <%}%>
<fon>
 </div>
</p>
</div>


</div>
<br><br>
   <center><input style="background-color: #56c2e1; box-shadow: #56c2e1; color: white; " type="submit" value="Submit" target="_top" ""/> </center>

</form>
       
   </body>
</html>