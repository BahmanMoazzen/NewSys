<%@ Control Language="C#" ClassName="DailyReport" %>

<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>



<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>



<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "گزارش روزانه معوقات مشارکت:: " + Page.Title;
        LoginSystem1.CheckSecurity("1_51_", mvw, vwPage, vwLogin);
        pdpStart.GeorgianDate = DateTime.Now;

    }

    protected void btnCalc_Click(object sender, EventArgs e)
    {
        gvw.DataSource = AB.Vosool.MosharekatDailyReportByDate(pdpStart.GeorgianDate);
        gvw.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <table width="100%">
            <tr>
                <td>
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        SubText="تاریخ مورد نظر خود را وارد نموده و کلید نمایش را فشار دهید." 
                        Text="آمار مطالبات معوق مشارکتی" />
                </td>
            </tr>
            <tr>
                <td>
                    <uc4:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddOff" />
                    <asp:Button ID="btnCalc" runat="server" CausesValidation="False" 
                        CssClass="FormButtom" onclick="btnCalc_Click" Text="نمایش" 
                        ValidationGroup="AddOff" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvw" runat="server" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" Width="100%">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                        <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                            VerticalAlign="Top" />
                        <HeaderStyle CssClass="ListHeader" />
                        <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                        <RowStyle CssClass="ListRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>






