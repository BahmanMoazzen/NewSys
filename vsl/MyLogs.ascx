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
        Page.Title = "یادآوری های من :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_54_", mvw, vwPage, vwLogin);
        

    }
    
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidRemId")).Value;
        AB.Vosool.DoneReminder(id);
        gvwAlerts.DataSource = AB.Vosool.MyAlarms(AB.user.Email);
        gvwAlerts.DataBind();
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        gvwAlerts.DataSource = AB.Vosool.MyAlarms(AB.user.Email);
        gvwAlerts.DataBind();
        
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
                    <uc2:tableTitle ID="tableTitle2" runat="server" Icon="1" 
                        Text="هشدار های من" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvwAlerts" runat="server" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
                        Width="100%" AutoGenerateColumns="False" onrowdeleting="gvw_RowDeleting">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:BoundField DataField="reminder" HeaderText="مدت زمان گذشته" />
                            <asp:TemplateField HeaderText="تاریخ پیگیری">
                                <ItemTemplate>
                                    <uc3:persiandatebinder ID="persiandatebinder1" Date='<%# DateTime.Parse(Eval("add_date").ToString()) %>' runat="server" />
                                    <asp:HiddenField ID="hidRemId" Value='<%# Eval("rem_id") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="شرح پیگیری" DataField="is_done_text" />
                            <asp:HyperLinkField DataNavigateUrlFields="uniq_id" 
                            
                                
                                DataNavigateUrlFormatString="~/default.aspx?system=vsl&amp;module=add-log&amp;uniq_id={0}" DataTextField="contract" 
                                HeaderText="قرار داد" Target="_blank" />
                            <asp:BoundField DataField="display_name" HeaderText="متعهد قرار داد" />
                            <asp:CommandField DeleteText="انجام شد" ShowDeleteButton="True" />
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                        <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                            VerticalAlign="Top" />
                        <HeaderStyle CssClass="ListHeader" />
                        <EmptyDataTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                                Text="[اطلاعاتي براي نمايش موجود نيست]"></asp:Label>
                        </EmptyDataTemplate>
                        <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                        <RowStyle CssClass="ListRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>






