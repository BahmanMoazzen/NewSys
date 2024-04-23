<%@ Control Language="C#" ClassName="Rules" %>





<%@ Register src="rulesPosts.ascx" tagname="rulesPosts" tagprefix="uc3" %>

<%@ Register src="rulesPermissions.ascx" tagname="rulesPermissions" tagprefix="uc1" %>

<%@ Register src="rulePostsPermissionsManagement.ascx" tagname="rulePostsPermissionsManagement" tagprefix="uc2" %>

<script runat="server">
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.FooterRow;
        string RName = ((TextBox)r.FindControl("txtNewRName")).Text;
        
        AB.Rules.AddRule(RName);

        loadData();


    }

    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        g.DataBind();

    }



    protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = e.NewEditIndex;
        gv.DataBind();

    }

    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.Rows[e.RowIndex];
        Label rid = (Label)r.FindControl("lblRID2");
        
        
        CheckBoxList permissions = ((rulePostsPermissionsManagement)r.FindControl("RPPM")).Permissions;
        CheckBoxList Posts = ((rulePostsPermissionsManagement)r.FindControl("RPPM")).Posts;
        TextBox RName = (TextBox)r.FindControl("txtRName");
        AB.Rules.UpdateRule(rid.Text, RName.Text);
        AB.Rules.UpdatePermissions(permissions, rid.Text);
        AB.Rules.UpdatePosts(Posts, rid.Text);
        
        
        //AB.General.UpdateBranch(RName, RID, address);
        gv.EditIndex = -1;
        loadData();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.Rules.List;
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {
        loadData();
    }

    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        gv.DataBind();
    }

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((Label)r.FindControl("lblRID")).Text;
        AB.Rules.Delete(id);
        loadData();

    }

</script>
    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
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
            <asp:TemplateField HeaderText="كد نقش">
                <EditItemTemplate>
                    <asp:Label ID="lblRID2" runat="server" Text='<%# Eval("RID") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRID" runat="server" Text='<%# Eval("RID") %>' ></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="1%" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="نام نقش">
                <FooterTemplate>
                    <asp:TextBox ID="txtNewRName" runat="server" Columns="30" 
                        CssClass="FormTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtNewRName" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="AddBranch">لطفا نام نقش را وارد كنيد.</asp:RequiredFieldValidator>
                    <asp:Button ID="btnAddBranch" runat="server" CssClass="FormButtom" 
                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddBranch" />
                </FooterTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtRName" runat="server" Columns="30" CssClass="FormTextBox" 
                        Text='<%# Eval("RName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRName" runat="server"  
                        Text='<%# Eval("RName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="1%" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تنظيمات">
                <EditItemTemplate>
                   
                    <uc2:rulePostsPermissionsManagement RuleID='<%# Eval("RID") %>' ID="RPPM" 
                        runat="server" />
                   
                </EditItemTemplate>
                <ItemTemplate>
                   
                    <uc1:rulesPermissions RuleID='<%# Eval("RID") %>' ID="rulesPermissions1" runat="server" />
                    <br />
                    <uc3:rulesPosts ID="rulesPosts1" RuleID='<%# Eval("RID") %>' runat="server" />
                   
                </ItemTemplate>
            </asp:TemplateField>
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



