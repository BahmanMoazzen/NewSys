<%@ Control Language="C#" ClassName="time" %>

<script runat="server">
    public AB.Time Time
    {
        get
        {
            return new AB.Time(txtHour.Text+":"+txtMinut.Text);
        }
    }
    
    
    public string ValidationGroup
    {
        set
        {
            rvHour.ValidationGroup = rvMinut.ValidationGroup = value;
            
        }
    }
    public string StringTime
    {
        get
        {
            return txtHour.Text + ":" + txtMinut.Text;
        }
        set
        {
            string[] time = value.Split(':');
            txtHour.Text = time[0];
            txtMinut.Text = time[1];
        }
    }
    
    public bool Enabled
    {
        set
        {
            pnlContent.Enabled = value;
            
        }
        get
        {
            return pnlContent.Enabled;
        }
    }
    
</script>
<asp:Panel ID="pnlContent" runat="server">
    <asp:Label ID="Label1" runat="server" Text="ساعت:"></asp:Label>
    <asp:TextBox ID="txtHour" runat="server" Columns="3" CssClass="FormTextBox" 
        MaxLength="2">0</asp:TextBox>
    <asp:RangeValidator ID="rvHour" runat="server" ControlToValidate="txtHour" 
        CssClass="FormError" Display="Dynamic" 
        ErrorMessage="لطفاً يك عدد بين 0 الي 23 وارد نماييد." MaximumValue="23" 
        MinimumValue="0" Type="Integer">*</asp:RangeValidator>
    <asp:Label ID="Label2" runat="server" Text="دقيقه:"></asp:Label>
    <asp:TextBox ID="txtMinut" runat="server" Columns="3" CssClass="FormTextBox" 
        MaxLength="2">0</asp:TextBox>
    <asp:RangeValidator ID="rvMinut" runat="server" ControlToValidate="txtMinut" 
        CssClass="FormError" Display="Dynamic" 
        ErrorMessage="لطفاً يك عدد بين 0 الي 59 وارد نماييد." MaximumValue="59" 
        MinimumValue="0" Type="Integer">*</asp:RangeValidator>
</asp:Panel>

    
        
            
                
                
        
       
