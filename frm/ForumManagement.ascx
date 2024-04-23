<%@ Control Language="C#" ClassName="ForumManagement" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc7" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc1" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc4" %>

<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc5" %>

<%@ Register src="forumTypeDropDown.ascx" tagname="forumTypeDropDown" tagprefix="uc6" %>

<%@ Register src="forumParentList.ascx" tagname="forumParentList" tagprefix="uc8" %>

<%@ Register src="frmAdd.ascx" tagname="frmAdd" tagprefix="uc9" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: مديريت  :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_34_", mvw, vwPage, vwLogin);


    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        AB.Forum.Export(Server.MapPath("~/")+"exp.csv");
        Response.Redirect("~/exp.csv");
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
        frmAdd1.FParent = "";
        frmAdd1.ToolBarSet = "Default";
    }
    protected void loadData()
    {
        gvw.DataSource = AB.Forum.LoadAllData;
        gvw.DataBind();
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
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string fid = ((Label)r.FindControl("lblFID")).Text;
        string ftext = ((FCKeditor)r.FindControl("ftext")).Value;
        string ftitle = e.NewValues[0].ToString();
        DateTime fadddate = ((persianDatePicker)r.FindControl("persianDatePicker")).GeorgianDate;
        string ftype = ((forumTypeDropDown)r.FindControl("ftddlType")).FType;
        string fadder = ((personnelIDBinder)r.FindControl("pibAdder")).PID;
        string fparent = ((forumParentList)r.FindControl("fplParent")).FParent;
        AB.Forum.ChangeData(fid, ftitle, ftext, fadddate, fadder, ftype, fparent);
        gv.EditIndex = -1;
        loadData();

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
        string id = ((Label)r.FindControl("lblFID")).Text;
        AB.Forum.Delete(id);
        loadData();

    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td colspan="2">
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        SubText="در اين قسمت مي توانيد كليه موارد مربوط به اتاق فكر را مديريت كنيد." 
                        Text="مديريت اتاق فكر" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" 
                        ShowFooter="True" 
                        onrowediting="gvw_RowEditing" onrowcancelingedit="gvw_RowCancelingEdit" 
                        Width="100%" onrowdeleting="gvw_RowDeleting" 
                        onrowupdating="gvw_RowUpdating" 
                        onpageindexchanging="gvw_PageIndexChanging">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="كد"><ItemTemplate><asp:Label ID="lblFID" runat="server" Text='<%# Eval("fid") %>'></asp:Label></ItemTemplate><EditItemTemplate><asp:Label ID="lblFID" runat="server" Text='<%# Eval("fid") %>'></asp:Label></EditItemTemplate></asp:TemplateField>
                            <asp:BoundField DataField="ftitle" HeaderText="عنوان" ><ControlStyle CssClass="FormTextBox" /></asp:BoundField>
                            <asp:TemplateField HeaderText="نوع"><ItemTemplate><uc6:forumTypeDropDown ID="ftddl" FType='<%# Eval("ftype") %>' Enabled="false" runat="server" /></ItemTemplate><EditItemTemplate><uc6:forumTypeDropDown ID="ftddlType" FType='<%# Eval("ftype") %>' runat="server" /></EditItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="ايجاد كننده"><ItemTemplate><asp:Label ID="Label12" runat="server" Text='<%# Eval("pname") %>'></asp:Label></ItemTemplate><EditItemTemplate><uc5:personnelIDBinder ID="pibAdder" runat="server" 
                                        PID='<%# Eval("fadder") %>' /></EditItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="تاريخ ايجاد"><ItemTemplate><uc1:persianDateBinder ID="persianDateBinder" runat="server" 
                                        StringDate='<%# Eval("fAdddate") %>' /></ItemTemplate><EditItemTemplate><uc4:persianDatePicker ID="persianDatePicker" runat="server" 
                                        GeorgianDate='<%# DateTime.Parse(Eval("fadddate").ToString()) %>' /></EditItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="مربوط به"><EditItemTemplate><uc8:forumParentList ID="fplParent" runat="server" FParent='<%# Eval("fparent") %>' /></EditItemTemplate><ItemTemplate><asp:Label ID="lblParent" runat="server" Text='<%# Eval("fparenttitle") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="متن"><EditItemTemplate><FCKeditorV2:FCKeditor ID="ftext" runat="server" BasePath="fckeditor/" 
                                        Height="350px" ToolbarSet="Basic" Value='<%# Eval("ftext") %>' Width="300"></FCKeditorV2:FCKeditor></EditItemTemplate><ItemTemplate><asp:Label ID="lblText" runat="server" Text='<%# Eval("ftext") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                            <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                                EditText="تغيير" ShowDeleteButton="True" ShowEditButton="True" 
                                UpdateText="اعمال تغييرات"><ControlStyle CssClass="FormButtom" /></asp:CommandField>
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                        <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                            VerticalAlign="Top" />
                        <HeaderStyle CssClass="ListHeader" />
                        <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                        <RowStyle CssClass="ListRow" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnExport" runat="server" CssClass="FormButtom" 
                        onclick="btnExport_Click" Text="خروجي" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <uc9:frmAdd ID="frmAdd1"   runat="server" />
    </asp:View>
</asp:MultiView>







