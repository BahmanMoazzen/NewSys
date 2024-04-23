<%@ Control Language="C#" ClassName="tableTitle" %>

<script runat="server">
    public string Text
    {
        set
        {
            lbl.Text = value;
            
        }
        get
        {
            return lbl.Text;
        }
    }
    public int Icon
    {
        set
        {
            img.ImageUrl = "~/images/titles/"+value.ToString()+".jpg";
            img.Visible = true;
        }
        
    }
    public string SubText
    {
        set
        {
            lblSub.Text = value;
            lblSub.Visible = true;
        }
        get
        {
            return lblSub.Text;
        }
    }
</script>


<asp:Image  ID="img" runat="server" ImageAlign="AbsMiddle" Visible="False" /> <asp:Label ID="lbl" runat="server" Font-Bold="True"></asp:Label>
<br />
<asp:Label Visible="false" ID="lblSub" runat="server"></asp:Label>