<%@ Control Language="C#" ClassName="OffDays" %>

<%@ Register src="branchesList.ascx" tagname="brancheslist" tagprefix="uc7" %>
<%@ Register src="branchesLink.ascx" tagname="brancheslink" tagprefix="uc5" %>
<%@ Register src="postsList.ascx" tagname="postslist" tagprefix="uc4" %>
<%@ Register src="persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc1" %>
<%@ Register src="persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<script runat="server">

    protected void btnAddDate_Click(object sender, EventArgs e)
    {
        GridView gv = gvw;
        GridViewRow r = gv.FooterRow;
        DateTime OffDayDate = ((persianDatePicker)r.FindControl("pdpNewDate")).GeorgianDate;
        string desc = ((TextBox)r.FindControl("txtNewDesc")).Text;

        AB.General.AddOffDay(OffDayDate, desc);
        loadData();
        ((persianDatePicker)r.FindControl("pdpNewDate")).GeorgianDate = OffDayDate;

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
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((Label)r.FindControl("lblOffDayID")).Text;
        DateTime date = ((persianDatePicker)r.FindControl("pdpDate")).GeorgianDate;
        string desc = ((TextBox)r.FindControl("txtDesc")).Text;
        AB.General.UpdateOffDay(id, date, desc);
        gv.EditIndex = -1;
        loadData();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.General.OffDays;
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
        string id = ((Label)r.FindControl("lblOffDayID")).Text;
        AB.General.DeleteOffDay(id);
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
            <asp:TemplateField HeaderText="كد">
                <EditItemTemplate>
                    <asp:Label ID="lblOffDayID" runat="server" Text='<%# Eval("OffDayID") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblOffDayID" runat="server" Text='<%# Eval("OffDayID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="تاريخ">
                <FooterTemplate>
                    <uc1:persiandatepicker ID="pdpNewDate"  runat="server" 
                        ValidationGroup="AddDate" />
                </FooterTemplate>
                <EditItemTemplate>
                    <uc1:persiandatepicker ID="pdpDate" GeorgianDate='<%# DateTime.Parse(Eval("OffDayDate").ToString()) %>' runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <uc3:persiandatebinder ID="pdbDate" runat="server" Date='<%# DateTime.Parse(Eval("OffDayDate").ToString()) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="توضيحات">
                <FooterTemplate>
                    <asp:TextBox ID="txtNewDesc" runat="server" Columns="30" CssClass="FormTextBox" 
                        ValidationGroup="AddDate"></asp:TextBox>
                    <asp:Button ID="btnAddDate" runat="server" CssClass="FormButtom" 
                        onclick="btnAddDate_Click" Text="ثبت" ValidationGroup="AddDate" />
                </FooterTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDesc" runat="server" Columns="30" CssClass="FormTextBox" 
                        Text='<%# Eval("OffDayDesc") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("OffDayDesc") %>' ID="lblDesc" runat="server" CssClass="FormCaption"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowDeleteButton="True" 
                ShowEditButton="True" UpdateText="ثبت تغييرات">
            <ControlStyle CssClass="FormButtom" />
            <HeaderStyle Wrap="False" />
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

