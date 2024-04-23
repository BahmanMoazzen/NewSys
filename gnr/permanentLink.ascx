<%@ Control Language="C#" ClassName="permanentLink" %>

<script runat="server">
    public string Text
    {
        set
        {
            hpl.Text = value;
        }
    }
    public string NavigateURL
    {
        set
        {
            hpl.NavigateUrl = value;
        }
    
    }
    public string Icon
    {
        set
        {
            img.ImageUrl = "../images/link/" + value + ".jpg";
            img.Visible = true;
        }
        
    }
</script>


<asp:Image ID="img" Visible="false" runat="server" ImageAlign="AbsMiddle"  /> 
<asp:HyperLink ID="hpl" runat="server"></asp:HyperLink>