<%@ Control Language="C#" ClassName="rulePostsPermissionsManagement" %>

<script runat="server">
    public string RuleID
    {
        set
        {
            
            AB.Rules.LoadPermissionsInCheckList(chLPermissions.Items, value);
            
            
            AB.Rules.LoadPostsInCheckList(chLPosts.Items, value);
            
            
            
        }
    }

    public CheckBoxList Permissions
    {
        get
        {
            return chLPermissions;
        }
    }
    public CheckBoxList Posts
    {
        get
        {
            return chLPosts;
        }
    }
</script>
<p>
<asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="مجوز ها:"></asp:Label>
<br />
<asp:CheckBoxList ID="chLPermissions" runat="server" CssClass="FormButtom" 
        RepeatDirection="Horizontal" RepeatColumns="3">
</asp:CheckBoxList></p>
<p>
    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="سمت ها:">
    </asp:Label><br />
    <asp:CheckBoxList ID="chLPosts" runat="server" 
        CssClass="FormButtom" RepeatDirection="Horizontal" RepeatColumns="3">
</asp:CheckBoxList>
</p>


