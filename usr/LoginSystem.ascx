<%@ Control Language="C#" ClassName="LoginSystem" %>



<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>



<%@ Register src="../gnr/permissionBinder.ascx" tagname="permissionBinder" tagprefix="uc2" %>



<script runat="server">

    public void CheckSecurity(string iRequiredKeys, MultiView iMultiViewName, View iHaveView, View iDontHaveView)
    {
        if (!Page.IsPostBack)
        {
            RequeredKeys.Keys = iRequiredKeys;
            pnlKeys.Visible = true;
            iMultiViewName.SetActiveView(iDontHaveView);
            if (AB.user != null)
            {

                if (AB.user.HaveKey(iRequiredKeys))
                {
                    iMultiViewName.SetActiveView(iHaveView);
                }


            }
        }


    }
    public string UserKeys
    {
        set
        {
            Cache["login_keys"] = value;
        }
        
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            
            refreshPage();
            
        }
    }
    private void refreshPage()
    {

        Response.Redirect("http://" + Request.ServerVariables["server_name"] + Request.ServerVariables["URL"] + "?" + Request.QueryString.ToString());
    }
    protected void cvLogin_ServerValidate(object source, ServerValidateEventArgs args)
    {
        Application.Lock();
        bool isLogedIn = true;
        
        AB.UserInfo logingUser = AB.User.Login(txtEmail.Text, txtPWD.Text);
        if (logingUser != null)
        {
            if (Cache["login_keys"] != null)
            {
                if (logingUser.HaveKey(Cache["login_keys"].ToString()))
                {
                    isLogedIn = true;
                }
                else
                {
                    isLogedIn = false;
                }
            }
            else
            {
                isLogedIn = true;
            }
            
            
            
             
        }
        else
        {
            isLogedIn = false;
        }
        if (isLogedIn)
        {
            AB.UserInfo usr = new AB.UserInfo(logingUser.Email,String.Empty,logingUser.DisplayName,true,logingUser.Keys,logingUser.BID,logingUser.Prefix);
            ArrayList onLineUsers = (ArrayList)Application["on-lines"];
            bool isUserExist = false;
            foreach (AB.UserInfo u in onLineUsers)
            {
                if (u.Email == usr.Email)
                    isUserExist = true;
                
            }
            if(! isUserExist)
                onLineUsers.Add(usr);
            Application["on-lines"] = onLineUsers;
            Session["user"] = usr;
        }
        args.IsValid=isLogedIn;
        Application.UnLock();
    }






    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.DefaultButton = btnLogin.UniqueID;
        Page.Form.DefaultFocus = txtEmail.UniqueID;
    }
</script>
<center><asp:ValidationSummary ID="ValidationSummary1" runat="server" 
            CssClass="FormError" DisplayMode="List" ForeColor="" 
            EnableClientScript="False" ShowMessageBox="True" /></center>
 
<table  width="405" height="195" border="0" cellpadding="0" cellspacing="0" 
    align="center" dir="ltr">
	<tr>
		<td colspan="3">
			<img src="images/Noori/login_01.gif" width="405" height="71" 
                alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="images/Noori/login_02.gif" width="10" height="124" 
                alt=""></td>
		<td dir="rtl" height="108" valign="top">
			<table align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
        <asp:Label ID="lblEmail" runat="server" CssClass="FormCaption" Text="شماره استخدامي:"></asp:Label>
                    </td>
                    <td>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="FormTextBoxLTR" 
            MaxLength="6"></asp:TextBox>
                    </td>
                    <td>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
              ControlToValidate="txtEmail" CssClass="FormError" Display="Dynamic" 
              ErrorMessage="لطفا شماره استخدامي خود را وارد كنيد:" ForeColor="" Text="*" 
              SetFocusOnError="True" EnableClientScript="False" 
              ToolTip="لطفا ایمیل خود را وارد کنید."></asp:RequiredFieldValidator>
          <asp:CustomValidator ID="cvLogin" Text="*" 
              ErrorMessage="نام کاربری و یا کلمه عبور اشتباه است." runat="server"  
              OnServerValidate="cvLogin_ServerValidate" Display="Dynamic" 
              CssClass="FormError" ControlToValidate="txtEmail" 
              ForeColor="" ToolTip="نام کاربری و یا کلمه عبور اشتباه است."></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td>
        <asp:Label ID="lblPWD" runat="server" CssClass="FormCaption">کلمه عبور:</asp:Label>
                    </td>
                    <td>
        <asp:TextBox ID="txtPWD" runat="server" CssClass="FormTextBoxLTR" 
            TextMode="Password"></asp:TextBox>
                    </td>
                    <td dir="rtl">
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
              ControlToValidate="txtPWD" CssClass="FormError" Display="Dynamic" 
              ErrorMessage="لطفا کلمه عبور خود را وارد کنید." ForeColor="" Text="*" 
              EnableClientScript="False" ToolTip="لطفا کلمه عبور خود را وارد کنید."></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td align="center">
        <asp:Button ID="btnLogin" runat="server" CssClass="FormButtom" Text="ورود" 
            onclick="btnLogin_Click" Width="76px" />
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </td>
		<td rowspan="2">
			<img src="images/Noori/login_04.gif" width="14" height="124" 
                alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/Noori/login_05.gif" width="381" height="16" 
                alt=""></td>
	</tr>
</table>
       
<asp:Panel  ID="pnlKeys" runat="server" 
    Visible="False">
<uc1:tableTitle ID="tableTitle2" Icon="1" 
        
        Text="برای ورود به این بخش نیازمند مجوز هاي زیر هستید. كلمه عبور شما كد ملي شما است. لطفاً پس از اولين ورود كلمه عبور خود را تغيير دهيد." 
        runat="server" />
    
    <uc2:permissionBinder ID="RequeredKeys" runat="server" />
    
</asp:Panel>

 


