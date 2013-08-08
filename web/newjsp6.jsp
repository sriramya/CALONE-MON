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
      String starthate = request.getParameter("starthate");
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
			<option selected="selected" value="10">Fit In page</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="150">150</option>
		</select>
	</div>
        <table style="font-family: open san; font-size: 30px; color: black; " class="tablesorter">
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
	</tfoot>
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
                                  
                          
                                    
                                     %>
                                       <tr>
                                       <td width ="10%"><%=bcount%></td>
                                       <td width ="10%"><%=daddr%></td>
                                       <td width ="10%"><%=dport%></td>
                                       <td width ="10%"><%=dst_as%></td>
                                       <td width ="10%"><%=dst_mask%></td>
                                       <td width ="10%"><%=etime%></td> 
                                       <td width ="10%"><%=input%></td>
                                       <td width ="10%"><%=next_hop%></td>
                                       <td width ="10%"><%=output%></td>
                                       <td width ="10%"><%=pcount%></td>
                                       <td width ="10%"><%=protocol%></td>
                                       <td width ="10%"><%=saddr%></td>
                                       <td width ="10%"><%=sport%></td>
                                       <td width ="10%"><%=src_as%></td>
                                       <td width ="10%"><%=src_mask%></td>
                                       <td width ="10%"><%=stime%></td>
                                        <td width ="10%"><%=tcp_flags%></td>
                                       <td width ="10%"><%=tos%></td>
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
