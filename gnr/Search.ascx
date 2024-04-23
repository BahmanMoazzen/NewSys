<%@ Control Language="C#" ClassName="Search" %>
<%@ Import Namespace="System.Data" %>
<%@ Register src="tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>
<%@ Register src="persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="downloadShow.ascx" tagname="downloadshow" tagprefix="uc1" %>

<script runat="server">
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Response.Redirect("~/?system=gnr&module=search&q=" + Server.UrlEncode(txtQuery.Text));

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title ="جستجو :: " + Page.Title;
        if (Request.QueryString["q"] != null)
        {
            if(Request.QueryString["q"] != String.Empty)
            mvw.SetActiveView(vwShow);
        }
    }

    protected void vwShow_Activate(object sender, EventArgs e)
    {
        
        string q = Request.QueryString["q"].ToString();
        Page.Title = q+" :: " + Page.Title;
        
        txtQuery.Text = q;
        string whois;
        if (AB.User.IsUserLoggedIn())
        {
            whois = AB.user.Email;
        }
        else
        {
            whois = Request.ServerVariables["remote_addr"].ToString();
        }
        DataTable tbl = AB.General.Search(Server.UrlDecode(q), whois);
        gvwLatest.DataSource = tbl;
        gvwLatest.DataBind();
        Cache["search_result"] = tbl;
        if (gvwLatest.Rows.Count <= 0)
        {
            mvw.SetActiveView(vwNotFound);
            hplGoogle.NavigateUrl = String.Format(hplGoogle.NavigateUrl, q);
            //hplNews.NavigateUrl += q;
            hplYahoo.NavigateUrl = String.Format(hplYahoo.NavigateUrl, q);
        }





    }
    protected void gvwLatest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        g.DataSource = (DataTable)Cache["search_result"];

        g.DataBind();
    }
</script>
<table width="100%" border="0" cellspacing="3" cellpadding="3">
  <tr>
    <td valign="top">
        <uc1:tableTitle ID="tableTitle1" runat="server" Icon="0" 
            Text="فرم جستجو" />
      </td>
  </tr>
  <tr>
    <td valign="top">
        <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
            Text="عبارت جستجو:"></asp:Label>
        <asp:TextBox ID="txtQuery" runat="server" CssClass="FormTextBox" Width="220px" 
            ValidationGroup="Search"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtQuery" Display="Dynamic" ErrorMessage="*" ForeColor="" 
            ToolTip="لطفا عبارتی را جهت جستجو وارد کنید." ValidationGroup="Search"></asp:RequiredFieldValidator>
        <asp:Button ID="btnSearch" runat="server" CssClass="FormButtom" 
            onclick="btnSearch_Click" Text="جستجو!" ValidationGroup="Search" />
      </td>
  </tr>
  <tr>
    <td valign="top">
        <asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwInfo" runat="server">
                <uc1:tableTitle ID="tableTitle2" runat="server" Icon="1" 
                     
                    Text="لطفا عبارت خود را جهت جستجو وارد کنید." />
                    <p>
                        در این بخش می توانید در مقالات موجود در سایت جستجو کنید. برای آنکه به راحتی به 
                        نتیجه دلخواه خود برسید پیشنهاد می کنیم قواعد زیر را رعایت کنید:</b></p>
                    <ul>
              <li>کلمات کلیدی مورد نظر خود را بوسیله Space از هم جدا کنید.</li>
            <li>در عبارات خود از حروفی غیر از حروف الفبا مانند <b>&quot;</b> , <b>@</b>, . و یا <b>'</b> استفاده نکنید.</li>
            <li>در عبارات خود از کلمات متداول مانند <b>از</b> ، <b>با</b> ، <b>برای</b> و یا <b>که</b> استفاده نکنید. زیرا این عبارات در کلیه متون تکرار می شوند و آن متن را جزء نتیجه جستجوی شما قرار می دهند و شما را با انبوهی از اطلاعات نا مرتبط با خواست شما مواجه می سازند. </li>
            </ul>
            </asp:View>
            <asp:View ID="vwShow" runat="server" onactivate="vwShow_Activate">
                <asp:GridView ID="gvwLatest" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvwLatest_PageIndexChanging" Width="100%">
                    <PagerSettings Mode="NumericFirstLast" />
                    <RowStyle CssClass="ListRow" />
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="id,module,id_name" 
                            DataNavigateUrlFormatString="~/?system={1}&module=show&{2}={0}" 
                            DataTextField="title" HeaderText="عنوان مقاله" Target="_blank"><ItemStyle HorizontalAlign="Justify" /></asp:HyperLinkField>
                        <asp:BoundField DataField="score" HeaderText="امتیاز جستجو"><HeaderStyle Wrap="False" /><ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="5%" 
                                Wrap="False" /></asp:BoundField>
                    </Columns>
                    <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                    <HeaderStyle CssClass="ListHeader" />
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                </asp:GridView>
            </asp:View>
            <asp:View ID="vwNotFound" runat="server">
                <uc1:tableTitle ID="tableTitle3" runat="server" Icon="2" 
                    Text="عبارت مورد جستجوی شما در میان مقالات یافت نشد." />
                <br />
                <ul>
                      <li>
                          <asp:HyperLink ID="hplGoogle" NavigateUrl="http://www.google.com/search?hl=fa&q={0}" Target="_blank" runat="server">تکرار جستجو در گوگل</asp:HyperLink> </li>
                    <li>
                        <asp:HyperLink ID="hplYahoo" NavigateUrl="http://search.yahoo.com/search?ei=UTF-8&fr=sfp&p={0}" Target="_blank" runat="server">تکرار جستجو در یاهو</asp:HyperLink></li>
                    <%--<li>
                        <asp:HyperLink ID="hplNews" NavigateUrl="~/?system=nws&module=search&q=" Target="_blank"   runat="server">تکرار جستجو در اخبار</asp:HyperLink></li>
                    --%>
                    </ul>
            </asp:View>
        </asp:MultiView>
      </td>
  </tr>
</table>
