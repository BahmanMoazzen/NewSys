<%@ Control Language="C#" ClassName="VerseShower" %>

<script runat="server">
    public string VerseType
    {
        set
        {
            litVerse.Text = AB.General.GetVerse(value);
        }
    }
   
</script>
<asp:Image ID="imgStart" runat="server" ImageAlign="AbsMiddle" 
    ImageUrl="~/images/verse-start.gif" Height="5px" Width="5px" />
<asp:Literal ID="litVerse" runat="server"></asp:Literal>
<asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" 
    ImageUrl="~/images/verse-end.gif" Height="5px" Width="5px" />

