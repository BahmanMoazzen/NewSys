<%@ Control Language="C#" ClassName="ManagerialReport" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../off/offShowLink.ascx" tagname="offshowlink" tagprefix="uc9" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc8" %>
<%@ Register src="../off/offStatDropDown.ascx" tagname="offstatdropdown" tagprefix="uc7" %>
<%@ Register src="../off/OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="employmentTypeDropDown.ascx" tagname="employmentTypeDropDown" tagprefix="uc10" %>
<%@ Register src="../gnr/postsList.ascx" tagname="postsList" tagprefix="uc9" %>
<%@ Register src="../gnr/gradesDropDown.ascx" tagname="gradesDropDown" tagprefix="uc7" %>
<%@ Register src="transfereTypeDropDown.ascx" tagname="transfereTypeDropDown" tagprefix="uc14" %>
<%@ Register src="../gnr/branchCirclesDropDown.ascx" tagname="branchCirclesDropDown" tagprefix="uc4" %>
<%@ Register src="../gnr/rolesDropDown.ascx" tagname="rolesDropDown" tagprefix="uc11" %>
<style type="text/css">

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
        loadData();


    }






    protected void loadData()
    {

        
        int count = 0;
        gvw.DataSource = AB.User.ManagerialReport(pib.PID, ddlBranches.BID,ddlBranchCircles.BCID,ddlPosts.POID,ddlGrades.GradeID,pdpStart.StringDate, pdpEnd.StringDate,ddlEmploymentType.ETID, ddlSex.SelectedValue, ddlTransfereType.TTID,ddlRoles.RID, ref count);

        gvw.DataBind();
        lblSum.Text =count.ToString();


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "گزارش مديريتي كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_29_", mvw, vwPage, vwLogin);

    }





    protected void vwPage_Activate(object sender, EventArgs e)
    {
        //pdpStart.GeorgianDate = pdpEnd.GeorgianDate = DateTime.Now;

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        loadData();
    }


</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="فهرست ساز كاركنان - مخصوص سرپرستي" 
            Icon="0" 
            SubText="به وسيله اين فرم مي توانيد اتواع گزارشات پرسنلي مورد نياز را تهيه فرمائيد." />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                       
                        <td width="20%">
                            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="كارمند:"></asp:Label>
                        </td>
                        <td width="16%">
                            <asp:Label ID="Label7" runat="server" CssClass="FormCaption" Text="محل خدمت:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                                Text="شروع بازه زماني:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                Text="پايان بازه زماني:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label9" runat="server" CssClass="FormCaption" Text="جنسيت:"></asp:Label>
                        </td>
                       
                    </tr>
                    <tr valign="top">
                        <td>
                            <uc1:personnelIDBinder ID="pib" runat="server" />
                        </td>

                        <td>
                            <uc8:branchesList ID="ddlBranches" runat="server" BID="" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpStart" runat="server" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpEnd" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSex" runat="server" CssClass="FormTextBox">
                                <asp:ListItem Selected="True" Value="">&lt;انتخاب كنيد&gt;</asp:ListItem>
                                <asp:ListItem Value="1">مرد</asp:ListItem>
                                <asp:ListItem Value="0">زن</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        
                    </tr>
                    <tr>
                        <td width="20%">
                            <asp:Label ID="Label8" runat="server" CssClass="FormCaption" 
                                Text="نوع استخدام:"></asp:Label>
                        </td>
                        <td width="18%">
                            <asp:Label ID="Label10" runat="server" CssClass="FormCaption" 
                                Text="نوع انتقال:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label4" runat="server" CssClass="FormCaption" 
                                Text="مدرك تحصيلي:"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label5" runat="server" CssClass="FormCaption" 
                                Text="پست سازماني:"></asp:Label>
                        </td>
                     <td>
                            <asp:Label ID="Label11" runat="server" CssClass="FormCaption" Text="نام دايره:"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                    <td>
                            <uc10:employmentTypeDropDown ID="ddlEmploymentType" runat="server" ETID="" />
                        </td>
                        <td>
                            <uc14:transfereTypeDropDown ID="ddlTransfereType" runat="server" TTID="" />
                        </td>
                        <td>
                            <uc7:gradesDropDown ID="ddlGrades" runat="server" GradeID="" 
                                />
                        </td>
                        <td>
                            <uc9:postsList ID="ddlPosts" runat="server" POID="" />
                        </td>
                            <td>
                                <uc4:branchCirclesDropDown ID="ddlBranchCircles" runat="server" BCID="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label12" runat="server" CssClass="FormCaption" Text="نقش:"></asp:Label>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <uc11:rolesDropDown ID="ddlRoles" runat="server" RID="" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                    onclick="btnShow_Click" Text="نمايش" CausesValidation="False" />
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" PageSize="20" ShowFooter="True" 
                    Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="كارمند">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" 
                                    ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg",Eval("PID")) %>' Width="30" />
                                <br />
                                <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("PName") %>'></asp:Literal>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="psexname" HeaderText="جنسيت" />
                        <asp:TemplateField HeaderText="تاريخ استخدام">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="persiandatebinder1" runat="server" StringDate='<%# Eval("DOE") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BName" HeaderText="محل خدمت" />
                        <asp:BoundField DataField="POName" HeaderText="پست سازماني" />
                        <asp:BoundField DataField="ttName" HeaderText="نوع انتقال" />
                        <asp:BoundField DataField="ETName" HeaderText="نوع استخدام" />
                        <asp:BoundField DataField="gradename" HeaderText="مدرك تحصيلي" />
                        <asp:BoundField DataField="grname" HeaderText="نام مدرك" />
                    </Columns>
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                        VerticalAlign="Top" />
                    <HeaderStyle CssClass="ListHeader" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                    <RowStyle CssClass="ListRow" />
                </asp:GridView>
                <br />
        <asp:Label ID="Label6" runat="server" CssClass="FormCaption" Text="تعداد:"></asp:Label>
        <asp:Label ID="lblSum" runat="server"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>















