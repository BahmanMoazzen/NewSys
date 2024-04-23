<%@ Control Language="C#" ClassName="downloadShow" %>

<script runat="server">
    public int Downloads
    {
        set
        {
            if (value > 50)
            {
                img.ImageUrl = "~/images/download-hot-little.png";
            }
            else
            {
                img.ImageUrl = "~/images/download-normal-little.png";
            }
            img.ToolTip+=value.ToString();
            img.AlternateText += value.ToString();
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

<asp:Image Width="25" ID="img" runat="server" AlternateText="تعداد دریافت: " ToolTip="تعداد دریافت: "  />