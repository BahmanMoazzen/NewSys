<%@ Control Language="C#" ClassName="personnelPic" %>

<script runat="server">
    public string PID
    {
        set
        {
            ibmPic.ImageUrl = String.Format(Resources.Resource.txtUsersImagePath, value);
        }
    }
    protected void ibmPic_Click(object sender, ImageClickEventArgs e)
    {
        if (ibmPic.Width == 35)
        {
            ibmPic.Width = 150;
        }
        else
        {
            ibmPic.Width = 35;
        }
    }
</script>
<asp:ImageButton ID="ibmPic" runat="server" onclick="ibmPic_Click" 
    Width="35px" BorderWidth="1" />

