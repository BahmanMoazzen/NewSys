<%@ Control Language="C#" ClassName="MyOffs" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc1" %>

<%@ Register src="offRemain.ascx" tagname="offRemain" tagprefix="uc5" %>

<%@ Register src="offShowLink.ascx" tagname="offShowLink" tagprefix="uc6" %>

<script runat="server">
    

    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();
        

    }

    protected void loadData()
    {

        offRemain1.PID = AB.user.Email;
        gvw.DataSource = AB.Offs.MyOffs(AB.user.Email);
        gvw.DataBind();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ليست مرخصي هاي من :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_8_", mvw, vwPage, vwLogin);
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
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="فهرست مرخصي هاي شما" 
            Icon="0" />
        <br />
        <uc5:offRemain ID="offRemain1" runat="server" />
        <br />
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True" Width="100%" onpageindexchanging="gvw_PageIndexChanging">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="otname" HeaderText="نوع مرخصي" ReadOnly="True" />
                <asp:BoundField DataField="ostname" ReadOnly="True" />
                <asp:TemplateField HeaderText="تاريخ شروع">
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbStart" runat="server" 
                            Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ خاتمه">
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbEnd" runat="server" 
                            Date='<%# DateTime.Parse(Eval("enddate").ToString()) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="amount" HeaderText="مقدار" ReadOnly="True" />
                <asp:BoundField DataField="bname" HeaderText="محل ثبت" ReadOnly="True" />
                <asp:BoundField DataField="dsc" HeaderText="توضيحات" ReadOnly="True" />
                <asp:BoundField DataField="osttname" HeaderText="وضعيت" ReadOnly="True" />
                
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <uc6:offShowLink ID="offShowLink1" OTID='<%# Eval("offtype") %>' OSTTID='<%# Eval("stat") %>' OffId='<%# Eval("offid") %>'  OffInsertType='<%# Eval("insertType") %>' runat="server" />
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










