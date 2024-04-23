<%@ Control Language="C#" ClassName="contractStat" %>

<script runat="server">
    public string Stat
    {
        get
        {
            return ddlStats.SelectedValue;
        }
        set
        {
            ddlStats.SelectedValue = value;
        }
    }
    public string Enabled
    {
        get
        {
            return ddlStats.Enabled.ToString();
        }
        set
        {
            ddlStats.Enabled = Boolean.Parse(value);
        }
    }
    
    
    
</script>
<asp:DropDownList ID="ddlStats" runat="server" CssClass="FormButtom" 
    AutoPostBack="True">
    <asp:ListItem Selected="True" Value="0">عادی</asp:ListItem>
    <asp:ListItem Value="1">تماس تلفنی</asp:ListItem>
    <asp:ListItem Value="2">صدور اخطار مقدماتی</asp:ListItem>
    <asp:ListItem Value="3">صدور اخطار ثانویه</asp:ListItem>
<asp:ListItem Value="4">صدور اخطار نهایی</asp:ListItem>
    <asp:ListItem Value="5">صدور اخطار دفترخانه ای</asp:ListItem>
    <asp:ListItem Value="6">تنظیم تقاضا نامه صدور اجرائیه</asp:ListItem>
    <asp:ListItem Value="7">تشکیل پرونده و اخذ کلاسه از اداره ثبت</asp:ListItem>
    <asp:ListItem Value="8">ابلاغ اجرائیه به طرفین</asp:ListItem>
    <asp:ListItem Value="9">اخذ استعلام وضعیت ثبتی</asp:ListItem>
    <asp:ListItem Value="10">تعیین کارشناس رسمی دادگستری</asp:ListItem>
    <asp:ListItem Value="11">ارزیابی ملک توسط ارزیابان بانک</asp:ListItem>
    <asp:ListItem Value="12">ارزیابی ملک توسط کارشناسان رسمی</asp:ListItem>
    <asp:ListItem Value="13">اخطار ماده 101 توسط اداره ثبت</asp:ListItem>
    <asp:ListItem Value="14">اخذ مجوز مزایده از اداره کل پیگیری بانک</asp:ListItem>
    <asp:ListItem Value="15">تعیین روز مزایده توسط اداره ثبت</asp:ListItem>
    <asp:ListItem Value="16">برگزاری جلسه مزایده</asp:ListItem>
    <asp:ListItem Value="17">اخذ سند پیشنویس اجرایی</asp:ListItem>
    <asp:ListItem Value="18">استعلام از اداره ثبت </asp:ListItem>
    <asp:ListItem Value="19">استعلام از اداره دارایی</asp:ListItem>
    <asp:ListItem Value="20">استعلام از شهرداری</asp:ListItem>
    <asp:ListItem Value="21">تملیک</asp:ListItem>
    <asp:ListItem Value="22">توقف اجرائیه</asp:ListItem>
</asp:DropDownList>

