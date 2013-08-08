<%-- 
    Document   : index
    Created on : 19 Apr, 2013, 12:18:03 PM
    Author     : sriramya
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<!--------------------
LOGIN FORM
by: Amit Jakhu
www.amitjakhu.com
--------------------->

<!--META-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CALONE-MON</title>
<link href="CSS/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<!--Slider-in icons-->
<script type="text/javascript">
     
            function validate()
            {
                var role = document.getElementById("admin").value;
                if (role == "none"){
                    alert("Select role");
                    return false;
                }
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
          
        
    
$(document).ready(function() {
	$(".username").focus(function() {
		$(".user-icon").css("left","-48px");
	});
	$(".username").blur(function() {
		$(".user-icon").css("left","0px");
	});
	
	$(".password").focus(function() {
		$(".pass-icon").css("left","-48px");
	});
	$(".password").blur(function() {
		$(".pass-icon").css("left","0px");
	});
});
</script>

</head>
    
    <body> 
    <style type="text/css">

html { background:#56c2e1;}
h {
	color: #003366;
	font-family:Open Sans;
	font-weight: 100;
	
}
</style>

<!--WRAPPER-->
<div id="wrapper" name="index">

	<!--SLIDE-IN ICONS-->
    <div class="user-icon"></div>
    <div class="pass-icon"></div>
    <!--END SLIDE-IN ICONS-->

<!--LOGIN FORM-->
<form method="post" action="auth.jsp"  class="login-form" id="frm" onsubmit="return validate()" >
   

	<!--HEADER-->
    <div class="header">
        <!--TITLE--><h1><h>CALONE-MON</h> </h1>
       
     
    <!--DESCRIPTION--><!--END DESCRIPTION-->
    </div>
   
	<!--CONTENT-->
    <div class="content">
    <!--USERNAME--><input name="user"     type="text"     class="input username" placeholder="Username" id="user"  ><!--END USERNAME-->
    <!--PASSWORD--><input name="password" type="password" class="input password" placeholder="Password" id="password" /><!--END PASSWORD-->
    </div>
    <!--END CONTENT-->
    
    <!--FOOTER-->
   
    <div class="footer">
        <center>
            <!--LOGIN BUTTON--><input type="submit" name="submit" value="Login" class="button" /><!--END LOGIN BUTTON--></center>

    </div>
    <!--END FOOTER-->

</form>
<!--END LOGIN FORM-->

</div>
<!--END WRAPPER-->

<!--GRADIENT--><div class="gradient"></div><!--END GRADIENT-->

</body>
</html>