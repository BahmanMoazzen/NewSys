<%@ Control Language="C#" ClassName="Cuation" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc1" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        height: 64px;
    }
</style>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uniq_id"] != null)
        {
            pdpToday.Date = DateTime.Now;
            string[] minmaj = Request.QueryString["uniq_id"].ToString().Split('/');
            string bid, maj, min;
            string name = Server.UrlDecode(Request.QueryString["name"]);
            bid = min = maj = String.Empty;
            if (minmaj.Length == 3)
            {
                bid = minmaj[0];
                maj = minmaj[1];
                min = minmaj[2];

            }
            else if (minmaj.Length == 2)
            {
                bid = AB.user.BID;
                maj = minmaj[0];
                min = minmaj[1];

            }
            //Response.Write(Request.QueryString["uniq_id"]);
            if(Request.QueryString["ctype"].Equals("3"))
                lblLetter.Text = String.Format(Resources.Resource.txtVosoolCaution3, String.Format("{0}/{1}", maj, min), AB.General.BranchName(bid), name);
            else if(Request.QueryString["ctype"].Equals("1"))
                lblLetter.Text = String.Format(Resources.Resource.txtVosoolCaution1, AB.Vosool.ContractName(bid, maj, min), String.Format("{0}/{1}", maj, min), AB.General.BranchName(bid), name);
            else if (Request.QueryString["ctype"].Equals("2"))
                lblLetter.Text = String.Format(Resources.Resource.txtVosoolCaution2, AB.Vosool.ContractName(bid,maj,min), String.Format("{0}/{1}", maj, min), AB.General.BranchName(bid),name);
            
                
        }
        else
        {
            Response.Redirect("~/");
        }
    }
</script>

<table cellpadding="15" cellspacing="15" class="style1">
    <tr>
        <td>

            <table cellpadding="0" cellspacing="0" class="style1">
                <tr>
                    <td align="left">

            <table >
                <tr>
                    <td align="center">
                        .....................</td>
                    <td dir="rtl">
                        <asp:Label ID="Label3" runat="server" Text="شماره:" Font-Names="B Nazanin" 
                            Font-Size="12pt"></asp:Label></td>
                </tr>
                <tr>
                    <td><span style='font-size:12.0pt;font-family:"B Nazanin","sans-serif";mso-bidi-font-family:"B Nazanin"'>
                        <uc1:persianDateBinder ID="pdpToday" runat="server" />
                        </span>
                    </td>
                    <td align="left" dir="rtl">
                        <asp:Label ID="Label2" runat="server" Text="تاریخ:" Font-Names="B Nazanin" 
                            Font-Size="12pt"></asp:Label>&nbsp;</td>
                </tr>
            </table>

                    </td>
                    <td width="50%" align="right">
                        <img alt="" src="/newsys/images/logo.jpg" style="height: 82px; width: 60px" /></td>
                </tr>
            </table>
            <hr />
        </td>
    </tr>
    <tr>
        <td class="style2">

<asp:Label ID="lblLetter" runat="server" Text="Label"></asp:Label>

        </td>
    </tr>
</table>


