<%@ Control Language="C#" ClassName="inlineSigning" %>

<script runat="server">
    private void refreshPage()
    {

        Response.Redirect("http://" + Request.ServerVariables["server_name"] + Request.ServerVariables["URL"] + "?" + Request.QueryString.ToString());
    }
    public string OffId
    {
        set
        {
            hidOffId.Value = value;
        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        mvw.SetActiveView(vwConfirm);
        hidCommandName.Value = btnConfirm.CommandName;
    }

    protected void btnNotConfirm_Click(object sender, EventArgs e)
    {
        mvw.SetActiveView(vwConfirm);
        hidCommandName.Value = btnNotConfirm.CommandName;
    }

    protected void btnNo_Click(object sender, EventArgs e)
    {
        mvw.SetActiveView(vwIdle);
        hidCommandName.Value = String.Empty;
    }
    
    protected void btnYes_Click(object sender, EventArgs e)
    {
        if (hidCommandName.Value.Equals(btnConfirm.CommandName))
        {
            AB.Offs.SignOff(hidOffId.Value);
        }
        if (hidCommandName.Value.Equals(btnNotConfirm.CommandName))
        {
            AB.Offs.NotSignOff(hidOffId.Value);
        }
        refreshPage();
    }
</script>
<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwIdle" runat="server">
        <asp:Button ID="btnConfirm" runat="server" CommandName="1" 
            CssClass="FormButtom" onclick="btnConfirm_Click" Text="امضاء" />
        &nbsp;<asp:Button ID="btnNotConfirm" runat="server" CommandName="2" 
            CssClass="FormButtom" Text="عدم امضاء" onclick="btnNotConfirm_Click" />
    </asp:View>
    <asp:View ID="vwConfirm" runat="server">
        <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
            Text="آيا از انتخاب خود اطمينان داريد؟"></asp:Label>
        <br />
        <asp:Button ID="btnYes" runat="server" CssClass="FormButtom" Text="بله" 
            onclick="btnYes_Click" />
        &nbsp;<asp:Button ID="btnNo" runat="server" CssClass="FormButtom" 
            onclick="btnNo_Click" Text="خير" />
    </asp:View>
</asp:MultiView>

<asp:HiddenField ID="hidOffId" runat="server" />
<asp:HiddenField ID="hidCommandName" runat="server" />



