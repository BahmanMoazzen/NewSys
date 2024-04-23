<%@ Control Language="C#" ClassName="commentShow" %>

<script runat="server">
    public int Comments
    {
        set
        {
            if (value > 50)
            {
                img.ImageUrl = "~/images/comments-hot-little.png";
            }
            else
            {
                img.ImageUrl = "~/images/comments-normal-little.png";
            }
            img.AlternateText += value.ToString();
            img.ToolTip += value.ToString();
        }
    }
    public int Width
    {
        set
        {
            img.Width = value;
        }
    }

</script>

<asp:Image Width="25" ID="img" runat="server" AlternateText="تعداد نظر: " ToolTip="تعداد نظر: "  />
