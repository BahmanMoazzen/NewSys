<%@ Control Language="C#" ClassName="offHourlyPaymentFines" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="offShowLink.ascx" tagname="offshowlink" tagprefix="uc9" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc8" %>
<%@ Register src="offStatDropDown.ascx" tagname="offstatdropdown" tagprefix="uc7" %>
<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/MonthDropDown.ascx" tagname="MonthDropDown" tagprefix="uc4" %>
<style type="text/css">

    .FormButtom
    {
        width: 39px;
    }
</style>

<script runat="server">
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();


    }






    protected void loadData()
    {


        gvw.DataSource = AB.Offs.LoadHourlyOffPaymentFines(ddlMonths.MID);
        gvw.DataBind();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "فهرست جرائم كسر از حقوق بابت تأخير :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_6_", mvw, vwPage, vwLogin);

    }





    

    protected void btnShow_Click(object sender, EventArgs e)
    {
        loadData();
    }









   
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="گزارش مرخصي - مخصوص سرپرستي" 
            Icon="0" />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="20%">
                            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="ماه عمليات:"></asp:Label>
                        </td>
                        <td width="20%">
                            &nbsp;</td>
                        <td width="20%">
                            &nbsp;</td>
                        <td width="20%">
                            &nbsp;</td>
                        <td width="20%">
                            &nbsp;</td>
                        <td width="25%">
                            &nbsp;</td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <uc4:MonthDropDown ID="ddlMonths" runat="server" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                    onclick="btnShow_Click" Text="نمايش" />
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" PageSize="20" 
                    ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="pname" HeaderText="نام كارمند" />
                        <asp:BoundField DataField="pid" HeaderText="شماره استخدامي" />
                        <asp:TemplateField HeaderText="تاريخ تأخير">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="persiandatebinder1" stringdate='<%# Eval("adddate") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="amount" HeaderText="مدت زمان" />
                        <asp:BoundField DataField="bname" HeaderText="محل ثبت تأخير" />
                    </Columns>
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                        VerticalAlign="Top" />
                    <HeaderStyle CssClass="ListHeader" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                    <RowStyle CssClass="ListRow" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>















