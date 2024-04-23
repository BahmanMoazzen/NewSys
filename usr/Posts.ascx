<%@ Control Language="C#" ClassName="Posts" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc6" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<style type="text/css">




    .FormButtom
    {
        width: 39px;
    }
    .style1
    {
        width: 100%;
    }
    </style>

<script runat="server">
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        loadData();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.Posts.List;
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "مديريت پست هاي سازماني:: " + Page.Title;
        LoginSystem1.CheckSecurity("1_33_", mvw, vwPage, vwLogin);



    }
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;


        string id = e.Values[0].ToString();
        AB.Posts.Delete(id);
        loadData();

    }


    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.Posts.Add(txtPostName.Text, chkNeedSign.Checked, chkNeedSubSign.Checked, chkNeedConfirmation.Checked, chkSignOutside.Checked);
        loadData();
        
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="مديريت شعب" 
            Icon="0" />
        <br />
        <table cellpadding="0" cellspacing="0" class="style1">
            <tr>
                <td nowrap="nowrap" width="1%">
                    <asp:Label ID="lbl" runat="server" CssClass="FormCaption" Text="نام پست:"></asp:Label>
                </td>
                <td width="10%">
                    <asp:TextBox ID="txtPostName" runat="server" CssClass="FormTextBox" 
                        ValidationGroup="AddPost"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtPostName" CssClass="FormError" Display="Dynamic" 
                        ErrorMessage="لطفاً نام پست سازماني را وارد كنيد." 
                        ToolTip="لطفاً نام پست سازماني را وارد كنيد." ValidationGroup="AddPost">*</asp:RequiredFieldValidator>
                </td>
                <td rowspan="3" valign="top">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                        CssClass="FormError" ValidationGroup="AddPost" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl0" runat="server" CssClass="FormCaption">نحوه تقاضاي مرخصي:</asp:Label>
                </td>
                <td nowrap="nowrap">
                    <asp:CheckBox ID="chkNeedSign" runat="server" Checked="True" 
                        CssClass="FormButtom" Text="مرخصي نياز به امضا دارد" 
                        ValidationGroup="AddPost" />
                    <asp:CheckBox ID="chkNeedConfirmation" runat="server" Checked="True" 
                        CssClass="FormButtom" Text="مرخصي نياز به تأييد دارد" 
                        ValidationGroup="AddPost" />
                    <br />
                    <asp:CheckBox ID="chkNeedSubSign" runat="server" Checked="True" 
                        CssClass="FormButtom" Text="مرخصي نياز به امضاء جانشين دارد" 
                        ValidationGroup="AddPost" />
                    <asp:CheckBox ID="chkSignOutside" runat="server" CssClass="FormButtom" 
                        Text="مرخصي خارج از شعبه امضا مي شود." ValidationGroup="AddPost" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddPost" />
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
        CellPadding="1" CellSpacing="1" GridLines="None" 
        onpageindexchanging="gvw_PageIndexChanging" PageSize="20" 
        Width="100%" ShowFooter="True" 
    onrowdeleting="gvw_RowDeleting"  
    
    >
        <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="poid" HeaderText="كد پست" />
                        <asp:BoundField DataField="poname" HeaderText="نام پست" />
                        <asp:CheckBoxField DataField="OffNeedSign" HeaderText="نياز به امضاء" />
                        <asp:CheckBoxField DataField="OffNeedConfirm" HeaderText="نياز به تأييد" />
                        <asp:CheckBoxField DataField="OffNeedSubSign" 
                            HeaderText="نياز به امضاء جانشين" />
                        <asp:CheckBoxField DataField="OffSignOutside" 
                            HeaderText="امضاء در بيرون شعبه" />
                        <asp:CommandField ButtonType="Button" DeleteText="حذف" ShowDeleteButton="True">
                        <ControlStyle CssClass="FormButtom" />
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















        
