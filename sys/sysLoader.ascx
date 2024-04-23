<%@ Control Language="C#" ClassName="sysLoader" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string module = null;
        Page.Title = "دايره سيستم ها :: " + Page.Title;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module.ToLower())
            {

                case "add-satna":
                    plc.Controls.Add(Page.LoadControl("sys/AddSatnaMember.ascx"));
                    break;
                case "show-satna":
                    plc.Controls.Add(Page.LoadControl("sys/ShowSatnaGroup.ascx"));
                    break;
                case "show-satna-change":
                    plc.Controls.Add(Page.LoadControl("sys/ShowSatnaChange.ascx"));
                    break;
                case "add-atm":
                    plc.Controls.Add(Page.LoadControl("sys/AddAtmMember.ascx"));
                    break;
                case "show-atm":
                    plc.Controls.Add(Page.LoadControl("sys/ShowAtmGroup.ascx"));
                    break;
                case "show-atm-change":
                    plc.Controls.Add(Page.LoadControl("sys/ShowAtmChange.ascx"));
                    break;
                
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("gnr/FirstPage.ascx"));
        }
    }
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>