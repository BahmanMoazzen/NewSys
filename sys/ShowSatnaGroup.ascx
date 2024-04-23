<%@ Control Language="C#" ClassName="ShowSatnaGroup" %>

<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc4" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>

<%@ Register src="loadSatnaMembers.ascx" tagname="loadSatnaMembers" tagprefix="uc1" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = " نمايش گروه ساتنا :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_27_", mvw, vwPage, vwLogin);

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
                                Text="فرم نمايش گروه ساتنا" />
                            
                            
                            
                            
                            
                            
                            
                            <asp:UpdatePanel  ID="upMain" runat="server">
                                <ContentTemplate>
                                    <uc4:branchesList ID="ddlBranches" runat="server" BID="1217" />
                                    <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" Text="نمايش" 
                                        onclick="btnShow_Click" />
                                    <br />
                                    <asp:Repeater ID="rp" runat="server">
                                    <ItemTemplate><uc1:loadSatnaMembers ID="loadSatnaMembers" BID='<%# Eval("BID") %>'  runat="server" /></ItemTemplate>
                                    </asp:Repeater>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>







