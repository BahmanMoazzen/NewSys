<%@ Control Language="C#" ClassName="Contracts" %>

<%@ Register src="../usr/chartDescription.ascx" tagname="chartdescription" tagprefix="uc5" %>
<%@ Register src="../usr/branchUserControl.ascx" tagname="branchusercontrol" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc2" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc6" %>

<%@ Register src="majorsDropDown.ascx" tagname="majorsDropDown" tagprefix="uc7" %>

<%@ Register src="../gnr/thousandSeprator.ascx" tagname="thousandSeprator" tagprefix="uc8" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
       
        Page.Title = "پیگیری های انجام شده در شعبه :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_53", mvw, vwPage, vwLogin);
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            gvw.AllowPaging = true;
            gvw.PageIndex = 0;
            loadData();
            
            
        }
    }
    protected void loadData()
    {
        
        gvw.DataSource = AB.Vosool.LoadBranchLogs(ddlBranches.BID);
        gvw.DataBind();
        
        
    }
    
    protected void vwPage_Activate(object sender, EventArgs e)
    {

        ddlBranches.BID = AB.user.BID;
        ddlBranches.UnlockKey = "44";
       
    }

    
    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;

        loadData();
    }
    
   
    
    



    protected void Page_Init(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            Session.Timeout = 500000;
    }








    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidLogId")).Value;
        AB.Vosool.ConfirmLog(id,AB.user.Email);
        loadData();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:tableTitle ID="tableTitle1" runat="server" Text="لیست پیگیری های انجام شده در شعبه" 
                    Icon="0" />
                <br />
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                       
                       <tr>
                           <td align="right">
                               <table cellpadding="0" cellspacing="0">
                                   <tr>
                                       <td>
                                           <uc2:branchesList ID="ddlBranches" runat="server" />
                                       </td>
                                       <td>
                                           <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                                               onclick="btnShow_Click" Text="نمايش" ValidationGroup="show" />
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       
                </table>
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate><uc4:progressPanelContent ID="progressPanelContent1" runat="server" /></ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" 
                    PageSize="50" Width="100%" onrowdeleting="gvw_RowDeleting">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="تاریخ">
                            <ItemTemplate>
                                <uc3:persiandatebinder ID="persiandatebinder1" Date='<%# DateTime.Parse(Eval("add_date").ToString()) %>' runat="server" />
                                <asp:HiddenField ID="hidLogId" runat="server" Value='<%# Eval("log_id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="uniq_id" 
                            DataNavigateUrlFormatString="~/default.aspx?system=vsl&amp;module=add-log&amp;uniq_id={0}" 
                            DataTextField="contract" HeaderText="قرار داد" Target="_blank" />
                        <asp:BoundField HeaderText="نام متعهد" DataField="display_name" />
                        <asp:TemplateField HeaderText="شرح">
                            <ItemTemplate>
                                <asp:Label ID="Label10" runat="server" 
                                    Text='<%# Eval("adder_name") %>' CssClass="FormInfo"></asp:Label>: <asp:Label ID="Label101" runat="server" 
                                    Text='<%# Eval("message") %>'></asp:Label>
                            </ItemTemplate>
                           
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="پیگیر" DataField="peigir_name" />
                        <asp:BoundField HeaderText="وضعیت" DataField="confirmed" />
                        <asp:CommandField DeleteText="تائید" ShowDeleteButton="True" />
                    </Columns>
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                    <EmptyDataTemplate>
                        <asp:Label ID="Label1" runat="server" CssClass="FormError" 
                            Text="[اطلاعاتي براي نمايش موجود نيست]"></asp:Label>
                    </EmptyDataTemplate>
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                        VerticalAlign="Top" />
                    <HeaderStyle CssClass="ListHeader" />
                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                    <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                    <RowStyle CssClass="ListRow" />
                </asp:GridView>
            
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>