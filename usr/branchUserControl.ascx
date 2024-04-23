<%@ Control Language="C#" ClassName="branchUserControl" %>

<script runat="server">
    public string BID
    {
        set
        {
            lbShowPersonnel.CommandArgument = value;
        }
        get
        {
            return lbShowPersonnel.CommandArgument;
        }
    }
    public string BName
    {
        set
        {
            lbShowPersonnel.Text = value;
        }
    }
    protected void lbShowPersonnel_Click(object sender, EventArgs e)
    {
        dl.Visible =!dl.Visible;
        if (dl.Visible)
        {
            dl.DataSource = AB.User.BranchPersonnelList(lbShowPersonnel.CommandArgument);

            dl.DataBind();
        }
    }
</script>
<asp:LinkButton ID="lbShowPersonnel" 
                                    runat="server" 
     onclick="lbShowPersonnel_Click"></asp:LinkButton>
<br />
<asp:DataList ID="dl" runat="server" Visible="False" Width="100%">
    <ItemStyle Wrap="False" />
    <HeaderTemplate><table style="border: 1px solid #FF9933; width: 100%; text-align: justify; vertical-align: top;"></HeaderTemplate>
    <ItemTemplate>
        
            
            <tr align="justify" valign="top">
                <td nowrap="nowrap">
                    <asp:Literal ID="litPid" runat="server" Text='<%# Eval("pid") %>'></asp:Literal>
                </td>
                <td nowrap="nowrap">
                   <asp:Literal ID="litPName" runat="server" Text='<%# Eval("PName") %>'></asp:Literal> 
                </td>
                <td nowrap="nowrap">
                    <asp:Literal ID="litPOName" runat="server" Text='<%# Eval("POName") %>'></asp:Literal>
                </td>
                 <td nowrap="nowrap">
                   <asp:Literal ID="litPermanency" runat="server" 
                                            Text='<%# Eval("TTname") %>'></asp:Literal>
                </td>
            </tr>
        
        
    </ItemTemplate>
    <FooterTemplate></table></FooterTemplate>
</asp:DataList>

