<%@ Control Language="C#" ClassName="Show" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../gnr/visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc5" %>

<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc6" %>
<%@ Register src="loanInfoParams.ascx" tagname="loaninfoparams" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<%@ Register src="loanInfoBinderForInput.ascx" tagname="loanInfoBinderForInput" tagprefix="uc7" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<style type="text/css">



    .FormButtom
    {
        width: 39px;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ثبت و تغيير مقادير آمار اعتباري :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_41_", mvw, vwPage, vwLogin);
        
    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        gvw.DataSource = AB.LoanInfo.LoadForInput();
        gvw.DataBind();
    }
</script>

<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
       
        <uc4:LoginSystem ID="LoginSystem1" runat="server" />
       
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate" >
        <uc2:tabletitle ID="tabletitle2" runat="server" Icon="0" 
            Text="ثبت آمار اعتباري" />
        <asp:GridView ID="gvw" runat="server" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" 
             PageSize="20" 
            ShowFooter="True" Width="100%">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:TemplateField HeaderText="عنوان">
                    <ItemTemplate>
                        <uc7:loanInfoBinderForInput ID="loanInfoBinderForInput1" LIID='<%# Eval("LIID") %>' Description='<%# Eval("LIDesc") %>' Name='<%# Eval("LIName") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle Wrap="False" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="مهلت ثبت">
                    <ItemTemplate>
                        <uc2:persianDateBinder ID="pdbEnd" runat="server" 
                            Date='<%# DateTime.Parse(Eval("enddatecaption").ToString()) %>' />
                    </ItemTemplate>
                    <ItemStyle Width="10%" />
                </asp:TemplateField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <EmptyDataTemplate>
                <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                    Text="اطلاعاتي موجود نيست."></asp:Label>
            </EmptyDataTemplate>
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    </asp:View>
</asp:MultiView>


