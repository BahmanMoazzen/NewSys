<%@ Control Language="C#" ClassName="ratingShow" %>

<script runat="server">

    public int Rating
    {
        set
        {
            img.ImageUrl = "../images/rating/"+value.ToString()+".png";
            img.AlternateText = value.ToString() + "/5";
        }
    }
</script>

<asp:Image ID="img" ImageAlign="AbsMiddle" runat="server" Width="134px" Height="25px" />