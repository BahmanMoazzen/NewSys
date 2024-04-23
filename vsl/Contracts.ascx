<%@ Control Language="C#" ClassName="Contracts" %>

<%@ Register src="../usr/chartDescription.ascx" tagname="chartdescription" tagprefix="uc5" %>
<%@ Register src="../usr/branchUserControl.ascx" tagname="branchusercontrol" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc2" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc6" %>

<%@ Register src="majorsDropDown.ascx" tagname="majorsDropDown" tagprefix="uc7" %>

<%@ Register src="../gnr/thousandSeprator.ascx" tagname="thousandSeprator" tagprefix="uc8" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
       
        Page.Title = "تخصيص قرار داد به كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_43", mvw, vwPage, vwLogin);
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            gvw.AllowPaging = true;
            gvw.PageIndex = 0;
            loadData();
            tdSearchField.Visible = tdSearchLabel.Visible = false;
            
        }
    }
    protected void loadData()
    {
        Cache["data"] = AB.Vosool.Contracts(ddlBranches.BID, ddlMinors.MajorId, txtCount.Text, txtCountTo.Text);
        gvw.DataSource = Cache["data"];
        gvw.DataBind();
        
        if (gvw.Rows.Count > 0)
            pnlAssignment.Visible = true;
        else
            pnlAssignment.Visible = false;
    }
    protected void loadUnassignedData()
    {
        Cache["data"] =AB.Vosool.UnassignedContracts(ddlBranches.BID);
        gvw.DataSource = Cache["data"];

        gvw.DataBind();

        if (gvw.Rows.Count > 0)
            pnlAssignment.Visible = true;
        else
            pnlAssignment.Visible = false;
    }
    protected void loadData(string iSearch)
    {
        Cache["data"] = AB.Vosool.Contract(ddlBranches.BID, iSearch);
        gvw.DataSource = Cache["data"];
        
        gvw.DataBind();
        if (gvw.Rows.Count > 0)
            pnlAssignment.Visible = true;
        else
            pnlAssignment.Visible = false;
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {

        ddlBranches.BID = AB.user.BID;
        ddlBranches.UnlockKey = "44";
        ddlMinors.MajorId = "";
    }

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        
        if (Page.IsValid)
        {
            
            ArrayList contracts = readContracts();
            if (! contracts.Count.Equals(0))
            {
                AB.Vosool.AssignContract(contracts, pib.PID, ddlBranches.BID);
                loadData();
            }
        }
    }
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        gvw.DataSource = Cache["data"];

        gvw.DataBind();
    }
    protected void imbSearch_Click(object sender, ImageClickEventArgs e)
    {
        if (tdSearchField.Visible & tdSearchLabel.Visible)
        {
             
            if (Page.IsValid)
            {
                gvw.AllowPaging = false;
                loadData(txtMiniSearch.Text);
            }
        }
        else
        {
            tdSearchField.Visible = tdSearchLabel.Visible = true;
        }
    }
    private void selectContracts()
    {
        foreach (GridViewRow r in gvw.Rows)
        {

            CheckBox chk = (CheckBox)r.FindControl("chkSelected");
            chk.Checked = !chk.Checked;
        }
    }
    private ArrayList readContracts()
    {
        ArrayList contracts = new ArrayList();
        foreach (GridViewRow r in gvw.Rows)
        {
           
            CheckBox chk = (CheckBox)r.FindControl("chkSelected");
            if (chk.Checked)
            {

                HiddenField major = (HiddenField)r.FindControl("hidMajor");
                HiddenField minor = (HiddenField)r.FindControl("hidMinor");
                contracts.Add(new ListItem(major.Value, minor.Value));


            }
        }
        return contracts;
    }
    protected void btnDisassign_Click(object sender, EventArgs e)
    {
        
        

            ArrayList contracts = readContracts();

            
            if (!contracts.Count.Equals(0))
            {
               
                AB.Vosool.AssignContract(contracts, "null", ddlBranches.BID);
                loadData();
            }
        
    }



    protected void Page_Init(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            Session.Timeout = 500000;
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (int.Parse(txtCount.Text) > int.Parse(txtCountTo.Text))
            args.IsValid = false;
        else
            args.IsValid = true;
    }


    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        selectContracts();
    }

    protected void btnAssignAll_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {

            AB.Vosool.AssignAllContract(pib.ID, ddlBranches.BID, ddlMinors.MajorId, txtCount.Text, txtCountTo.Text);
            
            
        }
    }

    protected void btnDisassignAll_Click(object sender, EventArgs e)
    {
        AB.Vosool.DisassignAllContract(ddlBranches.BID, ddlMinors.MajorId, txtCount.Text, txtCountTo.Text);
    }

    protected void btnUnassigned_Click(object sender, EventArgs e)
    {
        gvw.AllowPaging = true;
        gvw.PageIndex = 0;
        loadUnassignedData();
        tdSearchField.Visible = tdSearchLabel.Visible = false;

    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:tableTitle ID="tableTitle1" runat="server" Text="مديريت قرارداد ها" 
                    Icon="0" />
                <br />
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                       
                       <tr>
                           <td align="right">
                               <table cellpadding="0" cellspacing="0">
                                   <tr>
                                       <td>
                                           <uc2:branchesList ID="ddlBranches" runat="server" />
                                       </td>
                                       <td>

                                           <uc7:majorsDropDown ID="ddlMinors" runat="server" />
                                       </td>
                                       <td>
                                           <asp:Label ID="Label3" runat="server" CssClass="FormCaption" Text="تعداد معوق:"></asp:Label>
                                           <br />
                                           <asp:TextBox ID="txtCount" runat="server" Columns="4" CssClass="FormTextBox" 
                                               MaxLength="2" ValidationGroup="show">3</asp:TextBox>
                                           <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                               ControlToValidate="txtCount" Display="Dynamic" ErrorMessage="*" 
                                               Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" 
                                               ValidationGroup="show"></asp:CompareValidator>
                                           <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="الی"></asp:Label>
                                           <asp:TextBox ID="txtCountTo" runat="server" Columns="4" CssClass="FormTextBox" 
                                               MaxLength="3" ValidationGroup="show">240</asp:TextBox>
                                           <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                               ControlToValidate="txtCountTo" Display="Dynamic" ErrorMessage="*" 
                                               Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" 
                                               ValidationGroup="show"></asp:CompareValidator>
                                           <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" 
                                               ErrorMessage="*" onservervalidate="CustomValidator1_ServerValidate" 
                                               ValidationGroup="show"></asp:CustomValidator>
                                       </td>
                                       <td>
                                           <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                                               onclick="btnShow_Click" Text="نمايش" ValidationGroup="show" />
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           <asp:Button ID="btnUnassigned" runat="server" CausesValidation="False" 
                                               CssClass="FormButtom" onclick="btnUnassigned_Click" Text="تخصیص داده نشده ها" />
                                       </td>
                                       <td>
                                           &nbsp;</td>
                                       <td>
                                           &nbsp;</td>
                                       <td>
                                           &nbsp;</td>
                                   </tr>
                               </table>
                           </td>
                           <td align="left" nowrap="nowrap" width="20%">
                               <table runat="server" cellpadding="0" cellspacing="0" ID="tblSearch">
                                   <tr>
                                       <td runat="server" id="tdSearchLabel" visible="false">
                                           <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="جستجو:"></asp:Label>
                                           
                                       </td>
                                       <td runat="server" id="tdSearchField" visible="false"><asp:TextBox ID="txtMiniSearch" runat="server" CssClass="FormTextBoxLTR" 
                                               ValidationGroup="miniSearch"></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                               ControlToValidate="txtMiniSearch" CssClass="FormError" 
                                               ErrorMessage="لطفاً شماره قرار داد را وارد كنيد." ValidationGroup="miniSearch">*</asp:RequiredFieldValidator>
                                           
                                       </td>
                                       <td><asp:ImageButton ID="imbSearch" runat="server" AlternateText="جستجو در قرارداد ها" 
                                               Height="20px" ImageAlign="AbsMiddle" ImageUrl="~/images/search.gif" 
                                               onclick="imbSearch_Click" TabIndex="99" ToolTip="جستجو در سایت" 
                                               ValidationGroup="miniSearch" Width="20px" />
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       
                </table>
                <asp:Panel ID="pnlAssignment" runat="server" Visible="False">
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    <tr><td>  
                        <uc1:tableTitle ID="tableTitle2" runat="server" Icon="2" 
                            SubText="لطفاً پس از وارد کردن شماره پرسنلی، با کلیک بر روی دکمه بررسی از صحت آن اطمینان حاصل کنید و سپس اقدام به تخصیص نمایید." 
                            Text="شماره استخدامی فرد پیگیری کننده:" />
                        </td><td> 
                            <uc6:personnelIDBinder ID="pib" runat="server" ValidationGroup="assign" />
                        </td></tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnAssign" runat="server" CommandName="assign" 
                                    CssClass="FormButtom" onclick="btnAssign_Click" 
                                    Text="تخصيص موارد انتخاب شده به فرد" ValidationGroup="assign" />
                            </td>
                            <td align="center">
                                <asp:Button ID="btnDisassign" runat="server" CausesValidation="false" 
                                    CommandName="disassign" CssClass="FormButtom" onclick="btnDisassign_Click" 
                                    Text="رفع تخصيص از موارد انتخاب شده" ValidationGroup="assign" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                               <!-- <asp:Button ID="btnAssignAll" runat="server" CommandName="assign_all" 
                                    CssClass="FormButtom" onclick="btnAssignAll_Click" 
                                    Text="تخصيص همه این لیست به فرد" ValidationGroup="assign" /> -->
                                &nbsp;</td>
                            <td>
                                <!--<asp:Button ID="btnDisassignAll" runat="server" CausesValidation="false" 
                                    CommandName="disassign_all" CssClass="FormButtom" 
                                    onclick="btnDisassignAll_Click" Text="رفع تخصيص از همه این لیست" 
                                    ValidationGroup="assign" /> -->
                                &nbsp;</td>
                        </tr>
                        
                    </table>
                </asp:Panel>
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate><uc4:progressPanelContent ID="progressPanelContent1" runat="server" /></ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" 
                    PageSize="50" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" 
                                    oncheckedchanged="chkSelectAll_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server" />
                                <asp:HiddenField ID="hidMinor" runat="server" 
                                    Value='<%# Eval("con_minor") %>' />
                                <asp:HiddenField ID="hidMajor" runat="server" 
                                    Value='<%# Eval("con_major") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ct_name" HeaderText="سیستم" />
                        <asp:BoundField DataField="con_major" HeaderText="سرفصل" />
                        <asp:BoundField DataField="con_minor" HeaderText="معين" />
                        <asp:BoundField DataField="display_name" HeaderText="نام و نام خانوادگي" />
                        <asp:BoundField DataField="moavagh_count" HeaderText="تعداد معوق" />
                        <asp:TemplateField HeaderText="مبلغ معوق">
                            <ItemTemplate>
                                <uc8:thousandSeprator ID="thousandSeprator1" runat="server" 
                                    Text='<%# Eval("amount") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="pname" HeaderText="پيگيري كننده" />
                        <asp:HyperLinkField DataNavigateUrlFields="uniq_id" 
                            DataNavigateUrlFormatString="~/default.aspx?system=vsl&amp;module=add-log&amp;uniq_id={0}" 
                            Target="_blank" Text="پیگیری" />
                    </Columns>
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <EmptyDataTemplate>
                        <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                            Text="[اطلاعاتي براي نمايش موجود نيست]"></asp:Label>
                    </EmptyDataTemplate>
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                        VerticalAlign="Top" />
                    <HeaderStyle CssClass="ListHeader" />
                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                    <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                    <RowStyle CssClass="ListRow" />
                </asp:GridView>
            
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>