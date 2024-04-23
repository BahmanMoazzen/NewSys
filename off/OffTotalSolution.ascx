<%@ Control Language="C#" ClassName="OffTotalSolution" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc7" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc8" %>
<%@ Register src="offShowLink.ascx" tagname="offshowlink" tagprefix="uc6" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<script runat="server">

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            gvw.DataSource = AB.Offs.LoadTotalReport(branchesList.BID, pdpStart.GeorgianDate.ToString(), pdpEnd.GeorgianDate.ToString());
            gvw.DataBind();
            lblMessage.Text = String.Empty;
            btnAdd.Visible = lblMessage.Visible = true;
            btnAdd.Enabled = lblMessage.Visible = AB.Offs.CanInsertTotalTable(systemRef);
        }
    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        branchesList.BID = AB.user.BID;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = " جدول مرخصي سالانه :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_40_", mvw, vwPage, vwLogin);
        
        
        pdpEnd.Enable = pdpStart.Enable = false;
        
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        
        lblMessage.Text = AB.Offs.InsertTotalTable(AB.Offs.LoadTotalReport(branchesList.BID, pdpStart.GeorgianDate.ToString(), pdpEnd.GeorgianDate.ToString()),systemRef);
        btnAdd.Enabled = false;
        
    }
    protected string systemRef
    {
        get
        {
            return String.Format("{0}{1}{2}", "1392", branchesList.BID, "1");
        }
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" OnActivate="vwPage_Activate">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td>
                         <uc2:tabletitle ID="tabletitle4" runat="server" Icon="1" 
                                SubText="لطفاً مواردي از قبيل مانده هاي مختلف شمارش شده، سوخت مرخصي محاسبه شده، تعداد مرخصي افزوده شده و تعداد بازخريد را كنترل و در صورت وجود مغايرت به اين مديريت اطلاع دهيد" 
                                Text="جدول مرخصي سالانه" />
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" CssClass="FormCaption" Text="نام شعبه:"></asp:Label>
                                    </td>
                                    <td>
                                        <uc8:branchesList ID="branchesList" runat="server" UnlockKey="6" 
                                            ValidationGroup="offTotalReport" />
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" CssClass="FormCaption" 
                                            Text="تاريخ شروع محاسبه:"></asp:Label>
                                    </td>
                                    <td>
                                        <uc4:persiandatepicker ID="pdpStart" runat="server" Text="1392/01/01" 
                                            ValidationGroup="offTotalReport" />
                                    </td>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" CssClass="FormCaption" 
                                            Text="تاريخ پايان محاسبه:"></asp:Label>
                                    </td>
                                    <td>
                                        <uc4:persiandatepicker ID="pdpEnd" runat="server" Text="1392/12/29" 
                                            ValidationGroup="offTotalReport" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:Button ID="btnShow1" runat="server" CssClass="FormButtom" 
                                            onclick="btnShow_Click" Text="نمايش" />
                                    </td>
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
                           
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                                BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                                GridLines="None" Width="100%">
                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                <Columns>
                                    <asp:BoundField DataField="pid" HeaderText="استخدامي" />
                                    <asp:BoundField DataField="pname" HeaderText="نام " />
                                    <asp:BoundField DataField="esh" HeaderText="استحقاقي" />
                                    <asp:BoundField DataField="est" HeaderText="استعلاجي" />
                                    <asp:BoundField DataField="za" HeaderText="زايمان" />
                                    <asp:BoundField DataField="be" HeaderText="بدون حقوق" />
                                    <asp:BoundField DataField="gheibat" HeaderText="غيبت" />
                                    <asp:BoundField DataField="mazooriat" HeaderText="معذوريت" />
                                    <asp:BoundField DataField="tahsil" HeaderText="تحصيلي" />
                                    <asp:BoundField DataField="ezd" HeaderText="ازدواج" />
                                    <asp:BoundField DataField="saati" HeaderText="ساعتي (دقيقه)" />
                                    <asp:BoundField DataField="mamor" HeaderText="مأموريت (دقيقه)" />
                                    <asp:BoundField DataField="tsvza" HeaderText="تشويقي فزنددار شدن" />
                                    <asp:BoundField DataField="remain" HeaderText="مانده مرخصي استحقاقي" />
                                    <asp:BoundField DataField="duration" HeaderText="كاركرد" />
                                    <asp:BoundField DataField="added" HeaderText="افزوده شده در امسال" />
                                    <asp:BoundField DataField="offceiling" HeaderText="سقف مجاز" />
                                    <asp:BoundField DataField="sookht" HeaderText="سوخت مرخصي" />
                                    <asp:BoundField DataField="thisyearinc" HeaderText="افزايش امسال" />
                                    <asp:BoundField DataField="bazkh" HeaderText="بازخريد" />
                                </Columns>
                                <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                    VerticalAlign="Top" />
                                <HeaderStyle CssClass="ListHeader" />
                                <PagerSettings Mode="NumericFirstLast" />
                                <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                                <RowStyle CssClass="ListRow" />
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                                onclick="btnAdd_Click" Text="ثبت محاسبات" Visible="False" />
                            <br />
                            <asp:Label ID="lblMessage" runat="server" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                                AssociatedUpdatePanelID="UpdatePanel1">
                                <ProgressTemplate>
                                    <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:View>
</asp:MultiView>






