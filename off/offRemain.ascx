<%@ Control Language="C#" ClassName="offRemain" %>



<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>



<script runat="server">
    public string PID
    {
        set
        {
            gvw.DataSource = AB.Offs.RemainChart(value);
            gvwH.DataSource = AB.Offs.HourlyRemainChart(value);
            gvw.DataBind();
            gvwH.DataBind();
            
        }
    }

</script>


        <table cellpadding="0" cellspacing="0" class="style1">
            <tr>
                <td width="50%" valign="top">


        <asp:GridView ID="gvw" runat="server" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="yearid" HeaderText="عنوان" />
                <asp:BoundField DataField="usage" HeaderText="مقدار" 
                    NullDisplayText="[اطلاعات موجود نيست]" />
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    

                </td>
                <td valign="top">


        <asp:GridView ID="gvwH" runat="server" 
            AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
            ShowFooter="True">
            <AlternatingRowStyle CssClass="ListAlternateRow" />
            <Columns>
                <asp:BoundField DataField="dsc" HeaderText="عنوان" />
                <asp:BoundField DataField="count" HeaderText="تعداد" />
                <asp:BoundField DataField="sum" DataFormatString="{0} دقيقه" HeaderText="مقدار" 
                    NullDisplayText="[اطلاعات موجود نيست]" />
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
            <HeaderStyle CssClass="ListHeader" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
            <RowStyle CssClass="ListRow" />
        </asp:GridView>
    

                </td>
            </tr>
</table>

    

