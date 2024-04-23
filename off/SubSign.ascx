<%@ Control Language="C#" ClassName="SubSign" %>

<%@ Register src="inlineSigning.ascx" tagname="inlinesigning" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ليست مرخصي هاي جديد جهت امضاء جانشين :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_18_", mvw, vwPage, vwLogin);

    }
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();


    }






    protected void loadData()
    {


        gvw.DataSource = AB.Offs.ToSubSign();
        gvw.DataBind();



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
        string offid = ((HiddenField)r.FindControl("hidoffID")).Value;
        AB.Offs.SubSignOff(offid);
        gvw.EditIndex = -1;
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
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="فهرست مرخصي هاي جديد جهت امضاء جانشين" 
            Icon="0" />
        <br />
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True" Width="100%" onpageindexchanging="gvw_PageIndexChanging" 
            onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" 
            onrowcancelingedit="gvw_RowCancelingEdit">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="PName" HeaderText="درخواست كننده" ReadOnly="True" />
                <asp:TemplateField HeaderText="تاريخ شروع">
                    <EditItemTemplate>
                        <uc3:persiandatebinder ID="pdbStart" runat="server" 
                            Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>' />
                        <asp:HiddenField ID="hidoffid" runat="server" Value='<%# Eval("offid") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbStart" Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>' runat="server" />
                        <asp:HiddenField ID="hidoffid" Value='<%# Eval("offid") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ خاتمه">
                    <ItemTemplate>
                        <uc3:persiandatebinder ID="pdbEnd" Date='<%# DateTime.Parse(Eval("enddate").ToString()) %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="days" HeaderText="تعداد روز ها" ReadOnly="True" />
                <asp:BoundField DataField="BName" HeaderText="محل درخواست" ReadOnly="True" />
                <asp:CommandField ButtonType="Button" CancelText="عدم امضاء" 
                    EditText="امضاء جانشين" ShowEditButton="True" UpdateText="تائيد امضاء">
                <ControlStyle CssClass="FormButtom" />
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
    </asp:View>
</asp:MultiView>







