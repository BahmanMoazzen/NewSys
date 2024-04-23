<%@ Control Language="C#" ClassName="branchAdmin" %>

<style type="text/css">


    
    .FormButtom
    {
        width: 39px;
    }
    </style>

<script runat="server">
    public string LoanInfoID
    {
        set
        {
            lbShow.Visible = true;
            hidLIID.Value = value;
        }
    }
    protected void loadData()
    {


        gvw.DataSource = AB.LoanInfo.Answers.BranchStats(hidLIID.Value);
        gvw.DataBind();



    }
    

    protected void lbBranch_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        AB.LoanInfo.Answers.SetBranchAnswerStat(hidLIID.Value, lb.CommandArgument, "2");
        loadData();
        
    }

    protected void lbShow_Click(object sender, EventArgs e)
    {
        gvw.Visible = !gvw.Visible;
        if(gvw.Visible)
            loadData();
            
        
    }
</script>
<asp:LinkButton ID="lbShow" runat="server" onclick="lbShow_Click">نمايش</asp:LinkButton>

<asp:HiddenField ID="hidLIID" runat="server" />
                        <asp:GridView ID="gvw" runat="server" 
                            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                            CellPadding="1" CellSpacing="1" GridLines="None" 
    Width="100%" ShowHeader="False" Visible="False">
                            <AlternatingRowStyle CssClass="ListAlternateRow" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbBranch" CommandArgument='<%# Eval("BID") %>' Text='<%# Eval("BName") %>' runat="server" onclick="lbBranch_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                VerticalAlign="Top" />
                            <HeaderStyle CssClass="ListHeader" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                            <RowStyle CssClass="ListRow" />
                        </asp:GridView>
                    