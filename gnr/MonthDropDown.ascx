<%@ Control Language="C#" ClassName="MonthDropDown" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate0.ValidationGroup = rfvDate.ValidationGroup = value;
            rfvDate0.Enabled = rfvDate.Enabled = true;
        }
    }
    public string MID
    {
        
            
            
        
        get
        {
            return ddlMonth.SelectedValue;
        }
    }

    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadMonth();

    }
    protected void loadYear()
    {
        ddlYear.DataSource = AB.General.YearsForBinding;
        ddlYear.DataTextField = "yearname";
        ddlYear.DataValueField = "yearid";
        ddlYear.DataBind();
    }
    protected void loadMonth()
    {
        ddlMonth.DataSource = AB.General.MonthsForBinding(ddlYear.SelectedValue);
        ddlMonth.DataTextField = "MName";
        ddlMonth.DataValueField = "MID";
        ddlMonth.DataBind();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        loadYear();
        ddlYear.SelectedValue = AB.General.CurrentYearID;
        loadMonth();
        ddlMonth.SelectedValue = AB.General.CurrentMonthID;
    }
</script>
<asp:DropDownList ID="ddlYear" runat="server" CssClass="FormTextBox" 
    onselectedindexchanged="ddlYear_SelectedIndexChanged" AutoPostBack="True">
</asp:DropDownList>

<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlYear" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً سال مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً سال مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>
<asp:DropDownList ID="ddlMonth" runat="server" CssClass="FormTextBox">
</asp:DropDownList>

<asp:RequiredFieldValidator ID="rfvDate0" runat="server" 
    ControlToValidate="ddlMonth" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً ماه مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً ماه مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>
