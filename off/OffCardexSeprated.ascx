<%@ Control Language="C#" ClassName="OffCardexSeprated" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="OffTypeDropDown.ascx" tagname="OffTypeDropDown" tagprefix="uc5" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "كارتكس مرخصي تفكيكي همكاران :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_22_", mvw, vwPage, vwLogin);

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            gvw.DataSource = AB.Offs.Cardex(pibPersonnel.PID, otddTypes.OTID);
            gvw.DataBind();
        }
    }

    
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc2:tabletitle ID="ttTitle" runat="server" Icon="0" 
                    SubText="لطفاً شماره استخدامي كارمند مورد نظر خود را وارد كرده و كليك نمايش را فشار دهيد." 
                    Text="كارتكس مرخصي همكاران" />
                <br />
                <table cellpadding="2" cellspacing="3" >
                    <tr>
                        <td>
                            <uc1:personnelIDBinder ID="pibPersonnel" runat="server" 
                                ValidationGroup="Cardex" />
                        </td>
                        <td>
                            <uc5:OffTypeDropDown ID="otddTypes" runat="server" OTID="1" />
                        </td>
                    </tr>
                </table>
        <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" Text="نمايش" 
            onclick="btnShow_Click" ValidationGroup="Cardex" />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <uc4:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" PageSize="20" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="otname" HeaderText="نوع مرخصي" ReadOnly="True" />
                        <asp:BoundField DataField="ostname" />
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
                        <asp:BoundField DataField="amount" HeaderText="مقدار" />
                        <asp:BoundField DataField="dsc" HeaderText="توضيحات" />
                        <asp:BoundField DataField="remain" HeaderText="مانده" />
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











    

