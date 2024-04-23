<%@ Control Language="C#" ClassName="activeUsers" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc4" %>

<%@ Register src="../gnr/tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>

<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc2" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        dlt.DataSource = AB.Forum.LoadActiveUsers("10");
        dlt.DataBind();
    }
</script>
<center>

                                <uc1:tableTitle Icon="1" ID="tableTitle1" Text="كاربران فعال در اتاق فكر مديريت" SubText="همكاران محترم مي توانند جهت درج نظرات خود در زمينه هاي گوناگون از طريق لينك موجود با عنوان اتاق فكر در سمت راست صفحه اقدام نمايند. " runat="server" />
                                

                              

                                <asp:DataList ID="dlt" runat="server" 
    RepeatColumns="5" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" 
                                            ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg", Eval("FAdder")) %>' 
                                            Width="35" />
<br />
                                        <asp:Label ID="lblPerName" runat="server" 
                                            Text='<%# String.Format("<p><b>{0}</b><br/>({1}) نظر</p>", Eval("pName"),Eval("count")) %>'></asp:Label>
                                    </ItemTemplate>
</asp:DataList>
                            <p>  <uc2:permanentLink ID="permanentLink1" Icon="2" Text="ورود به اتاق فكر مديريت" NavigateURL="~/default.aspx?system=frm&module=forum" runat="server" />
</p>
                            </center>