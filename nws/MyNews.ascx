<%@ Control Language="C#" ClassName="MyNews" %>


<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc5" %>
<%@ Register src="../gnr/downloadShow.ascx" tagname="downloadshow" tagprefix="uc1" %>
<%@ Register src="../gnr/visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>

<%@ Register src="../gnr/commentShow.ascx" tagname="commentShow" tagprefix="uc3" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="LoginSystem" tagprefix="uc4" %>



<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "اخبار من :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_3_", mvw, vwList, vwLogin);
    }

    protected void vwList_Activate(object sender, EventArgs e)
    {
        gvw.DataSource = AB.News.MyNews;
        
        gvw.DataBind();

    }
    protected void gvwLatest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        g.DataSource = AB.News.MyNews;
        g.DataBind();
    }

    protected void hlbDelete_Command(object sender, CommandEventArgs e)
    {

        int cPage = gvw.PageIndex;
        string nws_id = e.CommandArgument.ToString();
        AB.News.Delete(nws_id);
        gvw.DataSource = AB.News.MyNews;
        gvw.DataBind();
        if (gvw.PageCount != cPage + 1 && gvw.PageIndex > 0)
        {
            gvw.PageIndex = cPage - 1;

        }
        else
        {
            gvw.PageIndex = cPage;
        }
    }
</script>

<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
       
        <uc4:LoginSystem ID="LoginSystem1" runat="server" />
       
    </asp:View>
    <asp:View ID="vwList" runat="server" onactivate="vwList_Activate">
        <table border="0" cellpadding="3" cellspacing="3" width="100%">
            <tr>
                <td valign="top">
                    <uc1:tableTitle ID="tableTitle1" runat="server" Icon="0" 
                        SubText="در این بخش می توانید اخبار ارسال شده خود را تغییر داده و یا آنها را حذف کنید." 
                        Text="مدیریت اخبار ارسالی" />
                    <br />
                    <uc5:permanentLink ID="permanentLink2" runat="server" Icon="2" 
                        NavigateURL="~/?system=nws&amp;module=add" Text="ارسال خبر" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" 
                        onpageindexchanging="gvwLatest_PageIndexChanging" Width="100%">
                        <PagerSettings Mode="NumericFirstLast" />
                        <RowStyle CssClass="ListRow" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <uc2:visitShow ID="visitShow1" runat="server" 
                                        Visits='<%# int.Parse(Eval("nws_visits").ToString()) %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="25px" 
                                    Wrap="True" />
                            </asp:TemplateField>
                            <asp:HyperLinkField DataNavigateUrlFields="nws_id" 
                                DataNavigateUrlFormatString="~/?system=nws&module=show&nws_id={0}" 
                                DataTextField="nws_title" HeaderText="عنوان خبر" Target="_blank">
                                <ItemStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                            </asp:HyperLinkField>
                            <asp:BoundField DataField="status_name" HeaderText="وضعیت ارسال">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="5%" 
                                    Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="hlbDelete" runat="server" 
                                        CommandArgument='<%# Eval("nws_id").ToString() %>' 
                                        oncommand="hlbDelete_Command">حذف</asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="5%" 
                                    Wrap="False" />
                            </asp:TemplateField>
                            <asp:HyperLinkField DataNavigateUrlFields="nws_id" 
                                DataNavigateUrlFormatString="~/?system=nws&amp;module=change&amp;nws_id={0}" 
                                Text="تغییر">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="5%" 
                                    Wrap="False" />
                            </asp:HyperLinkField>
                        </Columns>
                        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                        <HeaderStyle CssClass="ListHeader" />
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                    </asp:GridView>
                    <br />
                    <uc5:permanentLink ID="permanentLink1" runat="server" Icon="2" 
                        NavigateURL="~/?system=nws&amp;module=add" Text="ارسال خبر" />
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>

