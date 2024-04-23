<%@ Control Language="C#" ClassName="offTemplate" %>

<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc1" %>








<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        width: 100%;
        border: 3px solid #000000;
    }
</style>








<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "نمايش مرخصي :: "+Resources.Resource.txtSiteTitle;
        string offid = Session["offid"].ToString();
        Session["offif"] = null;
        dlOff.DataSource = AB.Offs.LoadOff(offid);
        dlOff.DataBind();
        
        
    }
</script>

<center>
<asp:DataList ID="dlOff" runat="server">
    <ItemTemplate>
        <table align="center" cellpadding="0" cellspacing="0" width="600">
            <tr>
                <td valign="top">
                    <table cellpadding="0" cellspacing="0" class="style1">
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="50%" valign="bottom">
                                            <table cellpadding="0" cellspacing="0" dir="rtl" >
                                                <tr>
                                                    <td>
                                                       تاريخ درخواست:</td>
                                                    <td>
                                                        <uc1:persianDateBinder ID="pdbRequestDate" runat="server" 
                                                            Date='<%# DateTime.Parse(Eval("requestdate").ToString()) %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="98" width="74" valign="bottom">
                                            <img src="images/off/logo.png" width="50" />
                                        </td>
                                        <td align="right" valign="bottom" width="50%">
                                            باسمه تعالي<br />برگ مرخصي روزانه</td>
                                    </tr>
                                </table>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td dir="rtl">
                                <table cellpadding="0" cellspacing="0" class="style2">
                                    <tr>
                                        <td>
                                            جناب آقاي/سركار خانم
                                            <asp:Label ID="Label3" runat="server" Font-Bold="True" 
                                                Text='<%# Eval("Signername") %>'></asp:Label>
                                            <br />
                                            خواهشمند است با
                                            <asp:Label ID="lblDaysRequest" runat="server" Text='<%# Eval("days") %>'></asp:Label>
                                            &nbsp;روز مرخصي استحقاقي اينجانب
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("pname") %>'></asp:Label>
                                            به شماره استخدامي
                                            <asp:Label ID="lblPID" runat="server" Text='<%# Eval("pid") %>'></asp:Label>
                                            &nbsp;از تاريخ
                                            <uc1:persianDateBinder ID="persianDateBinder1" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("StartDate").ToString()) %>' />
                                            &nbsp;لغايت
                                            <uc1:persianDateBinder ID="persianDateBinder2" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("EndDate").ToString()) %>' />
                                            &nbsp;موافقت نماييد.
                                            <br />
                                            <br />
                                            امضاء متقاضي<br />
                                            <br />
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" class="style2">
                                    <tr>
                                        <td>
                                            جناب آقاي/سركار خانم
                                            <asp:Label ID="Label9" runat="server" Font-Bold="True" 
                                                Text='<%# Eval("Signername") %>'></asp:Label>
                                            <br />
                                            با
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("days") %>'></asp:Label>
                                            &nbsp;روز مرخصي درخواستي موافقت دارد.&nbsp; -&nbsp;<asp:Label ID="Label7" runat="server" 
                                                Font-Bold="True" Text='<%# Eval("Confirmername") %>'></asp:Label>
                                            &nbsp;<asp:Label ID="lblPID0" runat="server" Text='<%# Eval("confirmer") %>'></asp:Label>
                                            <br />
                                            <asp:Image ID="Image1" runat="server" 
                                                ImageUrl='<%# String.Format("~/images/emza/{0}.jpg",Eval("confirmer")) %>' 
                                                Width="150" />
                                            <br />
                                            <uc1:persianDateBinder ID="pdbRequestDate0" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("confirmdate").ToString()) %>' />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" class="style2">
                                    <tr>
                                        <td>
                                            اداره امور كاركنان/امور اداري<br />با
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("days") %>'></asp:Label>
                                            &nbsp;روز مرخصي درخواستي موافقت دارد. -
                                            <asp:Label ID="Label8" runat="server" Font-Bold="True" 
                                                Text='<%# Eval("Signername") %>'></asp:Label><asp:Label ID="Label4" runat="server" Text='<%# Eval("signer") %>'></asp:Label>
                                            &nbsp;<br />

                                            <asp:Image ID="Image2" runat="server" 
                                                ImageUrl='<%# String.Format("~/images/emza/{0}.jpg",Eval("Signer")) %>' 
                                                Width="150" />
                                            <br />
                                            <uc1:persianDateBinder ID="pdbRequestDate1" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("signdate").ToString()) %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="29">
                    <img src="images/off/code.png" width="20" />
                </td>
            </tr>
        </table>

    </ItemTemplate>
</asp:DataList>

    <br />

</center>






