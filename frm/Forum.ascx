<%@ Control Language="C#" ClassName="forum" %>

<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../off/offRemain.ascx" tagname="offremain" tagprefix="uc5" %>
<%@ Register src="../off/OffTypeDropDown.ascx" tagname="offtypedropdown" tagprefix="uc6" %>

<%@ Register src="../off/offShowLink.ascx" tagname="offshowlink" tagprefix="uc6" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc7" %>

<%@ Register src="subTopics.ascx" tagname="subTopics" tagprefix="uc8" %>

<%@ Register src="roomTopic.ascx" tagname="roomTopic" tagprefix="uc9" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = "اتاق فكر :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_37_", mvw, vwPage, vwLogin);


    }

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            gvw.DataSource = AB.Forum.LoadRooms;
            gvw.DataBind();
            gvwLatestTopics.DataSource = AB.Forum.LoadLatestTopics("5");
            gvwLatestTopics.DataBind();
            gvwLatestOppinions.DataSource = AB.Forum.LoadLatestOpinions("5");
            gvwLatestOppinions.DataBind();
        }
        
    }

    

    
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
               
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td>
                    <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                        SubText="لطفا جهت ارسال نظرات ارزشمند خود ابتدا وارد يكي از اتاق هاي تشكيل شده شويد. سپس موضوع مورد نظر خود را انتخاب كرده و نظر خود را در آن مورد ارسال كنيد." 
                        Text="فهرست اتاق هاي تفكر تشكيل شده در مديريت شعب استان البرز" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvw" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                        CellPadding="1" CellSpacing="1" GridLines="None" PageSize="20" 
                        ShowFooter="True">
                        <AlternatingRowStyle CssClass="ListAlternateRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="عنوان">
                                <ItemTemplate>
                                    <uc9:roomTopic ID="roomTopic1" Description='<%# Eval("ftext") %>' FID='<%# Eval("fid") %>' Topic='<%# Eval("ftitle") %>'   runat="server" />
                                    
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="subcount" DataFormatString="({0})" 
                                HeaderText="تعداد موضوعات">
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
                </td>
            </tr>
            <tr>
                <td>
                    <table align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td valign="top" width="50%">
                                <uc2:tableTitle ID="tableTitle3" runat="server" Icon="1" 
                                    Text="آخرين موضوعات جهت ارسال نظر" />
                                <asp:GridView ID="gvwLatestTopics" runat="server" AutoGenerateColumns="False" 
                                    BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                                    GridLines="None" PageSize="5" Width="100%">
                                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="عنوان">
                                            <ItemTemplate>
                                                <uc7:permanentLink ID="phlTitle" runat="server" Icon="1" 
                                                    NavigateURL='<%# String.Format("~/?system=frm&module=show-statement&fid={0}",Eval("fid")) %>' 
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
                            </td>
                            <td valign="top" width="50%">
                                <uc2:tableTitle ID="tableTitle2" runat="server" Icon="1" 
                                    Text="آخرين نظرات ارسال شده" />
                                <asp:GridView ID="gvwLatestOppinions" runat="server" 
                                    AutoGenerateColumns="False" BorderStyle="None" BorderWidth="0px" 
                                    CellPadding="1" CellSpacing="1" GridLines="None" 
                                     Width="100%" PageSize="5" 
                                    ShowHeader="False">
                                    <AlternatingRowStyle CssClass="ListAlternateRow" />
                                    <Columns>
                                        <asp:TemplateField >
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td align="center" valign="top" width="15%">
                                                            <asp:Image ID="Image1" runat="server" 
                                                                ImageUrl='<%# String.Format("~/images/perpic/{0}.jpg", Eval("FAdder")) %>' 
                                                                Width="35" />
                                                            <br />
                                                            <asp:Label ID="lblPerName" runat="server" Text='<%# Eval("pName") %>'></asp:Label>
                                                        </td>
                                                        <td align="right" valign="top">
                                                            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# String.Format("~/?system=frm&module=show-statement&fid={0}#{1}",Eval("fparent"),Eval("fid")) %>' Text='<%# String.Format("{0} --> {1}", Eval("ftitle"),Eval("fparenttitle")) %>'  runat="server"></asp:HyperLink>
                                                            
                                                        </td>
                                                        <td align="center" valign="top" width="10%">
                                                            <uc4:persianDateBinder ID="persianDateBinder1" runat="server" 
                                                                StringDate='<%# Eval("fadddate") %>' />
                                                        </td>
                                                    </tr>
                                                </table>
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
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>






