<%@ Control Language="C#" ClassName="branchesLink" %>

<script runat="server">
    public string BranchName
    {
        set
        {
            btnBranch.Text = btnBranch.Text.Replace("$N", value);
        }
    }
    public string BranchCode
    {
        set
        {
            btnBranch.Text = btnBranch.Text.Replace("$C", value);
            btnBranch.CommandArgument = value;
        }
    }
    
    protected void btnBranch_Click(object sender, EventArgs e)
    {

        dtlPhones.DataSource = AB.General.BranchPhones(btnBranch.CommandArgument.ToString());
        dtlPhones.DataBind();
        dtlPhones.Visible = true;
    }
</script>
<asp:LinkButton ID="btnBranch" runat="server" onclick="btnBranch_Click">$C-$N</asp:LinkButton>
<asp:DataList ID="dtlPhones" runat="server" Visible="False">
    <ItemTemplate>
        <asp:Label ID="lblDsc" runat="server" Text='<%# Eval("dsc") %>'></asp:Label>: <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("tel") %>'></asp:Label>
    </ItemTemplate>
</asp:DataList>
