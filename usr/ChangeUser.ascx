<%@ Control Language="C#" ClassName="ChangeUser" %>


<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc2" %>

<%@ Register src="../gnr/DeadEnd.ascx" tagname="DeadEnd" tagprefix="uc3" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc4" %>


<%@ Register src="LoginSystem.ascx" tagname="LoginSystem" tagprefix="uc5" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "تغییر مشخصات کاربری :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_17", mvw, vwChange, vwLogin);
    }

    protected void vwChange_Activate(object sender, EventArgs e)
    {
        lblEmail.Text = AB.user.Email;
        
    }

    protected void btnChange_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.User.ChangePassword(lblEmail.Text, txtPass1.Text);
            mvw.SetActiveView(vwChanged);
            
            ArrayList onLineUsers = (ArrayList)Application["on-lines"];
            onLineUsers.Remove((AB.UserInfo)Session["user"]);
            Application["on-lines"] = onLineUsers;
            Session["user"] = null;
        }
        
    }
</script>



<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
   
        <uc5:LoginSystem ID="LoginSystem1" runat="server" />
    </asp:View>
    <asp:View ID="vwChange" runat="server" onactivate="vwChange_Activate">
        <asp:Panel ID="pnl" runat="server" DefaultButton="btnChange">
            <table border="0" cellpadding="3" cellspacing="3" width="100%">
                <tr>
                    <td colspan="2" nowrap="nowrap">
                        <uc2:tableTitle ID="tableTitle1" runat="server" Icon="0" 
                            SubText="در این بخش می توانید مشخصات کاربری خود را تغییر دهید." 
                            Text="فرم تغییر مشخصات کاربری" />
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" width="5%">
                        <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
                            Text="شماره استخدامي:" />
                    </td>
                    <td width="95%">
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                            Text="کلمه عبور جدید:" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtPass1" runat="server" CssClass="FormTextBoxLTR" 
                            TextMode="Password" ValidationGroup="changeForm" Width="220px"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToCompare="txtPass2" ControlToValidate="txtPass1" CssClass="FormError" 
                            Display="Dynamic" ErrorMessage="دو کلمه عبور با هم متفاوت هستند." ForeColor="" 
                            ValidationGroup="changeForm"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtPass1" CssClass="FormError" Display="Dynamic" 
                            ErrorMessage="لطفاً كلمه عبور را وارد كنيد." ValidationGroup="changeForm"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Label ID="Label11" runat="server" CssClass="FormCaption" 
                            Text="تکرار کلمه عبور جدید:" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtPass2" runat="server" CssClass="FormTextBoxLTR" 
                            TextMode="Password" ValidationGroup="changeForm" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:Button ID="btnChange" runat="server" CssClass="FormButtom" 
                            onclick="btnChange_Click" Text="اعمال تغییرات" ValidationGroup="changeForm" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:View>
    <asp:View ID="vwChanged" runat="server">
        <uc2:tableTitle ID="tableTitle2" runat="server" Icon="1" 
            Text="تغییرات با موفقیت صورت پذیرفت" 
            SubText="لطفا با مشخصات کاربری خود مجددا وارد سایت شوید." />
        <br />
        <br />
        <uc4:permanentLink ID="permanentLink1" runat="server" Icon="2" 
            NavigateURL="~/" Text="صفحه اول" />
        <br />
        
    </asp:View>
</asp:MultiView>
