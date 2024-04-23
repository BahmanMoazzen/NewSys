<%@ Control Language="C#" ClassName="ForumStatementList" %>

<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc7" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>

<%@ Register src="frmAdd.ascx" tagname="frmAdd" tagprefix="uc2" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc4" %>

<%@ Register src="../gnr/timeBinder.ascx" tagname="timeBinder" tagprefix="uc5" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: ليست نظرات :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_37_", mvw, vwPage, vwLogin);


    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        string fid = Request.QueryString["fid"].ToString();
        string fText = String.Empty;
        string fTitle = String.Empty;
        AB.Forum.LoadById(fid, ref fText, ref fTitle);
        tbtTitle.Text = fTitle;
        tbtTitle.SubText = fText;
        gvw.DataSource = AB.Forum.LoadStatement(fid);
        gvw.DataBind();
        frmAdd.FParent = fid;
    }


    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        string fid = Request.QueryString["fid"].ToString();
        gvw.DataSource = AB.Forum.LoadStatement(fid);
        gvw.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">

        <uc1:tableTitle ID="tbtTitle" runat="server" Icon="0" />

        <br />
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True" Width="100%" onpageindexchanging="gvw_PageIndexChanging">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:TemplateField HeaderText="نظرات مطرح شده">
                    <ItemTemplate>

                        <table cellpadding="0" cellspacing="0" style="width: 100%">
                            <tr>
                                <td align="center" valign="top" width="15%">
                                <a name='<%# Eval("Fid")  %>'></a>
                                    <asp:Image ID="Image1" runat="server" 
                                        ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg", Eval("FAdder")) %>' 
                                        Width="35" /> <br />
                                    <asp:Label ID="lblPerName" runat="server" Text='<%# Eval("pName") %>'></asp:Label>
                                </td>
                                <td valign="top" align="right">
                                   <uc1:tableTitle ID="tbtStatement" runat="server" Icon="1" 
                            SubText='<%# Eval("ftext") %>' Text='<%# Eval("ftitle") %>' /> </td>
                                <td align="center" valign="top" width="10%">
                                    <uc4:persianDateBinder ID="persianDateBinder1" StringDate='<%# Eval("fadddate") %>' runat="server" />
                                    <uc5:timeBinder ID="timeBinder1" runat="server" StringDate='<%# Eval("fadddate") %>' />
                                    <br />

                                  </td>
                            </tr>
                        </table>
                               
                       
                       
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
        <p>
    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="نظر شما:"></asp:Label>
</p>
<uc2:frmAdd ID="frmAdd" Type="3" runat="server" />
    </asp:View>
</asp:MultiView>

