<%-- 
    Document   : graph
    Created on : 10 May, 2013, 11:21:25 AM
    Author     : sriramya
--%>

<html>
    <head>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load('visualization', '1.0', {'packages':['corechart']});
            google.setOnLoadCallback(initialize);

            function initialize() {
                // removed the `var opts...` line
                var query = new google.visualization.Query('https://docs.google.com/spreadsheet/tq?range=A%3AB&key=0Aq4N8GK8re42dHlGMG0wM00tdE5PVjJZellXTEhFNEE&gid=0&headers=-1');

                query.send(handleQueryResponse);
            }

            function handleQueryResponse(response) {
                if (response.isError()) {
                    alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
                    return;
                }

                var data = response.getDataTable();
                var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                chart.draw(data, {width: 400, height: 240, is3D: true});
            }
        </script>
    </head>
    <body>
        <div id="chart_div"></div>
    </body>
</html>