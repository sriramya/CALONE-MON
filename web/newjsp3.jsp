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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script src="js/j1.js"></script>

	<!-- Demo stuff -->
	<link rel="stylesheet" href="CSS/jq.css">
	<link href="CSS/prettify.css" rel="stylesheet">
	<script src="js/prettify.js"></script>
	<script src="js/docs.js"></script>

	<link rel="stylesheet" href="CSS/theme.blue.css">
	<script src="js/jquery.tablesorter.js"></script>
	
	<!-- Tablesorter: optional -->
	<link rel="stylesheet" href="CSS/jquery.tablesorter.pager.css">
	<script src="js/jquery.tablesorter.pager.js"></script>
        
	<script src="js/jquery.tablesorter.widgets.js"></script>

	<script id="js">$(function(){

	// define pager options
	var pagerOptions = {
		// target the pager markup - see the HTML block below
		container: $(".pager"),
		// output string - default is '{page}/{totalPages}'; possible variables: {page}, {totalPages}, {startRow}, {endRow} and {totalRows}
		output: '{startRow} - {endRow} / {filteredRows} ({totalRows})',
		// if true, the table will remain the same height no matter how many records are displayed. The space is made up by an empty
		// table row set to a height to compensate; default is false
		fixedHeight: true,
		// remove rows from the table to speed up the sort of large tables.
		// setting this to false, only hides the non-visible rows; needed if you plan to add/remove rows with the pager enabled.
		removeRows: false,
		// go to page selector - select dropdown that sets the current page
		cssGoto:	 '.gotoPage'
	};

	// Initialize tablesorter
	// ***********************
	$("table")
		.tablesorter({
			theme: 'blue',
			headerTemplate : '{content} {icon}', // new in v2.7. Needed to add the bootstrap icon!
			widthFixed: true,
			widgets: ['zebra', 'filter']
		})

		// initialize the pager plugin
		// ****************************
		.tablesorterPager(pagerOptions);

		// Add two new rows using the "addRows" method
		// the "update" method doesn't work here because not all rows are
		// present in the table when the pager is applied ("removeRows" is false)
		// ***********************************************************************
		var r, $row, num = 50,
			row = '<tr><td>Student{i}</td><td>{m}</td><td>{g}</td><td>{r}</td><td>{r}</td><td>{r}</td><td>{r}</td><td><button class="remove" title="Remove this row">X</button></td></tr>' +
				'<tr><td>Student{j}</td><td>{m}</td><td>{g}</td><td>{r}</td><td>{r}</td><td>{r}</td><td>{r}</td><td><button class="remove" title="Remove this row">X</button></td></tr>';
		$('button:contains(Add)').click(function(){
			// add two rows of random data!
			r = row.replace(/\{[gijmr]\}/g, function(m){
				return {
					'{i}' : num + 1,
					'{j}' : num + 2,
					'{r}' : Math.round(Math.random() * 100),
					'{g}' : Math.random() > 0.5 ? 'male' : 'female',
					'{m}' : Math.random() > 0.5 ? 'Mathematics' : 'Languages'
				}[m];
			});
			num = num + 2;
			$row = $(r);
			$('table')
				.find('tbody').append($row)
				.trigger('addRows', [$row]);
		});

		// Delete a row
		// *************
		$('table').delegate('button.remove', 'click' ,function(){
			var t = $('table');
			// disabling the pager will restore all table rows
			t.trigger('disable.pager');
			// remove chosen row
			$(this).closest('tr').remove();
			// restore pager
			t.trigger('enable.pager');
		});

		// Destroy pager / Restore pager
		// **************
		$('button:contains(Destroy)').click(function(){
			// Exterminate, annhilate, destroy! http://www.youtube.com/watch?v=LOqn8FxuyFs
			var $t = $(this);
			if (/Destroy/.test( $t.text() )){
				$('table').trigger('destroy.pager');
				$t.text('Restore Pager');
			} else {
				$('table').tablesorterPager(pagerOptions);
				$t.text('Destroy Pager');
			}
		});

		// Disable / Enable
		// **************
		$('.toggle').click(function(){
			var mode = /Disable/.test( $(this).text() );
			$('table').trigger( (mode ? 'disable' : 'enable') + '.pager');
			$(this).text( (mode ? 'Enable' : 'Disable') + 'Pager');
		});
		$('table').bind('pagerChange', function(){
			// pager automatically enables when table is sorted.
			$('.toggle').text('Disable');
		});

});
        </script>
        <style>
    html { background:#95D6E6; font-family:Open Sans; }
</style>
        <style>
            body
{
	font-family:verdana,arial;
	font-size:20px;
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
        font-family: "Georgia",Georgia,Serif;
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
.odd
{font-size:17px;
	background-color:#DCDEFC;
	color:#343234;
}
        </style>
    </head>
    <body style=" background:#95D6E6; " id="pager-demo">
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
    
           
	

    <br>
	<div id="main">
	<button class="toggle">Disable Pager</button> <button>Destroy Pager</button>
	
        <div style="float: right" class="pager">
		Page: <select class="gotoPage"></select>
		<img src="icons/first.png" class="first" alt="First" title="First page" />
		<img src="icons/prev.png" class="prev" alt="Prev" title="Previous page" />
                <w style="border: 5px; width: 100px;height: 5px;"><span class="pagedisplay"></span></w> <!-- this can be any element, including an input -->
		<img src="icons/next.png" class="next" alt="Next" title="Next page" />
		<img src="icons/last.png" class="last" alt="Last" title= "Last page" />
		<select class="pagesize">
			<option selected="selected" value="10">10</option>
                        <option value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
		</select>
	</div>
        <table style="font-family: open san; font-size: 30px; color: black; " class="tablesorter">
	<thead>
		<tr>
                    <th>Host</th>
                    <th>Component</th>
                    <th>Severity</th>
                    <th class="filter-false">Timestamp</th>
                    <th class="filter-false">Data</th>
                    <%--     <th class="filter-false">Geometry</th> --%>
                </tr>
	</thead>
	<tfoot>
		<tr>
                   <th>Host</th>
                    <th>Component</th>
                    <th>Severity</th>
                    <th>Timestamp</th>
                    <th>Data</th>
                </tr>
	</tfoot>
<tbody>
    <%        String ksp = (String) session.getAttribute("ksp");
            Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
                    createKeyspace(ksp, c), se, se, se);
            
            /////////////////////////////////Timepicker/////////////////////////////////////
            if (startdate != "" & starttime!= "" & enddate != ""  & endtime != "" ){
                        
                
                        int h1 = gethour(startdate,starttime);
                        int h2 = gethour(enddate,endtime);
                        String t1 = gettmstp(startdate, starttime);
                        String t2 = gettmstp(enddate,endtime);
                        
                        int diff = h2 - h1;
                        String array[] = new String[diff+1];
                             for(i=0; i<= diff; i++){
                               array[i] = Integer.toString((h1+i));
                              }
                        DateFormat dfm = new SimpleDateFormat("yyyyMMddHHmmss");  
                        dfm.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));  

                        long start = dfm.parse(t1).getTime();  
                        long end = dfm.parse(t2).getTime();
                        
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                  String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                  String indcol = colfam+"_TimeIndex";
                                                    cqlQuery.setQuery("select * from "+indcol+" ");
                                                      StringSerializer stringSerializer = StringSerializer.get();         
                                                      Keyspace keyspaceOperator = HFactory.createKeyspace(ksp, c);
                                                      MultigetSliceQuery<String, UUID, String> multigetSliceQuery = 
                                                              HFactory.createMultigetSliceQuery(keyspaceOperator, stringSerializer, UUIDSerializer.get(), stringSerializer);
                                                      multigetSliceQuery.setColumnFamily(indcol);
                                                      multigetSliceQuery.setKeys(array);
                                                      // set null range for empty byte[] on the underlying predicate
                                                      multigetSliceQuery.setRange(null, null, false, 2000000000);
                                                      //out.println(multigetSliceQuery);
                                                      QueryResult<Rows<String, UUID, String>> result3 = multigetSliceQuery.execute();
                                                      Rows<String, UUID, String> orderedRows = result3.get();
                                                      String Key;
                                                        for (Row<String, UUID, String> r : orderedRows) {
                                                            for(k=0; k<r.getColumnSlice().getColumns().size(); k++) {
                                                                Key=r.getColumnSlice().getColumns().get(k).getName().toString();
                                                                cqlQuery.setQuery("select * from "+colfam+" where key ='"+Key+"'");
                                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                                .execute();

                                                                if (result2 != null && result2.get() != null) {
                                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                                    for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                    String host = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                    String component = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                    String severity = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                    String tmstamp = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                    String data = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                    Date time=new Date(Long.parseLong(tmstamp)); 
                                                                    
                                                                    if (Long.parseLong(tmstamp) > start &  Long.parseLong(tmstamp) < end) {
                                                                        if ((allsev != null & allcomp != null) | (slength == 0 & clength == 0) |
                                                                            (allsev != null & clength == 0) | (slength ==0 & allcomp != null) ){

                                                                                  %>
                                                                                    <tr>
                                                                                       <td height="30px"><%=host%> </td>
                                                                                       <td><%=component%> </td>
                                                                                       <td><%=severity%> </td>
                                                                                       <td width="20%" ><%=time%> </td>
                                                                                       <td><%=data%> </td>
                                                                                   </tr> <%       
                                                                        }
                                                                        else if(slength != 0 & clength == 0){
                                                                                for(i = 0; i < slength; i++){
                                                                                    if (severity.equals(sev[i])){
                                                                                        %>
                                                                                            <tr>
                                                                                               <td height="30px"><%=host%> </td>
                                                                                               <td><%=component%> </td>
                                                                                               <td><%=severity%> </td>
                                                                                               <td width="20%" ><%=time%> </td>
                                                                                               <td><%=data%> </td>
                                                                                           </tr> <% 
                                                                                    }
                                                                              }
                                                                        }
                                                                        else if (clength != 0 & slength == 0){
                                                                            for(i = 0; i < clength; i++){
                                                                                String str[] = comp[i].split("/");
                                                                                       String h = str[0];
                                                                                       String com = str[1];
                                                                                    if (component.equals(com) & host.equals(h)){
                                                                                        %>
                                                                                            <tr>
                                                                                               <td height="30px"><%=host%> </td>
                                                                                               <td><%=component%> </td>
                                                                                               <td><%=severity%> </td>
                                                                                               <td width="20%" ><%=time%> </td>
                                                                                               <td><%=data%> </td>
                                                                                           </tr> <% 
                                                                                    }
                                                                              }
                                                                        }
                                                                        else {
                                                                            for(i=0; i< slength;i++){
                                                                                for(j=0; j< clength; j++){
                                                                                    String str[] = comp[j].split("/");
                                                                                       String h = str[0];
                                                                                       String com = str[1];
                                                                                     if (severity.equals(sev[i]) & component.equals(com) & host.equals(h)){
                                                                                        %>
                                                                                            <tr>
                                                                                               <td height="30px"><%=host%> </td>
                                                                                               <td><%=component%> </td>
                                                                                               <td><%=severity%> </td>
                                                                                               <td width="20%" ><%=time%> </td>
                                                                                               <td><%=data%> </td>
                                                                                            </tr> <% 
                                                                                    }
                                                                                }
                                                                            }
                                                                     }
                                                                  } 
                                                      } }
	                                  
                                       
                          }}
                    }}
            }
                       
                
        /////////////////////////////////Severity///////////////////////////////////////
            else if ( clength == 0){
                 if (allsev != null){
                    
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                cqlQuery.setQuery("select * from "+colfam+""); 
                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                .execute();
                                                    if (result2 != null && result2.get() != null) {
                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                        for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                String colVal1 = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                String colVal2 = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                String colVal3 = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                String colVal4 = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                String colVal5 = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                Date time=new Date(Long.parseLong(colVal4));
                                                                       %>
                                                                       <tr>
                                                                          <td height="30px"><%=colVal1%> </td>
                                                                          <td><%=colVal2%> </td>
                                                                          <td><%=colVal3%> </td>
                                                                          <td width="20%" ><%=time%> </td>
                                                                          <td><%=colVal5%> </td>
                                                                      </tr>      <%       

                                                                   }
                                                                 }
                                                          } }  
                                                                                                                   
                 }
                 else {
                      
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                for (i = 0; i < slength; i++){
                                                cqlQuery.setQuery("select * from "+colfam+" where severity = '"+sev[i]+"'"); 
                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                .execute();
                                                    if (result2 != null && result2.get() != null) {
                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                        for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                String colVal1 = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                String colVal2 = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                String colVal3 = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                String colVal4 = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                String colVal5 = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                Date time=new Date(Long.parseLong(colVal4));
                                                                       %>
                                                                       <tr>
                                                                          <td height="30px"><%=colVal1%> </td>
                                                                          <td><%=colVal2%> </td>
                                                                          <td><%=colVal3%> </td>
                                                                          <td width="20%" ><%=time%> </td>
                                                                          <td><%=colVal5%> </td>
                                                                      </tr>      <%       

                                                                   }
                                                                 }
                                                               }
                                                          } }  
                                                      
                 } 
            }
           
            ///////////////////////////////component////////////////////////////////////
            else if (slength == 0){
                 if (allcomp != null){
                   
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                cqlQuery.setQuery("select * from "+colfam+""); 
                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                .execute();
                                                    if (result2 != null && result2.get() != null) {
                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                        for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                String colVal1 = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                String colVal2 = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                String colVal3 = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                String colVal4 = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                String colVal5 = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                Date time=new Date(Long.parseLong(colVal4));
                                                                       %>
                                                                       <tr>
                                                                          <td height="30px"><%=colVal1%> </td>
                                                                          <td><%=colVal2%> </td>
                                                                          <td><%=colVal3%> </td>
                                                                          <td width="20%" ><%=time%> </td>
                                                                          <td><%=colVal5%> </td>
                                                                      </tr>      <%       

                                                                   }
                                                                 }
                                                          } }  
                                                                                                                    
                 }
                 else {
                      
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                for (i = 0; i < clength; i++){
                                                     String str[] = comp[i].split("/");
                                                            String h = str[0];
                                                            String com = str[1];
                                                cqlQuery.setQuery("select * from "+colfam+" where host = '"+h+"' and component = '"+com+"'"); 
                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                .execute();
                                                    if (result2 != null && result2.get() != null) {
                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                        for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                String colVal1 = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                String colVal2 = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                String colVal3 = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                String colVal4 = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                String colVal5 = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                Date time=new Date(Long.parseLong(colVal4));
                                                                       %>
                                                                       <tr>
                                                                          <td height="30px"><%=colVal1%> </td>
                                                                          <td><%=colVal2%> </td>
                                                                          <td><%=colVal3%> </td>
                                                                          <td width="20%" ><%=time%> </td>
                                                                          <td><%=colVal5%> </td>
                                                                      </tr>      <%       

                                                                   }
                                                                 }
                                                               }
                                                          } }  
                                                       
                 } 
            }
            
     //////////////////////////////severity and component//////////////////////////////////////
            else if (slength != 0 & clength != 0) {
                
                                        cqlQuery.setQuery("select * from CFNlist");
                                        QueryResult<CqlRows<String, String, String>> result1 = cqlQuery
                                        .execute();
                                            if (result1 != null && result1.get() != null) {
                                            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list1 = result1.get().getList();
                                                for (me.prettyprint.hector.api.beans.Row<String, String, String> row1 : list1) {
                                                String colfam = row1.getColumnSlice().getColumns().get(1).getValue();
                                                for(j=0; j< slength ;j++) {
                                                for (i = 0; i < clength; i++){
                                                     String str[] = comp[i].split("/");
                                                            String h = str[0];
                                                            String com = str[1];
                                                cqlQuery.setQuery("select * from "+colfam+" where severity = '"+sev[j]+"' and host = '"+h+"' and component = '"+com+"'"); 
                                                QueryResult<CqlRows<String, String, String>> result2 = cqlQuery
                                                .execute();
                                                    if (result2 != null && result2.get() != null) {
                                                    java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
                                                        for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                                                                String colVal1 = row2.getColumnSlice().getColumns().get(3).getValue();
                                                                String colVal2 = row2.getColumnSlice().getColumns().get(1).getValue(); 
                                                                String colVal3 = row2.getColumnSlice().getColumns().get(4).getValue();
                                                                String colVal4 = row2.getColumnSlice().getColumns().get(5).getValue();
                                                                String colVal5 = row2.getColumnSlice().getColumns().get(2).getValue();
                                                                Date time=new Date(Long.parseLong(colVal4));
                                                                       %>
                                                                       <tr>
                                                                          <td height="30px"><%=colVal1%> </td>
                                                                          <td><%=colVal2%> </td>
                                                                          <td><%=colVal3%> </td>
                                                                          <td width="20%" ><%=time%> </td>
                                                                          <td><%=colVal5%> </td>
                                                                      </tr>      <%       

                                                                   }
                                                                 }
                                                               }}
                                                          } }  
                                                     
            }
            else 
                out.println("No data is available");
           
                  
	  %>
    </tbody> 
</table> 
</div>

    </body>
</html>

<%--
 cqlQuery.setQuery("select * from scis_TimeIndex where key >'32303133303430363136' and key < '32303133303430363137'");
                    QueryResult<CqlRows<String, String, String>> result = cqlQuery
                     .execute(); 
                       if (result != null && result.get() != null) {
                             java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list = result.get().getList();
                             for (me.prettyprint.hector.api.beans.Row<String, String, String> row : list) {
                             int len = row.getColumnSlice().getColumns().size();
                             String cols[] = new String[len];
                             out.println(len);
                             for( i=1;i<len ;i++){
                              cols[i] = row.getColumnSlice().getColumns().get(i).getValue();
                             }
             
                         //    Date time=new Date(Long.parseLong(tmstamp));
                                    %>
                                    <tr> <%for( i=1;i<len ;i++) {
                                        // Date time=new Date(Long.parseLong(cols[i]));%>
                                        
                                       <td height="30px"><%=cols[i] %> </td>
                                       <%}%>
                                   </tr>    <%       
              
                                }
                              }

--%>