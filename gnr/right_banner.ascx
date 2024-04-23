<%@ Control Language="C#" ClassName="right_banner" %>

<%@ Register src="../usr/PersonnelPicBinder.ascx" tagname="PersonnelPicBinder" tagprefix="uc1" %>

<style type="text/css">
    .style1
    {
        width: 180px;
        height: 38px;
    }
</style>

<script runat="server">
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        dtlRightBanner.DataSource = AB.General.RightBanner();
        dtlRightBanner.DataBind();
        
        
    }

    
</script>





        <table cellpadding="0" cellspacing="0" width="180">
            <tr>
                <td>
                    <img class="style1" src="images/Noori/right-plain-top.gif" /></td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" width="100%" >
                        <tr>
                            <td class="PersonnelBinderLeft">
                                <img src="images/Noori/spacer.gif" width="3" />
                               </td>
                            <td class="PersonnelBinderCenter">
                                
                               


<asp:Repeater ID="dtlRightBanner" runat="server">
<ItemTemplate>
        <asp:Literal ID="lit" runat="server" 
            Text='<%# Eval("link_template").ToString() %>'></asp:Literal>
    </ItemTemplate>
</asp:Repeater>



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
    



