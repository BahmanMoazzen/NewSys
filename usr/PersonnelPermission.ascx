﻿<%@ Control Language="C#" ClassName="PersonnelPermission" %>

<%@ Register src="transfereTypeDropDown.ascx" tagname="transferetypedropdown" tagprefix="uc14" %>
<%@ Register src="../gnr/gradesDropDown.ascx" tagname="gradesdropdown" tagprefix="uc7" %>
<%@ Register src="../gnr/postsList.ascx" tagname="postslist" tagprefix="uc9" %>
<%@ Register src="employmentTypeDropDown.ascx" tagname="employmenttypedropdown" tagprefix="uc10" %>
<%@ Register src="personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc5" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc8" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../gnr/PermissionsAllDropDown.ascx" tagname="PermissionsAllDropDown" tagprefix="uc4" %>
<style type="text/css">


    .FormButtom
    {
        width: 39px;
    }
    .style1
    {
        width: 100%;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "مجوز هاي انفرادي كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_30_", mvw, vwPage, vwLogin);

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.Permissions.AddUserPermission(pibPersonnel.PID, ddlPermissions.PerId);
            loadData();
        }
        
    }
    protected void loadData()
    {
        gvw.DataSource = AB.Permissions.AllUserPermission;
        gvw.DataBind();
    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        loadData();
    }

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        AB.Permissions.DeleteUserPermission(e.Values[0].ToString(), e.Values[2].ToString());
        loadData();
        
    }

    protected void gvw_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView g = (GridView)(sender);
        g.PageIndex = e.NewPageIndex;
        loadData();


    }
</script>
<p>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <uc2:tabletitle ID="tabletitle2" runat="server" Text="مديريت مجوز هاي انفرادي" 
            Icon="0" />
        <table cellpadding="0" cellspacing="0" class="style1">
            <tr>
                <td>
                    <asp:Label ID="Label7" runat="server" CssClass="FormCaption" Text="كارمند:"></asp:Label>
                </td>
                <td>
                    <uc1:personnelidbinder ID="pibPersonnel" runat="server" 
                        ValidationGroup="AddPermission" />
                </td>
                <td rowspan="3">
                    &nbsp;</td>
            </tr>
            <tr >
                <td>
                    <asp:Label ID="Label8" runat="server" CssClass="FormCaption" Text="مجوز:"></asp:Label>
                </td>
                <td>
                    <uc4:PermissionsAllDropDown ID="ddlPermissions" runat="server" 
                        ValidationGroup="AddPermission" PerId="1" />
                </td>
            </tr>
            <tr>
                <td  >
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" 
                        onclick="btnAdd_Click" Text="افزودن" ValidationGroup="AddPermission" />
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                
                <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                    CellPadding="1" CellSpacing="1" GridLines="None" 
                    onpageindexchanging="gvw_PageIndexChanging" PageSize="20" ShowFooter="True" 
                    Width="100%" onrowdeleting="gvw_RowDeleting">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="PID" HeaderText="شماره استخدامي" />
                        <asp:BoundField DataField="PName" HeaderText="نام و نام خانوادگي" />
                        <asp:BoundField DataField="perid" HeaderText="شماره مجوز" />
                        <asp:BoundField DataField="PerName" HeaderText="نام مجوز" />
                        <asp:BoundField DataField="AdderName" HeaderText="مجوز دهنده" />
                        <asp:CommandField ButtonType="Button" DeleteText="حذف" ShowDeleteButton="True">
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
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>















</p>
