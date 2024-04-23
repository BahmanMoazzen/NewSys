<%@ Control Language="C#" ClassName="personnelIDBinder" %>



<%@ Register src="personnelPic.ascx" tagname="personnelPic" tagprefix="uc1" %>


<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progressPanelContent" tagprefix="uc4" %>

<script runat="server">
    public string ValidationGroup
    {
        
        set
        {

            CustomValidator1.ValidationGroup=  txtPID.ValidationGroup =  RequiredFieldValidator1.ValidationGroup = btnCheck.ValidationGroup = value;
        }
    }
    public string PID
    {
        get
        {




            return txtPID.Text;
        }
        set
        {
            txtPID.Text = value;
            if (value.Equals(String.Empty))
            {
                lblPName.Visible = false;
                ppPersonnel.Visible = false;
            }
            else
            {
                lblPName.Visible = true;
                ppPersonnel.Visible = true;
                lblPName.Text = AB.User.Name(txtPID.Text);
                
            }
            
            

        }
    }
    public string PName
    {
        get
        {
            return lblPName.Text;
        }
    }
    protected void loadPersonnel(string iPID)
    {
        lblPName.Text = AB.User.Name(iPID);
        ppPersonnel.Visible = true;
        lblPName.Visible = true;
        ppPersonnel.PID = iPID;
        rblPersonnel.Visible = false;
    }
    protected void loadPersonnel(string iPID,string iPName)
    {
        lblPName.Text = iPName;
        txtPID.Text = iPID;
        ppPersonnel.Visible = true;
        lblPName.Visible = true;
        ppPersonnel.PID = iPID;
        rblPersonnel.Visible = false;
    }
    protected void searchPersonnel(string iQuery)
    {
        rblPersonnel.DataSource = AB.User.SearchPersonnels(iQuery, null);
        rblPersonnel.DataTextField = "pname";
        rblPersonnel.DataValueField = "pid";
        rblPersonnel.DataBind();
        ppPersonnel.Visible = false;
        lblPName.Visible = false;
        ppPersonnel.PID = String.Empty;
        rblPersonnel.Visible = true;
    }
    protected void btnCheck_Click(object sender, EventArgs e)
    {
        try
        {
            int pid = int.Parse(txtPID.Text);
            
            loadPersonnel(txtPID.Text);
            
            
        }
        catch
        {
            
            searchPersonnel(txtPID.Text);
            
            
        }
        
    }

    protected void rblPersonnel_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem rb in rblPersonnel.Items)
        {
            if (rb.Selected)
            {

                loadPersonnel(rb.Value, rb.Text);
            }
        }
    }
    public bool Enabled
    {
        set
        {
            pnlIDBinder.Enabled = value;
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = false;
        if(AB.User.IsVisible(args.Value))
        {
            args.IsValid = true;   
        }
    }
</script>
<asp:UpdatePanel ID="upMainIDBinder" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlIDBinder" DefaultButton="btnCheck" runat="server">
            <asp:TextBox ID="txtPID" runat="server" CssClass="FormTextBox" 
                ValidationGroup="PIDBinder"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                Display="Dynamic" ErrorMessage="فرد مورد نظر مربوط به شعبه شما نمي باشد." 
                onservervalidate="CustomValidator1_ServerValidate" 
                ToolTip="فرد مورد نظر مربوط به شعبه شما نمي باشد." 
                ControlToValidate="txtPID">*</asp:CustomValidator>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    ControlToValidate="txtPID" CssClass="FormError" Display="Dynamic" 
    ErrorMessage="لطفاً شماره پرسنلي را وارد كنيد." 
    ToolTip="لطفاً شماره پرسنلي را وارد كنيد." ValidationGroup="PIDBinder">*</asp:RequiredFieldValidator>
<asp:Button ID="btnCheck" runat="server" CssClass="FormButtom" 
    onclick="btnCheck_Click" Text="بررسي" ValidationGroup="PIDBinder" CausesValidation="False" />
    <asp:UpdateProgress ID="upIDBinder" runat="server" 
                AssociatedUpdatePanelID="upMainIDBinder" DisplayAfter="1">
        <ProgressTemplate>
            <uc4:progressPanelContent ID="progressPanelContent1" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
<asp:Label ID="lblPName" runat="server" CssClass="FormCaption"></asp:Label>
    <uc1:personnelPic ID="ppPersonnel" runat="server" Visible="False" />
            <asp:RadioButtonList ID="rblPersonnel" runat="server" AutoPostBack="True" 
                CssClass="FormButtom" Visible="False" 
                onselectedindexchanged="rblPersonnel_SelectedIndexChanged">
            </asp:RadioButtonList>
</asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>



