<%@ Control Language="C#" ClassName="AddNewStaff" %>

<%@ Register src="../off/OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../off/offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>

<%@ Register src="../gnr/gradesDropDown.ascx" tagname="gradesDropDown" tagprefix="uc7" %>
<%@ Register src="../off/branchPersonnel.ascx" tagname="branchPersonnel" tagprefix="uc8" %>
<%@ Register src="../gnr/postsList.ascx" tagname="postsList" tagprefix="uc9" %>
<%@ Register src="employmentTypeDropDown.ascx" tagname="employmentTypeDropDown" tagprefix="uc10" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc11" %>
<%@ Register src="militaryStatDropDown.ascx" tagname="militaryStatDropDown" tagprefix="uc12" %>
<%@ Register src="personnelStatusDropdown.ascx" tagname="personnelStatusDropdown" tagprefix="uc13" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc1" %>
<%@ Register src="transfereTypeDropDown.ascx" tagname="transfereTypeDropDown" tagprefix="uc14" %>
<%@ Register src="../gnr/branchCirclesDropDown.ascx" tagname="branchCirclesDropDown" tagprefix="uc15" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        width: 8%;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string title = String.Empty;
        if (Request.QueryString["pid"] ==null)
        {
            txtPID.Enabled = true;
            title = "افزودن كارمند جديد :: ";
            btnAddPersonnel.CommandName = btnAddUserName.CommandName = "add";
            btnAddPersonnel.Text = btnAddUserName.Text = "افزودن";
            btnAfterBasic.Visible = false;
            
        }
        else
        {
            title = "تغيير اطلاعات كارمند  :: ";
            btnAddPersonnel.CommandName = btnAddPersonnel.CommandName = "change";
            btnAfterBasic.Visible = true;
            btnAddPersonnel.Text = btnAddUserName.Text = "اعمال تغييرات";
            txtPID.Text = Request.QueryString["pid"].ToString();
            txtPID.Enabled = false;
            string employmentType = String.Empty, militaryStatus = String.Empty, personnelStatus = String.Empty, archiveid = String.Empty, offarchiveid = String.Empty;
            DateTime DOE = DateTime.Now, DOB = DateTime.Now;
            AB.User.LoadPersonnel(txtPID.Text, txtPName, ddlSex, ddlMarriage, txtPChildren, txtPOB, txtPOE, txtNID, txtIDNumber, txtSeri, txtSerial, txtAddress, txtPostalCode, txtPhone, txtMobile, ref DOE, ref employmentType, ref militaryStatus, ref personnelStatus, ref DOB,ref archiveid,ref offarchiveid);
            pdpDOE.GeorgianDate = DOE;
            etddEmploymentType.ETID = employmentType;
            msddMilitaryStatus.MSID = militaryStatus;
            psddPersonnelStatus.PSID = personnelStatus;
            pdpDOB.GeorgianDate = DOB;
            txtOffArchiveID.Text = offarchiveid;
            txtArchiveID.Text = archiveid;
        }
        Page.Title = title + Page.Title;
        LoginSystem1.CheckSecurity("1_15_", mvw, vwPage, vwLogin);
    }

    protected void btnAddPersonnel_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (((Button)sender).CommandName.Equals("add"))
            {
                AB.User.AddPersonnel(txtPID.Text, txtPName.Text, ddlSex.SelectedValue, ddlMarriage.SelectedValue, txtPChildren.Text, pdpDOE.GeorgianDate, pdpDOB.GeorgianDate, etddEmploymentType.ETID, msddMilitaryStatus.MSID, psddPersonnelStatus.PSID, txtPOE.Text, txtPOB.Text, txtNID.Text, txtIDNumber.Text, txtSeri.Text, txtSerial.Text, txtAddress.Text, txtPhone.Text, txtMobile.Text, txtPostalCode.Text,txtArchiveID.Text,txtOffArchiveID.Text);
                lblMessage.Text = Resources.Resource.txtAddStaffOk;

            }
            else
            {
                AB.User.ChangePersonnel(txtPID.Text, txtPName.Text, ddlSex.SelectedValue, ddlMarriage.SelectedValue, txtPChildren.Text, pdpDOE.GeorgianDate, pdpDOB.GeorgianDate, etddEmploymentType.ETID, msddMilitaryStatus.MSID, psddPersonnelStatus.PSID, txtPOE.Text, txtPOB.Text, txtNID.Text, txtIDNumber.Text, txtSeri.Text, txtSerial.Text, txtAddress.Text, txtPhone.Text, txtMobile.Text, txtPostalCode.Text, txtArchiveID.Text, txtOffArchiveID.Text);
            }
            mvwMain.SetActiveView(vwAddSchool);
        }
    }
    private void loadSchool()
    {
        gvwSchool.DataSource = AB.User.LoadPersonnelGrades(txtPID.Text);
        gvwSchool.DataBind();
    }
    private void loadEmployment()
    {
        gvwEmployment.DataSource = AB.User.LoadPersonnelBranches(txtPID.Text);
        gvwEmployment.DataBind();
    }
    protected void btnAddEmployment_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.User.AddEmployment(txtPID.Text, blEmployment.BID,ddlBranchCircles.BCID, plEmployment.POID, pdpStartDate.GeorgianDate,ddlTransfereType.TTID, txtDesc.Text);
            loadEmployment();
        }
    }
    
    protected void btnAddSchool_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.User.AddSchool(txtPID.Text, gddShool.GradeID, pdpEffectDate.GeorgianDate, txtGradeName.Text, txtDesc.Text);
            loadSchool();
        }
    }

    protected void btnAddUserName_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (((Button)sender).CommandName.Equals("change"))
            {
                AB.User.ChangePassword(txtPID.Text, txtPassword.Text);
                
                
            }
            else
            {
                AB.User.AddUsername(txtPID.Text, txtPassword.Text, chkActive.Checked);
            }
            mvwMain.SetActiveView(vwEnd);
        }
    }




    protected void gvwEmployment_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidpid")).Value;
        DateTime date = ((persianDateBinder)r.FindControl("pdbStartDate")).Date;
        AB.User.DeleteEmployment(id, date);
        loadEmployment();
    }

    protected void gvwSchool_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidpid")).Value;
        DateTime date = ((persianDateBinder)r.FindControl("pdbeffectdate")).Date;
        AB.User.DeleteGrade(id, date);
        loadSchool();
    }

    protected void vwAddEmployment_Activate(object sender, EventArgs e)
    {
        loadEmployment();
    }

    protected void vwAddSchool_Activate(object sender, EventArgs e)
    {
        loadSchool();
    }

    protected void btnAfterEmployment_Click(object sender, EventArgs e)
    {
        mvwMain.SetActiveView(vwAddUserName);
    }


    protected void btnAfterSchool_Click(object sender, EventArgs e)
    {
        mvwMain.SetActiveView(vwAddEmployment);
    }

    protected void btnAfterBasic_Click(object sender, EventArgs e)
    {
        mvwMain.SetActiveView(vwAddSchool);
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server">
                <asp:Panel ID="pnlAddBasic" runat="server" DefaultButton="btnAddPersonnel">
                    <uc2:tabletitle ID="tabletitle2" runat="server" Icon="1" 
                        SubText="از اين فرم جهت افزودن اطلاعات شناسنامه اي و استخدامي استفاده كنيد." 
                        Text="فرم شماره 1" />
                    <br />
                    <table class="style1">
                        <tr>
                            <td class="style2" nowrap="nowrap" width="10%">
                                <asp:Label ID="Label1" runat="server" CssClass="FormCaption" 
                                    Text="شماره استخدامي:"></asp:Label>
                            </td>
                            <td nowrap="nowrap" width="50%">
                                <asp:TextBox ID="txtPID" runat="server" Columns="6" CssClass="FormTextBox" 
                                    MaxLength="6" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="txtPID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً شماره استخدامي را وارد كنيد." 
                                    ToolTip="لطفاً شماره استخدامي را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                    ControlToValidate="txtPID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك عدد را وارد كنيد." Operator="DataTypeCheck" 
                                    ToolTip="لطفاً يك عدد را وارد كنيد." Type="Integer" ValidationGroup="AddStaff">*</asp:CompareValidator>
                            </td>
                            <td nowrap="nowrap" rowspan="24" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                    CssClass="FormError" HeaderText="ايرادات زير در فرم وجود دارد:" 
                                    ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label2" runat="server" CssClass="FormCaption">نام و نام خانوادگي:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPName" runat="server" CssClass="FormTextBox" 
                                    ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="txtPName" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً نام و نام خانوادگي را وارد كنيد." 
                                    ToolTip="لطفاً نام و نام خانوادگي را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label17" runat="server" CssClass="FormCaption">جنسيت:</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSex" runat="server" CssClass="FormTextBox">
                                    <asp:ListItem Selected="True" Value="True">مرد</asp:ListItem>
                                    <asp:ListItem Value="False">زن</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label18" runat="server" CssClass="FormCaption">وضعيت تأهل:</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMarriage" runat="server" CssClass="FormTextBox">
                                    <asp:ListItem Selected="True" Value="True">متأهل</asp:ListItem>
                                    <asp:ListItem Value="False">مجرد</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label23" runat="server" CssClass="FormCaption">تعداد فرزندان:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPChildren" runat="server" Columns="3" 
                                    CssClass="FormTextBox" MaxLength="2"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ControlToValidate="txtPChildren" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك عدد را وارد كنيد." Operator="DataTypeCheck" 
                                    ToolTip="لطفاً يك عدد را وارد كنيد." Type="Integer" ValidationGroup="AddStaff">*</asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                                    ControlToValidate="txtPChildren" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً تعداد فرزندان را وارد كنيد." 
                                    ToolTip="لطفاً تعداد فرزندان را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label3" runat="server" CssClass="FormCaption">تاريخ استخدام:</asp:Label>
                            </td>
                            <td>
                                <uc4:persiandatepicker ID="pdpDOE" runat="server" ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label26" runat="server" CssClass="FormCaption">نوع استخدام:</asp:Label>
                            </td>
                            <td>
                                <uc10:employmentTypeDropDown ID="etddEmploymentType" runat="server" ETID="2" 
                                    ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label24" runat="server" CssClass="FormCaption">وضعيت نظام وظيفه:</asp:Label>
                            </td>
                            <td>
                                <uc12:militaryStatDropDown ID="msddMilitaryStatus" runat="server" MSID="1" 
                                    ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label27" runat="server" CssClass="FormCaption">وضعيت شاغل:</asp:Label>
                            </td>
                            <td>
                                <uc13:personnelStatusDropdown ID="psddPersonnelStatus" runat="server" PSID="1" 
                                    ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label4" runat="server" CssClass="FormCaption">تاريخ تولد:</asp:Label>
                            </td>
                            <td>
                                <uc4:persiandatepicker ID="pdpDOB" runat="server" ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label21" runat="server" CssClass="FormCaption">محل تولد:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPOB" runat="server" CssClass="FormTextBox" MaxLength="30"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                                    ControlToValidate="txtPOB" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً محل تولد را وارد كنيد." 
                                    ToolTip="لطفاً محل تولد را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label22" runat="server" CssClass="FormCaption">محل صدور:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPOE" runat="server" CssClass="FormTextBox" MaxLength="30"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                                    ControlToValidate="txtPOE" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً محل صدور را وارد كنيد." 
                                    ToolTip="لطفاً محل صدور را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label5" runat="server" CssClass="FormCaption">شماره ملي:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNID" runat="server" Columns="15" CssClass="FormTextBox" 
                                    MaxLength="10" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ControlToValidate="txtNID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً شماره ملي را وارد كنيد." 
                                    ToolTip="لطفاً شماره ملي را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                    ControlToValidate="txtNID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً كد ملي را به فرمت صحيح وارد كنيد." 
                                    ToolTip="لطفاً كد ملي را به فرمت صحيح وارد كنيد." ValidationExpression="\d{10}" 
                                    ValidationGroup="AddStaff">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label6" runat="server" CssClass="FormCaption">شماره شناسنامه:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtIDNumber" runat="server" Columns="10" 
                                    CssClass="FormTextBox" MaxLength="10" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                    ControlToValidate="txtIDNumber" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً شماره شناسنامه را وارد كنيد." 
                                    ToolTip="لطفاً شماره شناسنامه را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label12" runat="server" CssClass="FormCaption">سريال شناسنامه:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSeri" runat="server" Columns="3" CssClass="FormTextBox" 
                                    MaxLength="3" ValidationGroup="AddStaff"></asp:TextBox>
                                /<asp:TextBox ID="txtSerial" runat="server" Columns="10" CssClass="FormTextBox" 
                                    MaxLength="6" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                    ControlToValidate="txtSeri" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً سري شناسنامه را وارد كنيد." 
                                    ToolTip="لطفاً سري شناسنامه را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                                    ControlToValidate="txtSerial" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً سريال شناسنامه را وارد كنيد." 
                                    ToolTip="لطفاً سريال شناسنامه را وارد كنيد." ValidationGroup="AddStaff">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap" valign="top">
                                <asp:Label ID="Label14" runat="server" CssClass="FormCaption">آدرس:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="FormTextBox" Rows="4" 
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap" valign="top">
                                <asp:Label ID="Label25" runat="server" CssClass="FormCaption">كدپستي:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="FormTextBox" 
                                    MaxLength="10"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                    ControlToValidate="txtPostalCode" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً كد پستي را به فرمت صحيح وارد كنيد." 
                                    ToolTip="لطفاً كد پستي را به فرمت صحيح وارد كنيد." 
                                    ValidationExpression="\d{10}" ValidationGroup="AddStaff">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label15" runat="server" CssClass="FormCaption">تلفن :</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="FormTextBox" MaxLength="8"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                    ControlToValidate="txtPhone" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك شماره تلفن را به فرمت صحيح  وارد كنيد." 
                                    ToolTip="لطفاً يك شماره تلفن را به فرمت صحيح  وارد كنيد." 
                                    ValidationExpression="\d{8}" ValidationGroup="AddStaff">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label16" runat="server" CssClass="FormCaption">موبايل:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobile" runat="server" CssClass="FormTextBox" 
                                    MaxLength="11"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                    ControlToValidate="txtMobile" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك شماره موبايل به فرمت صحيح  وارد كنيد." 
                                    ToolTip="لطفاً يك شماره موبايل به فرمت صحيح  وارد كنيد." 
                                    ValidationExpression="0\d{10}" ValidationGroup="AddStaff">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label38" runat="server" CssClass="FormCaption">شماره پرونده:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtArchiveID" runat="server" Columns="6" 
                                    CssClass="FormTextBox" MaxLength="4" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                    ControlToValidate="txtArchiveID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك عدد وارد كنيد!" Type="Integer" 
                                    ValidationGroup="AddStaff" Operator="DataTypeCheck">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label39" runat="server" CssClass="FormCaption">رديف مرخصي:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOffArchiveID" runat="server" Columns="6" 
                                    CssClass="FormTextBox" MaxLength="4" ValidationGroup="AddStaff"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator4" runat="server" 
                                    ControlToValidate="txtOffArchiveID" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً يك عدد وارد كنيد!" Type="Integer" 
                                    ValidationGroup="AddStaff" Operator="DataTypeCheck">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Button ID="btnAfterBasic" runat="server" CssClass="FormButtom" 
                                    onclick="btnAfterBasic_Click" Text="مرحله بعد" Visible="False" />
                            </td>
                            <td>
                                <asp:Button ID="btnAddPersonnel" runat="server" CssClass="FormButtom" 
                                    onclick="btnAddPersonnel_Click" Text="افزودن" ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </asp:View>
            <asp:View ID="vwEnd" runat="server" >
                <uc2:tabletitle ID="tabletitle1" runat="server" Icon="1" 
                    Text="كارمند مورد نظر با موفقيت اضافه شد" />
            </asp:View>
            <asp:View ID="vwAddEmployment" runat="server" 
                onactivate="vwAddEmployment_Activate">
                <uc2:tabletitle ID="tabletitle4" runat="server" Icon="1" 
                    SubText="از اين فرم جهت افزودن اطلاعات شغلي استفاده كنيد." Text="فرم شماره 1" />
                <asp:Panel ID="pnlEmployment" runat="server" DefaultButton="btnAddEmployment" 
                    EnableViewState="False">
                    <table cellpadding="0" cellspacing="0" class="style1">
                        <tr>
                            <td nowrap="nowrap" width="10%">
                                <asp:Label ID="Label28" runat="server" CssClass="FormCaption">محل خدمت:</asp:Label>
                            </td>
                            <td width="50%">
                                <uc11:branchesList ID="blEmployment" runat="server" BID="225" 
                                    ValidationGroup="AddEmployment" />
                                <uc15:branchCirclesDropDown BCID="" ID="ddlBranchCircles" runat="server" />
                            </td>
                            <td rowspan="6" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                    CssClass="FormError" HeaderText="ايرادات زير در فرم وجود دارد:" 
                                    ValidationGroup="AddEmployment" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label29" runat="server" CssClass="FormCaption">پست سازماني:</asp:Label>
                            </td>
                            <td>
                                <uc9:postsList ID="plEmployment" runat="server" POID="1" 
                                    ValidationGroup="AddEmployment" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label33" runat="server" CssClass="FormCaption">تاريخ شروع به كار:</asp:Label>
                            </td>
                            <td>
                                <uc1:persiandatepicker ID="pdpStartDate" runat="server" 
                                    ValidationGroup="AddEmployment" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                &nbsp;</td>
                            <td>
                                <uc14:transfereTypeDropDown ID="ddlTransfereType" runat="server" TTID="1" 
                                    ValidationGroup="AddEmployment" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style2" nowrap="nowrap">
                                <asp:Label ID="Label35" runat="server" CssClass="FormCaption">توضيحات:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDesc" runat="server" CssClass="FormTextBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnAddEmployment" runat="server" CssClass="FormButtom" 
                                    onclick="btnAddEmployment_Click" Text="افزودن" 
                                    ValidationGroup="AddEmployment" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:GridView ID="gvwEmployment" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" onrowdeleting="gvwEmployment_RowDeleting" PageSize="20" 
                    ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="تاريخ شروع به كار">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="pdbStartDate" runat="server" 
                                    Date='<%# DateTime.Parse(Eval("startday").ToString()) %>' />
                                <asp:HiddenField ID="hidPID" runat="server" Value='<%# Eval("pid") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="bname" HeaderText="نام شعبه" ReadOnly="True" />
                        <asp:BoundField DataField="BCName" HeaderText="دايره" />
                        <asp:BoundField DataField="poname" HeaderText="سمت" ReadOnly="True" />
                        <asp:BoundField DataField="TTname" HeaderText="نحوه انتقال" />
                        <asp:BoundField DataField="desc" HeaderText="توضيحات" />
                        <asp:CommandField ButtonType="Button" DeleteText="حذف" ShowDeleteButton="True">
                        <ControlStyle CssClass="FormButtom" />
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
                <br />
                <asp:Button ID="btnAfterEmployment" runat="server" CssClass="FormButtom" 
                    onclick="btnAfterEmployment_Click" Text="مرحله بعد" />
            </asp:View>
            <asp:View ID="vwAddSchool" runat="server" onactivate="vwAddSchool_Activate">
                <uc2:tabletitle ID="tabletitle5" runat="server" Icon="1" 
                    SubText="از اين فرم جهت افزودن اطلاعات تحصيلي استفاده كنيد." 
                    Text="فرم شماره 1" />
                <asp:Panel ID="pnlSchool" runat="server" DefaultButton="btnAddSchool" 
                    EnableViewState="False">
                    <table cellpadding="0" cellspacing="0" class="style1">
                        <tr>
                            <td nowrap="nowrap" width="10%">
                                <asp:Label ID="Label30" runat="server" CssClass="FormCaption">مقطع تحصيلي:</asp:Label>
                            </td>
                            <td width="50%">
                                <uc7:gradesDropDown ID="gddShool" runat="server" GradeID="1" 
                                    ValidationGroup="AddSchool" />
                            </td>
                            <td rowspan="5" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary3" runat="server" 
                                    CssClass="FormError" ValidationGroup="AddSchool" 
                                    HeaderText="ايرادات زير در فرم وجود دارد:" />
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Label31" runat="server" CssClass="FormCaption">عنوان مدرك:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtGradeName" runat="server" CssClass="FormTextBox" 
                                    ValidationGroup="AddSchool"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                                    ControlToValidate="txtGradeName" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً را وارد كنيد." ToolTip="لطفاً را وارد كنيد." 
                                    ValidationGroup="AddSchool">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Label34" runat="server" CssClass="FormCaption">تاريخ مؤثر:</asp:Label>
                            </td>
                            <td>
                                <uc1:persiandatepicker ID="pdpEffectDate" runat="server" 
                                    ValidationGroup="AddSchool" />
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Label36" runat="server" CssClass="FormCaption">توضيحات:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDescriptionSchool" runat="server" CssClass="FormTextBox" 
                                    ValidationGroup="AddSchool"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnAddSchool" runat="server" CssClass="FormButtom" 
                                    onclick="btnAddSchool_Click" Text="افزودن" ValidationGroup="AddStaff" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:GridView ID="gvwSchool" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" onrowdeleting="gvwSchool_RowDeleting" PageSize="20" 
                    ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="تاريخ مؤثر مدرك">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="pdbEffectDate" runat="server" Date='<%# DateTime.Parse(Eval("grgetdate").ToString()) %>' />
                                
                                <asp:HiddenField ID="hidPID" runat="server" Value='<%# Eval("pid") %>' />
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="مقطع تحصيلي" ReadOnly="True" 
                            DataField="gradename" />
                        <asp:BoundField HeaderText="نام مدرك" ReadOnly="True" DataField="grname" />
                        <asp:BoundField DataField="desc" HeaderText="توضيحات" />
                        <asp:CommandField ButtonType="Button" DeleteText="حذف" ShowDeleteButton="True">
                        <ControlStyle CssClass="FormButtom" />
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
                <asp:Button ID="btnAfterSchool" runat="server" CssClass="FormButtom" 
                    onclick="btnAfterSchool_Click" Text="مرحله بعد" />
                <br />
            </asp:View>
            <asp:View ID="vwAddUserName" runat="server">
                <uc2:tabletitle ID="tabletitle6" runat="server" Icon="1" 
                    SubText="از اين فرم جهت افزودن اطلاعات كاربري استفاده كنيد." 
                    Text="فرم شماره 1" />
                <asp:Panel ID="pnlUsername" runat="server" DefaultButton="btnAddUserName" 
                    EnableViewState="False">
                    <table cellpadding="0" cellspacing="0" class="style1">
                        <tr>
                            <td nowrap="nowrap" width="10%">
                                <asp:Label ID="Label32" runat="server" CssClass="FormCaption" 
                                    Text="شماره استخدامي:"></asp:Label>
                            </td>
                            <td width="50%">
                                <asp:Literal ID="litPID" runat="server"></asp:Literal>
                            </td>
                            <td rowspan="4" valign="top">
                                <asp:ValidationSummary ID="ValidationSummary4" runat="server" 
                                    CssClass="FormError" ValidationGroup="AddUsername" />
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="Label37" runat="server" CssClass="FormCaption" Text="كلمه عبور:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                    ValidationGroup="AddUsername" CssClass="FormTextBox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                                    ControlToValidate="txtPassword" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً كلمه عبور را وارد كنيد." 
                                    ToolTip="لطفاً كلمه عبور را وارد كنيد." ValidationGroup="AddUsername">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                &nbsp;</td>
                            <td>
                                <asp:CheckBox ID="chkActive" runat="server" Checked="True" 
                                    CssClass="FormButtom" Text="كاربر فعال است." ValidationGroup="AddUsername" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnAddUserName" runat="server" CssClass="FormButtom" 
                                    onclick="btnAddUserName_Click" Text="افزودن" 
                                    ValidationGroup="AddUsername" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>





