<%@ Control Language="C#" ClassName="permissionBinder" %>

<script runat="server">
    public string Keys
    {
        set
        {
            dtlKeys.DataSource = AB.Permissions.Names(value);
            dtlKeys.DataBind();
        }
    }
</script>
<asp:DataList ID="dtlKeys" runat="server" RepeatDirection="Horizontal" 
    CellPadding="1" CellSpacing="1" RepeatColumns="4" ShowFooter="False" 
    ShowHeader="False">
    <SeparatorTemplate>
      
    </SeparatorTemplate>
    <ItemTemplate>
        <asp:Image ID="imgKey" runat="server" ImageAlign="AbsMiddle" 
            ImageUrl='<%# String.Format("~/images/keys/{0}.gif", "6") %>' />
        <asp:Literal ID="litKeyName" runat="server" Text='<%# Eval("PerName") %>'></asp:Literal>
    </ItemTemplate>
</asp:DataList>

