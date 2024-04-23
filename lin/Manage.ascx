<%@ Control Language="C#" ClassName="Manage" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../gnr/visitShow.ascx" tagname="visitshow" tagprefix="uc2" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc5" %>
<%@ Register src="../gnr/yearMonths.ascx" tagname="yearmonths" tagprefix="uc4" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<%@ Register src="loanInfoParams.ascx" tagname="loanInfoParams" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc6" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc1" %>
<%@ Register src="branchAdmin.ascx" tagname="branchAdmin" tagprefix="uc8" %>
<style type="text/css">


    .FormButtom
    {
        width: 39px;
    }
</style>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "مديريت آمار اعتباري :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_42_", mvw, vwPage, vwLogin);
    }
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        g.DataBind();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.LoanInfo.LoadAll;
        gvw.DataBind();



    }
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidLoanInfoId")).Value;
        AB.LoanInfo.Delete(id);
        loadData();

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.LoanInfo.Add(txtName.Text, txtDesc.Text, pdpStart.GeorgianDate, pdpEnd.GeorgianDate, "3");
        loadData();
    }
    protected void vwPage_Activate(object sender, EventArgs e)
    {
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
        string id = ((HiddenField)r.FindControl("hidLoanInfoId")).Value;
        string name = ((TextBox)r.FindControl("txtName")).Text;
        string desc = ((TextBox)r.FindControl("txtDesc")).Text;
        DateTime start = ((persianDatePicker)r.FindControl("pdpStart")).GeorgianDate;
        DateTime end = ((persianDatePicker)r.FindControl("pdpEnd")).GeorgianDate;
        AB.LoanInfo.Update(id, name, desc, start, end, "3");
        gv.EditIndex = -1;
        loadData();
    }

    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        loadData();
    }
</script>

<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
       
        <uc4:LoginSystem ID="LoginSystem1" runat="server" />
       
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate" >
        <uc2:tabletitle ID="tabletitle2" runat="server" Icon="0" 
            Text="مديريت آمار اعتباري" />
        
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td valign="top">
                    <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="عنوان:"></asp:Label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="FormTextBox" 
                        ValidationGroup="Add"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtName" CssClass="FormError" Display="Dynamic" 
                        ValidationGroup="Add">*</asp:RequiredFieldValidator>
                </td>
                <td valign="top">
                    <asp:Label ID="Label5" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtDesc" runat="server" CssClass="FormTextBox" MaxLength="4" 
                        Rows="3" TextMode="MultiLine" ValidationGroup="Add"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="تاريخ شروع:"></asp:Label>
                    <uc1:persianDatePicker ID="pdpStart" runat="server" 
                        ValidationGroup="Add" />
                </td>
                <td style="font-weight: 700" valign="top">
                    <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                        Text="تاريخ پايان:"></asp:Label>
                    <uc1:persianDatePicker ID="pdpEnd" runat="server" ValidationGroup="Add" />
                </td>
                <td align="center" valign="top">
                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="Add" Width="78px" />
                </td>
            </tr>
        </table>
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" 
            onpageindexchanging="gvw_PageIndexChanging" onrowdeleting="gvw_RowDeleting" 
            PageSize="20" ShowFooter="True" Width="100%" onrowediting="gvw_RowEditing" 
            onrowupdating="gvw_RowUpdating" onrowcancelingedit="gvw_RowCancelingEdit">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:TemplateField HeaderText="عنوان">
                    <EditItemTemplate>
                        <asp:HiddenField ID="hidLoanInfoId" runat="server" 
                            Value='<%# Eval("LIID") %>' />
                        <asp:TextBox ID="txtName" Text='<%# Eval("LIName") %>' runat="server" 
                            CssClass="FormTextBox" ValidationGroup="change"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txtName" Display="Dynamic" ErrorMessage="FormError" 
                            ValidationGroup="change">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HiddenField ID="hidLoanInfoId" runat="server" 
                            Value='<%# Eval("LIID") %>' />
                        <uc3:loanInfoParams ID="loanInfoParams" runat="server" 
                            LoanInfoID='<%# Eval("LIID") %>' LoanInfoName='<%# Eval("LIName") %>' />
                    </ItemTemplate>
                    <ItemStyle Wrap="False" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ شروع">
                    <EditItemTemplate>
                        <uc6:persianDatePicker ID="pdpStart" 
                            GeorgianDate='<%# DateTime.Parse(Eval("LIStart").ToString()) %>'  
                            runat="server" ValidationGroup="change" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <uc2:persianDateBinder ID="pdbStart" runat="server" 
                            Date='<%# DateTime.Parse(Eval("LIStart").ToString()) %>'  />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ خاتمه">
                    <EditItemTemplate>
                        <uc6:persianDatePicker ID="pdpEnd" 
                            GeorgianDate='<%# DateTime.Parse(Eval("LIEnd").ToString()) %>'  runat="server" 
                            ValidationGroup="change" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <uc2:persianDateBinder ID="pdbEnd" runat="server" 
                            Date='<%# DateTime.Parse(Eval("LIEnd").ToString()) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="توضيحات">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDesc" Text='<%# Eval("LIDesc") %>' runat="server" CssClass="FormTextBox" Rows="3" 
                            TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1"  runat="server" Text='<%# Eval("LIDesc") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="گزارشات">
                    <ItemTemplate>
                    <asp:HyperLink ID="hplTotalRep" runat="server" NavigateUrl='<%# String.Format("~/?system=lin&module=show-total&LIID={0}&LIName={1}",Eval("LIID"),Eval("LIName")) %>'
                            Target="_blank">گزارش نهايي</asp:HyperLink><br />
                        <asp:HyperLink ID="hplDetailRep" runat="server" NavigateUrl='<%# String.Format("~/?system=lin&module=show-detail&LIID={0}&LIName={1}",Eval("LIID"),Eval("LIName")) %>'
                            Target="_blank">گزارش جزئي</asp:HyperLink><br />
                             
                        <uc8:branchAdmin ID="branchAdmin1" LoanInfoID='<%# Eval("LIID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                    EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowDeleteButton="True" 
                    ShowEditButton="True" UpdateText="ثبت تغييرات" ValidationGroup="change">
                <ControlStyle CssClass="FormButtom" />
                <HeaderStyle Wrap="False" />
                <ItemStyle Width="1%" Wrap="False" />
                </asp:CommandField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <EmptyDataTemplate>
                <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                    Text="اطلاعاتي موجود نيست."></asp:Label>
            </EmptyDataTemplate>
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    </asp:View>
</asp:MultiView>


