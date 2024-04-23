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
<%@ Register src="calculateBranchReward.ascx" tagname="calculateBranchReward" tagprefix="uc8" %>
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
        //Session.Timeout = 100000;
        
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        
        mvwProcess.SetActiveView(vwMonth);
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


        gvw.DataSource = AB.Vosool.LoadMonthlyStat(hidMIDStat.Value);
        gvw.DataBind();



    }
    protected void cvPayments_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = AB.Vosool.isPaymentsInserted(ddlMonths.MID);
    }
    protected void cvMoavagh_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = AB.Vosool.isMoavaghsInserted(ddlMonths.MID);
    }
    protected void vwGoalSetting_Activate(object sender, EventArgs e)
    {
        loadStatData();
    }

    protected void vwPoint_Activate(object sender, EventArgs e)
    {

    }

    protected void vwMonth_Activate(object sender, EventArgs e)
    {

    }

    protected void vwRewardsList_Activate(object sender, EventArgs e)
    {
        gvwRewards.DataSource = AB.Vosool.LoadMonthlyReward(hidMIDStat.Value);
        gvwRewards.DataBind();
    }
    string q = "?system=vsl&module=calc-reward";
    protected void btnStartCalc_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            hidMIDShare.Value = hidMIDStat.Value = ddlMonths.MID;
            AB.Vosool.CalculatePoints(ddlMonths.MID);
            mvwProcess.SetActiveView(vwPoint);
            /*
            if (! AB.Vosool.isPointCalculated(ddlMonths.MID))
            {
                AB.Vosool.CalculatePoints(ddlMonths.MID);
                mvwProcess.SetActiveView(vwPoint);
            }else if(! AB.Vosool.isStatCalculated(ddlMonths.MID)){
                
                mvwProcess.SetActiveView(vwGoalSetting);
            }else{
                
            }      
            //Response.Redirect(q + "&lvl=2");
            */

        }
      
            
    }

    protected void btnCalsStat_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.Vosool.CalculateMonthlyReward(hidMIDShare.Value, txtReward.Text);
            mvwProcess.SetActiveView(vwGoalSetting);
        }
    }


    protected void btnRewardShare_Click(object sender, EventArgs e)
    {
        AB.Vosool.CalculateRewardShare(hidMIDStat.Value);
        mvwProcess.SetActiveView(vwRewardShare);
    }

    protected void btnShowFinalList_Click(object sender, EventArgs e)
    {
        //AB.Vosool.CalculatePersonnelShare(hidMIDStat.Value);
        mvwProcess.SetActiveView(vwRewardsList);
    }

    protected void vwRewardShare_Activate(object sender, EventArgs e)
    {
        gvwBranchList.DataSource = AB.Vosool.BranchList(hidMIDShare.Value);
        gvwBranchList.DataBind();
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
                    <asp:View ID="vwMonth" runat="server" onactivate="vwMonth_Activate">
                        <uc1:tableTitle ID="tableTitle4" runat="server" Text="انتخاب ماه عمليات" />
                        <br />
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
                                        Text="ماه انجام عمليات:"></asp:Label>
                                </td>
                                <td>
                                    <uc4:MonthDropDown ID="ddlMonths" runat="server" ValidationGroup="month" />
                                    <asp:CustomValidator ID="cvPayments" runat="server" CssClass="FormError" 
                                        Display="Dynamic" 
                                        ErrorMessage="اطلاعات مربوط به حقوق ماه مورد نظر وارد نشده است." 
                                        onservervalidate="cvPayments_ServerValidate" ValidationGroup="month">*</asp:CustomValidator>
                                    <asp:CustomValidator ID="cvMoavagh" runat="server" CssClass="FormError" 
                                        Display="Dynamic" 
                                        ErrorMessage="اطلاعات مربوط به معوقات ماه مورد نظر وارد نشده است." 
                                        onservervalidate="cvMoavagh_ServerValidate" ValidationGroup="month">*</asp:CustomValidator>
                                </td>
                                <td >
                                    <asp:Button ID="btnStartCalc" runat="server" CssClass="FormButtom" 
                                        onclick="btnStartCalc_Click" Text="شروع عملیات" ValidationGroup="month" 
                                        Width="176px" />
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="vwPoint" runat="server" onactivate="vwPoint_Activate">

                        <uc1:tableTitle ID="tableTitle2" runat="server" 
                            Text="میزان پاداش" />
                        <asp:HiddenField ID="hidMIDShare" runat="server" />
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                                        Text="مبلغ پاداش قابل تقسيم:"></asp:Label>
                                </td>
                                <td>
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
                                <td>
                                    <asp:Button ID="btnCalsStat" runat="server" CssClass="FormButtom" 
                                        onclick="btnCalsStat_Click" Text="تقسیم مبلغ" ValidationGroup="calcReward" 
                                        Width="176px" />
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="vwGoalSetting" runat="server" onactivate="vwGoalSetting_Activate">
                    <uc1:tableTitle ID="tableTitle1" runat="server" 
                            Text="ثبت اهداف و تعديل مقادير پاداش" />
                        <asp:HiddenField ID="hidMIDStat" runat="server" />
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
                                        <uc5:thousandSeprator ID="thousandSeprator1" runat="server" 
                                            Text='<%# Eval("reward") %>' />
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
                                        <uc5:thousandSeprator ID="thousandSeprator2" runat="server" 
                                            Text='<%# Eval("goal") %>' />
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
                        <asp:Button ID="btnRewardShare" runat="server" CssClass="FormButtom" 
                            onclick="btnRewardShare_Click" Text="محاسبه قدر السهم" Width="163px" />
                        <br />
                   
                   
                            
                    </asp:View>
                    <asp:View ID="vwRewardShare" runat="server" onactivate="vwRewardShare_Activate">
                         <uc1:tableTitle ID="tableTitle5" runat="server" Text="محاسبه سهم کارکنان" />
                         <asp:GridView ID="gvwBranchList" runat="server" AutoGenerateColumns="False" 
                             BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                             GridLines="None" onrowcancelingedit="gvw_RowCancelingEdit" 
                             onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" PageSize="31" 
                             Width="100%">
                             <AlternatingRowStyle CssClass="ListAlternateRow" />
                             <Columns>
                                 <asp:BoundField DataField="BID" HeaderText="كد شعبه" ReadOnly="True" />
                                 <asp:BoundField DataField="BName" HeaderText="نام شعبه" ReadOnly="True" />
                                 <asp:TemplateField HeaderText="محاسبات">
                                     <ItemTemplate>
                                         <uc8:calculateBranchReward ID="calculateBranchReward1" BID='<%# Eval("bid") %>' MID='<%# Eval("mid") %>' runat="server" />
                                     </ItemTemplate>
                                 </asp:TemplateField>
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
                             onclick="btnShowFinalList_Click" Text="اتمام محاسبات" Width="163px" />
                            
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
