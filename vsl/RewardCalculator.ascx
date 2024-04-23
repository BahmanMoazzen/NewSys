<%@ Control Language="C#" ClassName="RewardCalculator" %>

<%@ Register src="majorsDropDown.ascx" tagname="majorsDropDown" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc6" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>

<%@ Register src="../gnr/MonthDropDown.ascx" tagname="MonthDropDown" tagprefix="uc4" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc6" %>
<%@ Register src="../gnr/thousandSeprator.ascx" tagname="thousandSeprator" tagprefix="uc5" %>
<style type="text/css">




    .FormButtom
    {
    }
    </style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "محاسبه پاداش وصول مطالبات :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_44", mvw, vwPage, vwLogin);
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        mvwProcess.SetActiveView(vwPoint);
    }

    protected void cvPayments_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = AB.Vosool.isPaymentsInserted(ddlMonths.MID);
    }

    protected void cvCalced_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //if(AB.Vosool.isRewardCalculated(ddlMonths.MID))
        //    mvwProcess.SetActiveView(vwRewardsList);
        args.IsValid = true;
        
    }

    protected void cvMoavagh_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = AB.Vosool.isMoavaghsInserted(ddlMonths.MID);
    }

    protected void btnStartCalc_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            hidMID.Value = ddlMonths.MID;
            if (AB.Vosool.isRewardCalculated(ddlMonths.MID))
                mvwProcess.SetActiveView(vwRewardsList);
            else
            {
                AB.Vosool.CalculatePoints(ddlMonths.MID);
                AB.Vosool.CalculateMonthlyReward(ddlMonths.MID, txtReward.Text);
                mvwProcess.SetActiveView(vwGoalSetting);
            }
            
        }
    }

    protected void vwGoalSetting_Activate(object sender, EventArgs e)
    {
        loadStatData();
    }
    
    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        loadStatData();
    }


    protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = e.NewEditIndex;
        loadStatData();

    }

    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.Rows[e.RowIndex];

        string statId = ((HiddenField)r.FindControl("hidStatId")).Value;
        string goal = ((TextBox)r.FindControl("txtGoal")).Text;
        string reward = ((TextBox)r.FindControl("txtReward")).Text;
        string rewardCount = ((TextBox)r.FindControl("txtRewardCount")).Text;
        AB.Vosool.UpdateMonthlyStat(statId, goal, reward, rewardCount);
        
        gv.EditIndex = -1;
        loadStatData();

    }
    protected void loadStatData()
    {


        gvw.DataSource = AB.Vosool.LoadMonthlyStat(hidMID.Value);
        gvw.DataBind();



    }

    protected void btnShowFinalList_Click(object sender, EventArgs e)
    {
        //AB.Vosool.CalculatePersonnelsShare(hidMID.Value);
        mvwProcess.SetActiveView(vwRewardsList);
    }

    protected void vwRewardsList_Activate(object sender, EventArgs e)
    {
        gvwRewards.DataSource = AB.Vosool.LoadMonthlyReward(hidMID.Value);
        gvwRewards.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <uc4:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>
                
                
                <asp:MultiView ID="mvwProcess" runat="server">
                    <asp:View ID="vwPoint" runat="server">

                        <uc1:tableTitle ID="tableTitle2" runat="server" 
                            Text="انتخاب ماه عمليات" />
                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                            <tr>
                                <td nowrap="nowrap" width="20%">
                                    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
                                        Text="ماه انجام عمليات:"></asp:Label>
                                </td>
                                <td>
                                    <uc4:MonthDropDown ID="ddlMonths" runat="server" ValidationGroup="calcReward" />
                                    <asp:CustomValidator ID="cvPayments" runat="server" CssClass="FormError" 
                                        Display="Dynamic" 
                                        ErrorMessage="اطلاعات مربوط به حقوق ماه مورد نظر وارد نشده است." 
                                        onservervalidate="cvPayments_ServerValidate" ValidationGroup="calcReward">*</asp:CustomValidator>
                                    <asp:CustomValidator ID="cvMoavagh" runat="server" CssClass="FormError" 
                                        Display="Dynamic" 
                                        ErrorMessage="اطلاعات مربوط به معوقات ماه مورد نظر وارد نشده است." 
                                        onservervalidate="cvMoavagh_ServerValidate" ValidationGroup="calcReward">*</asp:CustomValidator>
                                    <asp:CustomValidator ID="cvCalced" runat="server" CssClass="FormError" 
                                        Display="Dynamic" ErrorMessage="پاداش اين ماه قبلاً محاسبه شده است." 
                                        onservervalidate="cvCalced_ServerValidate" ValidationGroup="calcReward">*</asp:CustomValidator>
                                </td>
                                <td rowspan="3" width="30%">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                        CssClass="FormError" ValidationGroup="calcReward" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 27px">
                                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                                        Text="مبلغ پاداش قابل تقسيم:"></asp:Label>
                                </td>
                                <td style="height: 27px">
                                    <asp:TextBox ID="txtReward" runat="server" CssClass="FormTextBoxLTR" 
                                        ValidationGroup="calcReward"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtReward" CssClass="FormError" Display="Dynamic" 
                                        ErrorMessage="لطفا مبلغ پاداش را وارد كنيد." ValidationGroup="calcReward">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                        ControlToValidate="txtReward" CssClass="FormError" Display="Dynamic" 
                                        ErrorMessage="لطفاً يك عدد وارد كنيد." Operator="DataTypeCheck" Type="Integer" 
                                        ValidationGroup="calcReward">*</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnStartCalc" runat="server" CssClass="FormButtom" 
                                        onclick="btnStartCalc_Click" Text="انجام عمليات" ValidationGroup="calcReward" 
                                        Width="176px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="vwGoalSetting" runat="server" onactivate="vwGoalSetting_Activate">
                    <uc1:tableTitle ID="tableTitle1" runat="server" 
                            Text="ثبت اهداف و تعديل مقادير پاداش" />
                        <asp:HiddenField ID="hidMID" runat="server" />
                        <br />
                        <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                            BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                            GridLines="None" onrowcancelingedit="gvw_RowCancelingEdit" 
                            onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" PageSize="31" 
                            Width="100%">
                            <AlternatingRowStyle CssClass="ListAlternateRow" />
                            <Columns>
                                <asp:BoundField DataField="BID" HeaderText="كد شعبه" ReadOnly="True" />
                                <asp:BoundField DataField="BName" HeaderText="نام شعبه" ReadOnly="True" />
                                <asp:BoundField DataField="MID" HeaderText="ماه محاسبه" ReadOnly="True" />
                                <asp:TemplateField HeaderText="مقدار پاداش">
                                    <EditItemTemplate>
                                        <asp:HiddenField ID="hidStatId" runat="server" Value='<%# Eval("stat_id") %>' />
                                        <asp:TextBox ID="txtReward" runat="server" CssClass="FormTextBoxLTR" 
                                            Text='<%# Eval("reward") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="txtReward" CssClass="FormError" Display="Dynamic" 
                                            ErrorMessage="*" ValidationGroup="updateStat">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <uc5:thousandSeprator ID="thousandSeprator1" Text='<%# Eval("reward") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="درصد تحقق هدف">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtGoal" runat="server" CssClass="FormTextBoxLTR" 
                                            Text='<%# Eval("goal") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="txtGoal" CssClass="FormError" Display="Dynamic" 
                                            ErrorMessage="*" ValidationGroup="updateStat">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <uc5:thousandSeprator ID="thousandSeprator2" Text='<%# Eval("goal") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="تعداد نفرات">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtRewardCount" runat="server" Columns="3" 
                                            CssClass="FormTextBoxLTR" MaxLength="2" Text='<%# Eval("max_personell") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                            ControlToValidate="txtRewardCount" CssClass="FormError" Display="Dynamic" 
                                            ErrorMessage="*" ValidationGroup="updateStat">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("max_personell") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                                    EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowEditButton="True" 
                                    UpdateText="ثبت تغييرات" ValidationGroup="updateStat">
                                <controlstyle cssclass="FormButtom" />
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Width="1%" Wrap="False" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                VerticalAlign="Top" />
                            <HeaderStyle CssClass="ListHeader" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                            <RowStyle CssClass="ListRow" />
                        </asp:GridView>
                        <asp:Button ID="btnShowFinalList" runat="server" CssClass="FormButtom" 
                            onclick="btnShowFinalList_Click" Text="انجام محاسبات نهايي" Width="163px" />
                   
                   
                            
                    </asp:View>
                    <asp:View ID="vwRewardsList" runat="server" onactivate="vwRewardsList_Activate">
                         <uc1:tableTitle ID="tableTitle3" runat="server" 
                            Text="فهرست پاداش هاي قابل پرداخت" />
                            
                        <asp:GridView ID="gvwRewards" runat="server" AutoGenerateColumns="False" 
                            BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                            GridLines="None" onrowcancelingedit="gvw_RowCancelingEdit" 
                            onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" PageSize="31" 
                            Width="100%">
                            <AlternatingRowStyle CssClass="ListAlternateRow" />
                            <Columns>
                                <asp:BoundField DataField="BID" HeaderText="كد شعبه" ReadOnly="True" />
                                <asp:BoundField DataField="BName" HeaderText="نام شعبه" ReadOnly="True" />
                                <asp:BoundField DataField="PID" HeaderText="شماره استخدامي" />
                                <asp:BoundField DataField="PName" HeaderText="نام و نام خانوادگي" />
                                <asp:BoundField DataField="MID" HeaderText="ماه پرداخت" />
                                <asp:BoundField DataField="reward" HeaderText="مقدار پاداش" />
                                <asp:BoundField DataField="points" HeaderText="امتياز" />
                                <asp:BoundField DataField="desc" HeaderText="توضيحات" />
                            </Columns>
                            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                VerticalAlign="Top" />
                            <HeaderStyle CssClass="ListHeader" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                            <RowStyle CssClass="ListRow" />
                        </asp:GridView>
                         </asp:View>
                </asp:MultiView>
                 
          
                    
                    
                   
                    
                    
                  
          <%--      
            </ContentTemplate>
        </asp:UpdatePanel>--%>
        
        
    </asp:View>
</asp:MultiView>
