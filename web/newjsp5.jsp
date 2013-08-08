<%-- 
    Document   : AlltenData
    Created on : 9 Apr, 2013, 9:06:31 PM
    Author     : sriramya
--%>
<%@page import="me.prettyprint.hector.api.beans.Row"%>
<%@page import="me.prettyprint.cassandra.serializers.UUIDSerializer"%>
<%@page import="me.prettyprint.hector.api.beans.Rows"%>
<%@page import="me.prettyprint.hector.api.query.MultigetSliceQuery"%>
<%@page import="me.prettyprint.hector.api.Keyspace"%>
<%@page import="me.prettyprint.hector.api.factory.HFactory"%>
<%@page import="java.nio.ByteBuffer"%>
<%@page import="me.prettyprint.cassandra.utils.TimeUUIDUtils"%>
<%@page import="java.lang.String"%>
<%-- 
    Document   : DissAllTenData
    Created on : 3 Apr, 2013, 3:30:28 PM
    Author     : sriramya
--%>

<%@page import="com.eaio.util.lang.Hex"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
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
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
	<title>jQuery plugin: Tablesorter 2.0 - Pager plugin + Filter widget</title>

	<!-- jQuery -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

	<!-- Demo stuff -->
	<link rel="stylesheet" href="css/jq.css">
	<link href="css/prettify.css" rel="stylesheet">
	<script src="js/prettify.js"></script>
	<script src="js/docs.js"></script>

	<!-- Tablesorter: required -->
	<link rel="stylesheet" href="../css/theme.blue.css">
	<script src="../js/jquery.tablesorter.js"></script>

	<!-- Tablesorter: optional -->
	<link rel="stylesheet" href="../addons/pager/jquery.tablesorter.pager.css">
	<script src="../addons/pager/jquery.tablesorter.pager.js"></script>
	<script src="../js/jquery.tablesorter.widgets.js"></script>

</head>
    <body id="pager-demo">
	<div id="banner">
		<h1>table<em>sorter</em></h1>
		<h2>Pager plugin + Filter widget</h2>
		<h3>Flexible client-side table sorting</h3>
		<a href="index.html">Back to documentation</a>
	</div>

	<div id="main">

	<div class="pager">
		Page: <select class="gotoPage"></select>
		<img src="../addons/pager/icons/first.png" class="first" alt="First" title="First page" />
		<img src="../addons/pager/icons/prev.png" class="prev" alt="Prev" title="Previous page" />
		<span class="pagedisplay"></span> <!-- this can be any element, including an input -->
		<img src="../addons/pager/icons/next.png" class="next" alt="Next" title="Next page" />
		<img src="../addons/pager/icons/last.png" class="last" alt="Last" title= "Last page" />
		<select class="pagesize">
			<option selected="selected" value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
		</select>
	</div>

<table class="tablesorter">
	<thead>
		<tr>
                     <th width ="10%">bcount</th>
                                       <th width ="10%">daddr</th>
                                       <th width ="10%">dport</th>
                                       <th width ="4%">dst_as</th>
                                       <th width ="4%">dst_mask</th>
                                       <th width ="10%">etime</th> 
                                       <th width ="4%">input</th>
                                       <th width ="10%">next_hop</th>
                                       <th width ="10%">output</th>
                                       <th width ="4%">pcount</th>
                                       <th width ="10%">protocol</th>
                                       <th width ="9%">saddr</th>
                                       <th width ="10%">sport</th>
                                       <th width ="10%">src_as</th>
                                       <th width ="10%">src_mask</th>
                                       <th width ="10%">stime</th>
                                       <th width ="10%">tcp_flags</th>
                                       <th width ="10%">tos</th>
                                       </tr>
	</thead>
	<tfoot>
		<tr><th width ="10%">bcount</th>
                                       <th width ="10%">daddr</th>
                                       <th width ="10%">dport</th>
                                       <th width ="4%">dst_as</th>
                                       <th width ="4%">dst_mask</th>
                                       <th width ="10%">etime</th> 
                                       <th width ="4%">input</th>
                                       <th width ="10%">next_hop</th>
                                       <th width ="10%">output</th>
                                       <th width ="4%">pcount</th>
                                       <th width ="10%">protocol</th>
                                       <th width ="9%">saddr</th>
                                       <th width ="10%">sport</th>
                                       <th width ="10%">src_as</th>
                                       <th width ="10%">src_mask</th>
                                       <th width ="10%">stime</th>
                                       <th width ="10%">tcp_flags</th>
                                       <th width ="10%">tos</th>
                </tr>
                </tfoot>
	<tbody>
      <%!  
          public static int gethour(String Date, String time){
	   String[] str,str1;
	   int formate;
	   str = Date.split("-");
	   String year = str[0];
	   String month = str[1];
	   String date = str[2];
	   
	   str1 = time.split(":");
	   String hour = str1[0];
	   String min = str1[1];
	
	   formate  = Integer.parseInt(year+month+date+hour);
	    //  System.out.print(year+month+date);
	   return formate ;
	   
        }
           public static String gettmstp(String Date, String time){
	   String[] str,str1;
	   String formate =null;
           if (Date != null & time != null){
	   str = Date.split("-");
	   String year = str[0];
	   String month = str[1];
	   String date = str[2];
	   
	   str1 = time.split(":");
	   String hour = str1[0];
	   String min = str1[1];
               
	   formate  = year+month+date+hour+min+"00";
           return formate ;
           }
	    //  System.out.print(year+month+date);
	   return formate ;
	   
        }
       %>  
        
      
    <% ////////////////////////////////severity//////////////////////
      String allsev = request.getParameter("allsev");
      String sev[] = request.getParameterValues("severity");
      int slength = 0,i,j,k;
      if ( sev != null )
          slength = sev.length;
      
      /////////////////////////////TimePicker////////////////////////////
      String startdate = request.getParameter("startdate");
      String starttime = request.getParameter("starttime");
      String enddate = request.getParameter("enddate");
      String endtime = request.getParameter("endtime");
      
     /*long abc = dfm.parse("20130512235614").getTime();
                        out.println(start);
                        out.println(end); // to convert it to secounds
                        UUID uuid = TimeUUIDUtils.getTimeUUID(start);
                        ByteBuffer recordsKey = ByteBuffer.wrap(uuid.toString().getBytes());
                        StringBuilder sb = new StringBuilder();
                        for(byte b: uuid.toString().getBytes())
                        sb.append(String.format("%02x", b&0xff));

                        out.println(sb.toString());
                        String ab = sb.toString();*/
      
      ///////////////////////////Component//////////////////////////////
      String allcomp = request.getParameter("network");
      String comp[] = request.getParameterValues("net");
      int clength = 0;
      if ( comp != null )
          clength = comp.length;
      
     
       %>
    
    
<tbody>
    <%
     Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
              CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
              createKeyspace("netflow", c), se, se, se);

            cqlQuery1.setQuery("select * from records_index limit 1");
                              
           
	    String array[] = new String[10];
            array[0] = "2013052210";
            
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
                        
                                    String bcount = row2.getColumnSlice().getColumns().get(1).getValue();
                                    String daddr = row2.getColumnSlice().getColumns().get(2).getValue();
                                    String dport = row2.getColumnSlice().getColumns().get(3).getValue();
                                    String dst_as = row2.getColumnSlice().getColumns().get(4).getValue();
                                     String dst_mask = row2.getColumnSlice().getColumns().get(5).getValue();
                                    String etime = row2.getColumnSlice().getColumns().get(6).getValue();
                                    String input= row2.getColumnSlice().getColumns().get(7).getValue();
                                    String next_hop = row2.getColumnSlice().getColumns().get(8).getValue();
                                    String output  = row2.getColumnSlice().getColumns().get(9).getValue();
                                    String pcount = row2.getColumnSlice().getColumns().get(10).getValue();
                                    String protocol = row2.getColumnSlice().getColumns().get(11).getValue();
                                    String saddr  = row2.getColumnSlice().getColumns().get(12).getValue();
                                    String sport = row2.getColumnSlice().getColumns().get(13).getValue();
                                    String src_as = row2.getColumnSlice().getColumns().get(14).getValue();
                                    String src_mask = row2.getColumnSlice().getColumns().get(15).getValue();
                                    String stime  = row2.getColumnSlice().getColumns().get(16).getValue();
                                    String tcp_flags = row2.getColumnSlice().getColumns().get(17).getValue();
                                    String tos= row2.getColumnSlice().getColumns().get(18).getValue();
                                  
                                   
                                                                        

                                    
                                   // out.println(colVal1);
                                   
                                    
                                     %>
                                      <tr>
                                       <th width ="10%"><%=bcount%></th>
                                       <th width ="10%"><%=daddr%></th>
                                       <th width ="10%"><%=dport%></th>
                                       <th width ="10%"><%=dst_as%></th>
                                       <th width ="10%"><%=dst_mask%></th>
                                       <th width ="10%"><%=etime%></th> 
                                       <th width ="10%"><%=input%></th>
                                       <th width ="10%"><%=next_hop%></th>
                                       <th width ="10%"><%=output%></th>
                                       <th width ="10%"><%=pcount%></th>
                                       <th width ="10%"><%=protocol%></th>
                                       <th width ="10%"><%=saddr%></th>
                                       <th width ="10%"><%=sport%></th>
                                       <th width ="10%"><%=src_as%></th>
                                       <th width ="10%"><%=src_mask%></th>
                                       <th width ="10%"><%=stime%></th>
                                        <th width ="10%"><%=tcp_flags%></th>
                                       <th width ="10%"><%=tos%></th>
                                   </tr>          
             
                                  
        <%

	         } }
                       }
                               }
  
            
    %>
 </tbody>
</table>


</div>

</body>
</html>
