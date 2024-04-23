<%@ Control Language="C#" ClassName="paramBinderForInput" %>

<script runat="server">
    public string Description
    {
        set
        {
            lblDesc.Text = value;
            if (value.Equals(String.Empty))
            {
                imbShowDesc.Visible = false;
            }
            else
            {
                imbShowDesc.Visible = true;
            }
        }
    }
    public string Name
    {
        set
        {
            lblParamName.Text = value+": ";
        }
    }
    public string Value
    {
        set
        {
            txtParamValue.Text = value;
        }
        get
        {
            return txtParamValue.Text;
        }
    }
    public string MinValue
    {
        set
        {
            if (int.Parse(value) > 0)
            {
                rv.Visible = true;
                rv.MinimumValue = value;
            }
        }
    }
    public string MaxValue
    {
        set
        {
            if (int.Parse(value) > 0)
            {
                rv.Visible = true;
                rv.MaximumValue = value;
            }
        }
    }
    public string LIPID
    {
        set
        {
            hidLIPID.Value = value;
        }
        get
        {
            return hidLIPID.Value;
        }
    }
    protected void imbShowDesc_Click(object sender, ImageClickEventArgs e)
    {
        lblDesc.Visible = !lblDesc.Visible;
    }
    public bool CheckMode
    {
        set
        {
            if (value)
            {
                lblCheck.Text = AB.General.ThousandSeprator(txtParamValue.Text);
                lblCheck.Visible = true;
                txtParamValue.Visible = false;

            }
            else
            {
                txtParamValue.Visible = true;
                lblCheck.Visible = false;
            }
        }
    }

    
</script>
<table cellpadding="3" cellspacing="3">
    <tr>
        <td width="30px">
            <asp:ImageButton ID="imbShowDesc" runat="server" Height="30px" 
                ImageUrl="~/images/questionMark.png" onclick="imbShowDesc_Click" Width="30px" />
            </td>
        <td>
            <asp:Label ID="lblParamName" runat="server"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtParamValue" runat="server"></asp:TextBox>
            <asp:Label ID="lblCheck" runat="server" Visible="False" CssClass="FormCaption"></asp:Label>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="txtParamValue" CssClass="FormError" Display="Dynamic" 
                ErrorMessage="لطفاً يك عدد وارد كنيد." Operator="DataTypeCheck" 
                ToolTip="لطفاً يك عدد وارد كنيد." Type="Integer">*</asp:CompareValidator>
            <asp:RangeValidator
                ID="rv" runat="server" ControlToValidate="txtParamValue" 
                CssClass="FormError" Display="Dynamic" Visible="False">*</asp:RangeValidator>
        </td>
    </tr>
    <tr >
        <td colspan="3">
            <asp:Label ID="lblDesc" runat="server" Visible="False"></asp:Label>
            <asp:HiddenField ID="hidLIPID" runat="server" />
        </td>
    </tr>
</table>

