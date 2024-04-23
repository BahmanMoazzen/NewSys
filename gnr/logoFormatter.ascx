<%@ Control Language="C#" ClassName="logoFormatter" %>

<script runat="server">
    public string Text
    {
        set
        {
            hplText.Text = value;
            hplPic.ToolTip = value;
            
        }
    }
    public string NavigateUrl
    {
        set
        {
            hplPic.NavigateUrl =hplText.NavigateUrl = value;
           
            
        }
    }
    public string PictureUrl
    {

        set
        {
           hplPic.ImageUrl = value;
        }
    }

</script>
<table width="100%" border="0" cellspacing="3" cellpadding="1">
  <tr>
    <td align="center" valign="top">
        <asp:HyperLink ID="hplPic" runat="server" BorderWidth="1px" >
            
        </asp:HyperLink>
      </td>
  </tr>
  <tr>
    <td align="center" valign="top">
        <asp:HyperLink ID="hplText" runat="server"></asp:HyperLink>
      </td>
  </tr>
</table>