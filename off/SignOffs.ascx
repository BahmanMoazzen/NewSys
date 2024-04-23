<%@ Control Language="C#" ClassName="SignOffs" %>

<%@ Register src="inlineConfirmation.ascx" tagname="inlineconfirmation" tagprefix="uc1" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="inlineSigning.ascx" tagname="inlineSigning" tagprefix="uc4" %>

<script runat="server">
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();


    }






    protected void loadData()
    {


        gvw.DataSource = AB.Offs.ToSign();
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ليست مرخصي هاي جديد جهت امضاء :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_4_", mvw, vwPage, vwLogin);

    }





    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }
    
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="فهرست مرخصي هاي جديد جهت امضاء" 
            Icon="0" />
        <br />
        <br />
        <br />
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True" Width="100%" onpageindexchanging="gvw_PageIndexChanging">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="offid" HeaderText="كد مرخصي" />
                <asp:BoundField DataField="PName" HeaderText="درخواست كننده" />
                <asp:TemplateField HeaderText="تاريخ شروع">
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbStart" Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ خاتمه">
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbEnd" Date='<%# DateTime.Parse(Eval("enddate").ToString()) %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="days" HeaderText="تعداد روز ها" />
                <asp:BoundField DataField="BName" HeaderText="محل درخواست" />
                <asp:TemplateField HeaderText="دستورات">
                    <ItemTemplate>
                        <uc4:inlineSigning ID="inlineSigning1" OffId='<%# Eval("OffId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
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






