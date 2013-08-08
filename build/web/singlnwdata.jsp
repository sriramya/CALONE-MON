<%-- 
    Document   : DissAllTenData
    Created on : 3 Apr, 2013, 3:30:28 PM
    Author     : sriramya
--%>
<%@page import="com.eaio.util.lang.Hex"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="me.prettyprint.cassandra.utils.TimeUUIDUtils"%>
<%@page import="java.nio.ByteBuffer"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script type="text/javascript" src="js/jquery-latest.js"></script> 
<script type="text/javascript" src="js/jquery.tablesorter.js"></script> 
<link type="text/css" href="CSS/style_1.css" rel="stylesheet" />

<script>
    $(document).ready(function() 
    { 
        $("#myTable").tablesorter(); 
    } 
); 
    


$(document).ready(function() 
    { 
        $("#myTable").tablesorter( {sortList: [ [0,0]]} ); 
    } 
); 
    
    </script>
        <style>
            body
{
	font-family:Open Sans; 
	font-size:15px;
	margin:0 auto;
	width:100%;
}
.tables
{      font-size:17px;
	border:2px solid #000;
	margin:0 auto;
	width:95%;
       
}
th,td
{
        font-size:17px;
	padding:5px;
}
p
{       
        background: #EBEBFF;
        font-size:17px;
        font-family:Open Sans; 
	padding:10px;
        color: #003366;
}
a
{
    font-size:17px;
	color:#fff;
	text-decoration:none;
}
.even
{font-size:17px;
	background-color:#fff;
	color:#343234;
}
odd
{       font-size:30px;
	
}
        </style>
        <script>
            $(document).ready(function()
{
	$('#search').keyup(function()
	{
		searchTable($(this).val());
	});
});

function searchTable(inputVal)
{
	var table = $('#myTable');
	table.find('tr').each(function(index, row)
	{
		var allCells = $(row).find('td');
		if(allCells.length > 0)
		{
			var found = false;
			allCells.each(function(index, td)
			{
				var regExp = new RegExp(inputVal, 'i');
				if(regExp.test($(td).text()))
				{
					found = true;
					return false;
				}
			});
			if(found == true)$(row).show();else $(row).hide();
		}
	});
}
        </script>
        <title>JSP Page</title>
       
    </head>
    <body>
       <%!  
          public static String getformate(String Date, String time){
	   String[] str,str1;
	   String formate;
	   str = Date.split("/");
	   String year = str[0];
	   String month = str[1];
	   String date = str[2];
	   
	   str1 = time.split(":");
	   String hour = str1[0];
	   String min = str1[1];
	   String sec = str1[2];
	
	   formate  = year+month+date+hour+min+sec;
	    //  System.out.print(year+month+date);
	   return formate ;
	   
        }
       %>
        
       <%
      String all = request.getParameter("allsev");
      String emerg = request.getParameter("severity1");
      String alert  = request.getParameter("severity2");
      String crit = request.getParameter("severity3");
      String error = request.getParameter("severity4");
      String warning = request.getParameter("severity5");
      String notice = request.getParameter("severity6");
      String info = request.getParameter("severity7");
      String debug = request.getParameter("severity8");
      
      if ( all == "all"){
          System.out.println(all);
      }
                else { 
          if ( emerg == "emerg"){
          out.println(emerg);
      }
       if ( alert == "alert"){
          out.println("alert ");
      }
      if ( crit == "crit"){
          out.println("crit ");
      }
       if ( error == "error"){
          out.println("error");
      }
       if ( warning == "warning"){
          out.println("warning");
      }
      if ( info == "info"){
          out.println(info);
      }
      
       if (  info == "info"){
          out.println(all);
      }
      
                     }
      String startdate = request.getParameter("startdate");
      String starttime = request.getParameter("starttime");
      String enddate = request.getParameter("enddate");
      String endtime = request.getParameter("endtime");
     
      
      String value = getformate("05/01/2013","14:30:00");
      String value1 = getformate("05/01/2013","14:30:00");
     
      
      DateFormat dfm = new SimpleDateFormat("yyyyMMddHHmmss");  
      dfm.setTimeZone(TimeZone.getTimeZone("GMT"));  
   
      long start = dfm.parse(value).getTime();  
      long end = dfm.parse(value1).getTime();
      out.println(start);
      out.println(end); // to convert it to secounds
      UUID uuid = TimeUUIDUtils.getTimeUUID(start*1000);
      ByteBuffer recordsKey = ByteBuffer.wrap(uuid.toString().getBytes());
      StringBuilder sb = new StringBuilder();
      for(byte b: uuid.toString().getBytes())
      sb.append(String.format("%02x", b&0xff));
      
      out.println(sb.toString());
      String abc = sb.toString();
       %>
       <div class="tables">
           <p>
		<label for="search"><b>Enter keyword to search </b></label>
		<input type="text" id="search"/>
	   </p>  
	
	<table  id="myTable" class="tablesorter" bgcolor="#ACAAFC">
		
<thead> 
<tr> 
  
                <th>Component</th>
                <th>Facility</th>
                <th>Severity</th>
                <th>Timestamp</th>
                <th>Data</th>

</tr> 
</thead> 
<tbody>
  <%     
               String ksp = (String)session.getAttribute("ksp");
              // String cfn1 = request.getParameter("colfam");
               String cfn = (String)session.getAttribute("colfam");

              Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
              CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
              createKeyspace("hcu", c), se, se, se);

            cqlQuery.setQuery("select * from scis");
                              
           
	    QueryResult<CqlRows<String, String, String>> result = cqlQuery
	    .execute();
            
                     
            
	    if (result != null && result.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                            String colVal1 = row.getColumnSlice().getColumns().get(3).getValue();
                            String colVal2 = row.getColumnSlice().getColumns().get(1).getValue(); 
                            String colVal3 = row.getColumnSlice().getColumns().get(4).getValue();
                            String colVal4 = row.getColumnSlice().getColumns().get(5).getValue();
                            String colVal5 = row.getColumnSlice().getColumns().get(2).getValue();
                            Date time=new Date(Long.parseLong(colVal4));
                            
                          %>
                            
                       <tr>
                         <td style="background-color:#EBEBFF" width="8%"><%=colVal1%> </td>
                         <td style="background-color: #EBEBFF" width="15%"><%=colVal2%> </td>
                         <td style="background-color:#EBEBFF" width="7%"><%=colVal3%> </td>
                         <td style="background-color: #EBEBFF" width="22%"><%=time%> </td>
                         <td style="background-color:#EBEBFF" width="50%"><%=colVal5%> </td>
                     </tr>        
    
    <%             
	            }
	    }
            
    %>
  
 </tbody> 
</table> 
</div>
</html>
