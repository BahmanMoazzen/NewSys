<%@ Control Language="C#" ClassName="OffTypeDropDown" %>

<script runat="server">
    public string OTID
    {
        set
        {
            ddlOffType.DataSource = AB.Offs.TypesForBinding;
            if (!value.Equals(String.Empty)) 
                ddlOffType.SelectedValue = value;
            ddlOffType.DataTextField = "otname";
            ddlOffType.DataValueField = "otid";
            ddlOffType.DataBind();
            
        }
        get
        {
            return ddlOffType.SelectedValue;
        }
    }
    
</script>
                                <asp:DropDownList ID="ddlOffType" 
    runat="server" CssClass="FormTextBox">
                                </asp:DropDownList>
                            
