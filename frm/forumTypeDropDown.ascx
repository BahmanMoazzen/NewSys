<%@ Control Language="C#" ClassName="forumTypeDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string FType
    {
        set
        {
            
            ddlType.SelectedValue = value;
        }
        get
        {
            return ddlType.SelectedValue;
        }
    }
    public bool Enabled
    {
        set
        {
            ddlType.Enabled = value;
            rfvDate.Enabled = value;
        }
    }
</script>
<asp:DropDownList ID="ddlType" runat="server" CssClass="FormTextBox" 
    Width="120px">
    <asp:ListItem Value="1">اتاق</asp:ListItem>
    <asp:ListItem Value="2">موضوع</asp:ListItem>
    <asp:ListItem Value="3">نظر</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlType" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً نوع مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً نوع مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>