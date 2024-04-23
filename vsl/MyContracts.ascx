<%@ Control Language="C#" ClassName="DailyReport" %>

<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>



<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>



<%@ Register src="../gnr/thousandSeprator.ascx" tagname="thousandseprator" tagprefix="uc8" %>



<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "پرونده های من :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_55_", mvw, vwPage, vwLogin);
        

    }
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        gvw.DataSource = Cache["my_contracts"];
        gvw.DataBind();
    }
    
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        Cache["my_contracts"]=AB.Vosool.MyContracts(AB.user.Email,AB.user.BID);
        gvw.DataSource = Cache["my_contracts"];
        gvw.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Cache["my_contracts"] = AB.Vosool.MyContracts(AB.user.Email, AB.user.BID,txtQuery.Text.Replace('ی','ي'));
        gvw.PageIndex = 0;
        gvw.DataSource = Cache["my_contracts"];
        gvw.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <table width="100%">
            
            <tr>
                <td>
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        Text="پرونده های من" />
                    <br />
                    <asp:Label ID="Label2" runat="server" 
                        Text="جستجو در نام و نام خانوادگی و شماره قرار داد:" 
                        CssClass="FormCaption"></asp:Label>
                    <asp:TextBox ID="txtQuery" runat="server" CssClass="FormTextBoxLTR"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtQuery" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="بارت جستجو را وارد کنید">*</asp:RequiredFieldValidator>
                    <asp:Button ID="btnSearch" runat="server" CssClass="FormButtom" 
                        onclick="btnSearch_Click" Text="جستجو" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvw" runat="server" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="50" 
                        Width="100%" AllowPaging="True" AutoGenerateColumns="False" 
                        onpageindexchanging="gvw_PageIndexChanging">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:BoundField DataField="con_major" HeaderText="سرفصل" />
                            <asp:BoundField DataField="con_minor" HeaderText="معين" />
                            <asp:BoundField DataField="display_name" HeaderText="نام و نام خانوادگي" />
                            <asp:BoundField DataField="contact" HeaderText="اطلاعات تماس" />
                            <asp:BoundField DataField="moavagh_count" HeaderText="تعداد معوق" />
                            <asp:TemplateField HeaderText="مبلغ معوق">
                                <ItemTemplate>
                                    <uc8:thousandSeprator ID="thousandSeprator1" runat="server" 
                                        Text='<%# Eval("amount") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:HyperLinkField DataNavigateUrlFields="uniq_id" 
                            
                                DataNavigateUrlFormatString="~/default.aspx?system=vsl&amp;module=add-log&amp;uniq_id={0}" 
                                Text="پیگیری" Target="_blank" />
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                        <EmptyDataTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                                Text="[اطلاعاتي براي نمايش موجود نيست]"></asp:Label>
                        </EmptyDataTemplate>
                        <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                            VerticalAlign="Top" />
                        <HeaderStyle CssClass="ListHeader" />
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                        <RowStyle CssClass="ListRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>






