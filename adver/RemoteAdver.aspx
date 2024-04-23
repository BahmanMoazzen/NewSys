<%@ Page Language="C#" %>

<script runat="server">
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Request.QueryString["goto"] != null)
    //    {
    //        AB.Advertisment.AddRemote(Server.UrlDecode(Request.QueryString["host"]), Server.UrlDecode(Request.QueryString["goto"]), Request.QueryString["ref"]);
    //        Response.Redirect(Request.QueryString["goto"]);

    //    }
    //    else
    //    {
    //        byte startCode = 1;
    //        byte endCode = 3;
    //        string[] gotoUrl = { "http://shop.moazzen.net", "http://www.divansalar.com/", "http://www.divansalar.com/?system=nws&module=show&nws_id=19" };
    //        string[] imagePath = { "http://www.divansalar.com/images/adver/shop.jpg", "http://www.divansalar.com/images/adver/modir.jpg", "http://www.divansalar.com/images/adver/modir_weblog.jpg" };
    //        Random rnd = new Random();
    //        int adverCode = 0;
    //        if (Cache["adver_code"] != null)
    //        {

    //            adverCode = int.Parse(Cache["adver_code"].ToString());
    //        }

    //        int newCode = rnd.Next(startCode, endCode);



    //        while (adverCode == newCode)
    //        {
    //            newCode = rnd.Next(startCode, endCode);
    //        }

    //        adverCode = newCode;
    //        Cache["adver_code"] = newCode;


    //        string code = "<a href=\"http://www.divansalar.com/?system=adver&module=remote&host=" + Server.UrlEncode(Request.QueryString["host"]) + "&goto=" + Server.UrlEncode(gotoUrl[adverCode]) + "&ref=" + adverCode.ToString() + "&rnd=" + rnd.Next(0, 99999) + "\" target=\"_blank\"><img  src=\"" + imagePath[adverCode] + "\" width=\"130\" height=\"170\" border=\"0\"  />";
    //        Response.Write(code);
    //        AB.Advertisment.AddRemote(Request.QueryString["host"], 1);
    //    }
    //}
</script>

<asp:hyperlink runat="server" NavigateUrl="http://www.moazzen.net" 
    Target="_blank">سایت رسمی بهمن موذن</asp:hyperlink>
