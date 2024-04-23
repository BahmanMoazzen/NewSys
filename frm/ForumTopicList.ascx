<%@ Control Language="C#" ClassName="ForumTopicList" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc7" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: ليست موضوعات :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_37_", mvw, vwPage, vwLogin);


    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        gvw.DataSource = AB.Forum.LoadTopics(Request.QueryString["fid"].ToString());
        gvw.DataBind();
        tableTitle.Text = "فهرست موضوعات مربوط به اتاق " + Server.UrlDecode(Request.QueryString["roomname"]);
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc1:tableTitle ID="tableTitle" runat="server" />
        <br />
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" ShowFooter="True" 
            Width="100%">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:TemplateField HeaderText="عنوان">
                    <ItemTemplate>
                        <uc7:permanentLink ID="phlTitle" runat="server" Icon="1" NavigateURL='<%# String.Format("~/?system=frm&module=show-statement&fid={0}",Eval("fid")) %>' 
                            Text='<%# Eval("ftitle") %>' />
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="subcount" DataFormatString="({0})" 
                    HeaderText="تعداد نظرات">
                <ItemStyle Wrap="False" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    </asp:View>
</asp:MultiView>







