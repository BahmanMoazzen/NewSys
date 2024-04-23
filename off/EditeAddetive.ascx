<%@ Control Language="C#" ClassName="EditeAddetive" %>

<%@ Register src="OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>
<%@ Register src="offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc7" %>

<script runat="server">
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

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
        string days = ((TextBox)r.FindControl("txtDays")).Text;
        string advid = ((HiddenField)r.FindControl("hidAdtID")).Value;
        string description = ((TextBox )r.FindControl("txtDesc")).Text;
        DateTime  effectdate = ((persianDatePicker)r.FindControl("pdpEffectDate")).GeorgianDate;
        AB.Offs.UpdateAddetive(advid, days, effectdate,description);
        lblMessage.Text = Resources.Resource.txtEditeAddetiveUpdated;
        gv.EditIndex = -1;
        loadData();

    }
    protected void loadData()
    {


        gvw.DataSource = AB.Offs.AddetivesList(AB.user.BID);
        gvw.DataBind();



    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "افزودن و تغيير در مانده مرخصي :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_21_", mvw, vwPage, vwLogin);
        
    }

    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        loadData();
    }

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidAdtID")).Value;
        AB.Offs.DeleteAddetive(id);
        lblMessage.Text = Resources.Resource.txtEditeAddetiveDeleted;
        
        loadData();

    }

    protected void vwIdle_Activate(object sender, EventArgs e)
    {
        loadData();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server" onactivate="vwIdle_Activate">
                <asp:Panel ID="pnlMain" runat="server" >
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        SubText="از اين فرم جهت افزودن و  ويرايش پايه مرخصي استفاده نماييد." 
                        Text="فرم افزودن و ويرايش پايه مرخصي" />
                    
                    
                  
                            <p><asp:Label ID="lblMessage" runat="server" CssClass="FormError" 
                                EnableViewState="False"></asp:Label></p>
                            <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                                AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                                CellPadding="1" CellSpacing="1" GridLines="None" 
                                onpageindexchanging="gvw_PageIndexChanging" 
                                onrowcancelingedit="gvw_RowCancelingEdit" onrowdeleting="gvw_RowDeleting" 
                                onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" PageSize="20" 
                                ShowFooter="True" Width="100%">
                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                <Columns>
                                    <asp:BoundField DataField="PName" HeaderText="نام و نام خانوادگي" 
                                        ReadOnly="True" />
                                    <asp:BoundField DataField="PID" HeaderText="شماره پرسنلي" ReadOnly="True" />
                                    <asp:TemplateField HeaderText="مانده مرخصي">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDays" runat="server" Columns="3" MaxLength="3" 
                                                Text='<%# Eval("days") %>' ValidationGroup="EditeAddetive"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                ControlToValidate="txtDays" CssClass="FormError" Display="Dynamic" 
                                                ErrorMessage="لطفاً مانده مرخصي را وارد كنيد." ValidationGroup="EditeAddetive"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                                ControlToValidate="txtDays" CssClass="FormError" Display="Dynamic" 
                                                ErrorMessage="لطفاً يك عدد وارد كنيد." Operator="DataTypeCheck" Type="Integer" 
                                                ValidationGroup="EditeAddetive"></asp:CompareValidator>
                                            <asp:HiddenField ID="hidAdtID" runat="server" Value='<%# Eval("adtID") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Literal ID="litDays" runat="server" Text='<%# Eval("days") %>'></asp:Literal>
                                            <asp:HiddenField ID="hidAdtID" runat="server" Value='<%# Eval("adtID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="تاريخ مؤثر">
                                        <EditItemTemplate>
                                            <uc4:persiandatepicker ID="pdpEffectDate" runat="server" 
                                                GeorgianDate='<%# DateTime.Parse(Eval("EffectDate").ToString()) %>' 
                                                ValidationGroup="EditeAddetive" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <uc7:persianDateBinder ID="persianDateBinder1" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("EffectDate").ToString()) %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="توضيحات">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDesc" runat="server" CssClass="FormTextBox" 
                                                Text='<%# Eval("dsc") %>' ValidationGroup="EditeAddetive"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                ControlToValidate="txtDesc" CssClass="FormError" Display="Dynamic" 
                                                ErrorMessage="لطفاً توضيحات را وارد كنيد." ValidationGroup="EditeAddetive">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("dsc") %>'></asp:Literal>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ButtonType="Button" CancelText="انصراف" DeleteText="حذف" 
                                        EditText="تغيير" InsertText="افزودن" NewText="جديد" ShowDeleteButton="True" 
                                        ShowEditButton="True" UpdateText="ثبت تغييرات" ValidationGroup="EditeAddetive">
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
                        
                    
                    
                    
                    
                    
                </asp:Panel>
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>






