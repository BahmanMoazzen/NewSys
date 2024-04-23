<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {

        Application["on-lines"] = new ArrayList();
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        Application.Lock();
        
        
        Application.UnLock();

    }

    void Session_End(object sender, EventArgs e) 
    {
        Application.Lock();
        if (Session["user"] != null)
        {
            ArrayList onLineUsers = (ArrayList)Application["on-lines"];
            onLineUsers.Remove(AB.user);
            Application["on-lines"] = onLineUsers;
        }
        
        Application.UnLock();

    }
       
</script>
