<%@ Control Language="C#" ClassName="Branches" %>

<%@ Register src="persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc1" %>
<%@ Register src="persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="PermissionsAllDropDown.ascx" tagname="permissionsalldropdown" tagprefix="uc4" %>
<%@ Register src="progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../usr/branchUserControl.ascx" tagname="branchUserControl" tagprefix="uc5" %>
<%@ Register src="branchesList.ascx" tagname="branchesList" tagprefix="uc6" %>
<style type="text/css">



    .FormButtom
    {
        width: 39px;
    }
    </style>

<script runat="server">
    

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.FooterRow;
        string bName = ((TextBox)r.FindControl("txtNewBname")).Text;
        string BID = ((TextBox)r.FindControl("txtNewBID")).Text;
        string address=((TextBox)r.FindControl("txtNewAddress")).Text;
        string parent = ((branchesList)r.FindControl("ddlBranch")).BID;
        string grade = ((TextBox)r.FindControl("txtgrade")).Text;
        string max = ((TextBox)r.FindControl("txtBMaxPersonnel")).Text;
        string contracted = ((TextBox)r.FindControl("txtContracted")).Text;
        string rewardCount = ((TextBox)r.FindControl("txtRewardCount")).Text;
        AB.General.AddBranch(bName, BID, address,parent,grade,max,contracted,rewardCount);
        
        loadData();
        

    }

    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        loadData();

    }



    protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = e.NewEditIndex;
        loadData();

    }

    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.Rows[e.RowIndex];
        string bName = ((TextBox)r.FindControl("txtBName")).Text;
        string BID = ((Label)r.FindControl("lblBIDForChange")).Text;
        string address = ((TextBox)r.FindControl("txtAddress")).Text;
        string parent = ((branchesList)r.FindControl("ddlBranchforChange")).BID;
        string grade = ((TextBox)r.FindControl("txtGradeChange")).Text;
        string max = ((TextBox)r.FindControl("txtBMaxPersonnelForChange")).Text;
        string contracted = ((TextBox)r.FindControl("txtContractedForChange")).Text;
        string rewardCount = ((TextBox)r.FindControl("txtRewardCountEdite")).Text;
        AB.General.UpdateBranch(bName, BID, address,parent,grade,max,contracted,rewardCount);
        gv.EditIndex = -1;
        loadData();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.General.Branches;
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
        Page.Title = "مديريت اطلاعات شعب:: " + Page.Title;
        LoginSystem1.CheckSecurity("1_12_", mvw, vwPage, vwLogin);
        
    
        
    }

    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        loadData();
    }

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((Label)r.FindControl("lblBID")).Text;
        AB.General.DeleteBranch(id);
        loadData();

    }
   

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }
</script>
    <p>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="مديريت شعب" 
            Icon="0" />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:GridView ID="gvw" runat="server" 
        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
        CellPadding="1" CellSpacing="1" GridLines="None" 
        onpageindexchanging="gvw_PageIndexChanging" PageSize="20" 
        Width="100%" onrowediting="gvw_RowEditing" 
        onrowupdating="gvw_RowUpdating" 
        onrowcancelingedit="gvw_RowCancelingEdit" ShowFooter="True" 
    onrowdeleting="gvw_RowDeleting"  
    
    >
        <AlternatingRowStyle CssClass="ListAlternateRow" />
        <Columns>
            <asp:TemplateField HeaderText="كد شعبه">
                <EditItemTemplate>
                    <asp:Label ID="lblBIDForChange" runat="server" Text='<%# Eval("BID") %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtNewBID" runat="server" CssClass="FormTextBox" 
                        ValidationGroup="AddBranch" Columns="4" MaxLength="4"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txtNewBID" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا كد شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBID" runat="server" Text='<%# Eval("BID") %>' ></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="1%" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="نام شعبه">
                <FooterTemplate>
                    <asp:TextBox ID="txtNewBName" runat="server" Columns="30" 
                        CssClass="FormTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtNewBName" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا نام شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                </FooterTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtBName" runat="server" Columns="30" CssClass="FormTextBox" 
                        Text='<%# Eval("BName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBName" runat="server"  
                        Text='<%# Eval("Bname") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="1%" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="درجه شعبه">
                <ItemTemplate>
                    <asp:Label ID="lblGrade" runat="server" Text='<%# Eval("bgrade") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtGradeChange" runat="server" Columns="5" 
                        CssClass="FormTextBox" Text='<%# Eval("bgrade") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtGrade" runat="server" Columns="5" CssClass="FormTextBox" 
                        ValidationGroup="AddBranch"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtGrade" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا درجه شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="شعبه مادر">
                <ItemTemplate>
                    <asp:Label ID="lblParentName" runat="server" Text='<%# Eval("bparentname") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <uc6:branchesList ID="ddlBranchForChange" runat="server" 
                        BID='<%# Eval("BParent") %>' />
                </EditItemTemplate>
                <FooterTemplate>
                    <uc6:branchesList ID="ddlBranch" runat="server" BID="225" 
                        ValidationGroup="AddBranch" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="آدرس">
                <FooterTemplate>
                    <asp:TextBox ID="txtNewAddress" runat="server" Columns="35" 
                        CssClass="FormTextBox"></asp:TextBox>
                </FooterTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddress" Text='<%# Eval("BAddress") %>' runat="server" Columns="35" CssClass="FormTextBox"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblAddress" Text='<%# Eval("BAddress") %>' runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تعداد پرسنل در چارت">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBMaxPersonnelForChange" runat="server" Columns="5" 
                        CssClass="FormTextBox" Text='<%# Eval("BMaxPersonnel") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtBMaxPersonnel" runat="server" Columns="5" 
                        CssClass="FormTextBox" ValidationGroup="AddBranch"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txtBMaxPersonnel" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا تعداد پرسنل در چارت شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblMaxPersonnel" runat="server" 
                        Text='<%# Eval("BMaxPersonnel") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تعداد كاركنان شركتي"><EditItemTemplate>
                    <asp:TextBox ID="txtContractedForChange" runat="server" Columns="5" 
                        CssClass="FormTextBox" Text='<%# Eval("bCurrentContractedPersonnel") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtContracted" runat="server" Columns="5" 
                        CssClass="FormTextBox" ValidationGroup="AddBranch"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txtContracted" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا تعداد نيروي شركتي شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                    <asp:Button ID="btnAddBranch" runat="server" CssClass="FormButtom" 
                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddBranch" />
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblContracted" runat="server" 
                        Text='<%# Eval("BCurrentContractedPersonnel") %>'></asp:Label>
                </ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="نفرات جهت پاداش مطالبات"><EditItemTemplate>
                    <asp:TextBox ID="txtRewardCountEdite" runat="server" Columns="5" 
                        CssClass="FormTextBox" Text='<%# Eval("reward_count") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:TextBox ID="txtRewardCount" runat="server" Columns="3" 
                        CssClass="FormTextBox" ValidationGroup="AddBranch" MaxLength="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txtRewardCount" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا تعداد نفرات مربوط به وصول مطالبات شعبه را وارد كنيد.</asp:RequiredFieldValidator>
                    
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRewardCount" runat="server" 
                        Text='<%# Eval("reward_count") %>'></asp:Label>
                </ItemTemplate></asp:TemplateField>
            <asp:CommandField CancelText="انصراف" DeleteText="حذف" 
                EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowDeleteButton="True" 
                ShowEditButton="True" UpdateText="ثبت تغييرات" ButtonType="Button">
            <ControlStyle CssClass="FormButtom" />
            <HeaderStyle Wrap="False" />
            <ItemStyle Width="1%" Wrap="False" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>















        <br />
</p>
    


