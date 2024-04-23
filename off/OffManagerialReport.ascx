<%@ Control Language="C#" ClassName="OffManagerialReport" %>

<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc4" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc5" %>
<%@ Register src="OffTypeDropDown.ascx" tagname="OffTypeDropDown" tagprefix="uc6" %>
<%@ Register src="offStatDropDown.ascx" tagname="offStatDropDown" tagprefix="uc7" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc8" %>
<%@ Register src="offShowLink.ascx" tagname="offShowLink" tagprefix="uc9" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
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
        loadData();


    }






    protected void loadData()
    {

        //offRemain1.PID = pib.PID;
        int sum = 0;
        gvw.DataSource = AB.Offs.ManagerialReport(pib.PID,pdpStart.GeorgianDate,pdpEnd.GeorgianDate,blBranches.BID,otddType.OTID,osddStat.OSttID,ref sum);
        
        gvw.DataBind();
        lblSum.Text = sum.ToString();


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ليست مرخصي هاي كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_6_", mvw, vwPage, vwLogin);

    }





    protected void vwPage_Activate(object sender, EventArgs e)
    {
        pdpStart.GeorgianDate = pdpEnd.GeorgianDate = DateTime.Now;

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        loadData();
    }

    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow r = gvw.Rows[e.RowIndex];
        TextBox txtDesc = (TextBox)r.FindControl("txtDescriptionEdite");
        Literal litOffid = (Literal)r.FindControl("litOffIdEdite");
        AB.Offs.ReturnOff(litOffid.Text, txtDesc.Text);
        gvw.EditIndex = -1;
        loadData();
    }




    protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvw.EditIndex = e.NewEditIndex;
        loadData();
    }

    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvw.EditIndex = -1;
        loadData();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="گزارش مرخصي - مخصوص سرپرستي" 
            Icon="0" />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="20%">
                            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="كارمند:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label7" runat="server" CssClass="FormCaption" Text="شعبه:"></asp:Label>
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
                            <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="نوع مرخصي:"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label5" runat="server" CssClass="FormCaption" Text="وضعيت:"></asp:Label>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <uc1:personnelIDBinder ID="pib" runat="server" />
                        </td>
                        <td>
                            <uc8:branchesList ID="blBranches" runat="server" BID="225" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpStart" runat="server" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpEnd" runat="server" />
                        </td>
                        <td>
                            <uc6:OffTypeDropDown ID="otddType" runat="server" OTID="" />
                        </td>
                        <td>
                            <uc7:offStatDropDown ID="osddStat" runat="server" OSttID="3" />
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                    onclick="btnShow_Click" Text="نمايش" />
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" 
                    onrowcancelingedit="gvw_RowCancelingEdit" onrowediting="gvw_RowEditing" 
                    onrowupdating="gvw_RowUpdating" PageSize="20" ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="كد مرخصي">
                            <ItemTemplate>
                                <asp:Literal ID="litOffId" runat="server" Text='<%# Eval("offid") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litOffIdEdite" runat="server" Text='<%# Eval("offid") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="pname" HeaderText="نام كارمند" />
                        <asp:TemplateField HeaderText="تاريخ شروع">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="pdbStart" runat="server" 
                                    Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="تاريخ خاتمه">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="pdbEnd" runat="server" 
                                    Date='<%# DateTime.Parse(Eval("enddate").ToString()) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="تعداد روزها">
                            <ItemTemplate>
                                <asp:Literal ID="litDays" runat="server" Text='<%# Eval("days") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litDaysEdite" runat="server" Text='<%# Eval("days") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="نوع مرخصي">
                            <ItemTemplate>
                                <asp:Literal ID="litOffType" runat="server" Text='<%# Eval("otname") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litOffTypeEdite" runat="server" Text='<%# Eval("otname") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="امضاء كننده">
                            <ItemTemplate>
                                <asp:Literal ID="litSigner" runat="server" Text='<%# Eval("signername") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litSignerEdite" runat="server" 
                                    Text='<%# Eval("signername") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="تأييد كننده">
                            <ItemTemplate>
                                <asp:Literal ID="litConfirmer" runat="server" 
                                    Text='<%# Eval("confirmername") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litConfirmerEdite" runat="server" 
                                    Text='<%# Eval("confirmername") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="محل ثبت">
                            <ItemTemplate>
                                <asp:Literal ID="litBName" runat="server" Text='<%# Eval("insertbname") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Literal ID="litBNameEdite" runat="server" Text='<%# Eval("insertbname") %>'></asp:Literal>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="وضعيت">
                            <EditItemTemplate>
                                <asp:Literal ID="litStatusEdite" runat="server" Text='<%# Eval("osttname") %>'></asp:Literal>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Literal ID="litStatus" runat="server" Text='<%# Eval("osttname") %>'></asp:Literal>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="توضيحات">
                            <ItemTemplate>
                                <asp:Literal ID="litDescription" runat="server" Text='<%# Eval("dsc") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescriptionEdite" runat="server" CssClass="FormTextBox" 
                                    Text="ابطال:">ابطال:</asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <uc9:offShowLink ID="offShowLink1" runat="server" OffId='<%# Eval("offid") %>' 
                                    OffInsertType='<%# Eval("insertType") %>' />
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
                <br />
        <asp:Label ID="Label6" runat="server" CssClass="FormCaption" Text="جمع:"></asp:Label>
        <asp:Label ID="lblSum" runat="server"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>














