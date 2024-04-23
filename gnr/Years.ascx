<%@ Control Language="C#" ClassName="Years" %>

<%@ Register src="persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc1" %>
<%@ Register src="persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc2" %>
<%@ Register src="../usr/transfereTypeDropDown.ascx" tagname="transferetypedropdown" tagprefix="uc14" %>
<%@ Register src="gradesDropDown.ascx" tagname="gradesdropdown" tagprefix="uc7" %>
<%@ Register src="postsList.ascx" tagname="postslist" tagprefix="uc9" %>
<%@ Register src="../usr/employmentTypeDropDown.ascx" tagname="employmenttypedropdown" tagprefix="uc10" %>
<%@ Register src="persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc5" %>
<%@ Register src="branchesList.ascx" tagname="brancheslist" tagprefix="uc8" %>
<%@ Register src="progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="yearMonths.ascx" tagname="yearMonths" tagprefix="uc4" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }

    .FormButtom
    {
        width: 39px;
    }
</style>

<script runat="server">
   

    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        g.DataBind();

    }



   

    
    protected void loadData()
    {


       gvw.DataSource = AB.General.Years;
       gvw.DataBind();



    }
    

    

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidYearId")).Value;
        AB.General.DeleteYear(id);
        loadData();

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.General.AddYear(txtYearId.Text, pdpStart.GeorgianDate, pdpEnd.GeorgianDate);
        loadData();
    }


    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "مديريت سال ها و ماه ها :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_32_", mvw, vwPage, vwLogin);
    }
</script>
<p>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="گزارش مرخصي - مخصوص سرپرستي" 
            Icon="0" />
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnAdd">
            <table cellpadding="0" cellspacing="0" class="style1">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="style1">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="نام سال:"></asp:Label>
                                    <asp:TextBox ID="txtYearId" runat="server" Columns="4" CssClass="FormTextBox" 
                                        MaxLength="4" ValidationGroup="AddYear"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtYearId" CssClass="FormError" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                        ControlToValidate="txtYearId" CssClass="FormError" Display="Dynamic" 
                                        Operator="DataTypeCheck" Type="Integer">*</asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="تاريخ شروع:"></asp:Label>
                                    <uc1:persianDatePicker ID="pdpStart" runat="server" ValidationGroup="AddYear" />
                                </td>
                                <td style="font-weight: 700">
                                    <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                        Text="تاريخ پايان:"></asp:Label>
                                    <uc1:persianDatePicker ID="pdpEnd" runat="server" ValidationGroup="AddYear" />
                                </td>
                                <td align="center">
                                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddYear" Width="78px" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                        <ProgressTemplate>
                                            <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                            CellPadding="1" CellSpacing="1" GridLines="None" 
                            onpageindexchanging="gvw_PageIndexChanging" onrowdeleting="gvw_RowDeleting" 
                            PageSize="20" ShowFooter="True" Width="100%">
                            <AlternatingRowStyle CssClass="ListAlternateRow" />
                            <Columns>
                                <asp:TemplateField HeaderText="سال">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hidYearId" Value='<%# Eval("Yearid") %>' runat="server" />
                                        <uc4:yearMonths ID="yearMonths1" YearID='<%# Eval("Yearid") %>' runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="تاريخ شروع">
                                    <ItemTemplate>
                                        <uc2:persianDateBinder ID="pdbStart" runat="server" 
                                            Date='<%# DateTime.Parse(Eval("StartDate").ToString()) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="تاريخ خاتمه">
                                    <ItemTemplate>
                                        <uc2:persianDateBinder ID="pdbEnd" runat="server" 
                                            Date='<%# DateTime.Parse(Eval("EndDate").ToString()) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                                    EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowDeleteButton="True" 
                                    UpdateText="ثبت تغييرات">
                                <ControlStyle CssClass="FormButtom" />
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Width="1%" Wrap="False" />
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
            </table>
        </asp:Panel>
        <br />
        
                
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>















</p>


