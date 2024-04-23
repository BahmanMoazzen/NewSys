
<%@ Control Language="C#" ClassName="countShower" %>
<%@ Import Namespace="System.Data" %>
<%@ Register src="rulePostsPermissionsManagement.ascx" tagname="rulepostspermissionsmanagement" tagprefix="uc2" %>
<%@ Register src="rulesPermissions.ascx" tagname="rulespermissions" tagprefix="uc1" %>
<%@ Register src="rulesPosts.ascx" tagname="rulesposts" tagprefix="uc3" %>

<script runat="server">
    public DataTable Personnels
    {
        set
        {
            lbtnShow.Text = value.Rows.Count.ToString();
            gvw.DataSource = value;
            gvw.DataBind();
        }
    }

    protected void lbtnShow_Click(object sender, EventArgs e)
    {
        gvw.Visible = !gvw.Visible;
    }
</script>
<asp:LinkButton ID="lbtnShow" runat="server" onclick="lbtnShow_Click"></asp:LinkButton>
<p>
    
    <asp:GridView ID="gvw" runat="server" 
        AutoGenerateColumns="False" BorderStyle="Solid" BorderWidth="0px" 
        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
        ShowHeader="False" Visible="False" BorderColor="#660066"  
    
    >
        <AlternatingRowStyle CssClass="ListAlternateRow" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="pid" HeaderText="شماره استخدامي" />
            <asp:BoundField DataField="pname" HeaderText="نام و نام خانوادگي" />
            <asp:BoundField DataField="gradename" HeaderText="مدرك تحصيلي" />
            <asp:BoundField DataField="grname" HeaderText="نام مدرك" />
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
        <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" 
            CssClass="FooterStyle" />
        <HeaderStyle CssClass="ListHeader" />
        <PagerSettings Mode="NumericFirstLast" />
        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
        <RowStyle CssClass="ListRow" Wrap="False" />
    </asp:GridView>
</p>


