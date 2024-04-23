<%@ Control Language="C#" ClassName="gnrLoader" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string module = null;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
                
                case "years":
                    plc.Controls.Add(LoadControl("~/gnr/Years.ascx"));
                    break;
                case "search":
                    plc.Controls.Add(Page.LoadControl("gnr/Search.ascx"));
                    break;
                case "pointcard":
                    plc.Controls.Add(LoadControl("~/gnr/PointCard.ascx"));
                    break;
                case "help":
                    plc.Controls.Add(LoadControl("~/gnr/Help.ascx"));
                    break;
                case "mytrans":
                    plc.Controls.Add(LoadControl("~/gnr/Transactions.ascx"));
                    break;
                case "offdays":
                    plc.Controls.Add(LoadControl("~/gnr/OffDays.ascx"));
                    break;
                case "branches":
                    plc.Controls.Add(LoadControl("~/gnr/branches.ascx"));
                    break;
            }
        }
        else
        {
        }
    }
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>

