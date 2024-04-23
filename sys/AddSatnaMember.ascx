<%@ Control Language="C#" ClassName="AddSatnaMember" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="loadSatnaMembers.ascx" tagname="loadSatnaMembers" tagprefix="uc4" %>
<style type="text/css">




    .style1
    {
        width: 100%;
    }
    
    
    
    .style2
    {
        height: 36px;
    }
    
    
    
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = " مديريت گروه ساتنا :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_25_", mvw, vwPage, vwLogin);

    }

    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.System.SATNA.AddSATNAMember(AB.user.BID, pibPID.PID,ddlRole.SelectedValue,txtCompNumber.Text);
            loadSatnaMembers.BID = AB.user.BID;
            
        }
    }

    protected void vwIdle_Activate(object sender, EventArgs e)
    {
        loadSatnaMembers.BID = AB.user.BID;
    }
   

   

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (ddlRole.SelectedValue.Equals("0") && AB.System.SATNA.IsSATNAGroupHasRegisterer(AB.user.BID))
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
    }

protected void  CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
{
    if (ddlRole.SelectedValue.Equals("1") &&  AB.System.SATNA.IsSATNAGroupHasConfirmer(AB.user.BID))
    {
        args.IsValid = false;
    }
    else
    {
        args.IsValid = true;
    }
}
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server">
        <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0" 
            ViewStateMode="Enabled">
            <asp:View ID="vwIdle" runat="server" onactivate="vwIdle_Activate">
                
                        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnRequest" >
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                SubText="از اين فرم جهت ثبت و يا حذف اعضاء گروه ساتنا استفاده كنيد." 
                                Text="فرم مديريت گروه ساتنا" />
                            <asp:UpdatePanel  ID="upMain" runat="server">
                                <ContentTemplate>
                                    <table cellpadding="-1" cellspacing="0" class="style1">
                                    <tr>
                                            <td nowrap="nowrap" width="10%">
                                                <asp:Label ID="lbl3" runat="server" CssClass="FormCaption" Text="شماره پرسنلي:"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap" width="50%">
                                                <uc1:personnelIDBinder ID="pibPID" runat="server" 
                                                    ValidationGroup="AddATMMember" />
                                            </td>
                                            <td align="justify" rowspan="4" valign="top">
                                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                                    CssClass="FormError" DisplayMode="List" HeaderText="رخداد خطا!" 
                                                    ValidationGroup="AddATMMember" />
                                            </td>
                                        </tr>
                                    <tr>
                                            <td nowrap="nowrap" width="10%" class="style2">
                                                <asp:Label ID="lbl4" runat="server" CssClass="FormCaption" Text="نقش:"></asp:Label>
                                            </td>
                                            <td nowrap="nowrap" class="style2">
                                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="FormTextBox">
                                                    <asp:ListItem Selected="True" Value="0">ثبت كننده</asp:ListItem>
                                                    <asp:ListItem Value="1">تائيد كننده</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        
                                        
                                        <tr>
                                            <td nowrap="nowrap">
                                                <asp:Label ID="lbl5" runat="server" CssClass="FormCaption" 
                                                    Text="شماره كامپيوتر:"></asp:Label>
                                            </td>
                                            <td class="style2">
                                                <asp:TextBox ID="txtCompNumber" runat="server" Columns="4" CssClass="FormTextBox" 
                                                    MaxLength="3" ValidationGroup="AddATMMember"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                    ControlToValidate="txtCompNumber" CssClass="FormError" Display="Dynamic" 
                                                    ErrorMessage="لطفاً شماره كامپيوتر را وارد كنيد" 
                                                    ToolTip="لطفاً تلفن همراه را وارد كنيد." ValidationGroup="AddATMMember">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                            <td class="style2">
                                                <asp:Button ID="btnRequest" runat="server" CssClass="FormButtom" 
                                                    onclick="btnRequest_Click" Text="ثبت عضو ساتنا" 
                                                    ValidationGroup="AddATMMember" />
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                                    Display="Dynamic" ErrorMessage="امكان ثبت بيش از يك عضو ثبت كننده وجود ندارد." 
                                                    onservervalidate="CustomValidator1_ServerValidate" 
                                                    ToolTip="امكان ثبت بيش از يك عضو ثبت كننده وجود ندارد." 
                                                    ValidationGroup="AddATMMember">*</asp:CustomValidator>
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" CssClass="FormError" 
                                                    Display="Dynamic" ErrorMessage="امكان ثبت بيش از يك عضو تائيد كننده وجود ندارد." 
                                                    onservervalidate="CustomValidator2_ServerValidate" 
                                                    ToolTip="امكان ثبت بيش از يك عضو تائيد كننده وجود ندارد." 
                                                    ValidationGroup="AddATMMember">*</asp:CustomValidator>
                                                <asp:UpdateProgress ID="upsMain" runat="server" 
                                                    AssociatedUpdatePanelID="upMain" DisplayAfter="1">
                                                    <ProgressTemplate>
                                                        <uc7:progressPanelContent ID="progressPanelContent1" runat="server" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td colspan=3>
                                            <uc4:loadSatnaMembers ID="loadSatnaMembers" runat="server" />
                                        </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        
            </asp:View>
        </asp:MultiView>
    </asp:View>
</asp:MultiView>






