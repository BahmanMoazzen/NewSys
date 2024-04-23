<%@ Control Language="C#" ClassName="userShow" %>
<script runat="server">
    public string DisplayName
    {
        set
        {
            hplUser.Text=lblDisplayName.Text = value;
            
        }
    }
    public string TypeName
    {
        set
        {
            imgRank.ToolTip = imgRank.AlternateText = value;
            
        }
    }
    public string Email
    {
        set
        {
            hplUser.NavigateUrl = "/?system=usr&module=profile&email=" + Server.UrlEncode(value);
        }
    }
    public string Kind
    {
        set
        {
            
            
            imgRank.ImageUrl = "/images/ranks/" + value + "s.jpg";
            if (value.IndexOf("none") > 0)
            {
                lblDisplayName.Visible = true;
                hplUser.Visible = false;
            }
            else
            {
                lblDisplayName.Visible = false;
                hplUser.Visible = true;
                
            }
            
        }
    }

</script>
<asp:Image  Width="15" Height="15" BorderWidth="0" ImageAlign="AbsMiddle" ID="imgRank" runat="server" /><asp:HyperLink  ID="hplUser" runat="server"></asp:HyperLink>
<asp:Label
    ID="lblDisplayName" runat="server"></asp:Label>