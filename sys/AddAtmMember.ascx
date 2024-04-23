<%@ Control Language="C#" ClassName="AddAtmMember" %>

<%@ Register src="../off/OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../off/offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc7" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="loadATMMembers.ascx" tagname="loadATMMembers" tagprefix="uc8" %>
<style type="text/css">



    .style1
    {
        width: 100%;
    }
    
    
    
    .style2
    {
        height: 36px;
    }
    
    
    
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = " مديريت گروه ATM :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_26_", mvw, vwPage, vwLogin);

    }

    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.System.ATM.AddATMMember(AB.user.BID, pibPID.PID, txtPhone.Text, txtMobile.Text);
            
            loadATMMembers.BID = AB.user.BID;
        }
    }

    protected void vwIdle_Activate(object sender, EventArgs e)
    {
        loadATMMembers.BID = AB.user.BID;
    }
    

   

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (AB.System.ATM.IsATMGroupHas3Member(AB.user.BID))
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
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
                
                        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest" >
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                SubText="از اين فرم جها ثبت و يا حذف اعضاء گروه ATM استفاده نمائيد." 
                                Text="فرم مديريت گروه ATM" />
                            <asp:UpdatePanel  ID="upMain" runat="server">
                                <ContentTemplate>
                                    <table cellpadding="-1" cellspacing="0" class="style1">
                                    <tr>
                                            <td nowrap="nowrap" width="10%">
                                                <asp:Label ID="lbl3" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap" width="50%">
                                                <uc1:personnelIDBinder ID="pibPID" runat="server" 
                                                    ValidationGroup="AddATMMember" />
                                            </td>
                                            <td align="justify" rowspan="4" valign="top">
                                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                                    CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
                                                    ValidationGroup="AddATMMember" />
                                            </td>
                                        </tr>
                                    <tr>
                                            <td nowrap="nowrap" width="10%" class="style2">
                                                <asp:Label ID="lbl4" runat="server" CssClass="FormCaption" Text="تلفن ثابت:"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap" class="style2">
                                                <asp:TextBox ID="txtPhone" runat="server" Columns="9" CssClass="FormTextBox" 
                                                    MaxLength="8" ValidationGroup="AddATMMember"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                    ControlToValidate="txtPhone" CssClass="FormError" Display="Dynamic" 
                                                    ErrorMessage="تلفن ثابت را وارد كنيد." ToolTip="تلفن ثابت را وارد كنيد." 
                                                    ValidationGroup="AddATMMember">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        
                                        
                                        <tr>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lbl5" runat="server" CssClass="FormCaption" Text="تلفن همراه:"></asp:Label>
                                            </td>
                                            <td class="style2">
                                                <asp:TextBox ID="txtMobile" runat="server" Columns="12" CssClass="FormTextBox" 
                                                    MaxLength="11" ValidationGroup="AddATMMember"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                    ControlToValidate="txtMobile" CssClass="FormError" Display="Dynamic" 
                                                    ErrorMessage="لطفاً تلفن همراه را وارد كنيد." 
                                                    ToolTip="لطفاً تلفن همراه را وارد كنيد." ValidationGroup="AddATMMember">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                            <td class="style2">
                                                <asp:Button ID="btnRequest" runat="server" CssClass="FormButtom" 
                                                    onclick="btnRequest_Click" Text="ثبت عضو ATM" ValidationGroup="AddATMMember" />
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                                    Display="Dynamic" ErrorMessage="امكان ثبت بيش از سه عضو وجود ندارد." 
                                                    onservervalidate="CustomValidator1_ServerValidate" 
                                                    ToolTip="امكان ثبت بيش از سه عضو وجود ندارد." ValidationGroup="AddATMMember">*</asp:CustomValidator>
                                                <asp:UpdateProgress ID="upsMain" runat="server" 
                                                    AssociatedUpdatePanelID="upMain" DisplayAfter="1">
                                                    <ProgressTemplate>
                                                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td colspan=3>
                                            <uc8:loadATMMembers ID="loadATMMembers" runat="server" />
                                        </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>





