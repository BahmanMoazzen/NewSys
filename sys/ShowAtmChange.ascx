<%@ Control Language="C#" ClassName="ShowAtmChange" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc4" %>
<%@ Register src="loadATMMembers.ascx" tagname="loadatmmembers" tagprefix="uc8" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = " نمايش تغييرات گروه ATM :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_28_", mvw, vwPage, vwLogin);

    }
    private void loadData()
    {
        gvw.DataSource = AB.System.ATM.ATMGroupChange;
        gvw.DataBind();
    }
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string bid = ((HiddenField)r.FindControl("hidBID")).Value;
        string pid = ((HiddenField)r.FindControl("hidPID")).Value;
        AB.System.ATM.RegisterATMMember(bid, pid);
        loadData();
    }

    protected void vwIdle_Activate(object sender, EventArgs e)
    {
        loadData();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server" onactivate="vwIdle_Activate">
                
                        <asp:Panel ID="pnlMain" runat="server"  >
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                Text="فرم نمايش تغييرات گروه ATM" />
                            
                            <asp:UpdatePanel  ID="upMain" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                                        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                                        CellPadding="1" CellSpacing="1" GridLines="None" 
                                        onrowdeleting="gvw_RowDeleting" PageSize="20" ShowFooter="True" Width="100%">
                                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                                        <Columns>
                                            <asp:BoundField DataField="BID" HeaderText="كد شعبه" />
                                            <asp:BoundField DataField="bName" HeaderText="نام شعبه" />
                                            <asp:BoundField DataField="pid" HeaderText="شماره استخدامي" />
                                            <asp:BoundField DataField="pname" HeaderText="كارمند" ReadOnly="True" />
                                            <asp:BoundField DataField="PhoneNumber" HeaderText="شماره تلفن " 
                                                ReadOnly="True" />
                                            <asp:BoundField DataField="mobileNumber" HeaderText="شماره همراه" />
                                            <asp:BoundField DataField="pAddress" HeaderText="آدرس" />
                                            <asp:CommandField ButtonType="Button" DeleteText="ثبت شد" 
                                                ShowDeleteButton="True">
                                            <ControlStyle CssClass="FormButtom" />
                                            </asp:CommandField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hidBID" runat="server" Value='<%# Eval("BID") %>' />
                                                    <asp:HiddenField ID="hidPID" runat="server" Value='<%# Eval("PID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="adderName" HeaderText="ثبت كننده" />
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
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>







