<%-- 
    Document   : index
    Created on : 5 Apr, 2013, 10:43:59 AM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <script>
            function validate()
            {
                var username=document.getElementById("user").value;
                var password=document.getElementById("password").value;
               if(username==""){
                  alert("Please Enter Username");
			document.forms["frm"].user.focus();
			return false;
		}
              else if(password==""){
                  alert("Please Enter Password");
			document.forms["frm"].password.focus();
			return false;
		}
              else 
            	return true;
                  
            }   
          
        </script>
    </head>
    <body>
       
     <div align="center">
        <form method="post" action="authtable.jsp" id="frm" onsubmit="return validate()">
         <div align="center">
        <br><br><br><br>
        <table  width="25%" border="0" cellspacing="0" cellpadding="0">

        <tr>
        <td align="center">
        <fieldset>

        <Legend>
        <font face="Verdana,Tahoma,Arial,sans-serif" size="1" color="gray">
        <img  src="sym3.png" alt="Authorization Check">
        <br>
        </font>
        </Legend>

            <table width="100%"  border="0" cellspacing="3" cellpadding="0">

        <tr>
                <!--[if lt IE 8]>
        <div style='align: left; text-align: left; border: 2px dotted red;'>LogZilla has not been certified to work with the browser you are using. You may continue, but the application might not behave as expected.</div>
        <![endif]-->
       
        <td align="center" valign="middle">
            <input class="clear" placeholder="Username" type="text" size="15" id="user" name="user" >
        </td>
        </tr>

        <tr>
        
        <td align="center" valign="middle">
            <input class="pass" placeholder="Password" type="password" size="15" id="password" name="password">
        </td>
        </tr>
       
                    </table>
        <input style="background-color:#FFBD45"type="submit" value="Login"  name="submit" />
        <br>
        </div>
        </td>
        </tr>
        </fieldset>
        </table>
</div>
        </form>
    </body>
</html>
