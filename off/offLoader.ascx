<%@ Control Language="C#" ClassName="offLoader" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string module = null;
        Page.Title = "مرخصي :: " + Page.Title;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module.ToLower())
            {
                
                case "add":
                    plc.Controls.Add(Page.LoadControl("off/AddOffTotal.ascx"));
                    break;
                case "off-latency-fines":
                    plc.Controls.Add(Page.LoadControl("off/offHourlyPaymentFines.ascx"));
                    break;
                case "addhourly":
                    plc.Controls.Add(Page.LoadControl("off/AddHourlyOff.ascx"));
                    break;
                case "demulish":
                    plc.Controls.Add(Page.LoadControl("off/addDemulished.ascx"));
                    break;
                case "cardex":
                    plc.Controls.Add(Page.LoadControl("off/OffCardex.ascx"));
                    break;
                case "cardex-sep":
                    plc.Controls.Add(Page.LoadControl("off/OffCardexSeprated.ascx"));
                    break;
                case "cardex-seply":
                    plc.Controls.Add(Page.LoadControl("off/OffCardexSeprately.ascx"));
                    break;
                case "sub-sign":
                    plc.Controls.Add(Page.LoadControl("off/SubSign.ascx"));
                    break;
                case "request":
                    plc.Controls.Add(Page.LoadControl("off/RequestNewOff.ascx"));
                    break;
                case "mine":
                    plc.Controls.Add(Page.LoadControl("off/MyOffs.ascx"));
                    break;
                case "personnel":
                    plc.Controls.Add(Page.LoadControl("off/PersonnelOffs.ascx"));
                    break;
                case "confirm":
                    plc.Controls.Add(Page.LoadControl("off/ConfirmOffs.ascx"));
                    break;
                case "sign":
                    plc.Controls.Add(Page.LoadControl("off/SignOffs.ascx"));
                    break;
                case "sign-boss":
                    plc.Controls.Add(Page.LoadControl("off/SignBossesOffs.ascx"));
                    break;
                case "rep-management":
                    plc.Controls.Add(Page.LoadControl("off/OffManagerialReport.ascx"));
                    break;
                case "rep-branch":
                    plc.Controls.Add(Page.LoadControl("off/OffBranchReport.ascx"));
                    break;
                case "add-addetive":
                    plc.Controls.Add(Page.LoadControl("off/AddAdetive.ascx"));
                    break;
                case "addetives":
                    plc.Controls.Add(Page.LoadControl("off/EditeAddetive.ascx"));
                    break;
                case "off-fines":
                    plc.Controls.Add(Page.LoadControl("off/offHourlyFines.ascx"));
                    break;
                case "total-rep":
                    plc.Controls.Add(Page.LoadControl("off/OffTotalSolution.ascx"));
                    break;
                //default:
                //    plc.Controls.Add(Page.LoadControl("nws/FirstPage.ascx"));
                //    break;
            }
        }
        else
        {
            plc.Controls.Add(Page.LoadControl("nws/FirstPage.ascx"));
        }
    }

        
</script>
<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>

