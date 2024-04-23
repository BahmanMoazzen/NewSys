<%@ Control Language="C#" ClassName="AddNews" %>

<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>


<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc2" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc3" %>
<%@ Register src="../gnr/DeadEnd.ascx" tagname="DeadEnd" tagprefix="uc4" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="LoginSystem" tagprefix="uc1" %>



<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            
            AB.News.AddNews(txtTitle.Text, txtContext.Value, txtKeyword.Text, AB.user.Email,chkIsSticky.Checked);
            mvw.SetActiveView(vwAdded);
            
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ارسال خبر :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_3_", mvw, vwForm, vwShoulLogin);
        
    }

    protected void vwForm_Activate(object sender, EventArgs e)
    {
        
            txtContext.ToolbarSet = "Default";
            
        
        
    }
</script>
<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwShoulLogin" runat="server">
       
        <uc1:LoginSystem ID="LoginSystem1" runat="server" />
       
    </asp:View>
    <asp:View ID="vwForm" runat="server" onactivate="vwForm_Activate">
        <table border="0" cellpadding="3" cellspacing="3" width="100%">
            <tr>
                <td nowrap="nowrap" valign="top" colspan="2">
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="0" 
                        SubText="در این بخش می توانید اخبار خود را در زمینه های مختلف مدیریت ارسال کنید. این اخبار توسط نظرات سایر کاربران ارزیابی می شود." 
                        Text="فرم ارسال خبر" />
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" valign="top">
                    &nbsp;<asp:Label ID="lblTitle" runat="server" CssClass="FormCaption" 
                        Text="تیتر خبر:"></asp:Label></td>
                <td valign="top">
                    &nbsp;<asp:TextBox ID="txtTitle" runat="server" CssClass="FormTextBox" Width="423px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtTitle" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="لطفا تیتر خبر را وارد کنید." ForeColor="" 
                        ValidationGroup="addNews"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td nowrap="nowrap" valign="top">
                    &nbsp;<asp:Label ID="lblContext" runat="server" CssClass="FormCaption" 
                        Text="شرح خبر:"></asp:Label></td>
                <td valign="top">
                <table width="100%" border="0" cellspacing="3" cellpadding="1">
  <tr>
    <td width="500" valign="top"><FCKeditorV2:FCKeditor ID="txtContext" runat="server" BasePath="fckeditor/" 
                        Height="350px" Width="100%" ToolbarSet="Basic"></FCKeditorV2:FCKeditor></td>
    <td valign="top" nowrap="nowrap"><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtContext" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="لطفا شرح خبر را وارد کنید." ForeColor="" 
                        ValidationGroup="addNews"></asp:RequiredFieldValidator></td>
  </tr>
</table>
                    
                
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" valign="top">
                    <asp:Label ID="lblKeyword" runat="server" CssClass="FormCaption" 
                        Text="کلمات کلیدی:"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtKeyword" runat="server" CssClass="FormTextBox" 
                        Width="428px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" valign="top" colspan="2">
                    <asp:CheckBox ID="chkIsSticky" runat="server" Text="ثبت در اخبار مهم" 
                        CssClass="FormButtom" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;<asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                        OnClick="btnAdd_Click" Text="ارسال خبر" ValidationGroup="addNews" />
                </td>
            </tr>
        </table>
    </asp:View>
    <asp:View ID="vwAdded" runat="server">
        <uc2:tableTitle ID="tableTitle2" runat="server" Icon="1" 
            Text="خبر شما با موفقیت ارسال شد." />
        <br />
        <uc3:permanentLink ID="permanentLink1" runat="server" Icon="1" 
            NavigateURL="~/?system=nws&amp;module=add" Text="ارسال یک خبر دیگر" />
        <br />
        <uc4:DeadEnd ID="DeadEnd1" runat="server" />
    </asp:View>
</asp:MultiView>

