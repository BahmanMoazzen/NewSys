<%@ Control Language="C#" ClassName="DailyReport" %>

<%@ Register src="../gnr/time.ascx" tagname="time" tagprefix="uc7" %>
<%@ Register src="../usr/personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc2" %>
<%@ Register src="../usr/LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc10" %>


<%@ Register src="../gnr/persianDateBinder.ascx" tagname="persiandatebinder" tagprefix="uc3" %>



<%@ Register src="contractStat.ascx" tagname="contractStat" tagprefix="uc5" %>



<%@ Register src="../gnr/permanentLink.ascx" tagname="permanentLink" tagprefix="uc6" %>



<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .blackborder
    {
        border-color:Black;
        border-width:thin;
        
        
    }
    .style2
    {
        height: 147px;
    }
    .style3
    {
        height: 26px;
    }
</style>



<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "ثبت پیگیری مطالبات :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_49_", mvw, vwPage, vwLogin);
        //pdpStart.GeorgianDate = DateTime.Now;

    }

    

    protected void vwPage_Activate(object sender, EventArgs e)
    {
        hidBID.Value = AB.user.BID;
        
        if (Request.QueryString["uniq_id"] != null)
        {
            txtConId.Text = Request.QueryString["uniq_id"];
            if (!txtConId.Text.Equals(String.Empty))
            {

                string[] minmaj = txtConId.Text.Split('/');

                if (minmaj.Length == 3)
                {
                    hidBID.Value = minmaj[0];
                    hidMaj.Value = minmaj[1];
                    hidMin.Value = minmaj[2];
                    
                }
                else if (minmaj.Length == 2)
                {
                    hidBID.Value = AB.user.BID;
                    hidMaj.Value = minmaj[0];
                    hidMin.Value = minmaj[1];
                    
                }


            }
            pnlInsert.Visible = true;
            loadData();
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            pnlInsert.Visible = true;
            loadData();
            
        }
        else
            pnlInsert.Visible = false;
    }
    protected void gvw_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = e.NewEditIndex;
        gvwPhones.DataSource = AB.Vosool.ContractsDetail(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvwPhones.DataBind();

    }
    protected void gvw_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.EditIndex = -1;
        gvwPhones.DataSource = AB.Vosool.ContractsDetail(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvwPhones.DataBind();
    }
    protected void gvw_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string guaranteeName = ((TextBox)r.FindControl("txtGuaranteeName")).Text;
        string guaranteeTel = ((TextBox)r.FindControl("txtGuaranteeTel")).Text;
        string payerName = ((TextBox)r.FindControl("txtPayerName")).Text;
        string payerTel = ((TextBox)r.FindControl("txtPayerTel")).Text;
        string residentName = ((TextBox)r.FindControl("txtResidentName")).Text;
        string residentTel = ((TextBox)r.FindControl("txtResidentTel")).Text;
        string tel = ((TextBox)r.FindControl("txtTel")).Text;
        string address = ((TextBox)r.FindControl("txtAddress")).Text;
        string conId = ((HiddenField)r.FindControl("hidConId")).Value;
        AB.Vosool.UpdateContractDetails(conId, tel, guaranteeName, guaranteeTel, payerName, payerTel, residentName, residentTel,address);
        
        //AB.General.UpdateBranch(bName, BID, address, parent, grade, max, contracted, rewardCount);
        gv.EditIndex = -1;
        gvwPhones.DataSource = AB.Vosool.ContractsDetail(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvwPhones.DataBind();

    }
    private void loadData()
    {
        gvwPhones.DataSource = AB.Vosool.ContractsDetail(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvwPhones.DataBind();
        ddlContractStat.Stat = AB.Vosool.ContractStat(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvw.DataSource = AB.Vosool.LoadLogs(hidBID.Value, hidMaj.Value, hidMin.Value);
        gvw.DataBind();
        hplCaution1.NavigateUrl = "~/app.aspx?app=vsl-Cuation.ascx&name="+Server.UrlEncode(AB.user.DisplayName)+"&ctype=1&uniq_id=" + String.Format("{0}/{1}/{2}", hidBID.Value, hidMaj.Value, hidMin.Value);
        hplCaution2.NavigateUrl = "~/app.aspx?app=vsl-Cuation.ascx&name=" + Server.UrlEncode(AB.user.DisplayName) + "&ctype=2&uniq_id=" + String.Format("{0}/{1}/{2}", hidBID.Value, hidMaj.Value, hidMin.Value);
        hplCaution3.NavigateUrl = "~/app.aspx?app=vsl-Cuation.ascx&name=" + Server.UrlEncode(AB.user.DisplayName) + "&ctype=3&uniq_id=" + String.Format("{0}/{1}/{2}", hidBID.Value, hidMaj.Value, hidMin.Value);
        //hplCaution1.Target = plCaution2.Target = plCaution3.Target = "_blank";
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        bool valid = false;
        if (! txtConId.Text.Equals(String.Empty))
        {
           
            string[] minmaj = txtConId.Text.Split('/');

            if (minmaj.Length == 3)
            {
                hidBID.Value = minmaj[0];
                hidMaj.Value = minmaj[1];
                hidMin.Value = minmaj[2];
                valid = AB.Vosool.IsContractExists(minmaj[0], minmaj[1], minmaj[2]);
            }
            else if (minmaj.Length == 2)
            {
                hidBID.Value = AB.user.BID;
                hidMaj.Value = minmaj[0];
                hidMin.Value = minmaj[1];
                valid = AB.Vosool.IsContractExists(hidBID.Value, minmaj[0], minmaj[1]);
            }
                
            
        }
        args.IsValid = valid;
    }

    protected void btnAddLog_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AB.Vosool.AddLog(txtLogMessage.Text, hidBID.Value, hidMaj.Value, hidMin.Value, AB.user.Email,ddlContractStat.Stat);
            
            if(tdDate.Visible)
                AB.Vosool.AddLogReminder(pdpStart.GeorgianDate, hidBID.Value, hidMaj.Value, hidMin.Value, AB.user.Email);
            lblMessage.Visible = true;
            loadData();
        }
        
    }

    protected void vwLogDone_Activate(object sender, EventArgs e)
    {
        loadData();
    }

   

    protected void gvw_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = (GridView)sender;
        GridViewRow r = gv.Rows[e.RowIndex];
        string id = ((HiddenField)r.FindControl("hidLogId")).Value;
        AB.Vosool.DeleteLog(id);
        loadData();
    }

    

    protected void btnCaution_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/app.aspx?app=vsl-Cuation.ascx&ctype="+((Button)sender).CommandArgument+"&uniq_id="+String.Format("{0}/{1}/{2}",hidBID.Value,hidMaj.Value,hidMin.Value));
    }

    protected void rblConfirm_SelectedIndexChanged(object sender, EventArgs e)
    {
        tdDate.Visible = Boolean.Parse(((RadioButtonList)sender).SelectedValue);
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" onactivate="vwPage_Activate">
        <asp:UpdatePanel ID="upMain" runat="server">
            <ContentTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <uc2:tableTitle ID="tableTitle1" runat="server" Icon="1" 
                                SubText="اقدامات انجام شده در خصوص پرونده های مختلف را در این قسمت وارد نمایید. شماره قرار داد را به فرمت  123456/1162 وارد نمایید" 
                                Text="ثبت پیگیری مطالبات معوق" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HiddenField ID="hidBID" runat="server" />
                            <asp:HiddenField ID="hidMaj" runat="server" />
                            <asp:HiddenField ID="hidMin" runat="server" />
                            <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                Text="شماره قرار داد:"></asp:Label>
                            <asp:TextBox ID="txtConId" runat="server" CssClass="FormTextBoxLTR" 
                                ValidationGroup="show"></asp:TextBox>
                            <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                                onclick="btnShow_Click" Text="نمايش" ValidationGroup="show" />
                            <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="FormError" 
                                Display="Dynamic" ErrorMessage="چنین قرار دادی در سیستم وجود ندارد" 
                                onservervalidate="CustomValidator1_ServerValidate" ValidationGroup="show"></asp:CustomValidator>
                            <br />
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <uc10:progressPanelContent ID="progressPanelContent1" runat="server" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlInsert" runat="server" Visible="False">
                                <table class="style1">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvwPhones" runat="server" AutoGenerateColumns="False" 
                                                BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                                                GridLines="None" onrowcancelingedit="gvw_RowCancelingEdit" 
                                                onrowediting="gvw_RowEditing" onrowupdating="gvw_RowUpdating" PageSize="1" 
                                                Width="100%">
                                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="شماره های تماس">
                                                        <EditItemTemplate>
                                                            <table class="style1">
                                                                <tr>
                                                                    <td class="style3">
                                                                        &nbsp;</td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label102" runat="server" CssClass="FormCaption" Text="نام:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label18" runat="server" CssClass="FormCaption" 
                                                                            Text="شماره تماس:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        &nbsp;</td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label19" runat="server" CssClass="FormCaption" Text="نام:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label20" runat="server" CssClass="FormCaption" 
                                                                            Text="شماره تماس:"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label5" runat="server" CssClass="FormCaption" 
                                                                            Text="متعهد قرار داد:"></asp:Label>
                                                                        <asp:HiddenField ID="hidConId" runat="server" Value='<%# Eval("con_id") %>' />
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("display_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:TextBox ID="txtTel" runat="server" Columns="12" CssClass="FormTextBox" 
                                                                            MaxLength="11" Text='<%# Eval("con_tel") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label7" runat="server" CssClass="FormCaption" 
                                                                            Text="پرداخت کننده اقساط:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:TextBox ID="txtPayerName" runat="server" Columns="16" 
                                                                            CssClass="FormTextBox" MaxLength="75" Text='<%# Eval("con_payer_name") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:TextBox ID="txtPayerTel" runat="server" Columns="12" 
                                                                            CssClass="FormTextBox" MaxLength="11" Text='<%# Eval("con_payer_tel") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="server" CssClass="FormCaption" 
                                                                            Text="ضامن قرار داد:"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtGuaranteeName" runat="server" Columns="16" 
                                                                            CssClass="FormTextBox" MaxLength="75" Text='<%# Eval("con_guarantee_name") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtGuaranteeTel" runat="server" Columns="12" 
                                                                            CssClass="FormTextBox" MaxLength="11" Text='<%# Eval("con_guarantee_tel") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label8" runat="server" CssClass="FormCaption" Text="متصرف ملک:"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtResidentName" runat="server" Columns="16" 
                                                                            CssClass="FormTextBox" MaxLength="75" Text='<%# Eval("con_resident_name") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtResidentTel" runat="server" Columns="12" 
                                                                            CssClass="FormTextBox" MaxLength="11" Text='<%# Eval("con_resident_tel") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label103" runat="server" CssClass="FormCaption" Text="آدرس:"></asp:Label>
                                                                    </td>
                                                                    <td colspan="5">
                                                                        <asp:TextBox ID="txtAddress" runat="server" Columns="16" CssClass="FormTextBox" 
                                                                            MaxLength="200" Text='<%# Eval("con_addr") %>' Width="100%"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <table class="style1">
                                                                <tr>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label112" runat="server" CssClass="FormCaption" 
                                                                            Text="متعهد قرار داد:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("display_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("con_tel") %>'></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label113" runat="server" CssClass="FormCaption" 
                                                                            Text="پرداخت کننده اقساط:"></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label13" runat="server" Text='<%# Eval("con_payer_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td class="style3">
                                                                        <asp:Label ID="Label14" runat="server" Text='<%# Eval("con_payer_tel") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label114" runat="server" CssClass="FormCaption" 
                                                                            Text="ضامن قرار داد:"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("con_guarantee_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("con_guarantee_tel") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label115" runat="server" CssClass="FormCaption" 
                                                                            Text="متصرف ملک:"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label116" runat="server" Text='<%# Eval("con_resident_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Text='<%# Eval("con_resident_tel") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label17" runat="server" CssClass="FormCaption" Text="آدرس:"></asp:Label>
                                                                    </td>
                                                                    <td colspan="5">
                                                                        <asp:Label ID="Label117" runat="server" Text='<%# Eval("con_addr") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ButtonType="Button" CancelText="انصراف" EditText="تغییر" 
                                                        ShowEditButton="True" UpdateText="به روز رسانی" />
                                                </Columns>
                                                <EditRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                                <FooterStyle CssClass="FooterStyle" HorizontalAlign="Center" 
                                                    VerticalAlign="Top" />
                                                <HeaderStyle CssClass="ListHeader" />
                                                <PagerSettings Mode="NumericFirstLast" />
                                                <PagerStyle CssClass="ListPager" Font-Overline="False" Font-Strikeout="False" />
                                                <RowStyle CssClass="ListRow" />
                                            </asp:GridView>
                                            <table class="style1">
                                                <tr>
                                                    <td>
                                                        <table class="style1">
                                                            <tr align="center">
                                                                <td>
                                                                    <asp:HyperLink ID="hplCaution1" runat="server" Font-Size="Larger" 
                                                                        Target="_blank">صدور اخطار مقدماتی</asp:HyperLink>
                                                                </td>
                                                                <td>
                                                                    <asp:HyperLink ID="hplCaution2" runat="server" Font-Size="Larger" 
                                                                        Target="_blank">صدور اخطار ثانویه</asp:HyperLink>
                                                                </td>
                                                                <td>
                                                                    <asp:HyperLink ID="hplCaution3" runat="server" Font-Size="Larger" 
                                                                        Target="_blank">صدور اخطار نهایی</asp:HyperLink>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="blackborder" valign="top" width="50%">
                                            <asp:MultiView ID="mvwLog" runat="server" ActiveViewIndex="0">
                                                <asp:View ID="vwLogView" runat="server">
                                                    <table class="style1">
                                                        <tr>
                                                            <td colspan="2" style="width: 100%" width="50%">
                                                                <asp:Label ID="Label118" runat="server" CssClass="FormCaption" 
                                                                    Text="وضعیت قرار داد:"></asp:Label>
                                                                <br />
                                                                &nbsp;<uc5:contractStat ID="ddlContractStat" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style2" colspan="2">
                                                                <asp:Label ID="Label4" runat="server" CssClass="FormCaption" Text="شرح پیگیری:"></asp:Label>
                                                                <br />
                                                                <asp:TextBox ID="txtLogMessage" runat="server" Columns="70" 
                                                                    CssClass="FormTextBox" Rows="9" TextMode="MultiLine" ValidationGroup="addLog"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                                    ControlToValidate="txtLogMessage" CssClass="FormError" Display="Dynamic" 
                                                                    ErrorMessage="لطفاً شرح پیگیری را وارد نمایید" ValidationGroup="addLog"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label119" runat="server" CssClass="FormCaption" 
                                                                    Text="آیا مایل به ثبت یادآور هستید؟"></asp:Label>
                                                                <asp:RadioButtonList ID="rblConfirm" runat="server" AutoPostBack="True" 
                                                                    CssClass="FormButtom" onselectedindexchanged="rblConfirm_SelectedIndexChanged" 
                                                                    RepeatDirection="Horizontal" ValidationGroup="addLog">
                                                                    <asp:ListItem Value="true">بله</asp:ListItem>
                                                                    <asp:ListItem Value="false" Selected="True">خیر</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" visible="false" runat="server" ID="tdDate">
                                                                <asp:Label ID="Label111" runat="server" CssClass="FormCaption" 
                                                                    Text="انتخاب تاریخ:"></asp:Label>
                                                                <uc4:persianDatePicker ID="pdpStart" runat="server" 
                                                                    ValidationGroup="addLog" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnAddLog" runat="server" CssClass="FormButtom" 
                                                                    onclick="btnAddLog_Click" Text="ثبت پیگیری و تغییر وضعیت پرونده" 
                                                                    ValidationGroup="addLog" />
                                                                <asp:Label ID="lblMessage" runat="server" CssClass="FormInfo" 
                                                                    EnableViewState="False" Text="عملیات با موفقیت انجام شد." Visible="False"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:View>
                                            </asp:MultiView>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False" 
                                BorderStyle="None" BorderWidth="0px" CellPadding="1" CellSpacing="1" 
                                GridLines="None" onrowdeleting="gvw_RowDeleting" PageSize="20" Width="100%">
                                <AlternatingRowStyle CssClass="ListAlternateRow" />
                                <Columns>
                                    <asp:BoundField DataField="adder_id" HeaderText="کد پرسنلی" />
                                    <asp:BoundField DataField="adder_name" HeaderText="نام و نام خانوادگی" />
                                    <asp:TemplateField HeaderText="تاریخ پیگیری">
                                        <ItemTemplate>
                                            <uc3:persiandatebinder ID="persiandatebinder1" runat="server" 
                                                Date='<%# DateTime.Parse(Eval("add_date").ToString()) %>' />
                                            <asp:HiddenField ID="hidLogId" runat="server" Value='<%# Eval("log_id") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="message" HeaderText="متن پیگیری" />
                                    <asp:BoundField DataField="confirmed" HeaderText="وضعیت تائید" />
                                    <asp:CommandField DeleteText="حذف" HeaderText="عملیات" 
                                        ShowDeleteButton="True" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:View>
</asp:MultiView>






