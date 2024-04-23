<%@ Control Language="C#" ClassName="branchCirclesDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string BCID
    {
        set
        {
            ddlPosts.DataSource = AB.General.BrancheCirclesForBinding;
            ddlPosts.DataTextField = "BCName";
            ddlPosts.DataValueField = "BCid";
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


