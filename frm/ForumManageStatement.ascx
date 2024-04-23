<%@ Control Language="C#" ClassName="ForumManageStatement" %>

<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>
<%@ Register src="forumParentList.ascx" tagname="forumparentlist" tagprefix="uc8" %>
<%@ Register src="forumTypeDropDown.ascx" tagname="forumtypedropdown" tagprefix="uc6" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc1" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: مديريت نظرات شما  :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_36_", mvw, vwPage, vwLogin);


    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }
    protected void loadData()
    {
        gvw.DataSource = AB.Forum.LoadMine("3");
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
        DateTime fadddate = ((persianDateBinder)r.FindControl("pdbAddDate")).Date;
        string ftype = ((forumTypeDropDown)r.FindControl("ftddlType")).FType;
        string fadder = AB.user.Email;
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
                        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
                        ShowFooter="True" 
                        onrowediting="gvw_RowEditing" onrowcancelingedit="gvw_RowCancelingEdit" 
                        Width="100%" onrowdeleting="gvw_RowDeleting" 
                        onrowupdating="gvw_RowUpdating">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="كد">
                                <ItemTemplate>
                                    <asp:Label ID="lblFID" runat="server" Text='<%# Eval("fid") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblFID0" runat="server" Text='<%# Eval("fid") %>'></asp:Label>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ftitle" HeaderText="عنوان" >
                            <ControlStyle CssClass="FormTextBox" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pname" HeaderText="ايجاد كننده" ReadOnly="True" />
                            <asp:TemplateField HeaderText="تاريخ ارسال">
                                <ItemTemplate>
                                    <uc1:persiandatebinder ID="pdbAddDate" runat="server" 
                                        StringDate='<%# Eval("fadddate") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="مربوط به">
                                <EditItemTemplate>
                                    <uc8:forumParentList ID="fplParent" runat="server" FParent='<%# Eval("fparent") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblParent" runat="server" Text='<%# Eval("fparenttitle") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="متن">
                                <EditItemTemplate>
                                    <FCKeditorV2:FCKeditor ID="ftext" runat="server" BasePath="fckeditor/" 
                                        Height="350px" ToolbarSet="Basic" Value='<%# Eval("ftext") %>' Width="300">
                                                                            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            </FCKeditorV2:FCKeditor>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblText" runat="server" Text='<%# Eval("ftext") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                                EditText="تغيير" ShowDeleteButton="True" ShowEditButton="True" 
                                UpdateText="اعمال تغييرات">
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
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>

    </asp:View>
</asp:MultiView>








