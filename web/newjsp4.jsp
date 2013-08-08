<%-- 
    Document   : newjsp4
    Created on : 1 May, 2013, 11:57:35 PM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
	<title>jQuery plugin: Tablesorter 2.0 - Child Rows with Filter Widget</title>

	<!-- jQuery -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

	<!-- Demo stuff -->
	<link rel="text/css" href="CSS/a1.css">
	<link href="CSS/a2.css" rel="text/css">
	<script  src="js/j2.js"></script>
	<script  src="js/j3.js"></script>

	<!-- Tablesorter: required -->
	<link rel="text/css" href="CSS/a3.css">
	<script  src="js/jquery.tablesorter.js"></script>
	<script  src="js/j4.js"></script>

        <script>
            $(function() {

  $(".tablesorter")
    .tablesorter({
      theme : 'blue',
      // this is the default setting
      cssChildRow: "tablesorter-childRow",

      // initialize zebra and filter widgets
      widgets: ["zebra", "filter"],

      widgetOptions: {
        // include child row content while filtering, if true
        filter_childRows  : true,
        // class name applied to filter row and each input
        filter_cssFilter  : 'tablesorter-filter',
        // search from beginning
        filter_startsWith : false,
        // Set this option to false to make the searches case sensitive 
        filter_ignoreCase : true
      }

    });

  // hide child rows
  $('.tablesorter-childRow td').hide();

  // Toggle child row content (td), not hiding the row since we are using rowspan
  // Using delegate because the pager plugin rebuilds the table after each page change
  // "delegate" works in jQuery 1.4.2+; use "live" back to v1.3; for older jQuery - SOL
  $('.tablesorter').delegate('.toggle', 'click' ,function(){

    // use "nextUntil" to toggle multiple child rows
    // toggle table cells instead of the row
    $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();

    return false;
  });

  // Toggle widgetFilterChildRows option
  $('button.toggle-option').click(function(){
    var c = $('.tablesorter')[0].config.widgetOptions,
    o = !c.filter_childRows;
    c.filter_childRows = o;
    $('.state').html(o.toString());
    // update filter; include false parameter to force a new search
    $('input.tablesorter-filter').trigger('search', false);
  });

}); 
        </script>
    </head>
    <body>
        <div id="main">

	

	
	<div id="demo"><button class="toggle-option">Toggle Child Row Content</button> : <span class="state">true</span>
       <table class="tablesorter">
  <colgroup>
    <col width="85" />
    <col width="250" />
    <col width="100" />
    <col width="90" />
    <col width="70" />
  </colgroup>
  <thead>
    <tr>
      <th>Order #</th>
      <th>Customer</th>
      <th>PO</th>
      <th>Date</th>
      <th>Total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2"> <!-- rowspan="2" makes the table look nicer -->
        <a href="#" class="toggle">SO71774</a> <!-- link to toggle view of the child row -->
      </td>
      <td>Good Toys</td>
      <td>PO348186287</td>
      <td>Jul 20, 2007</td>
      <td>$972.78</td>
    </tr>
    <tr class="tablesorter-childRow">
      <td colspan="4">
        <div class="bold">Shipping Address</div>
        <div>99700 Bell Road<br>Auburn, California 95603</div>
      </td>
    </tr>
    <tr>
      <td rowspan="2"> <!-- rowspan="2" makes the table look nicer -->
        <a href="#" class="toggle">SO71775</a> <!-- link to toggle view of the child row -->
      </td>
      <td>Cycle Clearance</td>
      <td>PO58159451</td>
      <td>May 6, 2007</td>
      <td>$2,313.13</td>
    </tr>
    <tr class="tablesorter-childRow">
      <td colspan="4">
        <div class="bold">Shipping Address</div>
        <div>2255 254th Avenue Se<br>Albany, Oregon 97321</div>
      </td>
    </tr>

    <!-- View page source for complete HTML markup -->

  </tbody>
</table>

<div id="pager" class="pager">
  <form>
    <input type="button" value="&lt;&lt;" class="first" />
    <input type="button" value="&lt;" class="prev" />
    <input type="text" class="pagedisplay"/>
    <input type="button" value="&gt;" class="next" />
    <input type="button" value="&gt;&gt;" class="last" />
    <select class="pagesize">
      <option selected="selected"  value="10">10</option>
      <option value="20">20</option>
      <option value="30">30</option>
      <option value="40">40</option>
    </select>
  </form>
</div>
            
        </div>
        </div>
    </body>
</html>
