<%@ Control Language="C#" ClassName="FirstPageInfo" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc1" %>

<%@ Register src="../gnr/permissionBinder.ascx" tagname="permissionBinder" tagprefix="uc2" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc3" %>



<script runat="server">
    public string PID
    {
        set
        {
            dw.DataSource = AB.User.SearchPersonnels(AB.user.Email, String.Empty);
            dw.DataBind();
            pbMyPermissions.Keys = AB.user.Keys;
        }
    }
   
</script>
<table width="100%">
    <tr valign="top">
        <td>
            <uc3:tableTitle ID="tableTitle2" runat="server" Icon="0" Text="اطلاعات فردي" />
            <asp:DetailsView ID="dw" runat="server" AutoGenerateRows="False" 
                CellPadding="3" CellSpacing="3" Width="100%" BorderStyle="None" 
                BorderWidth="0px" GridLines="None">
                <AlternatingRowStyle CssClass="ListAlternateRow" HorizontalAlign="Center" 
                    VerticalAlign="Top" />
                <Fields>
                    <asp:BoundField DataField="Pname" HeaderText="نام و نام خانوادگي" />
                    <asp:BoundField DataField="PID" HeaderText="شماره استخدامي" />
                    <asp:BoundField DataField="BName" HeaderText="محل خدمت فعلي" >
                    <ItemStyle Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="POName" HeaderText="سمت فعلي" />
                    <asp:BoundField DataField="GradeName" 
                        HeaderText="مقطع تحصيلي" />
                    <asp:BoundField DataField="GRName" HeaderText="مدرك تحصيلي" />
                    <asp:TemplateField HeaderText="تاريخ تولد">
                        <ItemTemplate>
                            <uc1:persianDateBinder ID="pdbDOB" Date='<%# DateTime.Parse(Eval("DOB").ToString()) %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="تاريخ استخدام">
                        <ItemTemplate>
                            <uc1:persianDateBinder ID="pdbDOE" Date='<%# DateTime.Parse(Eval("DOE").ToString()) %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <RowStyle CssClass="ListRow" HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:DetailsView>
            <uc3:tableTitle ID="tableTitle1" runat="server" Icon="0" Text="مجوز هاي شما:" />
            <br />
            <uc2:permissionBinder ID="pbMyPermissions" runat="server" />
        </td>
    </tr>
</table>

