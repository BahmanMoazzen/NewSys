<%@ Control Language="C#" ClassName="AddOffTotal" %>

<%@ Register src="secondTypesDropDown.ascx" tagname="secondtypesdropdown" tagprefix="uc8" %>
<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>

<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc5" %>
<%@ Register src="offRemain.ascx" tagname="offRemain" tagprefix="uc5" %>

<style type="text/css">



    .style1
    {
        width: 100%;
    }
    
    .style2
    {
        width: 100%;
    }
    
</style>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = " ثبت انواع مرخصي  :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_7_", mvw, vwPage, vwLogin);
    }

    

    

    protected void rblOffType_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in rblOffType.Items)
        {

            if (li.Selected)
            {
                lbtOffType.Text = "[" + li.Text + "]";
                lbtOffType.CssClass = "FormButtom";
                lbtOffType.Enabled = true;
                if (AB.Offs.isHourly(li.Value))
                    hidOffRout.Value = "1";
                else
                    hidOffRout.Value = "0";
                hidOffType.Value = li.Value;
            }
            

        }
        mvwOffTypeOption.SetActiveView(vwSeconType);
    }

    protected void rblOffSecondType_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem li in rblOffSecondType.Items)
        {

            if (li.Selected)
            {
                lbtOffSecondType.Text = "[" + li.Text + "]";
                lbtOffSecondType.CssClass = "FormButtom";
                lbtOffSecondType.Enabled = true;
                hidOffSecondType.Value = li.Value;
            }
            

        }
        mvwOffTypeOption.SetActiveView(vwOffForm);
    }

protected void  vwType_Activate(object sender, EventArgs e)
{
    lbtOffSecondType.Enabled = false;
    lbtOffType.Enabled = false;
    lbtOffSecondType.CssClass = lbtOffType.CssClass = String.Empty;
    lbtOffSecondType.Text = "[ نوع فرعي]";
    lbtOffType.Text= "[ نوع مرخصي ]";
    rblOffType.DataSource = AB.Offs.Types();
    rblOffType.DataTextField = "otname";
    rblOffType.DataValueField = "otid";
    rblOffType.DataBind();
}

protected void vwSeconType_Activate(object sender, EventArgs e)
{
    lbtOffSecondType.Enabled = false;
    lbtOffSecondType.CssClass  = String.Empty;
    lbtOffSecondType.Text = "[ نوع فرعي]";
    rblOffSecondType.DataSource = AB.Offs.SecondTypes(hidOffRout.Value);
    rblOffSecondType.DataTextField = "OSTName";
    rblOffSecondType.DataValueField = "OSTID";
    rblOffSecondType.DataBind();
}

protected void vwOffForm_Activate(object sender, EventArgs e)
{
    decideFace();
}
protected void decideFace()
{
    if (hidOffRout.Value.Equals("1"))
    {
        mvwFormSelector.SetActiveView(vwHourly);
    }
    else
    {
        pnlMain.Enabled = true;
        pnlConfirm.Visible = false;
        pnlConfirm.Enabled = true;
        pibPID.Enabled = true;
        mvwFormSelector.SetActiveView(vwDaily);
    }
}
    #region HourlyOff
protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
{
    
    args.IsValid = true;
    if (AB.Offs.IsHourlyOffExists(pibPID.PID, pdpStart.GeorgianDate,timeStart.StringTime,timeEnd.StringTime))
    {
        args.IsValid = false;
    }
}
protected void btnCalc_Click(object sender, EventArgs e)
{

    txtDuration.Text = timeEnd.Time.Distance(timeStart.Time).ToString();

}
protected void btnRequest_Click(object sender, EventArgs e)
{
    if (Page.IsValid)
    {

        lblAddOffDescription.Text = AB.Offs.AddHourlyOff(pibPID.PID, pdpStart.GeorgianDate, timeStart.Time.FullTime, timeEnd.Time.FullTime, txtDuration.Text, hidOffType.Value, hidOffSecondType.Value, txtCount.Text, txtDsc.Text);
        lblMessage.Text = String.Format(" مرخصي همكار {0} به شماره استخدامي {1} به مدت {2} دقيقه ثبت گرديد.", pibPID.PName, pibPID.PID, txtDuration.Text);
        gvwArchiveId.DataSource = AB.User.LoadArchiveIDs(pibPID.PID);
        gvwArchiveId.DataBind();
        mvwMain.SetActiveView(vwDone);
        
    }
}
    #endregion
#region DailyOff
protected void btnDailyRequest_Click(object sender, EventArgs e)
{
    if (Page.IsValid)
    {
        pnlConfirm.Visible = true;
        pnlMain.Enabled = false;
        pibPID.Enabled = false;
        
        

    }
}
    protected void btnConfirm_Click(object sender, EventArgs e)
{
    if (Page.IsValid)
    {
        
        AB.Offs.AddOffByOperator(pibPID.PID, pdpDailyStart.GeorgianDate, pdpdailyEnd.GeorgianDate, AB.user.Email, litOffs.Text,hidOffType.Value, hidOffSecondType.Value, txtDailyDsc.Text);
        lblMessage.Text= String.Format(" مرخصي همكار {0} به شماره استخدامي {1} به مدت {2} روز ثبت گرديد.", pibPID.PName, pibPID.PID, litOffs.Text);
        gvwArchiveId.DataSource = AB.User.LoadArchiveIDs(pibPID.PID);

        gvwArchiveId.DataBind();
        mvwMain.SetActiveView(vwDone);

    }
}
    protected void btnEdite_Click(object sender, EventArgs e)
    {
        pnlConfirm.Visible = false;
        pnlMain.Enabled = true;
        pibPID.Enabled = true;
    }

    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;
        if (AB.Offs.IsExists(pibPID.PID, pdpDailyStart.GeorgianDate, pdpdailyEnd.GeorgianDate))
        {
            args.IsValid = false;
        }
    }

    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        
        int dif = pdpDailyStart.GeorgianDate.CompareTo(pdpdailyEnd.GeorgianDate);

        args.IsValid = (dif <= 0);
    }
    protected void CustomValidator4_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;
        string all = String.Empty, hollydays = String.Empty;
        AB.Offs.DaysBetween(pdpDailyStart.GeorgianDate, pdpdailyEnd.GeorgianDate, ref all, ref hollydays);
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
        if (hidOffType.Value.Equals("1"))
        {
            int remain = int.Parse(AB.Offs.Remain(pibPID.PID));
            if (remain < int.Parse(litOffs.Text))
                args.IsValid = false;
        }
    }
#endregion




    protected void lbtStart_Click(object sender, EventArgs e)
    {
        timeStart.StringTime = "7:0";
    }

    protected void lbtEnd_Click(object sender, EventArgs e)
    {
        if (! pdpStart.StringDate.Equals(String.Empty))
        {
            if (pdpStart.GeorgianDate.DayOfWeek == DayOfWeek.Thursday)
            {
                timeEnd.StringTime = "13:30";
            }
            else
            {
                timeEnd.StringTime = "14:30";
            }
        }
    }


    protected void lbtOffType_Click(object sender, EventArgs e)
    {
        mvwOffTypeOption.SetActiveView(vwType);
    }

    protected void lbtOffSecondType_Click(object sender, EventArgs e)
    {
        mvwOffTypeOption.SetActiveView(vwSeconType);
    }

    protected void vwDone_Activate(object sender, EventArgs e)
    {
        offRemain.PID = pibPID.PID;
    }

    protected void btnReInsert_Click(object sender, EventArgs e)
    {
        pibPID.PID = String.Empty;
        lblAddOffDescription.Text = String.Empty;
        mvwMain.SetActiveView(vwIdle);
        decideFace();
    }
</script>



<asp:UpdatePanel ID="upMain" runat="server">
                    <ContentTemplate>

<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server">
                
                
                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                            
                            <tr>
                                <td colspan="3">
                                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                        SubText="ابتدا به وسيله منوهاي ايجاد شده نوع مرخصي را انتخاب نموده و سپس ما بقي اطلاعات خواسته شده را وارد كنيد. " 
                                        Text="فرم افزودن انواع مرخصي " />
                                </td>
                            </tr>
                             
                            <tr>
                                <td nowrap="nowrap" width="10%">
                                    <asp:Label ID="lbl2" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                </td>
                                <td>
                                    <uc1:personnelIDBinder ID="pibPID" runat="server" ValidationGroup="AddOff" />
                                </td>
                                <td rowspan="3" valign="top">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                        CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
                                        ValidationGroup="AddOff" />
                                </td>
                            </tr>
                            <tr>
                            <td colspan="2">
                                    &nbsp; 
                                    <asp:LinkButton ID="lbtOffType" runat="server" Enabled="False" 
                                        onclick="lbtOffType_Click">[نوع مرخصي]</asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="lbtOffSecondType" runat="server" Enabled="False" 
                                        onclick="lbtOffSecondType_Click">[نوع فرعي]</asp:LinkButton>
                                    <asp:HiddenField ID="hidOffType" runat="server" />
                                    <asp:HiddenField ID="hidOffRout" runat="server" />
                                    <asp:HiddenField ID="hidOffSecondType" runat="server" />
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="1">
                                        <ProgressTemplate>
                                            <uc5:progressPanelContent ID="progressPanelContent1" runat="server" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:MultiView ID="mvwOffTypeOption" runat="server" ActiveViewIndex="0">
                                        <asp:View ID="vwType" runat="server" onactivate="vwType_Activate">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td nowrap="nowrap" width="10%">
                                                        <asp:Label ID="lblOffTypeCaption0" runat="server" CssClass="FormCaption" 
                                                            Text="نوع مرخصي:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList ID="rblOffType" runat="server" AutoPostBack="True" 
                                                            CssClass="FormButtom" onselectedindexchanged="rblOffType_SelectedIndexChanged" 
                                                            RepeatColumns="2" RepeatDirection="Horizontal">
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="vwSeconType" runat="server" onactivate="vwSeconType_Activate">
                                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td nowrap="nowrap" width="10%">
                                                        <asp:Label ID="lblOffTypeCaption1" runat="server" CssClass="FormCaption" 
                                                            Text="نوع فرعي مرخصي:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList ID="rblOffSecondType" runat="server" AutoPostBack="True" 
                                                            CssClass="FormButtom" 
                                                            onselectedindexchanged="rblOffSecondType_SelectedIndexChanged" 
                                                            RepeatColumns="2" RepeatDirection="Horizontal">
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="vwOffForm" runat="server" onactivate="vwOffForm_Activate">
                                            <asp:MultiView ID="mvwFormSelector" runat="server">
                                                <asp:View ID="vwHourly" runat="server">
                                                    <table cellpadding="3" cellspacing="3" width="100%">
                                                        <tr>
                                                            <td nowrap="nowrap" width="20%">
                                                                <asp:Label ID="lbl0" runat="server" CssClass="FormCaption" 
                                                                    Text="تاريخ شروع مرخصي:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <uc4:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddOff" />
                                                                <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                                                    Display="Dynamic" ErrorMessage="مرخصي مورد نظر قبلا ثبت شده است." 
                                                                    onservervalidate="CustomValidator1_ServerValidate" ValidationGroup="AddOff">*</asp:CustomValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: 700">
                                                                <asp:Label ID="lbl1" runat="server" CssClass="FormCaption" Text="ساعت شروع:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <uc7:time ID="timeStart" runat="server" CssClass="FormTextBox" 
                                                                    ValidationGroup="AddOff" ValidatorCssClass="FormError" />
                                                                <asp:LinkButton ID="lbtStart" runat="server" onclick="lbtStart_Click">ابتداي وقت اداري</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: 700">
                                                                <asp:Label ID="lbl4" runat="server" CssClass="FormCaption" Text="ساعت پايان:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <uc7:time ID="timeEnd" runat="server" CssClass="FormTextBox" 
                                                                    ValidationGroup="AddOff" ValidatorCssClass="FormError" />
                                                                <asp:LinkButton ID="lbtEnd" runat="server" onclick="lbtEnd_Click">پايان وقت اداري</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: 700">
                                                                <asp:Label ID="lbl5" runat="server" CssClass="FormCaption" Text="مدت:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:Button ID="btnCalc" runat="server" CausesValidation="False" 
                                                                    CssClass="FormButtom" onclick="btnCalc_Click" Text="محاسبه" 
                                                                    ValidationGroup="AddOff" />
                                                                <asp:TextBox ID="txtDuration" runat="server" Columns="4" CssClass="FormTextBox" 
                                                                    MaxLength="3" ValidationGroup="AddOff"></asp:TextBox>
                                                                &nbsp;<asp:Literal ID="Literal1" runat="server" Text="دقيقه"></asp:Literal>
                                                                <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                                                    ControlToValidate="txtDuration" CssClass="FormError" Display="Dynamic" 
                                                                    ErrorMessage="لطفا يك عدد بين 1 الي 240 وارد كنيد." MaximumValue="240" 
                                                                    MinimumValue="1" Type="Integer" ValidationGroup="AddOff">*</asp:RangeValidator>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                                    ControlToValidate="txtDuration" CssClass="FormError" Display="Dynamic" 
                                                                    ErrorMessage="لطفاً مدت زمان مرخصي را وارد كنيد." ValidationGroup="AddOff">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: 700">
                                                                <asp:Label ID="lbl6" runat="server" CssClass="FormCaption" Text="تعداد:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:TextBox ID="txtCount" runat="server" Columns="3" CssClass="FormTextBox" 
                                                                    MaxLength="2">1</asp:TextBox>
                                                                <asp:RangeValidator ID="RangeValidator2" runat="server" 
                                                                    ControlToValidate="txtCount" CssClass="FormError" Display="Dynamic" 
                                                                    ErrorMessage="لطفاً يك عدد بين 0 الي 99 وارد كنيد." MaximumValue="99" 
                                                                    MinimumValue="0" Type="Integer" ValidationGroup="AddOff">*</asp:RangeValidator>
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
                                                                    onclick="btnRequest_Click" Text="ثبت " ValidationGroup="AddOff" 
                                                                     UseSubmitBehavior="False"   onclientclick="javascript:disableButtom(this);" />
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:View>
                                                <asp:View ID="vwDaily" runat="server">
                                                <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest">
                                                    <table cellpadding="3" cellspacing="3" class="style1">
                                                        <tr>
                                                            <td nowrap="nowrap" width="20%">
                                                                <asp:Label ID="lbl8" runat="server" CssClass="FormCaption" 
                                                                    Text="تاريخ شروع مرخصي:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <uc4:persianDatePicker ID="pdpDailyStart" runat="server" 
                                                                    ValidationGroup="AddOff" />
                                                                <asp:CustomValidator ID="CustomValidator3" runat="server" CssClass="FormError" 
                                                                    Display="Dynamic" ErrorMessage="تاريخ شروع بايد كوچكتر از تاريخ خاتمه باشد" 
                                                                    onservervalidate="CustomValidator3_ServerValidate" 
                                                                    ValidationGroup="AddOff">*</asp:CustomValidator>
                                                                <asp:CustomValidator ID="CustomValidator2" runat="server" CssClass="FormError" 
                                                                    Display="Dynamic" ErrorMessage="تاريخ هاي انتخابي در سيستم ثبت شده است" 
                                                                    onservervalidate="CustomValidator2_ServerValidate" 
                                                                    ValidationGroup="AddOff">*</asp:CustomValidator>
                                                                <asp:CustomValidator ID="CustomValidator4" runat="server" CssClass="FormError" 
                                                                    Display="Dynamic" ErrorMessage="همكار مورد نظر فاقد مانده مرخصي كافي مي باشد! " 
                                                                    onservervalidate="CustomValidator4_ServerValidate" 
                                                                    ValidationGroup="AddOff">*</asp:CustomValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight: 700">
                                                                <asp:Label ID="lbl9" runat="server" CssClass="FormCaption" 
                                                                    Text="تاريخ اتمام مرخصي:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <uc4:persianDatePicker ID="pdpdailyEnd" runat="server" 
                                                                    ValidationGroup="AddOff" />
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
                                                                <asp:Label ID="lbl10" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                                                            </td>
                                                            <td class="style2">
                                                                <asp:TextBox ID="txtDailyDsc" runat="server" CssClass="FormTextBox"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td class="style2">
                                                                <asp:Button ID="btnDailyRequest" runat="server" CssClass="FormButtom" 
                                                                    onclick="btnDailyRequest_Click" Text="محاسبه" ValidationGroup="AddOff" />
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
                                                                &nbsp;<asp:Button ID="btnDailyConfirm" runat="server" CssClass="FormButtom" 
                                                                    onclick="btnConfirm_Click" Text="ثبت" ValidationGroup="AddOff" 
                                                                    onclientclick="javascript:disableButtom(this);" UseSubmitBehavior="False" />
                                                            </td>
                                                            <td align="center" width="50%">
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                    </asp:Panel>
                                                </asp:View>
                                            </asp:MultiView>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                           
                        </table>
                   
                
            </asp:View>
            <asp:View ID="vwDone" runat="server" onactivate="vwDone_Activate">
                <table cellpadding="0" cellspacing="0" class="style2">
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" CssClass="FormInfo" 
                                EnableViewState="False"></asp:Label>
                            <br />
                            <asp:Label ID="Label5" runat="server" Text="توضيحات:" CssClass="FormCaption"></asp:Label>
                            <br />
                            <asp:Label ID="lblAddOffDescription" runat="server" CssClass="FormError"></asp:Label>

                            <br />
                            <asp:GridView ID="gvwArchiveId" runat="server" CellPadding="3" CellSpacing="3">
                            
                            </asp:GridView>
                        </td>
                        <td>
                            <asp:Button ID="btnReInsert" runat="server" CausesValidation="False" 
                                onclick="btnReInsert_Click" Text="ثبت مورد مشابه" CssClass="FormButtom" />
                        </td>
                    </tr>
                </table>
                <uc5:offRemain ID="offRemain" runat="server" />
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>
 </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnReInsert" />
                    </Triggers>
                </asp:UpdatePanel>




