<%@ Control Language="C#" ClassName="FirstPage" %>

<%@ Register src="downloadShow.ascx" tagname="downloadShow" tagprefix="uc1" %>
<%@ Register src="visitShow.ascx" tagname="visitShow" tagprefix="uc2" %>

<%@ Register src="tableTitle.ascx" tagname="tableTitle" tagprefix="uc3" %>

<%@ Register src="permanentLink.ascx" tagname="permanentLink" tagprefix="uc4" %>

<%@ Register src="commentShow.ascx" tagname="commentShow" tagprefix="uc5" %>







<%@ Register src="userShow.ascx" tagname="userShow" tagprefix="uc7" %>



<%@ Register src="persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc8" %>



<%@ Register src="VerseShower.ascx" tagname="VerseShower" tagprefix="uc9" %>







<%@ Register src="../usr/LoginSystem.ascx" tagname="LoginSystem" tagprefix="uc6" %>







<%@ Register src="../off/offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/FirstPageInfo.ascx" tagname="FirstPageInfo" tagprefix="uc10" %>
<%@ Register src="VerseShower.ascx" tagname="VerseShower" tagprefix="uc4" %>
<%@ Register src="../frm/activeUsers.ascx" tagname="activeUsers" tagprefix="uc11" %>







<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "صفحه نخست :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_", mvw, vwPage, vwLogin);

    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        FirstPageInfo1.PID = AB.user.Email;
    }
</script>
 










<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
      
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc10:FirstPageInfo ID="FirstPageInfo1" runat="server" />
    </asp:View>
</asp:MultiView>
















