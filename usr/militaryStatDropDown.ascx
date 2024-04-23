<%@ Control Language="C#" ClassName="militaryStatDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string MSID
    {
        set
        {
            ddlEmploymentType.DataSource = AB.User.MilitaryStatsForBinding;
            ddlEmploymentType.DataTextField = "MSName";
            ddlEmploymentType.DataValueField = "MSid";
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



