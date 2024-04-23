<%@ Control Language="C#" ClassName="AddAdetive" %>

<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>


<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>


<script runat="server">

    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = "افزودن پايه مرخصي :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_16_", mvw, vwPage, vwLogin);

    
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid) 
        {
            AB.Offs.AddAddetive(pibPID.PID,txtDays.Text,otddOffType.OTID,AB.user.Email,pdpEffectDate.GeorgianDate,txtDsc.Text);
            mvwMain.SetActiveView(vwEnd);
            offRemain1.PID = pibPID.PID;
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
            <asp:View ID="vwIdle" runat="server">
                <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnAdd">
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        SubText="از اين فرم جهت افزودن پايه مرخصي استفاده نماييد." 
                        Text="فرم افزودن پايه مرخصي" />
                    <br />
                    <table cellpadding="0" cellspacing="0" >
                        <tr>
                            <td nowrap="nowrap" width="10%">
                                <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
                                    Text="شماره استخدامي:"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="10%">
                                <uc1:personnelidbinder ID="pibPID" runat="server" 
                                    ValidationGroup="Addetive" />
                            </td>
                            <td rowspan="6" width="80%" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                    CssClass="FormError" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" CssClass="FormCaption">تعداد (روز):</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDays" runat="server" Columns="3" CssClass="FormTextBox" 
                                    MaxLength="3" ValidationGroup="Addetive"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="txtDays" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً تعداد روز ها را وارد كنيد.">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ControlToValidate="txtDays" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك عدد وارد كنيد." Operator="DataTypeCheck" Type="Integer">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" CssClass="FormCaption">نوع مرخصي:</asp:Label>
                            </td>
                            <td>
                                <uc6:offtypedropdown ID="otddOffType" runat="server" OTID="1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label4" runat="server" CssClass="FormCaption">تاريخ موثر:</asp:Label>
                            </td>
                            <td>
                                <uc4:persiandatepicker ID="pdpEffectDate" runat="server" 
                                    ValidationGroup="Addetive" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label5" runat="server" CssClass="FormCaption">توضيحات:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDsc" runat="server" CssClass="FormTextBox" 
                                    ValidationGroup="Addetive"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td align="center" class="FormButtom">
                                <asp:Button ID="btnAdd" runat="server" onclick="btnAdd_Click" Text="ثبت" 
                                    Width="68px" ValidationGroup="Addetive" CssClass="FormButtom" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp;</td>
                        </tr>
                    </table>
                    
                </asp:Panel>
            </asp:View>
            <asp:View ID="vwEnd" runat="server">
                <asp:Label ID="lblEnd" runat="server">عمليات مورد نظر با موفقيت انجام شد.</asp:Label>
                <br />
                <uc5:offRemain ID="offRemain1" runat="server" />
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>





