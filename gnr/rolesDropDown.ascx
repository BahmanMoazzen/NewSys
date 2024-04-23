<%@ Control Language="C#" ClassName="rolesDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string RID
    {
        set
        {
            ddlRoles.DataSource = AB.General.RolesForBinding;
            ddlRoles.DataTextField = "rName";
            ddlRoles.DataValueField = "rid";
            ddlRoles.DataBind();
            ddlRoles.SelectedValue = value;
        }
        get
        {
            return ddlRoles.SelectedValue;
        }
    }
    
</script>
<asp:DropDownList ID="ddlRoles" runat="server" CssClass="FormTextBox" 
    Width="200px">
</asp:DropDownList>

<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlRoles" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً نقش مورد نظر را انتخاب كنيد." 
    ForeColor="" ToolTip="لطفاً نقش مورد نظر را انتخاب كنيد.">*</asp:RequiredFieldValidator>


