<%@ Control Language="C#" ClassName="nwsLoader" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string module = null;
        Page.Title = "اخبار :: " + Page.Title;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
                
                case "show":
                    plc.Controls.Add(Page.LoadControl("nws/ShowNews.ascx"));
                    break;
                case "add":
                    plc.Controls.Add(Page.LoadControl("nws/AddNews.ascx"));
                    break;
                case "my":
                    plc.Controls.Add(Page.LoadControl("nws/MyNews.ascx"));
                    break;
                case "change":
                    plc.Controls.Add(Page.LoadControl("nws/ChangeNews.ascx"));
                    break;
                default:
                    plc.Controls.Add(Page.LoadControl("nws/FirstPage.ascx"));
                    break;
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("nws/FirstPage.ascx"));
        }
    }
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>

