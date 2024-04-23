<%@ Control Language="C#" ClassName="majorsDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string MajorId
    {
        set
        {
            ddl.DataSource = AB.Vosool.MinorsForBindings;
            ddl.DataTextField = "maj_name";
            ddl.DataValueField = "maj_id";
            ddl.DataBind();
            ddl.SelectedValue = value;
        }
        get
        {
            return ddl.SelectedValue;
        }
    }
    
    public bool Enabled
    {
        set
        {
            ddl.Enabled = value;
            rfvDate.Enabled = value;
        }
    }

    
</script>
<asp:DropDownList ID="ddl" runat="server" CssClass="FormTextBox" 
    Width="200px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddl" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً سرفصل مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً سرفصل مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>
