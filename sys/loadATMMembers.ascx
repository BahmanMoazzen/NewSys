<%@ Control Language="C#" ClassName="loadATMMembers" %>

<script runat="server">
    private void loadData()
    {
        gvw.DataSource = AB.System.ATM.ATMGroup(hidBID.Value);
        gvw.DataBind();
    }
    
    public string BID
    {
        set
        {
            hidBID.Value = value;
            loadData();
        }
    }
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string bid = ((HiddenField)r.FindControl("hidBID")).Value;
        string pid = ((HiddenField)r.FindControl("hidPID")).Value;
        AB.System.ATM.DeleteATMMEmber(bid, pid);
        loadData();
    }
    
</script>
                                            <asp:GridView ID="gvw" 
    runat="server" AllowPaging="True" 
                                                AutoGenerateColumns="False" 
    BorderStyle="None" BorderWidth="0px" 
                                                CellPadding="1" 
    CellSpacing="1" GridLines="None" 
                                                
    onrowdeleting="gvw_RowDeleting" PageSize="20" 
                                                ShowFooter="True" Width="100%">
                                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                                <Columns>
                                                    <asp:BoundField DataField="BID" HeaderText="كد شعبه" />
                                                    <asp:BoundField DataField="bName" HeaderText="نام شعبه" />
                                                    <asp:BoundField DataField="pid" HeaderText="شماره استخدامي" />
                                                    <asp:BoundField DataField="pname" HeaderText="كارمند" ReadOnly="True" />
                                                    <asp:BoundField DataField="PhoneNumber" HeaderText="شماره تلفن " 
                                                        ReadOnly="True" />
                                                    <asp:BoundField DataField="mobileNumber" HeaderText="شماره همراه">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pAddress" HeaderText="آدرس" />
                                                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True" DeleteText="حذف">
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
                                        
<asp:HiddenField ID="hidBID" runat="server" />

                                        
