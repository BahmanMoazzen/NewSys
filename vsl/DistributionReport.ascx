﻿<%@ Control Language="C#" ClassName="Contracts" %>

<%@ Register src="../usr/chartDescription.ascx" tagname="chartdescription" tagprefix="uc5" %>
<%@ Register src="../usr/branchUserControl.ascx" tagname="branchusercontrol" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc2" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelIDBinder" tagprefix="uc6" %>

<%@ Register src="majorsDropDown.ascx" tagname="majorsDropDown" tagprefix="uc7" %>

<%@ Register src="../gnr/thousandSeprator.ascx" tagname="thousandSeprator" tagprefix="uc8" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
       
        Page.Title = "نحوه تخصیص قرار داد به پرسنل :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_48", mvw, vwPage, vwLogin);
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        gvw.DataSource = AB.Vosool.DistributionReport(ddlBranches.BID);
        gvw.DataBind();
    }
    
    
    protected void vwPage_Activate(object sender, EventArgs e)
    {

        ddlBranches.BID = AB.user.BID;
        ddlBranches.UnlockKey = "44";
        
    }

   

    protected void Page_Init(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            Session.Timeout = 500000;
    }

    
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:tableTitle ID="tableTitle1" runat="server" Text="گزارش نحوه تقسیم قرار داد ها بین پرسنل" 
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
                                           &nbsp;</td>
                                       <td>
                                           <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                                               onclick="btnShow_Click" Text="نمايش" />
                                       </td>
                                   </tr>
                               </table>
                           </td>
                           <td align="left" nowrap="nowrap" width="20%">
                               &nbsp;</td>
                       </tr>
                       
                </table>
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate><uc4:progressPanelContent ID="progressPanelContent1" runat="server" /></ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    PageSize="50" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
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