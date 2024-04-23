<%@ Control Language="C#" ClassName="linLoader" %>

<script runat="server">

protected void Page_Load(object sender, EventArgs e)
    {
        string module = null;
        Page.Title = "آمار اعتباري :: " + Page.Title;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
                
                case "show":
                    plc.Controls.Add(Page.LoadControl("lin/Show.ascx"));
                    break;
                case "manage":
                    plc.Controls.Add(Page.LoadControl("lin/Manage.ascx"));
                    break;
                case "show-total":
                    plc.Controls.Add(Page.LoadControl("lin/ShowTotal.ascx"));
                    break;
                case "show-detail":
                    plc.Controls.Add(Page.LoadControl("lin/ShowDetail.ascx"));
                    break;
                default:
                    plc.Controls.Add(Page.LoadControl("lin/Show.ascx"));
                    break;
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("lin/Show.ascx"));
        }
    }
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>


