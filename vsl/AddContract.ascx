<%@ Control Language="C#" ClassName="DailyReport" %>

<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>



<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>



<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc5" %>

<%@ Register src="majorsDropDown.ascx" tagname="majorsDropDown" tagprefix="uc8" %>
<%@ Register src="contractsType.ascx" tagname="contractsType" tagprefix="uc9" %>



<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc2" %>



<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        height: 34px;
    }
</style>



<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "افزودن قرار داد :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_57_", mvw, vwPage, vwLogin);
        

    }


    protected void btnAdd0_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            
            string uniqId=AB.Vosool.AddContract(ddlBranches.BID, txtMajor.Text, txtMinor.Text, txtDisplayName.Text, ddlContractTypes.TypeId);
            if (!txtMoavaghAmount.Text.Equals(String.Empty) & !txtMoavaghMonth.Text.Equals(String.Empty) & !txtCount.Text.Equals(String.Empty))
            {
                AB.Vosool.AddContractLog(uniqId, txtMoavaghMonth.Text, txtCount.Text, txtMoavaghAmount.Text);
            }
        }
    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        ddlBranches.BID = AB.user.BID;
        ddlBranches.UnlockKey = "44";
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
    
        <table width="100%">
            <tr>
                <td>
                    <uc2:tableTitle ID="tableTitle2" runat="server" Icon="1" 
                        Text="افزودن پرونده مطالبات" />
                </td>
            </tr>
            <tr>
                <td>
                    <table class="style1">
                        <tr>
                            <td class="style2">
                                <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="شعبه:"></asp:Label>
                            </td>
                            <td class="style2">
                                <uc2:branchesList ID="ddlBranches" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label7" runat="server" CssClass="FormCaption" 
                                    Text="شماره قرار داد:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMinor" runat="server" Columns="8" CssClass="FormTextBoxLTR" 
                                    MaxLength="7" ValidationGroup="addContract"></asp:TextBox>
                                <asp:Label ID="Label12" runat="server" CssClass="FormCaption" Text="/"></asp:Label>
                                <asp:TextBox ID="txtMajor" runat="server" Columns="4" CssClass="FormTextBoxLTR" 
                                    MaxLength="4" ValidationGroup="addContract"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="txtMajor" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً معین را وارد کنید." ValidationGroup="addContract"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ControlToValidate="txtMajor" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً سرفصل را وارد کنید." ValidationGroup="addContract"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ControlToValidate="txtMajor" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً یک عدد وارد کنید." Operator="DataTypeCheck" 
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="addContract"></asp:CompareValidator>
                                <asp:CompareValidator ID="CompareValidator4" runat="server" 
                                    ControlToValidate="txtMinor" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً یک عدد وارد کنید." Operator="DataTypeCheck" 
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="addContract"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label8" runat="server" CssClass="FormCaption" 
                                    Text="متعهد قرارداد:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDisplayName" runat="server" CssClass="FormTextBox" 
                                    ValidationGroup="addContract"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                    ControlToValidate="txtDisplayName" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً نام متعهد را وارد کنید." ValidationGroup="addContract"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label9" runat="server" CssClass="FormCaption" 
                                    Text="نوع قرارداد:"></asp:Label>
                            </td>
                            <td>
                                <uc9:contractsType ID="ddlContractTypes" runat="server" LoadData="True" 
                                    ValidationGroup="addContract" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label10" runat="server" CssClass="FormCaption" 
                                    Text="مبلغ فعلی معوق:"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label13" runat="server" CssClass="FormCaption" Text="تعداد"></asp:Label>
                                <asp:TextBox ID="txtCount" runat="server" Columns="3" CssClass="FormTextBox" 
                                    MaxLength="3"></asp:TextBox>
                                <asp:Label ID="Label14" runat="server" CssClass="FormCaption" Text="به مبلغ"></asp:Label>
                                <asp:TextBox ID="txtMoavaghAmount" runat="server" CssClass="FormTextBoxLTR"></asp:TextBox>
                                <asp:Label ID="Label11" runat="server" CssClass="FormCaption" 
                                    Text="ريال مربوط به ماه:"></asp:Label>
                                <asp:TextBox ID="txtMoavaghMonth" runat="server" Columns="5" 
                                    CssClass="FormTextBoxLTR" MaxLength="4"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                    ControlToValidate="txtCount" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً یک عدد وارد کنید." Operator="DataTypeCheck" 
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="addContract"></asp:CompareValidator>
                                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                    ControlToValidate="txtMoavaghAmount" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً یک عدد وارد کنید." Operator="DataTypeCheck" 
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="addContract"></asp:CompareValidator>
                                <asp:CompareValidator ID="CompareValidator5" runat="server" 
                                    ControlToValidate="txtMoavaghMonth" CssClass="FormError" Display="Dynamic" 
                                    ErrorMessage="لطفاً یک عدد وارد کنید." Operator="DataTypeCheck" 
                                    SetFocusOnError="True" Type="Integer" ValidationGroup="addContract"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                                    onclick="btnAdd0_Click" Text="افزودن" ValidationGroup="addContract" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" CssClass="FormInfo"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>






