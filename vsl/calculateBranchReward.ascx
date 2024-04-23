<%@ Control Language="C#" ClassName="calculateBranchReward" %>

<script runat="server">

    public string BID
    {
        set { hidBid.Value = value; }
        get { return hidBid.Value; }
    }
    public string MID
    {
        set { hidMid.Value = value; }
        get { return hidMid.Value; }
    }
    protected void btnShowFinalList_Click(object sender, EventArgs e)
    {
        if (hidBid.Value != String.Empty && hidMid.Value != String.Empty)
        {
            AB.Vosool.CalculateBranchReward(hidMid.Value, hidBid.Value);
            mvw.SetActiveView(vwDone);
        }
    }
</script>
<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwButton" runat="server">
        <asp:Button ID="btnCalc" runat="server" CssClass="FormButtom" 
            onclick="btnShowFinalList_Click" Text="محاسبه " />
    </asp:View>
    <asp:View ID="vwDone" runat="server">
        <asp:Label ID="Label1" runat="server" CssClass="FormInfo" Text="انجام شد"></asp:Label>
    </asp:View>
</asp:MultiView>

<asp:HiddenField ID="hidBid" runat="server" />


<asp:HiddenField ID="hidMid" runat="server" />


