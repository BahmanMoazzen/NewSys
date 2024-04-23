<%@ Control Language="C#" ClassName="PersonnelsList" %>

<%@ Register src="../gnr/userShow.ascx" tagname="usershow" tagprefix="uc6" %>
<%@ Register src="../gnr/visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc1" %>

<%@ Register src="../gnr/postsList.ascx" tagname="postsList" tagprefix="uc4" %>

<%@ Register src="../gnr/branchesLink.ascx" tagname="branchesLink" tagprefix="uc5" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc7" %>

<%@ Register src="../gnr/gradesDropDown.ascx" tagname="gradesDropDown" tagprefix="uc8" %>

<%@ Register src="personnelPic.ascx" tagname="personnelPic" tagprefix="uc9" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        text-align: center;
    }
</style>

<script runat="server">

    protected void loadData()
    {
        
        if (Request.QueryString["search"] == null)
        {
            Page.Title = "ليست پرسنل :: " + Page.Title;
            gvwLatest.DataSource = AB.User.AllPersonnels;
            gvwLatest.DataBind();
            
        }
        else
        {
            string q = Request.QueryString["search"].ToString();
            //txtMiniSearch.Text = q;
            
            gvwLatest.DataSource = AB.User.SearchPersonnels(q, null);
            gvwLatest.DataBind();


        }
        if (Cache["SP"] != null)
        {
            SelectedPersonnel = (ArrayList)Cache["SP"];
            gvwSelectedPersonnel.DataSource = AB.User.SelectedPersonnelList(SelectedPersonnel);
            gvwSelectedPersonnel.DataBind();
        }
        
        
        
        
    }
    private ArrayList SelectedPersonnel;
    protected void Page_Load(object sender, EventArgs e)
    {

        //if (!Page.IsPostBack)
        //{
        //    if (Cache["SP"] != null)
        //        Cache["SP"] = new ArrayList();
        //}
        txtMiniSearch.Focus();
        
        loadData();
        
    }
    protected void gvwLatest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        g.DataBind();
    }
   
    protected void imbSearch_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/?system=usr&module=personnels&search=" + txtMiniSearch.Text);
        
    }


    protected void gvwLatest_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.NewEditIndex];
        Label PID = (Label)r.FindControl("lblPID");
        Response.Redirect("~/?system=usr&module=add-staff&pid="+PID.Text);
        //GridView gv = (GridView)sender;
        //gv.EditIndex = e.NewEditIndex;
        //gv.DataBind();
        
    }

   

    protected void gvwLatest_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        gv.DataBind();

    }


    protected void btnAddPersonnel_Click(object sender, EventArgs e)
    {
        GridView gv = gvwLatest;
        GridViewRow r = gv.FooterRow;
        TextBox PName = (TextBox)r.FindControl("txtPName");
        TextBox PID = (TextBox)r.FindControl("txtPID");
        branchesList bl = (branchesList)r.FindControl("newBranchesList");
        postsList pl = (postsList)r.FindControl("newPostsList");
        persianDatePicker sd = (persianDatePicker)r.FindControl("NewPDPStartDate");
        CheckBox chk = (CheckBox)r.FindControl("newChkIsPermanent");
        AB.User.AddPersonnel(PName.Text, PID.Text, pl.POID, bl.BID, sd.GeorgianDate, chk.Checked);
        
        loadData();
    }

    protected void gvwLatest_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.NewSelectedIndex];
        Label lbl = (Label)r.FindControl("lblPID");

        if (Cache["SP"] != null)
        {
            SelectedPersonnel = (ArrayList)Cache["SP"];
        }
        else
        {
            SelectedPersonnel = new ArrayList();
        }
        SelectedPersonnel.Add(lbl.Text);
        Cache["SP"] = SelectedPersonnel;
        gvwSelectedPersonnel.DataSource = AB.User.SelectedPersonnelList(SelectedPersonnel);
        gvwSelectedPersonnel.DataBind();
                
        
    }

    protected void gvwSelectedPersonnel_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        Label lbl = (Label)r.FindControl("lblSelectedPID");
        SelectedPersonnel = (ArrayList)Cache["SP"];
        SelectedPersonnel.Remove(lbl.Text);
        gvwSelectedPersonnel.DataSource = AB.User.SelectedPersonnelList(SelectedPersonnel);
        gvwSelectedPersonnel.DataBind();
        Cache["SP"] = SelectedPersonnel;
        

    }

    protected void btnClearSelected_Click(object sender, EventArgs e)
    {
        if (Cache["SP"] != null)
            Cache["SP"] = new ArrayList();
        gvwSelectedPersonnel.DataSource = null;
        gvwSelectedPersonnel.DataBind();
    }

    protected void ibnPic_Click(object sender, ImageClickEventArgs e)
    {
        if (((ImageButton)sender).Width == 35)
        {
            ((ImageButton)sender).Width = 100;
        }
        if (((ImageButton)sender).Width == 100)
        {
            ((ImageButton)sender).Width = 35;
        }
    }

    protected void btnAddSelected_Click(object sender, EventArgs e)
    {
        
        if (Cache["SP"] != null)
            SelectedPersonnel = (ArrayList)Cache["SP"];
        else
            SelectedPersonnel = new ArrayList();
        foreach(GridViewRow r in gvwLatest.Rows)
        {
            CheckBox chk =(CheckBox) r.FindControl("chkSelected");
            if (chk.Checked)
            {
                Label lbl = (Label)r.FindControl("lblPID");
                SelectedPersonnel.Add(lbl.Text);
            }
        }
        Cache["SP"] = SelectedPersonnel;
        gvwSelectedPersonnel.DataSource = AB.User.SelectedPersonnelList(SelectedPersonnel);
        gvwSelectedPersonnel.DataBind();
    }


    
</script>
<asp:Panel  ID="pnlPersonnel" runat="server" DefaultButton="imbSearch">
    <table align="center" cellpadding="0" cellspacing="0"  width="100%">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="جستجو:"></asp:Label>
                <asp:TextBox ID="txtMiniSearch" runat="server" CssClass="FormTextBox" 
            ValidationGroup="miniSearch"></asp:TextBox>
                <asp:ImageButton ID="imbSearch" runat="server" AlternateText="جستجو در سایت" 
            CausesValidation="False" Height="20px" ImageAlign="AbsMiddle" 
            ImageUrl="~/images/search.gif" onclick="imbSearch_Click" TabIndex="99" 
            ToolTip="جستجو در سایت" ValidationGroup="miniSearch" Width="20px" />
            </td>
            
        </tr>
    </table>
    <asp:GridView ID="gvwLatest" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
        CellPadding="1" CellSpacing="1" GridLines="None" 
        onpageindexchanging="gvwLatest_PageIndexChanging" PageSize="20" 
        Width="100%" onrowediting="gvwLatest_RowEditing" 
        onrowcancelingedit="gvwLatest_RowCancelingEdit" 
        onselectedindexchanging="gvwLatest_SelectedIndexChanging">
        <AlternatingRowStyle CssClass="ListAlternateRow" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <uc9:personnelPic ID="personnelPic1" runat="server" PID='<%# Eval("pid") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="نام و نام خانوادگي">
                <FooterTemplate>
                    <asp:TextBox ID="txtPName" runat="server" CssClass="FormTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtPName" Display="Dynamic" 
                        ErrorMessage="لطفا نام كارمند را وارد كنيد." 
                        ToolTip="لطفا نام كارمند را وارد كنيد." ValidationGroup="AddPersonnel">*</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPName" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="شماره استخدامي">
                <EditItemTemplate>
                    <asp:Label ID="lblPID" runat="server" Text='<%# Eval("PID") %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtPID" runat="server" Columns="9" CssClass="FormTextBox" 
                        MaxLength="9"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtPID" Display="Dynamic" 
                        ErrorMessage="شماره استخدامي را وارد كنيد." ValidationGroup="AddPersonnel">*</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPID" runat="server" Text='<%# Eval("PID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PSName" HeaderText="وضعيت" ReadOnly="True" />
            <asp:TemplateField HeaderText="شعبه محل خدمت">
                <EditItemTemplate>
                    <uc7:branchesList ID="branchesList" runat="server" BID='<%# Eval("bid") %>' />
                    <br />
                    <asp:CheckBox ID="chkIsPermanent" runat="server" Checked='<%# bool.Parse(Eval("isPermanent").ToString()) %>' 
                        Text="انتقال قطعي" />
                </EditItemTemplate>
                <FooterTemplate>
                    <uc7:branchesList ID="newBranchesList" runat="server" BID="" 
                        ValidationGroup="AddPersonnel" />
                    <br />
                    <asp:CheckBox ID="newChkIsPermanent" runat="server" Checked="True" 
                        Text="انتقال قطعي" />
                </FooterTemplate>
                <ItemTemplate>
                    <uc5:branchesLink ID="branchesLink1" runat="server" 
                        BranchCode='<%# Eval("bid") %>' BranchName='<%# Eval("Bname") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="سمت">
                <EditItemTemplate>
                    <uc4:postsList ID="postsList" runat="server" POID='<%# Eval("POID") %>' />
                    <br />
                    <asp:Label ID="Label3" runat="server" CssClass="FormCaption" Text="تاريخ شروع:"></asp:Label>
                    <br />
                    <uc1:persianDatePicker ID="pdpStartDate" GeorgianDate='<%# DateTime.Now %>' runat="server" />
                    <br />
                </EditItemTemplate>
                <FooterTemplate>
                    <uc4:postsList ID="newPostsList" runat="server" POID="" 
                        ValidationGroup="AddPersonnel" />
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPost" runat="server" Text='<%# Eval("POName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="مدرك تحصيلي">
                <ItemTemplate>
                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("GradeName") %>'></asp:Literal>
                    &nbsp;<asp:Literal ID="Literal2" runat="server" Text='<%# Eval("GRName") %>'></asp:Literal>
                </ItemTemplate>
                <EditItemTemplate>
                    <uc8:gradesDropDown ID="gddGrades" GradeID='<%# Eval("GRID") %>' runat="server" />
                    <br />
                    <asp:TextBox ID="txtGradeName" Text='<%# Eval("grname") %>' runat="server" 
                        CssClass="FormTextBox"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تاريخ استخدام">
                <EditItemTemplate>
                    <uc1:persianDatePicker ID="pdpDOE" 
                        GeorgianDate='<%# DateTime.Parse(Eval("DOE").ToString()) %>' runat="server" />
                    <br />
                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                    <asp:TextBox ID="txtDesc" runat="server" CssClass="FormTextBox"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <uc3:persiandatebinder ID="pdbDOE" Date='<%# DateTime.Parse(Eval("DOE").ToString()) %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="بايگاني">
                
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" CssClass="FormCaption" 
                        Text="شماره پرونده:"></asp:Label>
                    <br />
                    <asp:Literal ID="Literal7" Text='<%# Eval("archiveId") %>' runat="server"></asp:Literal>
                    <br />
                    <asp:Label ID="Label5" runat="server" CssClass="FormCaption" Text="رديف مرخصي:"></asp:Label>
                    <br />
                    <asp:Literal ID="Literal8" Text='<%# Eval("offarchiveid") %>' runat="server"></asp:Literal>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField CancelText="انصراف" DeleteText="حذف" EditText="تغيير" 
                HeaderText="دستورات" InsertText="افزودن" NewText="جديد" SelectText="انتخاب" 
                ShowEditButton="True" ShowHeader="True" UpdateText="ثبت تغييرات" 
                ShowSelectButton="True" ButtonType="Button" >
            <ControlStyle CssClass="FormButtom" />
            <ItemStyle Wrap="False" />
            </asp:CommandField>
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
        <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" 
            CssClass="FooterStyle" />
        <HeaderStyle CssClass="ListHeader" />
        <PagerSettings Mode="NumericFirstLast" />
        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
        <RowStyle CssClass="ListRow" />
    </asp:GridView>
</asp:Panel>


<p>
    <table cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td class="style2" width="50%">
                <asp:Button ID="btnAddSelected" runat="server" CssClass="FormButtom" 
                    onclick="btnAddSelected_Click" Text="افزودن موارد انتخابي" />
            </td>
            <td class="style2">
    <asp:Button ID="btnClearSelected" runat="server" CssClass="FormButtom" 
        onclick="btnClearSelected_Click" Text="ليست انتخابي جديد" />
            </td>
        </tr>
    </table>
</p>
    <asp:GridView ID="gvwSelectedPersonnel" runat="server" 
        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
        Width="100%" 
    onrowdeleting="gvwSelectedPersonnel_RowDeleting">
        <AlternatingRowStyle CssClass="ListAlternateRow" />
        <Columns>
            <asp:TemplateField HeaderText="نام و نام خانوادگي">
                <FooterTemplate>
                    <asp:TextBox ID="txtPName0" runat="server" CssClass="FormTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtPName" Display="Dynamic" 
                        ErrorMessage="لطفا نام كارمند را وارد كنيد." 
                        ToolTip="لطفا نام كارمند را وارد كنيد." ValidationGroup="AddPersonnel">*</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPName0" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="شماره استخدامي">
                <EditItemTemplate>
                    <asp:Label ID="lblPID0" runat="server" Text='<%# Eval("PID") %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtPID0" runat="server" Columns="9" CssClass="FormTextBox" 
                        MaxLength="9"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txtPID" Display="Dynamic" 
                        ErrorMessage="شماره استخدامي را وارد كنيد." ValidationGroup="AddPersonnel">*</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSelectedPID" runat="server" Text='<%# Eval("PID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="نمره از بيست" />
            <asp:TemplateField HeaderText="سمت">
                <EditItemTemplate>
                    <uc4:postsList ID="postsList0" runat="server" POID='<%# Eval("POID") %>' />
                </EditItemTemplate>
                <FooterTemplate>
                    <uc4:postsList ID="newPostsList0" runat="server" POID="" 
                        ValidationGroup="AddPersonnel" />
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPost0" runat="server" Text='<%# Eval("POName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تاريخ استخدام">
                <ItemTemplate>
                    <uc3:persiandatebinder ID="pdbDOE" Date='<%# DateTime.Parse(Eval("DOE").ToString()) %>' runat="server" />
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="شعبه محل خدمت">
                <EditItemTemplate>
                    <uc7:branchesList ID="branchesList0" runat="server" BID='<%# Eval("bid") %>' />
                    <br />
                    <asp:CheckBox ID="chkIsPermanent0" runat="server" Checked='<%# bool.Parse(Eval("isPermanent").ToString()) %>' 
                        Text="انتقال قطعي" />
                </EditItemTemplate>
                <FooterTemplate>
                    <uc7:branchesList ID="newBranchesList0" runat="server" BID="" 
                        ValidationGroup="AddPersonnel" />
                    <br />
                    <asp:CheckBox ID="newChkIsPermanent0" runat="server" Checked="True" 
                        Text="انتقال قطعي" />
                </FooterTemplate>
                <ItemTemplate>
                    <uc5:branchesLink ID="branchesLink2" runat="server" 
                        BranchCode='<%# Eval("bid") %>' BranchName='<%# Eval("Bname") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="مدرك تحصيلي">
                <ItemTemplate>
                    <asp:Literal ID="Literal3" runat="server" Text='<%# Eval("GradeName") %>'></asp:Literal>
                    &nbsp;<asp:Literal ID="Literal4" runat="server" Text='<%# Eval("GRName") %>'></asp:Literal>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Literal ID="Literal5" runat="server" 
                        Text='<%# Eval("GradeName") %>'></asp:Literal>
                    &nbsp;<asp:Literal ID="Literal6" runat="server" Text='<%# Eval("GRName") %>'></asp:Literal></EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField CancelText="انصراف" DeleteText="حذف" EditText="تغيير" 
                HeaderText="دستورات" InsertText="افزودن" NewText="جديد" 
                SelectText="انتخاب" ShowHeader="True" UpdateText="ثبت تغييرات" 
                ShowDeleteButton="True" >
            <ItemStyle Wrap="False" />
            </asp:CommandField>
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
        <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" 
            CssClass="FooterStyle" />
        <HeaderStyle CssClass="ListHeader" />
        <PagerSettings Mode="NumericFirstLast" />
        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
        <RowStyle CssClass="ListRow" />
    </asp:GridView>



