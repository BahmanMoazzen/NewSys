<%@ Control Language="C#" ClassName="loanInfoParams" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc1" %>
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
    public string LoanInfoName
    {
        set
        {
            lbtnLoanInfo.Text= value;
        }
    }
    public string LoanInfoID
    {
        set
        {
            hidLIID.Value = value;
        }
    }
    protected void loadData()
    {


        gvw.DataSource = AB.LoanInfo.Params.Load(hidLIID.Value);
        gvw.DataBind();



    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.LoanInfo.Params.Add(hidLIID.Value, txtTitle.Text, txtDesc.Text, txtMinValue.Text, txtMaxValue.Text);
        loadData();
    }

    
    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
        
        AB.LoanInfo.Params.Delete(e.Values[0].ToString());
        loadData();

    }


    protected void lbtnLoanInfo_Click(object sender, EventArgs e)
    {
        pnlMain.Visible = !pnlMain.Visible;
        if (!bool.Parse(hidParamsLoaded.Value))
        {
            loadData();
            hidParamsLoaded.Value = "true";
        }
    }
</script>
<asp:LinkButton ID="lbtnLoanInfo" runat="server" onclick="lbtnLoanInfo_Click" 
    CausesValidation="False"></asp:LinkButton>
<asp:Panel ID="pnlMain" runat="server" Visible="False">
<table cellpadding="0" cellspacing="0" class="style1">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="style1">
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="عنوان:"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtTitle" runat="server" CssClass="FormTextBox" 
                                        ValidationGroup="AddMonth"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtTitle" CssClass="FormError" Display="Dynamic" 
                                        ValidationGroup="AddMonth">*</asp:RequiredFieldValidator>
                                </td>
                                <td valign="top">
                                    <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="توضيحات:"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtDesc" runat="server" CssClass="FormTextBox" Rows="3" 
                                        TextMode="MultiLine" ValidationGroup="AddMonth"></asp:TextBox>
                                </td>
                                <td valign="top">
                                    <asp:Label ID="Label2" runat="server" CssClass="FormCaption" Text="حد اقل:"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtMinValue" runat="server" Columns="12" 
                                        CssClass="FormTextBox"></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                        ErrorMessage="حد اقل مي بايست يك عدد باشد" CssClass="FormError" 
                                        Display="Dynamic" ControlToValidate="txtMinValue" Operator="DataTypeCheck" 
                                        Type="Integer" >*</asp:CompareValidator>
                                </td>
                                <td style="font-weight: 700" valign="top">
                                    <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                        Text="حد اكثر:"></asp:Label>
                                </td>
                                <td style="font-weight: 700" valign="top">
                                    <asp:TextBox ID="txtMaxValue" runat="server" Columns="12" 
                                        CssClass="FormTextBox"></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                        ControlToValidate="txtMaxValue" CssClass="FormError" Display="Dynamic" 
                                        ErrorMessage="حد اكثر مي بايست يك عدد باشد" Operator="DataTypeCheck" 
                                        Type="Integer">*</asp:CompareValidator>
                                </td>
                                <td align="center" valign="top">
                                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                                        onclick="btnAdd_Click" Text="ثبت" ValidationGroup="AddMonth" 
                                        Width="78px" />
                                    <asp:HiddenField ID="hidLIID" runat="server" />
                                    <asp:HiddenField ID="hidParamsLoaded" runat="server" Value="false" />
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
                                <asp:BoundField DataField="LIPID" HeaderText="كد پارامتر" ReadOnly="True" />
                                <asp:BoundField DataField="LIPTitle" HeaderText="عنوان" ReadOnly="True" />
                                <asp:BoundField DataField="LIPDesc" HeaderText="توضيحات" ReadOnly="True" />
                                <asp:BoundField DataField="MinValue" HeaderText="حد اقل" ReadOnly="True" />
                                <asp:BoundField DataField="MaxValue" HeaderText="حد اكثر" ReadOnly="True" />
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
        

