<%@ Control Language="C#" ClassName="forumParentList" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfv.ValidationGroup = value;
            rfv.Enabled = true;
        }
    }
    
    
    public string FParent
    {
        set
        {
            ddl.DataSource = AB.Forum.LoadAllDataForBinding;
            ddl.DataTextField = "ftitle";
            ddl.DataValueField = "fid";
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
            rfv.Enabled = value;
        }
    }


    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    ddl.DataSource = AB.Forum.LoadAllDataForBinding;
    //    ddl.DataTextField = "ftitle";
    //    ddl.DataValueField = "fid";
    //    ddl.DataBind();
    //    if (!hidFParent.Value.Equals(String.Empty))
    //        ddl.SelectedValue = hidFParent.Value;
    //}
</script>
<%--<asp:HiddenField ID="hidFType" runat="server" />
<asp:HiddenField ID="hidFParent" runat="server" />--%>
<asp:DropDownList ID="ddl" runat="server" CssClass="FormTextBox" 
    Width="120px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfv" runat="server" 
    ControlToValidate="ddl" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً بخش مربوطه مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً بخش مربوطه مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>