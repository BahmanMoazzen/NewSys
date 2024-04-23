<%@ Control Language="C#" ClassName="Help" %>

<%@ Register src="tableTitle.ascx" tagname="tableTitle" tagprefix="uc1" %>

<style type="text/css">
    .style1
    {
        color: #00CC00;
    }
</style>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.QueryString["hid"] != null)
        {
            string hid = Request.QueryString["hid"];
            switch (hid[0])
                {
                    case '1':
                        mvw1.SetActiveView(vw1);
                        break;
                    case '2':
                        mvw1.SetActiveView(vw2);
                        break;
                    case '3':
                        mvw1.SetActiveView(vw3);
                        break;
                    case '4':
                        mvw1.SetActiveView(vw4);
                        break;
                    case '5':
                        mvw1.SetActiveView(vw5);
                        break;
                        
                        
                }
            
            
        }
    }

    protected void vw1_Activate(object sender, EventArgs e)
    {
        
        string hid = Request.QueryString["hid"];
        if (hid.Length > 1)
        {
            switch (hid[1])
            {
                case '1':
                    mvw11.SetActiveView(vw11);
                    break;
                case '2':
                    mvw11.SetActiveView(vw12);
                    break;
                case '3':
                    mvw11.SetActiveView(vw13);
                    break;
                case '4':
                    mvw11.SetActiveView(vw14);
                    break;


            }
        }
    }

    protected void vw2_Activate(object sender, EventArgs e)
    {
        string hid = Request.QueryString["hid"];
        if (hid.Length > 1)
        {
            switch (hid[1])
            {
                case '1':
                    mvw21.SetActiveView(vw21);
                    break;
                case '2':
                    mvw21.SetActiveView(vw22);
                    break;
                case '3':
                    mvw21.SetActiveView(vw23);
                    break;
                


            }
        }
    }

    protected void vw3_Activate(object sender, EventArgs e)
    {
        string hid = Request.QueryString["hid"];
        if (hid.Length > 1)
        {
            switch (hid[1])
            {
                case '1':
                    mvw31.SetActiveView(vw31);
                    break;
                case '2':
                    mvw31.SetActiveView(vw32);
                    break;
                case '3':
                    mvw31.SetActiveView(vw33);
                    break;



            }
        }

    }

    protected void vw4_Activate(object sender, EventArgs e)
    {
        string hid = Request.QueryString["hid"];
        if (hid.Length > 1)
        {
            switch (hid[1])
            {
                case '1':
                    mvw41.SetActiveView(vw41);
                    break;
                case '2':
                    mvw41.SetActiveView(vw42);
                    break;
                case '3':
                    mvw41.SetActiveView(vw43);
                    break;



            }
        }

    }

    protected void vw5_Activate(object sender, EventArgs e)
    {

    }
</script>
<uc1:tableTitle ID="tableTitle1" runat="server" Icon="0" Text="راهنمای سایت" />


<asp:MultiView ID="mvw1" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwDef1" runat="server">
        به بخش راهنمای سایت خوش آمدید.برای استفاده از راهنمای هر بخش کافی است روی آن 
        کلیک کنید.<br />
        <ul>
        <li><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/?system=gnr&module=help&hid=1" Text="راهنمای بخش مقالات"></asp:HyperLink></li>
         <li><asp:HyperLink ID="HyperLink2" runat="server" 
                 NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=2">راهنمای بخش اخبار</asp:HyperLink></li>
         <li><asp:HyperLink ID="HyperLink3" runat="server" 
                 NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=3">راهنمای ثبت نام در سایت</asp:HyperLink></li>
         <li><asp:HyperLink ID="HyperLink4" runat="server" 
                 NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=4">راهنمای سیستم امتیاز</asp:HyperLink></li>
            <li>
                <asp:HyperLink ID="HyperLink9" runat="server" 
                    NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=5">راهنمای تبلیغات در سایت</asp:HyperLink>
            </li>
        </ul>
    </asp:View>
    <asp:View ID="vw1" runat="server" onactivate="vw1_Activate">
        <asp:MultiView ID="mvw11" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwDef11" runat="server">
                به بخش راهنمای مقالات خوش آمدید.برای استفاده از راهنمای هر بخش کافی است روی آن 
                کلیک کنید.<br />
                <br />
                <ul>
                    <li>
                        <asp:HyperLink ID="HyperLink5" runat="server" 
                            NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=11" 
                            Text="راهنمای ارسال مقاله"></asp:HyperLink>
                    </li>
                    <li>
                        <asp:HyperLink ID="HyperLink6" runat="server" 
                            NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=12">راهنمای مدیریت مقالات ارسال شده.</asp:HyperLink>
                    </li>
                    <li>
                        <asp:HyperLink ID="HyperLink7" runat="server" 
                            NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=13">راهنمای دریافت مقاله</asp:HyperLink>
                    </li>
                    <li>
                        <asp:HyperLink ID="HyperLink8" runat="server" 
                            NavigateUrl="~/?system=gnr&amp;module=help&amp;hid=14">راهنمای ارسال مقالات برای دیگران</asp:HyperLink>
                    </li>
                </ul>
                <br />
            </asp:View>
            <asp:View ID="vw11" runat="server">
            <p>راهنمای ارسال مقاله.<br />
ارسال مقاله فرآیند بسیار ساده ای دارد. شما برای ارسال یک مقاله نیاز دارید که   فایل خود را در فرمت های معتبر <b>PDF</b> و یا <b>DOC</b> ارسال نمایید. برای ارسال مقاله ابتدا   باید <a href="/?system=usr&module=register" target="_blank">عضو سایت شوید</a> و کاربری خود را نیز فعال کرده باشید. به این صورد دو کلید   مربوط به ارسال مقاله را در اختیار خواهید داشت.</p>
<ol>
  <li>به بخش <a href="/?system=art&amp;module=add">ارسال مقاله</a> بروید.</li>
  <li>در صورتی که هنوز وارد سایت نشده باشید، در این قسمت با نام کاربری - Email - و کلمه عبور خود این کار را انجام دهید.</li>
  <li>پس از ورود به سایت، به بخش ارسال مقاله راهنمایی می شوید. در این بخش اطلاعات مقاله از شما پرسیده می شود. آن ها را به دقت تکمیل فرمایید.</li>
  <li>در صورتی که نویسندگان بیش از یک نفر است، نام هرکدام را به صورت جداگانه وارد کنید.</li>
  <li>در صورتی که در مقاله ایمیل فرد موجود است ، می توانید آن را در قسمت ایمیل وارد کنید. در غیر این صورت این قسمت را خالی بگذارید.</li>
  <li>در قسمت فایل بر روس عبارت Browse کلیک کرده و فایل خود را به سیستم نشان بدهید. لطفا در هنگام تهیه فایل مقاله به نوع فایل های معتبر برای سیتم توجه فرمایید.</li>
  <li>در قسمت قیمت ، تعداد امتیاز مورد نظر برای فروش مقاله را وارد کنید. این امتیاز در هنگام دریافت مقاله شما توسط کاربران از آن ها کسر و به امتیازات شما اضافه می شود. جهت کسب اطلاعات بیشتر در مورد امتیازات <a href="/?system=gnr&module=help&hid=4">به این بخش</a> مراجعه کنید.</li>
  <li>در پایان گزینه ارسال را در پایین صفحه فشار دهید. تا پایان عملیات انتقال فایل صبر کنید. در صورتی که مقاله به طور کامل ارسال شود، می توانید با استفاده از لینک به نمایش در آمده یک مقاله دیگر نیز ارسال کنید.<br />
  </li>
</ol>
            </asp:View>
            <asp:View ID="vw12" runat="server">
                راهنمای مدیریت مقالات ارسال شده
            </asp:View>
            <asp:View ID="vw13" runat="server">
                راهنمای دریافت مقاله
            </asp:View>
            <asp:View ID="vw14" runat="server">
                راهنمای ارسال مقاله
            </asp:View>
        </asp:MultiView>
    </asp:View>
    <asp:View ID="vw2" runat="server" onactivate="vw2_Activate">
        <asp:MultiView ID="mvw21" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwDef21" runat="server">
                راهنمای بخش اخبار<br />
            </asp:View>
            <asp:View ID="vw21" runat="server">
            </asp:View>
            <asp:View ID="vw22" runat="server">
            </asp:View>
            <asp:View ID="vw23" runat="server">
            </asp:View>
        </asp:MultiView>
    </asp:View>
    <asp:View ID="vw3" runat="server" onactivate="vw3_Activate">
        <asp:MultiView ID="mvw31" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwDef31" runat="server">
                راهنمای ثبت نام در سایت
            </asp:View>
            <asp:View ID="vw31" runat="server">
            </asp:View>
            <asp:View ID="vw32" runat="server">
            </asp:View>
            <asp:View ID="vw33" runat="server">
            </asp:View>
        </asp:MultiView>
    </asp:View>
    <asp:View ID="vw4" runat="server" onactivate="vw4_Activate">
        <asp:MultiView ID="mvw41" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwDef41" runat="server">
                راهنمای بخش امتیازات
            </asp:View>
            <asp:View ID="vw41" runat="server">
            </asp:View>
            <asp:View ID="vw42" runat="server">
            </asp:View>
            <asp:View ID="vw43" runat="server">
            </asp:View>
        </asp:MultiView>
    </asp:View>
    <asp:View ID="vw5" runat="server" onactivate="vw5_Activate">
        <b>راهنمای تبلیغات در سایت<br />
        </b>تبلیغات در یکی از تخصصی ترین وبسایت های مدیریت با حد اقل قیمت ماهانه در 
        اختیار شماست. با ماهی <span class="style1">250000 ریال </span>در صفحه اول دیده 
        شوید.<br />
        جهت سفارش تبلیغات می توانید با شماره تلفن 09374471773 آقای <b>بهمن موذن</b> تماس 
        گرفته و تبلیغ خود را در انواع فرمت های متنی، تصویری و پویا نمایی سفارش دهید.
    </asp:View>
</asp:MultiView>


