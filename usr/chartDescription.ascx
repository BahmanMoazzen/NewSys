<%@ Control Language="C#" ClassName="chartDescription" %>

<%@ Register src="branchUserControl.ascx" tagname="branchusercontrol" tagprefix="uc4" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc1" %>

<script runat="server">
    public string BID
    {
        set
        {
            gvw.DataSource = AB.User.ChartDescription(value);
            gvw.DataBind();
        }
    }
</script>
                <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                    GridLines="None" PageSize="20" Width="100%">
                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                    <Columns>
                        <asp:BoundField DataField="pname" HeaderText="كارمند" >
                        <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dsc" HeaderText="توضيحات" />
                        <asp:TemplateField HeaderText="تاريخ شروع">
                            <ItemTemplate>
                                <uc1:persianDateBinder ID="persianDateBinder1" Date='<%# DateTime.Parse(Eval("startdate").ToString()) %>'  runat="server" />
                            </ItemTemplate>
                            </asp:TemplateField>
                        <asp:TemplateField HeaderText="تاريخ پايان">
                            <ItemTemplate>
                                <uc1:persianDateBinder ID="persianDateBinder2" StringDate='<%# Eval("enddate").ToString() %>' runat="server" />
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
            
