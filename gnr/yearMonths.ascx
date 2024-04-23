<%@ Control Language="C#" ClassName="yearMonths" %>

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

<%@ Register src="persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc1" %>
<%@ Register src="persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
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
    public string YearID
    {
        set
        {
            lbtnYear.Text= value;
        }
    }
    protected void loadData()
    {


        gvw.DataSource = AB.General.Months(lbtnYear.Text);
        gvw.DataBind();



    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.General.AddMonth(lbtnYear.Text, txtMonthId.Text, pdpStart.GeorgianDate, pdpEnd.GeorgianDate);
        loadData();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        loadData();
        
    }
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
        
        AB.General.DeleteMonth(e.Values[0].ToString());
        loadData();

    }

    protected void lbtnYear_Click(object sender, EventArgs e)
    {
        pnlMain.Visible = !pnlMain.Visible;
    }
</script>
<asp:LinkButton ID="lbtnYear" runat="server" onclick="lbtnYear_Click" 
    CausesValidation="False"></asp:LinkButton>
<asp:Panel ID="pnlMain" runat="server" Visible="False">
<table cellpadding="0" cellspacing="0" class="style1">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="style1">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="نام ماه:"></asp:Label>
                                    <asp:TextBox ID="txtMonthId" runat="server" Columns="5" CssClass="FormTextBox" 
                                        MaxLength="4" ValidationGroup="AddMonth"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtMonthId" CssClass="FormError" Display="Dynamic" 
                                        ValidationGroup="AddMonth">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                        ControlToValidate="txtMonthId" CssClass="FormError" Display="Dynamic" 
                                        Operator="DataTypeCheck" Type="Integer" ValidationGroup="AddMonth">*</asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="تاريخ شروع:"></asp:Label>
                                    <uc1:persianDatePicker ID="pdpStart" runat="server" 
                                        ValidationGroup="AddMonth" />
                                </td>
                                <td style="font-weight: 700">
                                    <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                        Text="تاريخ پايان:"></asp:Label>
                                    <uc1:persianDatePicker ID="pdpEnd" runat="server" ValidationGroup="AddMonth" />
                                </td>
                                <td align="center">
                                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddMonth" 
                                        Width="78px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvw" runat="server" 
                            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                            CellPadding="1" CellSpacing="1" GridLines="None" onrowdeleting="gvw_RowDeleting" 
                            PageSize="20" ShowFooter="True" Width="100%">
                            <AlternatingRowStyle CssClass="ListAlternateRow" />
                            <Columns>
                                <asp:BoundField DataField="Mid" HeaderText="نام ماه" />
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
        
