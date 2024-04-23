<%@ Control Language="C#" ClassName="rulesPosts" %>

<script runat="server">
    public string RuleID
    {
        set
        {
            rptPosts.DataSource = AB.Rules.Posts(value);
            
            rptPosts.DataBind();
        }
        
    }
</script>

    
    
<asp:Repeater ID="rptPosts" runat="server">
<SeparatorTemplate> - </SeparatorTemplate>
<HeaderTemplate>سمت ها:

</HeaderTemplate>
<ItemTemplate>
    <asp:Literal ID="Literal1" Text='<%# Eval("POName") %>' runat="server"></asp:Literal></ItemTemplate>
</asp:Repeater>




