<%@ Control Language="C#" ClassName="adverLoader" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "تبلیغات :: " + Page.Title;
        string module = String.Empty;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
                
                case "remote":
                    Response.Redirect("~/adver/RemoteAdver.aspx?"+Request.QueryString.ToString());
                    break;
                
                
                default:
                    plc.Controls.Add(Page.LoadControl("adver/FirstPage.ascx"));
                    break;
                
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("adver/FirstPage.ascx"));
        }
    }
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>