<%@ Control Language="C#" ClassName="ShowAtmGroup" %>

<%@ Register src="loadATMMembers.ascx" tagname="loadatmmembers" tagprefix="uc8" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="branchesList" tagprefix="uc4" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = " نمايش گروه ATM :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_28_", mvw, vwPage, vwLogin);

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        rp.DataSource = AB.System.LoadBranches(ddlBranches.BID);
        rp.DataBind();
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server">
                
                        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnShow" >
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                Text="فرم نمايش گروه ATM" />
                            
                            <asp:UpdatePanel  ID="upMain" runat="server">
                                <ContentTemplate>
                                    <uc4:branchesList ID="ddlBranches" runat="server" BID="1217" />
                                    <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" Text="نمايش" 
                                        onclick="btnShow_Click" />
                                    <br />
                                    <asp:Repeater ID="rp" runat="server">
                                    <ItemTemplate><uc8:loadatmmembers ID="loadatmmembers" BID='<%# Eval("BID") %>' runat="server" /></ItemTemplate>
                                    </asp:Repeater>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>






