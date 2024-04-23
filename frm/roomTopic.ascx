<%@ Control Language="C#" ClassName="roomTopic" %>

<%@ Register src="subTopics.ascx" tagname="subtopics" tagprefix="uc8" %>
<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentlink" tagprefix="uc7" %>

<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc1" %>

<script runat="server">
    public string Topic
    {
        set
        {
            lbtTopic.Text = value;
        }
    }
    public string Description
    {
        set
        {
            litDesc.Text = value;
        }
    }
    public string FID
    {
        set
        {
            hidFID.Value = value;
        }
    }
    

    protected void lbtTopic_Click1(object sender, EventArgs e)
    {
        
        subTopics.Visible = !subTopics.Visible;
        litDesc.Visible = !litDesc.Visible;
        if (subTopics.Visible)
        {
            subTopics.FParent = hidFID.Value;
        }
    }
</script>
<asp:HiddenField ID="hidFID" runat="server" />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <asp:LinkButton ID="lbtTopic" runat="server" CssClass="FormCaption" 
            onclick="lbtTopic_Click1"></asp:LinkButton>
        <br />
        <asp:Literal ID="litDesc" runat="server"></asp:Literal>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">

            <ProgressTemplate>
                
                <uc1:progressPanelContent ID="progressPanelContent1" runat="server" />
            </ProgressTemplate>

        </asp:UpdateProgress>
        <p>
                     <uc8:subTopics ID="subTopics" Visible="false"  runat="server" />
                </p>
    </ContentTemplate>
</asp:UpdatePanel>


