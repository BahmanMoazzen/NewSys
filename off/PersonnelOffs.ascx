<%@ Control Language="C#" ClassName="PersonnelOffs" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc1" %>

<%@ Register src="offRemain.ascx" tagname="offRemain" tagprefix="uc4" %>

<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc4" %>

<%@ Register src="offShowLink.ascx" tagname="offShowLink" tagprefix="uc5" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>

<script runat="server">
    


    

    
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();


    }






    protected void loadData()
    {

        offRemain1.PID = pib.PID ;
        gvw.DataSource = AB.Offs.LoadOffs(pib.PID);
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ليست مرخصي هاي كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_9_", mvw, vwPage, vwLogin);

    }





    protected void vwPage_Activate(object sender, EventArgs e)
    {
        
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            loadData();
    }

    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow r = gvw.Rows[e.RowIndex];
        TextBox txtDesc = (TextBox)r.FindControl("txtDescriptionEdite");
        HiddenField Offid = (HiddenField )r.FindControl("hidoffid");
        AB.Offs.ReturnOff(Offid.Value, txtDesc.Text);
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
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="فهرست مرخصي هاي همكاران" 
            Icon="0" 
            SubText="از اين فرم جهت نمايش كليه مرخصي هاي همكاران و در صورت لذوم ابطال آن استفاده نماييد." />
       
                <uc1:personnelIDBinder ID="pib" runat="server" 
                    ValidationGroup="PersonnelsOffs" />
                <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                    onclick="btnShow_Click" Text="نمايش" ValidationGroup="PersonnelsOffs" /> 

               

                <uc4:offRemain ID="offRemain1" runat="server" />
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" 
                    onrowcancelingedit="gvw_RowCancelingEdit" onrowediting="gvw_RowEditing" 
                    onrowupdating="gvw_RowUpdating" PageSize="20" ShowFooter="True" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="OTName" HeaderText="نوع مرخصي" ReadOnly="True" />
                        <asp:BoundField DataField="OSTName" ReadOnly="True" />
                        <asp:TemplateField HeaderText="تاريخ شروع">
                            <ItemTemplate>
                                <asp:HiddenField ID="hidOffid" runat="server" Value='<%# Eval("offid") %>' />
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
                        <asp:BoundField DataField="amount" HeaderText="مقدار" ReadOnly="True" />
                        <asp:BoundField DataField="InsertBName" HeaderText="محل ثبت" ReadOnly="True" />
                        <asp:BoundField DataField="osttname" HeaderText="وضعيت" ReadOnly="True" />
                        <asp:TemplateField HeaderText="توضيحات">
                            <ItemTemplate>
                                <asp:Literal ID="litDescription" runat="server" Text='<%# Eval("dsc") %>'></asp:Literal>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescriptionEdite" runat="server" CssClass="FormTextBox" 
                                    Text="ابطال:">ابطال:</asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Button" CancelText="انصراف" EditText="ابطال" 
                            ShowEditButton="True" UpdateText="اعمال تغييرات">
                        <ControlStyle CssClass="FormButtom" />
                        </asp:CommandField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <uc5:offShowLink ID="offShowLink1" runat="server" OffId='<%# Eval("offid") %>' 
                                    OffInsertType='<%# Eval("insertType") %>' OSTTID='<%# Eval("stat") %>' 
                                    OTID='<%# Eval("offtype") %>' />
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
            
        
    </asp:View>
</asp:MultiView>





