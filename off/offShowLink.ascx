<%@ Control Language="C#" ClassName="offShowLink" %>

<script runat="server">
    public string OTID
    {
        set
        {
            if (!value.Equals("1"))
                btnShow.Enabled = false;
        }
    }
    public string OSTTID
    {
        set
        {
            if (!value.Equals("3"))
                btnShow.Enabled = false;
        }
    }
    public string OffInsertType
    {
        set
        {
            if (! value.Equals("1"))
            {
                btnShow.Enabled = false;
                
            }
        }
    }
    public string OffId
    {
        set
        {
            btnShow.CommandArgument = value;
        }
    }

    

    protected void btnShow_Click(object sender, EventArgs e)
    {
        Session["offid"] = btnShow.CommandArgument;
        Response.Redirect("~/app.aspx?app=off-offTemplate.ascx");
    }
</script>
<asp:Button ID="btnShow" runat="server" Text="نمايش" CssClass="FormButtom" 
    Enabled="True" onclick="btnShow_Click" 
    />


