<%-- 
    Document   : test
    Created on : 2 May, 2013, 12:13:24 AM
    Author     : sriramya
--%>

<%@page import="me.prettyprint.hector.api.beans.Row"%>
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


<%@page import="me.prettyprint.hector.api.query.MultigetSliceQuery"%>
<%@page import="me.prettyprint.hector.api.beans.Rows"%>
<%@page import=" me.prettyprint.hector.api.Keyspace"%>
<%@page import="me.prettyprint.hector.api.query.SliceQuery"%>
<%@page import="me.prettyprint.hector.api.query.ColumnQuery"%>
<%@page import=" me.prettyprint.hector.api.Keyspace"%>
<%@page import="me.prettyprint.hector.api.factory.HFactory"%>
<%@page import="me.prettyprint.hector.api.query.RangeSlicesQuery"%>
<%@page import="me.prettyprint.hector.api.beans.OrderedRows"%>
<%@page import="me.prettyprint.hector.api.beans.ColumnSlice"%>
<%@page import="me.prettyprint.cassandra.serializers.UUIDSerializer"%>
<%@page import="me.prettyprint.hector.api.factory.HFactory"%>
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
	   str = Date.split("-");
	   String year = str[0];
	   String month = str[1];
	   String date = str[2];
	   
	   str1 = time.split(":");
	   String hour = str1[0];
	   String min = str1[1];
	
	   formate  = year+month+date+hour;
	    //  System.out.print(year+month+date);
	   return formate ;
	   
        }
       %>
         <table style="font-family: open san; font-size: 30px; color: black; " class="tablesorter">
	<thead>
		<tr>
                    <th>Host</th>
                    
                </tr>
	</thead>
	
       <%
/* 
      String startdate = request.getParameter("startdate");
      String starttime = request.getParameter("starttime");
      String enddate = request.getParameter("enddate");
      String endtime = request.getParameter("endtime");
     
      
      String value = getformate(startdate,starttime);
      String value1 = getformate(enddate,endtime);
     out.println(value);
     out.println("2013040616");
      
     DateFormat dfm = new SimpleDateFormat("yyyyMMddHHmmss");  
      dfm.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));  
   
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
      String abc = sb.toString();*/
       %>
  <%     int i;
              Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
              CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
              createKeyspace("netflow", c), se, se, se);

            cqlQuery1.setQuery("select * from records_index");
                              
           
	    String array[] = new String[10];
            array[0] = "2013051523";
            
            StringSerializer stringSerializer = StringSerializer.get();         
            Keyspace keyspaceOperator = HFactory.createKeyspace("netflow", c);
 
            MultigetSliceQuery<String, UUID, String> multigetSliceQuery = 
                    HFactory.createMultigetSliceQuery(keyspaceOperator, stringSerializer, UUIDSerializer.get(), stringSerializer);
            multigetSliceQuery.setColumnFamily("records_index");
            multigetSliceQuery.setKeys(array);

            // set null range for empty byte[] on the underlying predicate
            multigetSliceQuery.setRange(null, null, false, 2000000000);
            //out.println(multigetSliceQuery);

            QueryResult<Rows<String, UUID, String>> result1 = multigetSliceQuery.execute();
            Rows<String, UUID, String> orderedRows = result1.get();
           
            
            int j=0;
            String Key;
            for (Row<String, UUID, String> r : orderedRows) {
                for(j=0; j<r.getColumnSlice().getColumns().size(); j++) {
                 
                 Key=r.getColumnSlice().getColumns().get(j).getName().toString();
            cqlQuery1.setQuery("select * from records where key ='"+Key+"'");
                              
           
	    QueryResult<CqlRows<String, String, String>> result2 = cqlQuery1
	    .execute();
            
            if (result2 != null && result2.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                    String colVal1 = row2.getColumnSlice().getColumns().get(1).getValue().toString();
                                   
                                   %>
                                   <tbody>
                                       <tr>
                                       <td ><%=colVal1%> </td>
                                   </tr>          
             
                                   </tbody>
        <%

	         } }
                       }
                               }
  
            
    %>
  
</body>
</html>

