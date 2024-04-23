<%@ Control Language="C#" ClassName="vslLoader" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = "وصول مطالبات :: " + Page.Title;
        string module = null;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {

                case "contracts":
                    plc.Controls.Add(Page.LoadControl("vsl/Contracts.ascx"));
                    break;
                case "regional-caution":
                    plc.Controls.Add(Page.LoadControl("vsl/regional-caution.ascx"));
                    break;
                case "branch-flowups":
                    plc.Controls.Add(Page.LoadControl("vsl/BranchFlowups.ascx"));
                    break;
                case "my-logs":
                    plc.Controls.Add(Page.LoadControl("vsl/MyLogs.ascx"));
                    break;
                case "my-contracts":
                    plc.Controls.Add(Page.LoadControl("vsl/MyContracts.ascx"));
                    break;
                case "daily-rep":
                    plc.Controls.Add(Page.LoadControl("vsl/DailyReport.ascx"));
                    break;
                case "daily-rep-total":
                    plc.Controls.Add(Page.LoadControl("vsl/DailyReportTotal.ascx"));
                    break;
                case "comparative-rep":
                    plc.Controls.Add(Page.LoadControl("vsl/ComparativeReport.ascx"));
                    break;
                case "mosharekat-comparative-rep":
                    plc.Controls.Add(Page.LoadControl("vsl/MosharekatComparativeReport.ascx"));
                    break;
                case "add-log":
                    plc.Controls.Add(Page.LoadControl("vsl/AddLog.ascx"));
                    break;
                case "distribution-rep":
                    plc.Controls.Add(Page.LoadControl("vsl/DistributionReport.ascx"));
                    break;
                case "bad-account":
                    plc.Controls.Add(Page.LoadControl("vsl/BadAccounts.ascx"));
                    break;
                case "mosharekat-daily-rep":
                    plc.Controls.Add(Page.LoadControl("vsl/DailyMosharekatReport.ascx"));
                    break;
                case "calc-reward":
                    plc.Controls.Add(Page.LoadControl("vsl/RewardCalculator2.ascx"));
                    break;
                case "add-contract":
                    plc.Controls.Add(Page.LoadControl("vsl/AddContract.ascx"));
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

