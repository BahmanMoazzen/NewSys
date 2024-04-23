<%@ Control Language="C#" ClassName="FirstPage" %>

<%@ Register src="../gnr/downloadShow.ascx" tagname="downloadshow" tagprefix="uc1" %>
<%@ Register src="../gnr/visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../gnr/commentShow.ascx" tagname="commentShow" tagprefix="uc4" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc5" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc4" %>

<%@ Register src="../gnr/userShow.ascx" tagname="userShow" tagprefix="uc6" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "آخرین اخبار ارسالی :: " + Page.Title;
        gvwLatest.DataSource = AB.News.LoadAll;
        gvwLatest.DataBind();
    }
    protected void gvwLatest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        g.DataBind();
    }
</script>
<table width="100%" border="0" cellspacing="3" cellpadding="1">
  <tr>
    <td>
            <uc4:tableTitle ID="ttlLatest" runat="server" Text="آخرین اخبار ارسال شده" 
                Icon="0" />
          </td>
  </tr>
  <tr>
    <td><asp:GridView ID="gvwLatest" runat="server" AutoGenerateColumns="False" 
                BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                GridLines="None" Width="100%" AllowPaging="True" 
                onpageindexchanging="gvwLatest_PageIndexChanging">
                <PagerSettings Mode="NumericFirstLast" />
                <RowStyle CssClass="ListRow" />
                <Columns>
                    <asp:TemplateField HeaderText="تاریخ ارسال">
                        <ItemTemplate>
                            <uc3:persianDateBinder ID="persianDateBinder1" runat="server" 
                                Date='<%# DateTime.Parse(Eval("nws_add_date").ToString())%>' />
                        </ItemTemplate>
                        <ItemStyle Width="10%" Wrap="False" VerticalAlign="Top" />
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="nws_id" 
                        DataNavigateUrlFormatString="~/?system=nws&amp;module=show&amp;nws_id={0}" 
                        DataTextField="nws_title" HeaderText="عنوان خبر" >
                        <ItemStyle HorizontalAlign="Justify" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="PName" HeaderText="ارسال كننده" />
                    <asp:BoundField DataField="BName" HeaderText="شعيه" />
                </Columns>
                <PagerStyle Font-Overline="False" Font-Strikeout="False" CssClass="ListPager" />
                <HeaderStyle CssClass="ListHeader" />
                <AlternatingRowStyle CssClass="ListAlternateRow" />
            </asp:GridView></td>
  </tr>
  <tr>
    <td>
            <uc5:permanentLink ID="plAddArticle" runat="server" Icon="1" 
                NavigateURL="~/?system=nws&amp;module=add" Text="ارسال خبر" />
          </td>
  </tr>
</table>
            
          
