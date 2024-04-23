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
        Page.Title = "صدور اخطار منطقه ای :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_56_", mvw, vwPage, vwLogin);
        

    }
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        gvw.DataSource = Cache["result"];
        gvw.DataBind();
    }
    
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Cache["result"] = AB.Vosool.RegionalSearch(txtSearch.Text, AB.user.BID);
            gvw.DataSource = Cache["result"];
            gvw.DataBind();
        }
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
                        Text="صدور اخطار منطقه ای" 
                        SubText="ابتدا نام خیابان، محله و یا منطقه را وارد نموده و سپس کلید جستجو را فشار دهید." />
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="نام منطقه:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="FormTextBox" Width="261px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="txtSearch" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً عبارت جستجو را وارد کنید"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" CssClass="FormButtom" 
                                    onclick="Button1_Click" Text="جستجو" />
                            </td>
                        </tr>
                    </table>
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
                            <asp:BoundField DataField="con_addr" HeaderText="آدرس" />
                            <asp:BoundField DataField="moavagh_count" HeaderText="تعداد معوق" />
                            <asp:TemplateField HeaderText="مبلغ معوق">
                                <ItemTemplate>
                                    <uc8:thousandSeprator ID="thousandSeprator1" runat="server" 
                                        Text='<%# Eval("amount") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="pname" HeaderText="پیگیر" />
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






