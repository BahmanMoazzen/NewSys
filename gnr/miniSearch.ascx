<%@ Control Language="C#" ClassName="miniSearch" %>

<script runat="server">

    protected void btnMiniSearch_Click(object sender, EventArgs e)
    {
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        mvwMain.SetActiveView(vwForm);
        if (Request.QueryString["module"] != null)
        {
            if (Request.QueryString["module"].Equals("search"))
            {
                mvwMain.SetActiveView(vwIdle);
            }
        }
        
    }

    protected void imbSearch_Click(object sender, ImageClickEventArgs e)
    {
        
            Response.Redirect("~/?system=gnr&module=search&q="+Server.UrlEncode(txtMiniSearch.Text));
        

    }
</script>
<asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="1">
    <asp:View ID="vwIdle" runat="server">
    </asp:View>
    <asp:View ID="vwForm" runat="server">
       
        <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="جستجو:"></asp:Label>
        <asp:TextBox ID="txtMiniSearch" runat="server" CssClass="FormTextBox" 
            ValidationGroup="miniSearch"></asp:TextBox>
        <asp:ImageButton ID="imbSearch" runat="server" AlternateText="جستجو در سایت" 
            CausesValidation="False" Height="20px" ImageAlign="AbsMiddle" 
            ImageUrl="~/images/search.gif" onclick="imbSearch_Click" TabIndex="99" 
            ToolTip="جستجو در سایت" ValidationGroup="miniSearch" Width="20px" />
       
    </asp:View>
</asp:MultiView>


