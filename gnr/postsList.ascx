<%@ Control Language="C#" ClassName="postsList" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string POID
    {
        set
        {
            ddlPosts.DataSource = AB.Posts.ListForBinding;
            ddlPosts.DataTextField = "POName";
            ddlPosts.DataValueField = "POid";
            ddlPosts.DataBind();
            ddlPosts.SelectedValue = value;
        }
        get
        {
            return ddlPosts.SelectedValue;
        }
    }
    
</script>
<asp:DropDownList ID="ddlPosts" runat="server" CssClass="FormTextBox" 
    Width="200px">
</asp:DropDownList>

<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlPosts" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً سمت مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً سمت مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>


