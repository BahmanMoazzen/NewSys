<%@ Control Language="C#" ClassName="AddOff" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="offRemain.ascx" tagname="offRemain" tagprefix="uc5" %>
<%@ Register src="OffTypeDropDown.ascx" tagname="OffTypeDropDown" tagprefix="uc6" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc7" %>
<%@ Register src="secondTypesDropDown.ascx" tagname="secondTypesDropDown" tagprefix="uc8" %>
<style type="text/css">


    .style1
    {
        width: 100%;
    }
    
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = " ثبت مرخصي روزانه :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_7_", mvw, vwPage, vwLogin);

    }

    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            pnlConfirm.Visible = true;
            pnlMain.Enabled = false;
            string all = String.Empty, hollydays = String.Empty;
            AB.Offs.DaysBetween(pdpStart.GeorgianDate, pdpEnd.GeorgianDate, ref all, ref hollydays);
            litHollyDays.Text = hollydays;
            litAll.Text = all;
            if (chkHollyDays.Checked)
            {
                litOffs.Text = (int.Parse(all) - int.Parse(hollydays)).ToString();
            }
            else
            {
                litOffs.Text = all;
            }
            
        }

    }



    protected void btnEdite_Click(object sender, EventArgs e)
    {
        pnlConfirm.Visible = false;
        pnlMain.Enabled = true;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {   
            Button btn = (Button)sender;
            btn.Enabled = false;
            AB.Offs.AddOffByOperator(pibPID.PID, pdpStart.GeorgianDate, pdpEnd.GeorgianDate, AB.user.Email, litOffs.Text, otddType.OTID,ddlSecondType.OSTID, txtDsc.Text);
            mvwMain.SetActiveView(vwEnd);

        }
        
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        bool dateIsOk = true;
        int dif = pdpStart.GeorgianDate.CompareTo(pdpEnd.GeorgianDate);

        if (dif > 0)
        {
            dateIsOk = false;
        }

        
        args.IsValid= dateIsOk ;
    }

    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
       
            args.IsValid = true;
            if (AB.Offs.IsExists(pibPID.PID, pdpStart.GeorgianDate, pdpEnd.GeorgianDate))
            {
                args.IsValid = false;
            }
        
    }

protected void  vwEnd_Activate(object sender, EventArgs e)
{
    lblEnd.Text = String.Format(" مرخصي همكار {0} به شماره استخدامي {1} به مدت {2} روز مرخصي ثبت گرديد.", pibPID.PName, pibPID.PID,litOffs.Text);
    //offRemain1.PID = pibPID.PID;
}

//protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
//{
//    args.IsValid=true;
//    if (pdpStart.GeorgianDate == pdpEnd.GeorgianDate & pdpStart.GeorgianDate.DayOfWeek.Equals(DayOfWeek.Friday))
//    {

//        args.IsValid = false;
//    }
//}
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
                                SubText="از اين فرم جهت افزودن مرخصي روزانه استفاده نماييد." 
                                Text="فرم افزودن مرخصي روزانه" />
                            <table cellpadding="3" cellspacing="3" class="style1">
                                <tr>
                                    <td nowrap="nowrap" width="10%">
                                        <asp:Label ID="lbl2" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap" width="50%">
                                        <uc1:personnelIDBinder ID="pibPID" runat="server" ValidationGroup="AddOff" />
                                    </td>
                                    <td align="justify" rowspan="7" valign="top">
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
                                        <uc8:secondTypesDropDown ID="ddlSecondType" OSTID="1" runat="server" 
                                            ValidationGroup="AddOff" />
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                        <asp:Label ID="lbl0" runat="server" CssClass="FormCaption" 
                                            Text="تاريخ شروع مرخصي:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <uc4:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddOff" />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                            Display="Dynamic" ErrorMessage="تاريخ شروع بايد كوچكتر از تاريخ خاتمه باشد" 
                                            onservervalidate="CustomValidator1_ServerValidate" ValidationGroup="AddOff">*</asp:CustomValidator>
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" CssClass="FormError" 
                                            Display="Dynamic" ErrorMessage="تاريخ هاي انتخابي در سيستم ثبت شده است" 
                                            onservervalidate="CustomValidator2_ServerValidate" ValidationGroup="AddOff">*</asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl1" runat="server" CssClass="FormCaption" 
                                            Text="تاريخ اتمام مرخصي:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <uc4:persianDatePicker ID="pdpEnd" runat="server" ValidationGroup="AddOff" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="font-weight: 700">
                                        <asp:CheckBox ID="chkHollyDays" runat="server" Checked="True" 
                                            CssClass="FormButtom" Text="تعطيلات را به عنوان روز مرخصي محاسبه نكن" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl3" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <asp:TextBox ID="txtDsc" runat="server" CssClass="FormTextBox"></asp:TextBox>
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
                        
                        <asp:Panel ID="pnlConfirm" runat="server" Visible="False">
                            <table cellpadding="3" cellspacing="3" class="style1">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                                            Text="تعداد روز هاي درخواستي:"></asp:Label>
                                        <asp:Literal ID="litAll" runat="server"></asp:Literal>
                                        <br />
                                        <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                            Text="تعداد تعطيلات:"></asp:Label>
                                        <asp:Literal ID="litHollyDays" runat="server"></asp:Literal>
                                        <br />
                                        <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="مرخصي:"></asp:Label>
                                        <asp:Literal ID="litOffs" runat="server"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnEdite" runat="server" CssClass="FormButtom" 
                                            onclick="btnEdite_Click" Text="اصلاح " />
                                        &nbsp;<asp:Button ID="btnConfirm0" runat="server" CssClass="FormButtom" 
                                            onclick="btnConfirm_Click" Text="تائيد" />
                                    </td>
                                    <td align="center" width="50%">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </asp:Panel>
                    
            </asp:View>
            <asp:View ID="vwEnd" runat="server" onactivate="vwEnd_Activate">
                <asp:Label ID="lblEnd" runat="server"></asp:Label>
                <%--<br />
                <uc5:offRemain ID="offRemain1" runat="server" />--%>
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>




