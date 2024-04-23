<%@ Control Language="C#" ClassName="today" %>

<%@ Register src="persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc6" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        load();
    }
    private void load()
    {
        pdbToday.Date = DateTime.Now;
        
    }

    protected void tmrUpdateTime_Tick(object sender, EventArgs e)
    {
        load();
    }
</script>

        <uc6:persianDateBinder CssStyle="Today" ID="pdbToday" runat="server" />
        
    
                           
                    



                           
                    

