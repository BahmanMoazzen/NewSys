<%@ Control Language="C#" ClassName="persianDatePicker" %>
<%@ Import Namespace="System.Globalization" %>
<script runat="server" >
    public string ValidationGroup
    {
        set
        {
            rfvDate.ValidationGroup = value;
            rfvDate.Enabled = true;
            txtDate.ValidationGroup = value;
            
        }
    }
    public string Text
    {
        get
        {
            return txtDate.Text;
        }
        set
        {
            txtDate.Text = value;
        }
    }
    public DateTime GeorgianDate
    {
        get
        {
            PersianCalendar pd = new PersianCalendar();
            
            return pd.ToDateTime(int.Parse(txtDate.Text.Substring(0, 4)), int.Parse(txtDate.Text.Substring(5, txtDate.Text.IndexOf('/', 5) - 5)), int.Parse(txtDate.Text.Substring(txtDate.Text.IndexOf("/", 5) + 1, txtDate.Text.Length - txtDate.Text.IndexOf("/", 5) - 1)),0, 0, 0, 0);
            
            
            
            
        }
        set
        {
            PersianCalendar pd = new PersianCalendar();
            
            txtDate.Text = String.Format("{0}/{1}/{2}", pd.GetYear(value), pd.GetMonth(value), pd.GetDayOfMonth(value));
        }
    }
    public bool Enable
    {
        set
        {
            txtDate.Enabled = value;
            btnPick.Enabled = value;
            rfvDate.Enabled = value;
        }
        get
        {
            return txtDate.Enabled;
        }
    }
    public string StringDate
    {
        get
        {
            PersianCalendar pd = new PersianCalendar();
            string rettext=String.Empty;
            if (! txtDate.Text.Equals(String.Empty))
            {
                try
                {
                    rettext = pd.ToDateTime(int.Parse(txtDate.Text.Substring(0, 4)), int.Parse(txtDate.Text.Substring(5, txtDate.Text.IndexOf('/', 5) - 5)), int.Parse(txtDate.Text.Substring(txtDate.Text.IndexOf("/", 5) + 1, txtDate.Text.Length - txtDate.Text.IndexOf("/", 5) - 1)), 0, 0, 0, 0).ToString();
                }
                catch { rettext = String.Empty; }
                
            }
            
                 
            return rettext;


        }
        
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {

        
        btnPick.OnClientClick = String.Format("javascript:displayDatePicker('{0}');return false;",txtDate.UniqueID);
        
        
        
    }

    
</script>
<asp:TextBox dir="ltr" ID="txtDate" runat="server" CssClass="FormTextBox" 
     ></asp:TextBox>
<asp:Button CssClass="FormButtom" ID="btnPick" runat="server" Text="تقويم" />

<asp:RequiredFieldValidator ID="rfvDate" runat="server" 
    ControlToValidate="txtDate" CssClass="FormError" Display="Dynamic" 
    Enabled="False" ErrorMessage="لطفاً تاریخ مورد نظر خود را انتخاب کنید." 
    ForeColor="" ToolTip="لطفاً تاریخ مورد نظر خود را انتخاب کنید.">*</asp:RequiredFieldValidator>










