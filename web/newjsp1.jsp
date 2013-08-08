<%-- 
    Document   : newjsp1
    Created on : 2 May, 2013, 10:09:51 AM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script src="js/jquery.min.js"></script>
        <!-- Demo stuff -->
	<link rel="text/css" href="CSS/a1.css">
	<link href="CSS/prettify.css" rel="text/css">
	<script  src="js/prettify.js"></script>
	<script  src="js/docs.js"></script>

	<!-- Tablesorter: required -->
	<link rel="text/css" href="CSS/theme.blue.css">
	<script  src="js/jquery.tablesorter.js"></script>
	<script  src="js/jquery.tablesorter.widgets.js"></script>
        <title>JSP Page</title>
        <script>
            $('table').tablesorter({

    widgets: ['zebra', 'filter'],

    widgetOptions: {

        // Add select box to 4th column (zero-based index) each
        // option has an associated function that returns a boolean 
        // function variables: 
        // e = exact text from cell 
        // n = normalized value returned by the column parser 
        // f = search filter input value 
        // i = column index 
        filter_functions: {

            // Add these options to the select dropdown (date example) 
            // Note that only the normalized (n) value will contain
            // the date as a numerical value (.getTime())
            3: {
                "< 2004"   : function(e, n, f, i) {
                    return n < Date.UTC(2004,0,1); // < Jan 1 2004
                },
                "2004-2006": function(e, n, f, i) {
                    return n >= Date.UTC(2004,0,1) && // Jan 1 2004
                           n < Date.UTC(2007,0,1);   // Jan 1 2007
                },
                "2006-2008": function(e, n, f, i) {
                    return n >= Date.UTC(2006,0,1) && // Jan 1 2006
                           n < Date.UTC(2009,0,1);   // Jam 1 2009
                },
                "2008-2010": function(e, n, f, i) {
                    return n >= Date.UTC(2008,0,1) && // Jan 1 2006
                           n < Date.UTC(2011,0,1);   // Jam 1 2009
                },
                "> 2010": function(e, n, f, i) {
                    return n >= Date.UTC(2010,0,1); // Jan 1 2010
                }
            }
        }

    }

});
        </script>
    </head>
    <body>
       <table class="tablesorter"> 
  <thead> 
    <tr> 
      <th class="filter-select" data-placeholder="Select a name">First Name</th> <!-- add "filter-select" class or filter_functions : { 0: true } --> 
      <th data-placeholder="Exact matches only">Last Name</th> 
      <th>Age</th> 
      <th data-placeholder="Choose a date range">Date</th> 
    </tr> 
  </thead> 
  <tbody> 
    <tr> 
      <td>Aaron</td> 
      <td>Johnson Sr</td> 
      <td>35</td> 
      <td>Jun 26, 2004 7:22 AM</td> 
    </tr> 
    <tr> 
      <td>Aaron</td> 
      <td>Johnson</td> 
      <td>12</td> 
      <td>Aug 21, 2009 12:21 PM</td> 
    </tr> 
    <tr> 
      <td>Clark</td> 
      <td>Henry Jr</td> 
      <td>51</td> 
      <td>Oct 13, 2000 1:15 PM</td> 
    </tr> 
    <tr> 
      <td>Peter</td> 
      <td>Henry</td> 
      <td>28</td> 
      <td>Jul 6, 2006 8:14 AM</td> 
    </tr> 
    <tr> 
      <td>John</td> 
      <td>Hood</td> 
      <td>33</td> 
      <td>Dec 10, 2002 5:14 AM</td> 
    </tr> 
    <tr> 
      <td>Clark</td> 
      <td>Kent Sr</td> 
      <td>18</td> 
      <td>Jan 12, 2003 11:14 AM</td> 
    </tr> 
    <tr> 
      <td>John</td> 
      <td>Kent Esq</td> 
      <td>45</td> 
      <td>Jan 18, 2021 9:12 AM</td> 
    </tr> 
    <tr> 
      <td>Peter</td> 
      <td>Johns</td> 
      <td>13</td> 
      <td>Jan 8, 2012 5:11 PM</td> 
    </tr> 
    <tr> 
      <td>Aaron</td> 
      <td>Evan</td> 
      <td>24</td> 
      <td>Jan 14, 2004 11:23 AM</td> 
    </tr> 
    <tr> 
      <td>Bruce</td> 
      <td>Evans</td> 
      <td>22</td> 
      <td>Jan 18, 2007 9:12 AM</td> 
    </tr> 
    <tr> 
      <td>Clark</td> 
      <td>McMasters</td> 
      <td>18</td> 
      <td>Feb 12, 2010 7:23 PM</td> 
    </tr> 
    <tr> 
      <td>Dennis</td> 
      <td>Masters</td> 
      <td>65</td>
      <td>Jan 20, 2001 1:12 PM</td> 
    </tr> 
    <tr> 
      <td>John</td> 
      <td>Hood</td> 
      <td>25</td> 
      <td>Jun 11, 2011 10:55 AM</td> 
    </tr> 
  </tbody> 
</table>
    </body>
</html>
