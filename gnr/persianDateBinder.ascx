<%@ Control Language="C#" ClassName="persianDateBinder" %>
<%@ Import Namespace="System.Globalization" %>
<script runat="server">
    public string CssStyle
    {
        set
        {
            lblDate.CssClass = value;
        }
        get
        {
            return lblDate.CssClass;
        }
    }
    public static class PersianDate
    {

        private static string[] dayNames = { "دو شنبه", "سه شنبه", "چهار شنبه", "پنج شنبه", "جمعه", "شنبه", "یک شنبه" };
        private static string[] monthNames = { "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند" };

        public static string Now
        {
            get
            {
                PersianCalendar pcal = new PersianCalendar();
                DateTime dt = DateTime.Now;
                return pcal.GetYear(dt).ToString() + "/" + pcal.GetMonth(dt).ToString() + "/" + pcal.GetDayOfMonth(dt).ToString();

            }
        }
        //public static string ToDayName
        //{
        //    get
        //    {
        //        PersianCalendar pcal = new PersianCalendar();
        //        DateTime dt = DateTime.Now;
        //        return dayNames[((int)pcal.GetDayOfWeek(dt))-1];
        //    }
        //}
        //public static byte DayOfMonth
        //{
        //    get
        //    {
        //        PersianCalendar pcal = new PersianCalendar();
        //        DateTime dt = DateTime.Now;
        //        return (byte) pcal.GetMonth(dt);

        //    }
        //}
        //public static string MonthName
        //{
        //    get
        //    {
        //        PersianCalendar pcal = new PersianCalendar();
        //        DateTime dt = DateTime.Now;
        //        return monthNames[((int)pcal.GetMonth(dt)) - 1];
        //    }
        //}
        public static string ToPersion(DateTime dt)
        {
            PersianCalendar pcal = new PersianCalendar();

            return pcal.GetYear(dt).ToString() + "/" + pcal.GetMonth(dt).ToString() + "/" + pcal.GetDayOfMonth(dt).ToString();
        }
    }
    public string StringDate
    {
        set
        {
            
            try
            {
                lblDate.Text = PersianDate.ToPersion(DateTime.Parse(value));
            }
            catch
            {
                lblDate.Text = "[نا مشخص]";
            }
            finally
            {
                lblDate.Style.Add("direction", "rtl");
            }
            
        }
    }
    
    public DateTime Date
    {
        set
        {
            lblDate.Style.Add("direction", "rtl");
            lblDate.Text = PersianDate.ToPersion(value);
            hidDate.Value = value.ToString();
                
            
        }
        get
        {
            return DateTime.Parse( hidDate.Value);
        }
    }
    
</script>
<font dir="ltr"><asp:Label  ID="lblDate" runat="server"></asp:Label></font>

<asp:HiddenField ID="hidDate" runat="server" />


