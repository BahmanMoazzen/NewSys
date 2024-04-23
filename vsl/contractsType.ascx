<%@ Control Language="C#" ClassName="contractsType" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        ddl.DataSource = AB.Vosool.ContractTypesForBinding;
        ddl.DataTextField = "ct_name";
        ddl.DataValueField = "ct_id";
        ddl.DataBind();


    }
    public string TypeId
    {
        set
        {
            ddl.SelectedItem.Value=value;
        }
        get
        {
            return ddl.SelectedItem.Value;
        }
    }
    
</script>
<asp:DropDownList ID="ddl" runat="server" CssClass="FormTextBox" 
    Width="200px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddl" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفا نوع قرار داد را انتخاب کنید." 
    ForeColor="" ToolTip="لطفا نوع قرار داد را انتخاب کنید.">*</asp:RequiredFieldValidator>
