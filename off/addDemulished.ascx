<%@ Control Language="C#" ClassName="addDemulished" %>

<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<style type="text/css">


    .style1
    {
        width: 100%;
    }
    
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = "ثبت مرخصي :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_23_", mvw, vwPage, vwLogin);

        pdpStart.GeorgianDate = DateTime.Parse("2014-3-19");

    }

    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.Offs.AddOffByOperator(pibPID.PID, pdpStart.GeorgianDate, pdpStart.GeorgianDate, AB.user.Email, txtDays.Text, otddType.OTID,"2", txtDsc.Text);
            mvwMain.SetActiveView(vwEnd);
            
        }

    }



    

    

   

    

protected void  vwEnd_Activate(object sender, EventArgs e)
{
    lblEnd.Text = String.Format("مانده مرخصي همكار {0} به شماره استخدامي {1} بعد از {2} روز مرخصي ثبت شده:", pibPID.PName, pibPID.PID,txtDays.Text);
    offRemain1.PID = pibPID.PID;
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
                
                        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest">
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                SubText="از اين فرم جهت افزودن سوخت مرخصي استفاده نماييد." 
                                Text="فرم افزودن سوخت مرخصي" />
                            <table cellpadding="3" cellspacing="3" class="style1">
                                <tr>
                                    <td nowrap="nowrap" width="10%">
                                        <asp:Label ID="lbl2" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap" width="50%">
                                        <uc1:personnelIDBinder ID="pibPID" runat="server" ValidationGroup="AddOff" />
                                    </td>
                                    <td align="justify" rowspan="6" valign="top">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                            CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
                                            ValidationGroup="AddOff" />
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" width="10%">
                                        <asp:Label ID="lbl" runat="server" CssClass="FormCaption" Text="نوع مرخصي:"></asp:Label>
                                    </td>
                                    <td class="style2" nowrap="nowrap">
                                        <uc6:OffTypeDropDown ID="otddType" runat="server" OTID="1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" width="10%">
                                        <asp:Label ID="lbl4" runat="server" CssClass="FormCaption" 
                                            Text="تعداد روز:"></asp:Label>
                                    </td>
                                    <td class="style2" nowrap="nowrap">
                                        <asp:TextBox ID="txtDays" runat="server" Columns="3" CssClass="FormTextBox" 
                                            MaxLength="2" ValidationGroup="AddOff"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            CssClass="FormError" Display="Dynamic" 
                                            ErrorMessage="لطفاً تعداد روز را وارد كنيد." ValidationGroup="AddOff" 
                                            ControlToValidate="txtDays">*</asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                            ControlToValidate="txtDays" CssClass="FormError" 
                                            ErrorMessage="لطفاً يك عدد بين 1 الي 15 وارد كنيد." MaximumValue="15" 
                                            MinimumValue="1" Type="Integer" ValidationGroup="AddOff">*</asp:RangeValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                        <asp:Label ID="lbl0" runat="server" CssClass="FormCaption" Text="تاريخ موثر:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <uc4:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddOff" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl3" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <asp:TextBox ID="txtDsc" runat="server" CssClass="FormTextBox">سوخت مرخصي سال 1392</asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td class="style2">
                                        <asp:Button ID="btnRequest" runat="server" CssClass="FormButtom" 
                                            onclick="btnRequest_Click" Text="ثبت مرخصي" ValidationGroup="AddOff" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        
            </asp:View>
            <asp:View ID="vwEnd" runat="server" onactivate="vwEnd_Activate">
                <asp:Label ID="lblEnd" runat="server"></asp:Label>
                <br />
                <uc5:offRemain ID="offRemain1" runat="server" />
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>





