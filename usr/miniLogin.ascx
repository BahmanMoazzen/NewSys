<%@ Control Language="C#" ClassName="miniLogin" %>


<script runat="server">
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            //mvw.SetActiveView(vwInfo);
            refreshPage();

        }
    }
    private void refreshPage()
    {

        Response.Redirect("http://" + Request.ServerVariables["server_name"] + Request.ServerVariables["URL"] + "?" + Request.QueryString.ToString());
    }
    protected void cvLogin_ServerValidate(object source, ServerValidateEventArgs args)
    {
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.DefaultFocus = txtEmail.UniqueID;
        Page.Form.DefaultButton = btnLogin.UniqueID;
        hlbChat.Text = "تعداد افراد آنلاین: " +((ArrayList) Application["on-lines"]).Count.ToString();
        if (AB.user == null  )
        {
            
            
            
            hlbLogout.Visible =false;
            imgLogout.Visible = false;
            imgLogin.Visible = true;
            hlbLogin.Visible = true;
            
            hlbChat.NavigateUrl = String.Empty;
            
        }
        else
        {
            
            hlbLogout.Visible = true;
            imgLogout.Visible = true;
            hlbLogin.Visible = false;
            imgLogin.Visible = false;
            hlbChat.NavigateUrl = "~/?system=frm&module=chat";
            
        }
        
    }

    protected void hlbLogout_Click(object sender, EventArgs e)
    {
        logout();
    }
    private void logout()
    {
        Application.Lock();
        ArrayList onLineUsers = (ArrayList)Application["on-lines"];
        onLineUsers.Remove((AB.UserInfo)Session["user"]);
        Application["on-lines"] = onLineUsers;
        Session["user"] = null;
        Application.UnLock();
        Response.Redirect("~/");
    }
    protected void imgLogout_Click(object sender, ImageClickEventArgs e)
    {
        logout();
    }

    protected void imgLogin_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/");
    }


   
</script>
<asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="1">
    <asp:View ID="vwForm" runat="server">
        <table cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lblEmail" runat="server" CssClass="FormCaption" 
                        Text="شماره استخدامي:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="FormTextBoxLTR" 
                        MaxLength="6"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtEmail" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="لطفا شماره استخدامي خود را وارد کنید." ForeColor="" SetFocusOnError="True" 
                        Text="*" ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvLogin" runat="server" ControlToValidate="txtEmail" 
                        CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="نام کاربری و یا کلمه عبور اشتباه است." ForeColor="" 
                        OnServerValidate="cvLogin_ServerValidate" Text="*" ValidationGroup="loginForm"></asp:CustomValidator>
                </td>
                <td>
                    <asp:Label ID="lblPWD" runat="server" CssClass="FormCaption">کلمه عبور:</asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPWD" runat="server" CssClass="FormTextBoxLTR" 
                        TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtPWD" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="لطفا کلمه عبور خود را وارد کنید." ForeColor="" Text="*" 
                        ValidationGroup="loginForm"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Button ID="btnLogin" runat="server" CssClass="FormButtom" 
                        onclick="btnLogin_Click" Text="ورود" ValidationGroup="loginForm" />
                </td>
            </tr>
        </table>
    </asp:View>
    <asp:View ID="vwInfo" runat="server">
        <asp:HyperLink ID="hlbChat" runat="server">HyperLink</asp:HyperLink>
        <asp:ImageButton ID="imgLogin" runat="server" ImageAlign="AbsMiddle" 
            ImageUrl="~/images/login.gif" onclick="imgLogin_Click" 
            AlternateText="ورود به سایت" ToolTip="ورود به سایت" 
            CausesValidation="False" />
        <asp:HyperLink ID="hlbLogin" runat="server" 
            NavigateUrl="~/">- ورود</asp:HyperLink>
        &nbsp;<asp:ImageButton ID="imgLogout" runat="server" ImageAlign="AbsMiddle" 
            ImageUrl="~/images/logout.gif" onclick="imgLogout_Click" 
            AlternateText="خروج از سایت" ToolTip="خروج از سایت" 
            CausesValidation="False" />
        <asp:LinkButton ID="hlbLogout" runat="server" onclick="hlbLogout_Click" 
            CausesValidation="False">- خروج</asp:LinkButton>
        &nbsp;
    </asp:View>
</asp:MultiView>


