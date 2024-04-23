<%@ Control Language="C#" ClassName="loanInfoBinderForInput" %>
<%@ Import Namespace="System.Data" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc6" %>
<%@ Register src="loanInfoParams.ascx" tagname="loaninfoparams" tagprefix="uc3" %>
<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc2" %>
<%@ Register src="paramBinderForInput.ascx" tagname="paramBinderForInput" tagprefix="uc1" %>
<style type="text/css">



    .FormButtom
    {
        width: 39px;
    }
    
</style>

<script runat="server">
    public string Description
    {
        set
        {
            lblDesc.Text = value;
        }
    }
    public string Name
    {
        set
        {
            lbLoanInfo.Text = value;
        }
    }
    public string LIID
    {
        set
        {
            hidLIID.Value = value;
        }
        get
        {
            return hidLIID.Value;
        }
    }
    protected void loadData()
    {
        gvw.DataSource= AB.LoanInfo.Params.LoadForInput(hidLIID.Value);
        gvw.DataBind();
        
        
    }
    protected void lbLoanInfo_Click(object sender, EventArgs e)
    {
        pnlDesc.Visible = !pnlDesc.Visible;
        pnlParams.Visible = !pnlParams.Visible;
        if (!bool.Parse(hidParamsLoaded.Value))
        {
            loadData();
            hidParamsLoaded.Value = "true";
        }
        if (AB.LoanInfo.Answers.CanAnswer(hidLIID.Value))
        {
            tblButtons.Visible = true;
        }
        else
        {
            tblButtons.Visible = false;
            gotoCheckMode();
        }
    }

    protected void gotoCheckMode()
    {
        foreach (GridViewRow r in gvw.Rows)
        {
            paramBinderForInput binder = (paramBinderForInput)r.FindControl("pbfiData");
            binder.CheckMode = true;
        }
    }
    protected void btnControl_Click(object sender, EventArgs e)
    {
        btnControl.Enabled=btnTempSave.Enabled= false;
        btnSave.Enabled = true;
        gotoCheckMode();
        save("2");
        
        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        trButtoms.Visible = false;
        lblMessage.Visible= true;
        save("3");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void timAutoSave_Tick(object sender, EventArgs e)
    {
        save("2");
    }
    protected void save(string iStat)
    {
        ArrayList list = new ArrayList();
        foreach (GridViewRow r in gvw.Rows)
        {
            paramBinderForInput binder = (paramBinderForInput)r.FindControl("pbfiData");
            ListItem li = new ListItem(binder.LIPID, binder.Value);
            list.Add(li);
        }
        AB.LoanInfo.Answers.Add(list, iStat);
    }
    protected void btnTempSave_Click(object sender, EventArgs e)
    {
        save("2");
    }
</script>
<asp:LinkButton ID="lbLoanInfo" runat="server" onclick="lbLoanInfo_Click"></asp:LinkButton>
                                    <asp:HiddenField ID="hidParamsLoaded" 
    runat="server" Value="false" />
<asp:HiddenField ID="hidLIID" runat="server" />
<asp:Timer ID="timAutoSave" runat="server" Interval="300000" 
    ontick="timAutoSave_Tick">
</asp:Timer>
<asp:Panel ID="pnlDesc" runat="server">
    <asp:Label ID="lblDesc" runat="server"></asp:Label>
</asp:Panel>
<asp:Panel ID="pnlParams" runat="server" Visible="False">
    <asp:GridView ID="gvw" runat="server" BorderStyle="None" BorderWidth="0px" 
            CellPadding="1" CellSpacing="1" GridLines="None" 
             
             Width="100%" AutoGenerateColumns="False" ShowHeader="False">
        <AlternatingRowStyle CssClass="ListAlternateRow" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <uc1:paramBinderForInput ID="pbfiData" runat="server" 
                        Description='<%# Eval("lipdesc") %>' MaxValue='<%# Eval("maxvalue") %>' 
                        MinValue='<%# Eval("minvalue") %>' Name='<%# Eval("liptitle") %>' 
                        Value='<%# Eval("avalue") %>' LIPID='<%# Eval("lipid") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:TemplateField>
        </Columns>
        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
        <EmptyDataTemplate>
            
        </EmptyDataTemplate>
        <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                VerticalAlign="Top" />
        <HeaderStyle CssClass="ListHeader" />
        <PagerSettings Mode="NumericFirstLast" />
        <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
        <RowStyle CssClass="ListRow" />
    </asp:GridView>
    <table cellpadding="0" runat="server" id="tblButtons"  cellspacing="0" align="center"  >
        <tr  runat="server" id="trButtoms">
            <td >
                <asp:Button ID="btnTempSave" runat="server" Text="ذخيره موقت" 
                    onclick="btnTempSave_Click" />
            </td>
            <td>
                <asp:Button ID="btnControl" runat="server" onclick="btnControl_Click" 
                    Text="ذخيره و كنترل" CssClass="FormButton" />
            </td>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="تائيد نهايي" 
                    onclick="btnSave_Click" CssClass="FormButton" Enabled="False" /></td>
        </tr>
        <tr  >
        <td colspan="3">
            <asp:Label ID="lblMessage" runat="server" CssClass="FormInfo" 
                Text="عمليات با موفقيت انجام شد." Visible="False"></asp:Label>
        </td>
        </tr>
    </table>
</asp:Panel>

