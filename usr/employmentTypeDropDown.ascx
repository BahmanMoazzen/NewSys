<%@ Control Language="C#" ClassName="employmentTypeDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string ETID
    {
        set
        {
            ddlEmploymentType.DataSource = AB.User.EmploymentTypesForBinding;
            ddlEmploymentType.DataTextField = "ETName";
            ddlEmploymentType.DataValueField = "ETid";
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
    Enabled="False" ErrorMessage="لطفاً نوع استخدام مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً نوع استخدام مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>


