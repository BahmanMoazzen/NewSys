<%@ Control Language="C#" ClassName="ShowDetail" %>


<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc4" %>


<style type="text/css">



    .FormButtom
    {
        width: 39px;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "گزارش جزئيات ثبت اطلاعات :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_42_", mvw, vwPage, vwLogin);
    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        tabletitle2.SubText = Request.QueryString["LIName"].ToString();
        gvw.DataSource = AB.LoanInfo.Answers.DetailReport(Request.QueryString["LIID"].ToString());
        gvw.DataBind();
    }
</script>

<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
       
        <uc4:LoginSystem ID="LoginSystem1" runat="server" />
       
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate" >
        <uc2:tabletitle ID="tabletitle2" runat="server" Icon="0" 
            Text="گزارش جزئيات" />
        
        <asp:GridView ID="gvw" runat="server" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" 
             ShowFooter="True" Width="100%" >
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="bid" HeaderText="كد شعبه" />
                <asp:BoundField DataField="bname" HeaderText="نام شعبه" />
                <asp:BoundField DataField="liptitle" HeaderText="عنوان پارامتر" />
                <asp:BoundField DataField="avalue" HeaderText="مقدار" />
                <asp:BoundField DataField="astatname" HeaderText="وضعيت ثبت" />
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <EmptyDataTemplate>
                <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                    Text="اطلاعاتي موجود نيست."></asp:Label>
            </EmptyDataTemplate>
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    </asp:View>
</asp:MultiView>



