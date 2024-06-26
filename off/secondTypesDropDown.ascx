﻿<%@ Control Language="C#" ClassName="secondTypesDropDown" %>


<script runat="server">
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
        }
    }
    public string OSTID
    {
        set
        {
            ddlGrades.DataSource = AB.Offs.SecondTypesForBinding;
            ddlGrades.DataTextField = "OSTName";
            ddlGrades.DataValueField = "OSTID";
            ddlGrades.DataBind();
            ddlGrades.SelectedValue = value;
        }
        get
        {
            return ddlGrades.SelectedValue;
        }
    }
   
</script>
<asp:DropDownList ID="ddlGrades" runat="server" CssClass="FormTextBox" 
    Width="120px">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="ddlGrades" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً مدرك مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً شعبه مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>
