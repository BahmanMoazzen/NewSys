<%@ Control Language="C#" ClassName="visitShow" %>

<script runat="server">
    public int Visits
    {
        set
        {
            if (value > 50)
            {
                img.ImageUrl = "~/images/visit-hot-little.png";
                
            }
            else
            {
                img.ImageUrl = "~/images/visit-normal-little.png";
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

<asp:Image ID="img" Width="25" runat="server" AlternateText="تعداد بازدید: " ToolTip="تعداد بازدید: "  />
