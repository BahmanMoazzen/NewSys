<%@ Control Language="C#" ClassName="usrLoader" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = "کاربران :: " + Page.Title;
        string module = null;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
               
                case "add-staff":
                    plc.Controls.Add(Page.LoadControl("usr/AddNewStaff.ascx"));
                    break;
                case "personnel-total":
                    plc.Controls.Add(Page.LoadControl("usr/TotalReport.ascx"));
                    break;
                case "chart":
                    plc.Controls.Add(Page.LoadControl("usr/Chart.ascx"));
                    break;

                case "posts":
                    plc.Controls.Add(Page.LoadControl("usr/Posts.ascx"));
                    break;
                case "change-pass":
                    plc.Controls.Add(Page.LoadControl("usr/ChangeUser.ascx"));
                    break;

                case "rep-managerial":
                    plc.Controls.Add(Page.LoadControl("usr/ManagerialReport.ascx"));
                    break;
                case "personnels":
                    plc.Controls.Add(Page.LoadControl("usr/PersonnelsList.ascx"));
                    break;
                case "rules":
                    plc.Controls.Add(Page.LoadControl("usr/Rules.ascx"));
                    break;
                case "personnel-permission":
                    plc.Controls.Add(Page.LoadControl("usr/PersonnelPermission.ascx"));
                    break;
                case "personnel-count":
                    plc.Controls.Add(Page.LoadControl("usr/PersonnelScreenedCount.ascx"));
                    break;
                case "grant-permission":
                    plc.Controls.Add(Page.LoadControl("usr/GrantPermission.ascx"));
                    break;
                //default:
                //    plc.Controls.Add(Page.LoadControl("usr/ChangeUser.ascx"));
                //    break;
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("usr/RegisterSystem.ascx"));
        }
    }
</script>

<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>
