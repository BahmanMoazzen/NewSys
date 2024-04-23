<%@ Control Language="C#" ClassName="PersonnelPicBinder" %>



<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (AB.user == null)
        {
            mvw.SetActiveView(vwBlank);
            
        }
        else
        {
            mvw.SetActiveView(vwShow);
            lblPID.Text = AB.user.Email;
            lblName.Text = AB.user.FullName;
            imgPic.ImageUrl = String.Format(Resources.Resource.txtUsersImagePath,AB.user.Email);
        }
        
    }
</script>
<asp:MultiView ID="mvw" runat="server">
    <asp:View ID="vwBlank" runat="server">
    </asp:View>
    <asp:View ID="vwShow" runat="server">
        <table cellpadding="0" cellspacing="0" width="180">
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" width="100%" >
                        <tr><td height="58" width="44">
                                <img  
                            src="images/Noori/pers-Right.gif" height="58" width="44" />
                            </td>
                            <td class="PersonnelBinderTop">
                                <asp:Label ID="lblPID" runat="server" CssClass="PersonnelBinderPID"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" width="100%" >
                        <tr>
                            <td class="PersonnelBinderLeft">
                                <img src="images/Noori/spacer.gif" width="3" />
                               </td>
                            <td class="PersonnelBinderCenter">
                                
                                <asp:Image ID="imgPic" runat="server" BorderColor="#CC3300" BorderStyle="Solid" 
                                    BorderWidth="2px" Width="75px" />
                                <br />
                                <asp:Label ID="lblName" runat="server" CssClass="PersonnelBinderName"></asp:Label>
                                <br />
                                <asp:Label ID="Label1" runat="server" Text="خوش آمديد"></asp:Label>
                            </td>
                            <td class="PersonnelBinderRight">
                                <img " src="images/Noori/spacer.gif" width="2" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="images/Noori/pers-button.gif" />
                </td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>

