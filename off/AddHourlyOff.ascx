<%@ Control Language="C#" ClassName="AddHourlyOff" %>

<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<style type="text/css">



    .style1
    {
        width: 100%;
    }
    
</style>

<script runat="server">
    //protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView g = (GridView)(sender);
    //    g.PageIndex = e.NewPageIndex;

    //    loadData();

    //}
    //protected void loadData()
    //{


    //    gvw.DataSource =AB.Offs.LoadHourlyOffs;
    //    gvw.DataBind();
    //    if (pibPID.PID != String.Empty)
    //    {
    //        offRemain.PID = pibPID.PID;
    //        offRemain.Visible = true;
    //    }



    //}
    //protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
    //    GridView gv = (GridView)sender;
    //    GridViewRow r = gv.Rows[e.RowIndex];
    //    string id = ((HiddenField)r.FindControl("hidId")).Value;
    //    AB.Offs.DeleteHourlyOff(id);
    //    loadData();

    //}
   

    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int offtype = 0,secondtype=1;
            if (rbOff.Checked)
                offtype = 9;
            if (rbMission.Checked)
                offtype = 10;
            if (rbLatency.Checked)
            {
                secondtype = 4;
                offtype = 9;
            }
            
            lblMessage.Text= AB.Offs.AddHourlyOff(pibPID.PID, pdpStart.GeorgianDate, timeStart.Time.FullTime, timeEnd.Time.FullTime, txtDuration.Text, offtype,secondtype,txtCount.Text, txtDsc.Text);
            lblMessage.Visible = true;
            //loadData();
            
        }
    }

    //protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{
    //    if (Page.IsValid)
    //    {
    //        GridView gv = (GridView)(sender);
            
    //        GridViewRow r = gv.Rows[gv.EditIndex];
    //        string id = ((HiddenField)r.FindControl("hidID")).Value;
    //        TextBox duration = ((TextBox)r.FindControl("txtChangeDuration"));
            
    //        time start = (time)r.FindControl("timeStartTime");
    //        time end = (time)r.FindControl("timeEndTime");

    //        AB.Offs.UpdateHourlyOff(id, start.Time.FullTime, end.Time.FullTime, duration.Text, e.NewValues[0].ToString());
    //        gv.EditIndex = -1;

    //        loadData();
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ثبت مرخصي ساعتي :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_7_", mvw, vwPage, vwLogin);
    }

    protected void btnCalc_Click(object sender, EventArgs e)
    {
        
            txtDuration.Text = timeEnd.Time.Distance(timeStart.Time).ToString();
        
    }

    //protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    GridView g = (GridView)(sender);
    //    g.EditIndex = e.NewEditIndex;

    //    loadData();
    //}

    //protected void vwIdle_Activate(object sender, EventArgs e)
    //{
    //    loadData();
    //}

    //protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    GridView g = (GridView)(sender);
    //    g.EditIndex = -1;

    //    loadData();
    //}

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int offtype = 0;
        if (rbOff.Checked)
            offtype = 9;
        if (rbMission.Checked)
            offtype = 10;
        if (rbLatency.Checked)
            offtype = 11;
        args.IsValid = true;
        if (AB.Offs.IsExists(pibPID.PID, pdpStart.GeorgianDate, offtype))
        {
            args.IsValid = false;
        }
    }


   

    

    //protected void lbGridCalc_Click(object sender, EventArgs e)
    //{
    //    GridView gv = gvw;
    //    GridViewRow r = gv.Rows[gv.EditIndex];
    //    TextBox duration = ((TextBox)r.FindControl("txtChangeDuration"));
    //    time start = (time)r.FindControl("timeStartTime");
    //    time end = (time)r.FindControl("timeEndTime");
    //    duration.Text = end.Time.Distance(start.Time).ToString();
    //}

    
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server"> <%--onactivate="vwIdle_Activate">--%>
                
                        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest">
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                SubText="از اين فرم جهت افزودن مرخصي ساعتي استفاده نماييد." 
                                Text="ثبت مرخصي ساعتي" />
                            <table cellpadding="3" cellspacing="3" class="style1">
                                <tr>
                                    <td nowrap="nowrap" width="10%" valign="top">
                                        <asp:Label ID="lbl2" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap" width="50%">
                                        <uc1:personnelIDBinder ID="pibPID" runat="server" ValidationGroup="AddOff" />
                                        <asp:RadioButton ID="rbOff" runat="server" Checked="True" CssClass="FormButtom" 
                                            GroupName="off" Text="مرخصي ساعتي" ValidationGroup="AddOff" />
                                        <asp:RadioButton ID="rbMission" runat="server" CssClass="FormButtom" 
                                            GroupName="off" Text="مأموريت ساعتي" ValidationGroup="AddOff" />
                                        <asp:RadioButton ID="rbLatency" runat="server" CssClass="FormButtom" 
                                            GroupName="off" Text="تآخير در ورود" ValidationGroup="AddOff" />
                                    </td>
                                    <td align="justify" rowspan="8" valign="top">
                                        <asp:Label ID="lblMessage" runat="server" CssClass="FormError" Visible="False" 
                                            EnableViewState="False"></asp:Label>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                            CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
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
                                            Display="Dynamic" ErrorMessage="مرخصي مورد نظر قبلا ثبت شده است." 
                                            onservervalidate="CustomValidator1_ServerValidate" ValidationGroup="AddOff">*</asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl1" runat="server" CssClass="FormCaption" 
                                            Text="ساعت شروع:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <uc7:time ID="timeStart" runat="server" ValidationGroup="AddOff" 
                                            CssClass="FormTextBox" ValidatorCssClass="FormError" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl4" runat="server" CssClass="FormCaption" Text="ساعت پايان:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <uc7:time ID="timeEnd" runat="server" ValidationGroup="AddOff" 
                                            CssClass="FormTextBox" ValidatorCssClass="FormError" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: 700">
                                        <asp:Label ID="lbl5" runat="server" CssClass="FormCaption" Text="مدت:"></asp:Label>
                                    </td>
                                    <td class="style2">
                                        <asp:Button ID="btnCalc" runat="server" CausesValidation="False" 
                                            CssClass="FormButtom" Text="محاسبه" ValidationGroup="AddOff" 
                                            onclick="btnCalc_Click" />
                                        <asp:TextBox ID="txtDuration" runat="server" Columns="4" CssClass="FormTextBox" 
                                            MaxLength="3" ValidationGroup="AddOff"></asp:TextBox>
                                        &nbsp;<asp:Literal ID="Literal1" runat="server" Text="دقيقه"></asp:Literal>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                            ErrorMessage="لطفا يك عدد بين 1 الي 240 وارد كنيد." Type="Integer" 
                                            ControlToValidate="txtDuration" CssClass="FormError" Display="Dynamic" 
                                            MaximumValue="240" MinimumValue="1" ValidationGroup="AddOff">*</asp:RangeValidator>
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
                                            ErrorMessage="لطفاً يك عدد بين 0 الي 99 وارد كنيد." 
                                            ControlToValidate="txtCount" CssClass="FormError" Display="Dynamic" 
                                            MaximumValue="99" MinimumValue="0" Type="Integer" ValidationGroup="AddOff">*</asp:RangeValidator>
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
                           <%-- <uc5:offRemain ID="offRemain" runat="server" Visible="False" />--%>
                            <%--<br />
                            <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                                AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                                CellPadding="1" CellSpacing="1" GridLines="None" 
                                onpageindexchanging="gvw_PageIndexChanging" onrowdeleting="gvw_RowDeleting" 
                                PageSize="20" ShowFooter="True" Width="100%" 
                                onrowupdating="gvw_RowUpdating" onrowediting="gvw_RowEditing" 
                                onrowcancelingedit="gvw_RowCancelingEdit">
                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                <Columns>
                                    <asp:BoundField DataField="pname" DataFormatString="{0}" 
                                        HeaderText="كارمند" ReadOnly="True" />
                                    <asp:BoundField HeaderText="نوع مرخصي" DataField="otName" ReadOnly="True" />
                                    <asp:BoundField DataField="OSTName" ReadOnly="True" />
                                    <asp:TemplateField HeaderText="تاريخ مؤثر">
                                        <ItemTemplate>
                                            <uc2:persianDateBinder ID="pdbStart" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("StartDate").ToString()) %>' />
                                            <asp:HiddenField Value='<%# Eval("offid").ToString() %>' ID="hidId" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ساعت شروع">
                                        <EditItemTemplate>
                                            <uc7:time ID="timeStartTime" StringTime='<%# Eval("starttime").ToString() %>' 
                                                runat="server" ValidationGroup="changeOff" CssClass="FormTextBox" ValidatorCssClass="FormError" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Literal ID="litStartTime" Text='<%# Eval("starttime").ToString() %>'  runat="server"></asp:Literal>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ساعت پايان">
                                        <EditItemTemplate>
                                            <uc7:time ID="timeEndTime" StringTime='<%# Eval("endtime").ToString() %>'  
                                                runat="server" ValidationGroup="changeOff" CssClass="FormTextBox" ValidatorCssClass="FormError" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Literal ID="litEndTime" Text='<%# Eval("endtime").ToString() %>' runat="server"></asp:Literal>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="مدت (دقيقه)">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="lbGridCalc" runat="server" 
                                                onclick="lbGridCalc_Click" CausesValidation="False">محاسبه</asp:LinkButton>
                                            <asp:TextBox  Text='<%# Eval("duration").ToString() %>' ID="txtChangeDuration" 
                                                runat="server" Columns="4" 
                                                CssClass="FormTextBox" MaxLength="3" ValidationGroup="changeOff"></asp:TextBox>
                                            &nbsp;<asp:Literal ID="Literal1" runat="server" Text="دقيقه"></asp:Literal>
                                            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                                ControlToValidate="txtChangeDuration" CssClass="FormError" Display="Dynamic" 
                                                ErrorMessage="لطفا يك عدد بين 1 الي 240 وارد كنيد." MaximumValue="240" 
                                                MinimumValue="1" Type="Integer" ValidationGroup="changeOff">*</asp:RangeValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                ControlToValidate="txtChangeDuration" CssClass="FormError" Display="Dynamic" 
                                                ErrorMessage="لطفاً مدت زمان مرخصي را وارد كنيد." 
                                                ValidationGroup="changeOff">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Literal ID="litDuration" Text='<%# Eval("duration").ToString() %>' runat="server"></asp:Literal>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="dsc" HeaderText="توضيحات">
                                    <ControlStyle CssClass="FormTextBox" />
                                    </asp:BoundField>
                                    <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="ابطال" 
                                        EditText="تغيير" HeaderText="تغيير" ShowDeleteButton="True" 
                                        ShowEditButton="True" UpdateText="اعمال تغييرات" ValidationGroup="changeOff">
                                    <ControlStyle CssClass="FormButtom" />
                                    </asp:CommandField>
                                    <asp:BoundField DataField="osttname" HeaderText="وضعيت" ReadOnly="True" />
                                </Columns>
                                <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                    VerticalAlign="Top" />
                                <HeaderStyle CssClass="ListHeader" />
                                <PagerSettings Mode="NumericFirstLast" />
                                <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                                <RowStyle CssClass="ListRow" />
                            </asp:GridView>--%>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>





