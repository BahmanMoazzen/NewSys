<%@ Control Language="C#" ClassName="personnelStatusDropdown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string PSID
    {
        set
        {
            ddlEmploymentType.DataSource = AB.User.PersonnelStatusForBinding;
            ddlEmploymentType.DataTextField = "PSName";
            ddlEmploymentType.DataValueField = "PSid";
            ddlEmploymentType.DataBind();
            ddlEmploymentType.SelectedValue = value;
        }
        get
        {
            return ddlEmploymentType.SelectedValue;
        }
    }
    public bool Enabled
    {
        set
        {
            ddlEmploymentType.Enabled = value;
            rfvDate.Enabled = value;
        }
    }
</script>
<asp:DropDownList ID="ddlEmploymentType" runat="server" CssClass="FormTextBox" 
    Width="120px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlEmploymentType" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً وضعيت نظام وظيفه مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً وضعيت نظام وظيفه مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>




