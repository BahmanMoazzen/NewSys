<%@ Control Language="C#" ClassName="rulesPermissions" %>

<script runat="server">
    public string RuleID
    {
        set
        {
            rptPermissions.DataSource = AB.Rules.Permissions(value);
            rptPermissions.DataBind();
        }
        
    }
</script>
<asp:Repeater ID="rptPermissions" runat="server">
<SeparatorTemplate> - </SeparatorTemplate>
<HeaderTemplate>مجوز ها:

</HeaderTemplate>
<ItemTemplate>
    <asp:Literal ID="Literal1" Text='<%# Eval("PerName") %>' runat="server"></asp:Literal></ItemTemplate>
</asp:Repeater>


