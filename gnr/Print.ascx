<%@ Control Language="C#" ClassName="Print" %>
<script runat="server">

    

    protected void Page_Load(object sender, EventArgs e)
    {
        btnHide.Text = Resources.Resource.txtHideRightBannerText;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        HtmlTableCell right=null;
        for (int i = 1; i <= 21; i++)
        {
            right = (HtmlTableCell)Page.FindControl("td"+i.ToString());
            right.Visible = !right.Visible;
        }
        //for (int i = 1; i <= 3; i++)
        //{
        //    HtmlTableCell alwaysVisible = (HtmlTableCell)Page.FindControl("av" + i.ToString());
        //    alwaysVisible.Visible = true;
        //}
        if (right.Visible)
        {
            btnHide.Text = Resources.Resource.txtHideRightBannerText;
        }
        else
        {
            btnHide.Text = Resources.Resource.txtShowRightBannerText;
        }
    }
</script>
<asp:Button ID="btnHide" runat="server" CssClass="FormButtom" 
    onclick="Button1_Click" CausesValidation="False" />






