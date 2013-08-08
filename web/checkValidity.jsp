<script>
function checkvalidity()
            {
                <% try
                                        {
                if(!request.isRequestedSessionIdValid())
                {
                    String msg="Session Expired!";
                    response.sendRedirect("login.jsp?msg="+msg);
                }
                else if(session.getAttribute("user")==null)
               {
                    //String msg="Session Expired or You are not Logged in";                  
                    response.sendRedirect("index.jsp");
                    return ;
               }
                
}
                catch(Exception e)
                               {}
%>                        
        }
    </script>