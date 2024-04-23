<%@ Control Language="C#" ClassName="TotalReport" %>

<%@ Register src="rulePostsPermissionsManagement.ascx" tagname="rulepostspermissionsmanagement" tagprefix="uc2" %>
<%@ Register src="rulesPermissions.ascx" tagname="rulespermissions" tagprefix="uc1" %>
<%@ Register src="rulesPosts.ascx" tagname="rulesposts" tagprefix="uc3" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc4" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            gvw.DataSource = AB.User.TotalReport;
            gvw.DataBind();
        }
    }
</script>
    <asp:GridView ID="gvw" runat="server"  
        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="1px" 
        CellPadding="1" CellSpacing="1" GridLines="None" 
        
        Width="100%"  
         
    
    >
        <AlternatingRowStyle CssClass="ListAlternateRow" />
        <Columns>
            <asp:BoundField HeaderText="شماره استخدامي" DataField="pid" />
            <asp:BoundField HeaderText="نام" DataField="pname" />
            <asp:BoundField HeaderText="محل خدمت فعلي" DataField="Bname" />
            <asp:BoundField HeaderText="سمت" DataField="poname" />
            <asp:BoundField HeaderText="محل خدمت قبلي" DataField="latterbname" />
            <asp:TemplateField HeaderText="تاريخ جابجائي">
                <ItemTemplate>
                    <uc4:persianDateBinder ID="persianDateBinder1" StringDate='<%# Eval("startdate") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="سمت قبلي" DataField="latterPOstname" />
            <asp:BoundField HeaderText="توقف در پست" DataField="stopday" />
            <asp:BoundField DataField="branchStopdays" HeaderText="توقف در شعبه" />
            <asp:TemplateField HeaderText="تاريخ تولد">
                <ItemTemplate>
                    <uc4:persianDateBinder ID="persianDateBinder2"  StringDate='<%# Eval("dob") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="مدرك تحصيلي" DataField="gradename" />
            <asp:BoundField HeaderText="عنوان مدرك" DataField="grname" />
            <asp:TemplateField HeaderText="تاريخ استخدام">
                <ItemTemplate>
                    <uc4:persianDateBinder ID="persianDateBinder3"  StringDate='<%# Eval("doe") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="آدرس" DataField="paddress" />
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
        <FooterStyle HorizontalAlign="Center" VerticalAlign="Top" 
            CssClass="FooterStyle" />
        <HeaderStyle CssClass="ListHeader" />
        <PagerSettings Mode="NumericFirstLast" />
        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
        <RowStyle CssClass="ListRow" />
    </asp:GridView>




