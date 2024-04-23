<%@ Control Language="C#" ClassName="subTopics" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc7" %>

<script runat="server">
    public string FParent
    {
        set
        {
            gvw.DataSource = AB.Forum.LoadTopics(value);
            gvw.DataBind();
        }
    }
    //public bool Visible
    //{
    //    set
    //    {
    //        gvw.Visible = value;
    //    }
    //    get
    //    {
    //        return gvw.Visible;
    //    }
    //}
</script>
        <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" ShowFooter="True" 
            Width="100%">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:TemplateField HeaderText="عنوان">
                    <ItemTemplate>
                        <uc7:permanentLink ID="phlTitle" runat="server" Icon="1" NavigateURL='<%# String.Format("~/?system=frm&module=show-statement&fid={0}",Eval("fid")) %>' 
                            Text='<%# Eval("ftitle") %>' />
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="subcount" DataFormatString="({0})" 
                    HeaderText="تعداد نظرات">
                <ItemStyle Wrap="False" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    
