<%@ Control Language="C#" ClassName="branchesList" %>

<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string BID
    {
        set
        {
            ddlBranches.DataSource = AB.General.BranchesForBinding;
            ddlBranches.DataTextField = "BName";
            ddlBranches.DataValueField = "bid";
            ddlBranches.DataBind();
            ddlBranches.SelectedValue = value;
        }
        get
        {
            return ddlBranches.SelectedValue;
        }
    }
    public  string UnlockKey
    {
        set
        {
            if (AB.user.HaveKey(value))
            {
                ddlBranches.Enabled = true;
            }
            else
            {
                ddlBranches.Enabled = false;
            }
        }
    }
    public bool Enabled
    {
        set
        {
            ddlBranches.Enabled = value;
            rfvDate.Enabled = value;
        }
    }

    
</script>
<asp:DropDownList ID="ddlBranches" runat="server" CssClass="FormTextBox" 
    Width="140px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlBranches" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً شعبه مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً شعبه مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>

