<%@ Control Language="C#" ClassName="CommentPage" %>



<%@ Register src="tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>



<%@ Register src="persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc2" %>



<script runat="server">

   
    private void loadComments()
    {
        dltComments.DataSource = AB.General.LoadComments(Request.QueryString["page"].ToString());
        dltComments.DataBind();
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        AB.General.AddComent(Request.QueryString["page"].ToString(), txtName.Text, txtEmail.Text, txtWebsite.Text, txtContext.Text, ddlType.SelectedValue.ToString());
        mvwMain.SetActiveView(vwSent);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (AB.User.IsUserLoggedIn())
        {
            txtEmail.Text = AB.user.Email;
            txtName.Text = AB.user.DisplayName;
        }
        loadComments();
        pdbToday.Date = DateTime.Now;
        lblPageTitle.Text = Request.QueryString["title"].ToString();
    }

    protected void vwSent_Activate(object sender, EventArgs e)
    {
        loadComments();
    }
</script>

<asp:MultiView ID="mvwMain" ActiveViewIndex="0" runat="server">
    <asp:View ID="vwForm" runat="server">
    <table width="100%">
    <tr>
        <td width="1%" colspan="3">
            <table style="width: 100%">
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="Label9" runat="server" CssClass="FormCaption" 
                            Text="ارسال نظر برای صفحه:"></asp:Label>
                    </td>
                    <td nowrap="nowrap" width="10%">
                        <asp:Label ID="Label10" runat="server" CssClass="FormCaption" 
                            Text="تاریخ ارسال:"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPageTitle" runat="server"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <uc2:persianDateBinder ID="pdbToday" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td colspan="2">
            <uc1:tableTitle ID="tableTitle1" runat="server" Icon="0" Text="نظر شما:" />
        </td>
    </tr>
    <tr>
        <td style="width: 1%">
            <asp:Label ID="Label6" runat="server" CssClass="FormError" Text="*"></asp:Label>
        </td>
        <td width="10%">
            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="نام:"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtName" runat="server" CssClass="FormTextBox" 
                ValidationGroup="commentForm"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                CssClass="FormError" Display="Dynamic" 
                ErrorMessage="لطفاً ایمیل دوست خود را وارد کنید." ForeColor="" 
                ToolTip="لطفاً ایمیل دوست خود را وارد کنید." 
                ValidationGroup="commentForm" ControlToValidate="txtName">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td>
            <asp:Label ID="Label2" runat="server" CssClass="FormCaption">ایمیل:</asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="FormTextBox" 
                ValidationGroup="commentForm"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                CssClass="FormError" Display="Dynamic" ErrorMessage="لطفاً یک ایمیل وارد کنید." 
                ForeColor="" ToolTip="لطفاً یک ایمیل وارد کنید." 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ValidationGroup="commentForm" ControlToValidate="txtEmail">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td>
            <asp:Label ID="Label3" runat="server" CssClass="FormCaption">وبسایت:</asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtWebsite" runat="server" CssClass="FormTextBox" 
                ValidationGroup="commentForm"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                CssClass="FormError" Display="Dynamic" ErrorMessage="لطفاً ادرس وبسایت وارد کنید." 
                ForeColor="" ToolTip="لطفاً ادرس وبسایت وارد کنید." 
                ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" 
                ValidationGroup="commentForm" ControlToValidate="txtWebsite">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td style="width: 1%" valign="top">
            <asp:Label ID="Label7" runat="server" CssClass="FormError" Text="*"></asp:Label>
        </td>
        <td valign="top" nowrap="nowrap">
            <asp:Label ID="Label4" runat="server" CssClass="FormCaption">متن نظر:</asp:Label>
        </td>
        <td valign="top">
            <asp:TextBox ID="txtContext" runat="server" CssClass="FormTextBox" Rows="4" 
                TextMode="MultiLine" ValidationGroup="commentForm"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                CssClass="FormError" Display="Dynamic" 
                ErrorMessage="لطفاً ایمیل دوست خود را وارد کنید." ForeColor="" 
                ToolTip="لطفاً ایمیل دوست خود را وارد کنید." 
                ValidationGroup="commentForm" ControlToValidate="txtContext">*</asp:RequiredFieldValidator>
            </td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td nowrap="nowrap">
            <asp:Label ID="Label5" runat="server" CssClass="FormCaption">نوع نظر:</asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlType" runat="server" CssClass="FormTextBox" 
                ValidationGroup="commentForm">
                <asp:ListItem Selected="True" Value="false">قابل رویت برای همه</asp:ListItem>
                <asp:ListItem Value="true">خصوصی</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td style="width: 1%">
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>
            <asp:Button ID="btnSend" runat="server" CssClass="FormButtom" 
                Text="ارسال نظر" onclick="btnSend_Click" ValidationGroup="commentForm" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            &nbsp;</td>
    </tr>
</table>
    </asp:View>
    <asp:View ID="vwSent" runat="server" onactivate="vwSent_Activate">
    <center>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="پیام شما با موفقیت ارسال گردید." 
            CssClass="FormCaptionBox" Width="100%"></asp:Label>
            
        <br />
        <br />
        <br />
            
        <asp:Button ID="Button1" runat="server" Text="بستن پنجره" 
            onclientclick="javascript:window.close();" />
    
        <br />
        <br />
    
    </center>
    </asp:View>
</asp:MultiView>

            <asp:DataList ID="dltComments" runat="server" 
                 
    CellPadding="3" CellSpacing="3" Width="100%">
                <AlternatingItemStyle CssClass="ListAlternateRow" />
                <ItemStyle CssClass="ListRow" />
                <ItemTemplate>
                    <table bordercolor="#FF00FF" width="100%" border="1" cellpadding="6" 
                        cellspacing="0">
                        <tr bgcolor="#99FF33">
                            <td>
                                <asp:HyperLink ID="hplName" runat="server" 
                                    Text='<%# Eval("com_display_name") %>' 
                                    NavigateUrl='<%# Eval("com_website") %>' Target="_blank"></asp:HyperLink>
                            </td>
                            <td nowrap="nowrap" width="1%">
                                <uc2:persianDateBinder ID="pdbDate" runat="server" 
                                    Date='<%# DateTime.Parse(Eval("com_date").ToString()) %>' />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <blockquote>
                                    <asp:Literal ID="litContext" runat="server" Text='<%# Eval("com_context") %>'></asp:Literal></blockquote></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        

