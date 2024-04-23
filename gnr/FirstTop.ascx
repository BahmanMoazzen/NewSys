<%@ Control Language="C#" ClassName="FirstTop" %>

<%@ Register src="Ghesar.ascx" tagname="Ghesar" tagprefix="uc1" %>



<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.ToString().Equals(String.Empty))
        {
            mvw.SetActiveView(vwShow);
        }
        else
        {
            mvw.SetActiveView(vwBlank);
        }
        
    }
</script>
<asp:MultiView ID="mvw" runat="server">
    <asp:View ID="vwShow" runat="server">
        <p align="center">
            <img  src="images/Noori/periodic.jpg" />
            <uc1:Ghesar ID="Ghesar1" runat="server" />
        </p>
    </asp:View>
    <asp:View ID="vwBlank" runat="server">
    </asp:View>
</asp:MultiView>




