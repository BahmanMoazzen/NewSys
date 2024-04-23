<%@ Control Language="C#" ClassName="frmAdd" %>

<%@ Register src="forumTypeDropDown.ascx" tagname="forumTypeDropDown" tagprefix="uc1" %>
<%@ Register src="forumParentList.ascx" tagname="forumParentList" tagprefix="uc2" %>
<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>

<script runat="server">
    public string ToolBarSet
    {
        set
        {
            txtContext.ToolbarSet = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddlType.FType = hidType.Value;
            if (!hidType.Value.Equals(String.Empty))
            {

                ddlType.Enabled = false;
            }

            ddlParent.FParent = hidParent.Value;
            if (!hidParent.Value.Equals(String.Empty))
            {

                ddlParent.Enabled = false;
            }
        }
    }
    public string FParent
    {
        set
        {
            
            hidParent.Value = value;
            
        }
        get
        {
            return ddlParent.FParent;
        }
    }
    public string Type
    {
        set
        {
            
            hidType.Value = value;
        }
        get
        {
            return ddlType.FType;
        }
    }
    private void refreshPage()
    {

        Response.Redirect("http://" + Request.ServerVariables["server_name"] + Request.ServerVariables["URL"] + "?" + Request.QueryString.ToString());
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AB.Forum.AddData(txtTopic.Text, ddlParent.FParent, ddlType.FType, txtContext.Value);
        refreshPage();
    }
</script>
<table cellpadding="0" cellspacing="0" style="width: 100%">
    <tr>
        <td nowrap="nowrap" width="10">
            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="نوع:"></asp:Label>
        </td>
        <td>
            <uc1:forumTypeDropDown ID="ddlType" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label2" runat="server" CssClass="FormCaption">مربوط به:</asp:Label>
        </td>
        <td>
            <uc2:forumParentList ID="ddlParent" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label3" runat="server" CssClass="FormCaption">عنوان:</asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtTopic" runat="server" Width="294px" CssClass="FormTextBox"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label4" runat="server" CssClass="FormCaption">متن:</asp:Label>
        </td>
        <td>
        <FCKeditorV2:FCKeditor ID="txtContext" runat="server" BasePath="fckeditor/" 
                        Height="350px" Width="100%" ToolbarSet="Basic"></FCKeditorV2:FCKeditor></td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:Button ID="btnAdd" runat="server" CssClass="FormButtom" Text="افزودن" 
                onclick="btnAdd_Click" />
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidParent" runat="server" />
<asp:HiddenField ID="hidType" runat="server" />

