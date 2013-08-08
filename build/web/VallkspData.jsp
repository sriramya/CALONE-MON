<%-- 
    Document   : VallkspData
    Created on : 7 May, 2013, 11:59:21 PM
    Author     : sriramya
--%>

<%-- 
    Document   : AlltenData
    Created on : 9 Apr, 2013, 9:06:31 PM
    Author     : sriramya
--%>
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
    <body>
       
        
      
       <% /////////////////////////Severity///////////////////////////////
      String all = request.getParameter("allsev");
      String emerg = request.getParameter("severity1");
      String alert  = request.getParameter("severity2");
      String crit = request.getParameter("severity3");
      String error = request.getParameter("severity4");
      String warning = request.getParameter("severity5");
      String notice = request.getParameter("severity6");
      String info = request.getParameter("severity7");
      String debug = request.getParameter("severity8");
      /////////////////////////////TimePicker////////////////////////////
      String startdate = request.getParameter("startdate");
      String starttime = request.getParameter("starttime");
      String enddate = request.getParameter("enddate");
      String endtime = request.getParameter("endtime");
  
      
      ///////////////////////////Component//////////////////////////////
      String allcomp = request.getParameter("component");
      String comp[] = request.getParameterValues("net");
      int length = 0,i;
      if ( comp != null )
          length = comp.length;
       %>
    
           
	
<body style=" background:#95D6E6; " id="pager-demo">
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
  <%      
            Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
            CqlQuery<String, String, String> cqlQuery = new CqlQuery<String, String, String>(
            createKeyspace("ListKeyspace", c), se, se, se);
            
            /////////////////////////////////Timepicker/////////////////////////////////////
            if (startdate != "" & starttime!= "" & enddate != ""  & endtime != "" ){
            CqlQuery<String, String, String> cqlQueryx = new CqlQuery<String, String, String>(
            createKeyspace("ListKeyspace", c), se, se, se);
            cqlQueryx.setQuery("select * from listksp");
	    QueryResult<CqlRows<String, String, String>> result = cqlQueryx
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
                            cqlQuery2.setQuery("select * from "+colfam+" where severity = 'info'"); 
                            QueryResult<CqlRows<String, String, String>> result2 = cqlQuery2
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
                                   </tr>          
             

<%             
	         } }
	    } } 
      }}
       
    
            }
            
            /////////////////////////////////Severity all///////////////////////////////////////
            else  if ( all != null | allcomp != null){
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>      <%       
              
                                }
                              }
                                     
                       }
           
             /////////////////////////////////component one//////////////////////////////////////
            
            else if (length != 0){
                  for (i=0; i < length; i++){
                      String str[] = comp[i].split("/");
                     cqlQuery.setQuery("select * from scis where host = '"+str[0]+"' and component = '"+str[1]+"'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>    <%       
              
                                }
                              }
                          }
                      }
            
                             
            //////////////////////////////severity one//////////////////////////////////////
             else  { 
                                   if ( emerg != null){
                                      cqlQuery.setQuery("select * from scis where severity= 'emerg'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>     <%       
              
                                }
                              }
                                    }
                                   if ( alert != null){
                                     cqlQuery.setQuery("select * from scis where severity= 'alert'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>     <%       
              
                                }
                              }
                                                              }
                                   if ( crit != null){
                                      cqlQuery.setQuery("select * from scis where severity= 'crit'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>      <%       
              
                                }
                              }
                                                       }
                                   if ( error != null){
                                      cqlQuery.setQuery("select * from scis where severity= 'error'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>    <%       
              
                                }
                              }
                                                                   }
                                   if ( warning != null){
                                      cqlQuery.setQuery("select * from scis where severity= 'warning'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>      <%       
              
                                }
                              }
                                                                }
                                   if (notice != null){
                                         cqlQuery.setQuery("select * from scis where severity= 'notice'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>      <%       
              
                                }
                              }                                         
                                                                     }
                                   if ( info != null){
                                      cqlQuery.setQuery("select * from 'scis' where severity= 'info'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>      <%       
              
                                }
                              }
                                                   }
                                   if ( debug != null){
                                     cqlQuery.setQuery("select * from scis where severity= 'debug'");
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
                                       <td height="30px"><%=colVal1%> </td>
                                       <td><%=colVal2%> </td>
                                       <td><%=colVal3%> </td>
                                       <td width="20%" ><%=time%> </td>
                                       <td><%=colVal5%> </td>
                                   </tr>     <%       
              
                                }
                              }
                           }

                         }
           
            
	  %>
    </tbody> 
</table> 
</div>

    </body>
</html>

