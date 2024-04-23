<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    private void WriteInDocument(string iString)
    {
        Response.Write("document.write('"+iString+"');\n");
    }
    private void Alert(string iString)
    {
        Response.Write("<script type=\"text/javascript\" language=\"javascript\">\nalert('"+iString+"')\n<"+"/script>");
    }
    private string appPath = "http://www.divansalar.com/adver/a.aspx";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["module"] == null)
        {
            string campid="3";
            if (Request.QueryString["campid"] != null)
            {
                campid = Request.QueryString["campid"].ToString();
            }
            string width,height;
            width=height=String.Empty;
            AB.Advertisment.GetDimantion(campid,ref width,ref height);
            
            //Response.Write("<script type=\"text/javascript\">\n");
            Response.Write("var host = document.location;\n");
            Response.Write("var title=document.title;\n");
            Response.Write("var rnd = Math.round(Math.random() * 100000);\n");
            Response.Write("var url = \""+appPath+"?module=show&campid=\"+"+campid+"+\"&host=\" + escape(host) + \"&title=\" + escape(title) + \"&rnd=\" + rnd;\n");
            //Response.Write("window.frames.divanAd.location.href = url;\n");
            WriteInDocument("<iframe src=\"'+url+'\" id=\"divanAd\" name=\"divanAd\" height=\""+height+"\"  width=\""+width+"\" frameborder=\"0\" allowtransparency=\"true\" hspace=\"0\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" vspace=\"0\"></iframe>");
            //Response.Write("<"+"/script>");
            
            
        }
        else
        {
            switch (Request.QueryString["module"].ToString())
            {
                case "show":
                    string page = "<html><head><style type=\"text/css\">";
                    page += "body {font-family: Tahoma; background-color: transparent; font-size: 12px; direction:rtl;}";
                    page += "<" + "/style></head><body>";
                    DataTable tbl= AB.Advertisment.LoadAdver(Request.QueryString["campid"].ToString(), Request.QueryString["host"].ToString(), Request.QueryString["title"].ToString());
                    foreach (DataRow r in tbl.Rows)
                    {
                        
                        page += r["code"].ToString().Replace("$ptitle$", Server.UrlEncode(Request.QueryString["title"].ToString())).Replace("$url$", Server.UrlEncode(Request.QueryString["host"].ToString()));
                        
                    }
                    page += "<" + "/body></html>";
                    Response.Write(page);
                    break;
                case "goto":
                    if (Request.QueryString["title"] != null && Request.QueryString["host"] != null)
                    {
                        AB.Advertisment.RegisterAdver(Request.QueryString["adverid"].ToString(), Request.QueryString["host"].ToString(), Request.QueryString["title"].ToString());
                    }
                    Response.Redirect(Request.QueryString["location"].ToString());
                    break;
            }
        }
    }
</script>

