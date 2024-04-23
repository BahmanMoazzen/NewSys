<%@ Control Language="C#" ClassName="DeadEnd" %>
<%@ Register src="permanentLink.ascx" tagname="permanentLink" tagprefix="uc1" %>



<script runat="server">

</script>
<table width="100%" border="0" cellspacing="3" cellpadding="3">
  <tr>
    <td align="center" valign="top"><table width="100%" border="0" cellspacing="3" cellpadding="3">
      <tr valign="top">
        <td width="34%">
            <uc1:permanentLink ID="permanentLink2" runat="server" Icon="2" NavigateURL="~/" 
                Text="صفحه اول" />
          </td>
        <td width="33%">
            <uc1:permanentLink ID="permanentLink3" runat="server" Icon="2" 
                NavigateURL="~/?system=nws" Text="اخبار" />
            <br />
            <uc1:permanentLink ID="permanentLink7" runat="server" Icon="1" 
                NavigateURL="~/?system=nws&amp;module=add" Text="ارسال خبر" />
            <br />
            <uc1:permanentLink ID="permanentLink8" runat="server" Icon="1" 
                NavigateURL="~/?system=nws&amp;module=search" Text="جستجو در اخبار" />
          </td>
        <td width="33%">
            <uc1:permanentLink ID="permanentLink4" runat="server" Icon="2" 
                NavigateURL="~/?system=art" Text="مقالات" />
            <br />
            <uc1:permanentLink ID="permanentLink5" runat="server" Icon="1" 
                NavigateURL="~/?system=art&amp;module=add" Text="ارسال مقاله" />
            <br />
            <uc1:permanentLink ID="permanentLink6" runat="server" Icon="1" 
                NavigateURL="~/?system=art&amp;module=search" Text="جستجو در مقالات" />
          </td>
      </tr>
    </table></td>
    <td width="50%" align="center" valign="top">&nbsp;</td>
    
  </tr>
    </table>