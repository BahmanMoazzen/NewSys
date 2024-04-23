<%@ Control Language="C#" ClassName="offInsertTypeDropDown" %>

<script runat="server">
public string OITID
    {
        set
        {
            ddlOffType.DataSource = AB.Offs.InsertTypeForBinding;
            ddlOffType.SelectedValue = value;
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
                            
