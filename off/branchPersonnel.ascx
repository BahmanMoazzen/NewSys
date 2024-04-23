<%@ Control Language="C#" ClassName="branchPersonnel" %>

<script runat="server">
    public string BranchCode
    {
        set
        {
            ddlBranchPersonnel.DataSource = AB.General.BranchPersonnelsForBinding(value);
            ddlBranchPersonnel.DataValueField = "pid";
            ddlBranchPersonnel.DataTextField = "pname";
            ddlBranchPersonnel.DataBind();
            
        }
    }
    public string ValidationGroup
    {
        set
        {
            rfv.ValidationGroup = value;
            rfv.Visible = true;
             
        }
    }
    public string SelectedPersonnelID
    {
        get
        {
            return ddlBranchPersonnel.SelectedItem.Value;
        }
        set
        {
            ddlBranchPersonnel.SelectedItem.Value = value;
        }
    }
    public string SelectedPersonnelName
    {
        get
        {
            return ddlBranchPersonnel.SelectedItem.Text;
            
        }
        set
        {
            ddlBranchPersonnel.SelectedItem.Text = value;
        }
    }
    
</script>
<asp:DropDownList ID="ddlBranchPersonnel" runat="server" CssClass="FormTextBox">
</asp:DropDownList>

<asp:RequiredFieldValidator ID="rfv" runat="server" 
    ControlToValidate="ddlBranchPersonnel" CssClass="FormError" Display="Dynamic" 
    ErrorMessage="لطفاً فرد مورد نظر را انتخاب كنبد.">*</asp:RequiredFieldValidator>





