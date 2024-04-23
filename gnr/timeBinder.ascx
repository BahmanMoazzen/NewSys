<%@ Control Language="C#" ClassName="timeBinder" %>

<script runat="server">
    public string StringDate
    {
        set
        {


            lbl.Text = DateTime.Parse(value).TimeOfDay.ToString();
            

        }
        get
        {
            return lbl.Text;
        }
    }
    public string CssClass
    {
        set
        {
            lbl.CssClass = value;
        }
        get
        {
            return lbl.CssClass;
        }
    }
</script>
<asp:Label ID="lbl" runat="server" Text="Label"></asp:Label>