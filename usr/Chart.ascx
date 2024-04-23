<%@ Control Language="C#" ClassName="Chart" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>
<%@ Register src="../off/OffCardex.ascx" tagname="OffCardex" tagprefix="uc2" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="branchUserControl.ascx" tagname="branchUserControl" tagprefix="uc4" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>

<%@ Register src="chartDescription.ascx" tagname="chartDescription" tagprefix="uc5" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "چارت سازماني مديريت شعب استان البرز :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_6_", mvw, vwPage, vwLogin);
        
    }




    protected void vwPage_Activate(object sender, EventArgs e)
    {
        gvw.DataSource = AB.User.Chart;
        gvw.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:tableTitle ID="tableTitle1" runat="server" Text="چارت سازماني" />
                <br />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate><uc4:progressPanelContent ID="progressPanelContent1" runat="server" /></ProgressTemplate>
                </asp:UpdateProgress>
                <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" PageSize="20" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="bid" HeaderText="كد شعبه" ReadOnly="True" />
                        <asp:TemplateField HeaderText="نام شعبه"><ItemTemplate><uc4:branchUserControl ID="branchUserControl1" runat="server" 
                                    bid='<%# Eval("BID") %>' BName='<%# Eval("BName") %>' /></ItemTemplate><ItemStyle Wrap="False" /></asp:TemplateField>
                        <asp:BoundField DataField="bgrade" HeaderText="درجه" ReadOnly="True" />
                        <asp:BoundField DataField="BMaxPersonnel" HeaderText="تعداد در چارت" />
                        <asp:BoundField DataField="count" HeaderText="تعداد فعلي كارمندان" 
                            ReadOnly="True" />
                        <asp:BoundField DataField="BCurrentContractedPersonnel" 
                            HeaderText="تعداد نيروهاي شركتي" ReadOnly="True" />
                        <asp:BoundField DataField="PersonnelSum" HeaderText="جمع" />
                        <asp:BoundField DataField="result" HeaderText="اختلاف" ReadOnly="True" />
                        <asp:TemplateField HeaderText="توضيحات">
                            <ItemTemplate>
                                <uc5:chartDescription ID="chartDescription1" BID='<%# Eval("bid") %>' runat="server" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>











    
<p>
    &nbsp;</p>
                
            

