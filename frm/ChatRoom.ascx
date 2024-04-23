<%@ Control Language="C#" ClassName="ChatRoom" %>

<%@ Register src="~/gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc1" %>

<%@ Register src="~/gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc2" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>

<script runat="server">

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        
        loadData();
    }
    protected void loadData()
    {
        lb.DataSource = (ArrayList)Application["on-lines"];
        lb.DataTextField = "DisplayName";
        lb.DataBind();
        
        gvw.DataSource = AB.Forum.Chat.loadStatments("1-1-1");
        gvw.DataBind();
                
        txtQ.Focus();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        hidDate.Value = DateTime.Now.ToString();
        loadData();
    }

    protected void btnSend0_Click(object sender, EventArgs e)
    {
        AB.Forum.Chat.AddStatement(AB.user.Email,txtQ.Text);
        txtQ.Text = String.Empty;
        loadData();
    }
</script>

<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSend">
<asp:HiddenField ID="hidDate" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
    <ContentTemplate>
    <table cellpadding="0" cellspacing="0" class="style1">
        <tr valign="top">
            <td width="10">
                <asp:ListBox ID="lb" runat="server" CssClass="FormTextBox" 
                    DataTextField="FullName" Rows="10" ToolTip="اسامي افراد آن لاين" 
                    Width="135px">
                </asp:ListBox>
            </td>
            <td valign="top">
                <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" PageSize="20" 
                    ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg", Eval("Adder")) %>' Width="35" />
                                <br /><asp:Label ID="lblPerName" Text='<%# Eval("pName") %>' runat="server" ></asp:Label>
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Top" Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="statment" HeaderText="متن" >
                        <ItemStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="تاريخ ارسال">
                            <ItemTemplate>
                                <uc2:persianDateBinder ID="persianDateBinder1" Date='<%# DateTime.Parse(Eval("adddate").ToString()) %>' runat="server" />
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
            </td>
        </tr>
    </table>

    </ContentTemplate>
    </asp:UpdatePanel>
    
    <table cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td valign="top">
                <asp:TextBox ID="txtQ" runat="server" CssClass="FormTextBox" Width="450px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtQ" CssClass="FormError" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:Button ID="btnSend" runat="server" CssClass="FormButtom" 
                    onclick="btnSend0_Click" Text="ارسال" 
                    ToolTip="جهت ارسال متن كليك كنيد و يا ENTER را بزنيد." />
                <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick">
                </asp:Timer>
            </td>
            <td width="10" valign="top">
                    <asp:UpdateProgress ID="UpdateProgress" runat="server" 
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="100">
                    <ProgressTemplate>
                        <uc1:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    
</asp:Panel>

