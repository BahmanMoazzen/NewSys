<%@ Control Language="C#" ClassName="RequestNewOff" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc4" %>
<%@ Register src="branchPersonnel.ascx" tagname="branchPersonnel" tagprefix="uc5" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc6" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        pdbToday.Date = DateTime.Now;
        Page.Title = "درخواست مرخصي :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_2_", mvw, vwPage, vwLogin);
        
    }
    //protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    args.IsValid = true;
    //    if (pdpStart.GeorgianDate == pdpEnd.GeorgianDate & pdpStart.GeorgianDate.DayOfWeek.Equals(DayOfWeek.Friday))
    //    {

    //        args.IsValid = false;
    //    }
    //}
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
        AB.Offs.AddOff( pdpStart.GeorgianDate, pdpEnd.GeorgianDate,litOffs.Text);
        mvwMain.SetActiveView(vwEnd);
        
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int dif =pdpStart.GeorgianDate.CompareTo(pdpEnd.GeorgianDate);

        if (dif>0)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
      
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;
        if (AB.Offs.IsExists(AB.user.Email, pdpStart.GeorgianDate, pdpEnd.GeorgianDate))
        {
            args.IsValid = false;
        }

    }
</script>
<style type="text/css">

    .style1
    {
        width: 100%;
    }
</style>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server">
                <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest">
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="0" 
                        SubText="از اين فرم جهت درخواست مرخصي استفاده نماييد." 
                        Text="فرم درخواست مرخصي" />
                    <table cellpadding="3" cellspacing="3" class="style1">
                        <tr>
                            <td nowrap="nowrap" width="10%">
                                <asp:Label ID="lbl" runat="server" CssClass="FormCaption" Text="تاريخ درخواست:"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="50">
                                <uc3:persianDateBinder ID="pdbToday" runat="server" CssStyle="FormError" />
                            </td>
                            <td align="justify" rowspan="5" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                    CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
                                    ValidationGroup="AddOff" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl0" runat="server" CssClass="FormCaption" 
                                    Text="تاريخ شروع مرخصي:"></asp:Label>
                            </td>
                            <td>
                                <uc4:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddOff" />
                                <asp:CustomValidator ID="CustomValidator2" runat="server" CssClass="FormError" 
                                    Display="Dynamic" ErrorMessage="تاريخ هاي انتخابي در سيستم ثبت شده است" 
                                    onservervalidate="CustomValidator2_ServerValidate" 
                                    ValidationGroup="AddOff">*</asp:CustomValidator>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                    Display="Dynamic" ErrorMessage="تاريخ شروع بايد كوچكتر از تاريخ خاتمه باشد" 
                                    onservervalidate="CustomValidator1_ServerValidate" ValidationGroup="AddOff">*</asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: 700">
                                <asp:Label ID="lbl1" runat="server" CssClass="FormCaption" 
                                    Text="تاريخ اتمام مرخصي:"></asp:Label>
                            </td>
                            <td>
                                <uc4:persianDatePicker ID="pdpEnd" runat="server" ValidationGroup="AddOff" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="font-weight: 700">
                                <asp:CheckBox ID="chkHollyDays" runat="server" Checked="True" 
                                    CssClass="FormButtom" Text="تعطيلات را كسر كن" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnRequest" runat="server" CssClass="FormButtom" 
                                    onclick="btnRequest_Click" Text="ثبت درخواست" ValidationGroup="AddOff" />
                            </td>
                        </tr>
                    </table>
                    
                </asp:Panel><asp:Panel ID="pnlConfirm" runat="server" Visible="False">
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
            <asp:View ID="vwEnd" runat="server">
                <asp:Label ID="Label1" runat="server" 
                    Text="عمليات با موفقيت انجام شد.در انتظار تائيد و امضاء مرخصي باشيد."></asp:Label>
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>



