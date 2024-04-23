<%@ Control Language="C#" ClassName="ShowNews" %>

<%@ Register src="../gnr/visitShow.ascx" tagname="visitShow" tagprefix="uc1" %>
<%@ Register src="../gnr/commentShow.ascx" tagname="commentShow" tagprefix="uc2" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc3" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc4" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc4" %>

<%@ Register src="../gnr/userShow.ascx" tagname="userShow" tagprefix="uc7" %>


<script runat="server">

    private long nws_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["nws_id"] != null)
        {
            nws_id =long.Parse( Request.QueryString["nws_id"].ToString());
            string title = String.Empty, context = String.Empty, bid = String.Empty, keyword = String.Empty, displayName = String.Empty, email = String.Empty, userCode = String.Empty, typeName = String.Empty;
            DateTime addDate = DateTime.Now;
            int visits = 0;
            AB.News.LoadNews(nws_id,ref title,ref context,ref email ,ref displayName,ref typeName,ref userCode,ref keyword,ref visits,ref addDate,ref bid );
            visitShow1.Visits = visits;
            string pageUrl = "http://" + Request.ServerVariables["server_name"] + Request.ServerVariables["URL"] + "?" + Request.QueryString.ToString();
            context = AB.General.ReplaceWordWithLink(context, keyword, pageUrl);
            
            
            ttlTitle.Text = title;
            lblContext.Text = context;
            userShow1.Email = email;
            userShow1.DisplayName = displayName;
            userShow1.TypeName = typeName;
            userShow1.Kind = userCode;
            pdbAddDate.Date = addDate;
            Page.Title =  title+" :: " +Page.Title;
            ((HtmlMeta)Page.FindControl("pageKeyword")).Content +=" , "+ keyword;
        }
        
        
    }
</script>
<table width="100%" border="0" cellspacing="3" cellpadding="1">
<tr><td> 
                            <table width="100%" border="0" cellspacing="3" cellpadding="1">
  <tr>
    <td width="25%">
        <uc4:permanentLink ID="plAddArticle" runat="server" Icon="2" 
            NavigateURL="~/?system=nws&amp;module=add" Text="ارسال خبر" />
      </td>
    <td width="25%">
        <uc4:permanentLink ID="plSearch" runat="server" Icon="2" 
            NavigateURL="~/?system=nws" Text=" فهرست اخبار" />
      </td>
    <td width="25%">&nbsp;</td>
    <td width="25%">
        <uc4:permanentLink ID="permanentLink1" runat="server" Icon="1" 
            NavigateURL="javascript:history.back(-1);" Text="بازگشت" />
                                        </td>
  </tr>
</table> </td></tr>
  <tr>
    <td class="TableTop"><table width="100%" border="0" cellspacing="3" cellpadding="1">
      <tr>
        <td width="1%" valign="top">
            <uc1:visitShow ID="visitShow1" runat="server" EnableViewState="False" />
          </td>
        <td valign="top">
            <uc3:tableTitle ID="ttlTitle" runat="server" />
          </td>
        <td valign="top" nowrap="nowrap" width="10%">
            <uc4:persianDateBinder ID="pdbAddDate" runat="server" />
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="3" cellpadding="1">
      <tr>
        <td valign="top">
          <blockquote>
            <p align="justify">
                <asp:Label ID="lblContext" runat="server"></asp:Label>
              </p>
          </blockquote></td>
      </tr>
      <tr>
        <td valign="top" align="left" class="TableBottom">
                  <uc7:userShow ID="userShow1" runat="server" />
              </td>
      </tr>
    </table></td>
  </tr>
</table>

