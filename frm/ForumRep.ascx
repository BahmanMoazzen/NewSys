<%@ Control Language="C#" ClassName="ForumRep" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc2" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: گزارش :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_39_", mvw, vwPage, vwLogin);


    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        txtMiniSearch.Focus();
    }
    protected void loadData()
    {
        gvw.DataSource = AB.Forum.SearchForum(txtMiniSearch.Text, "");
        gvw.DataBind();
    }
    protected void imbSearch_Click(object sender, ImageClickEventArgs e)
    {
        loadData();
    }


    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate><asp:Panel DefaultButton="imbSearch" runat="server">
            <table width="100%"><tr><td><asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="جستجو:"></asp:Label>
                <asp:TextBox ID="txtMiniSearch" runat="server" CssClass="FormTextBox" 
            ></asp:TextBox>
                <asp:ImageButton ID="imbSearch" runat="server" AlternateText="جستجو در سایت" 
            CausesValidation="False" Height="20px" ImageAlign="AbsMiddle" 
            ImageUrl="~/images/search.gif" onclick="imbSearch_Click" TabIndex="99" 
            ToolTip="جستجو در سایت" ValidationGroup="miniSearch" Width="20px" /></td></tr><tr><td> <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                <uc2:progressPanelContent ID="progressPanelContent1" runat="server" />
                </ProgressTemplate>
                </asp:UpdateProgress>
                
                </td></tr><tr><td>
                    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" ShowFooter="True" 
                        Width="100%" onpageindexchanging="gvw_PageIndexChanging">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="نظرات مطرح شده">
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td align="center" valign="top" width="15%">
                                                <asp:Image ID="Image1" runat="server" 
                                                    ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg", Eval("FAdder")) %>' 
                                                    Width="35" />
                                                <br />
                                                <asp:Label ID="lblPerName" runat="server" Text='<%# Eval("pName") %>'></asp:Label>
                                            </td>
                                            <td align="right" valign="top">
                                                <uc1:tableTitle ID="tbtStatement" runat="server" Icon="1" 
                                                    SubText='<%# Eval("ftext") %>' Text='<%# String.Format("{0} --> {1}", Eval("ftitle"),Eval("fparenttitle")) %>' />
                                            </td>
                                            <td align="center" valign="top" width="10%">
                                                <uc4:persianDateBinder ID="persianDateBinder1" runat="server" 
                                                    StringDate='<%# Eval("fadddate") %>' />
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
                    </td></tr></table>
               
</asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

        <br />
    </asp:View>
</asp:MultiView>

