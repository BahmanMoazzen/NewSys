<%@ Control Language="C#" ClassName="offStatDropDown" %>

<script runat="server">
 public string OSttID
    {
        set
        {
            ddlOffType.DataSource = AB.Offs.StatsForBinding;
            if(! value.Equals(String.Empty))
                ddlOffType.SelectedValue = value;
            ddlOffType.DataTextField = "osttname";
            ddlOffType.DataValueField = "osttid";
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
                            
