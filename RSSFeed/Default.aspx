<%@ Page Language="C#" ValidateRequest="false" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.ServiceModel.Syndication" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.IO" %>


<script runat="server">
    
    public class DbTools
    {
        
        protected static string SQLConnectionStringTemplate
        {
            get
            {
                return "server={0};uid={2};pwd={3};database={1}";
            }
        }
        public static string MakeConnectionString(string iServerName, string iDBName, string iUsername, string iPWD)
        {
            return String.Format(SQLConnectionStringTemplate, iServerName, iDBName, iUsername, iPWD);
        }
        public static ArrayList CommandToArrayList(string command, string connection)
        {
            SqlConnection sqlcon = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(command, sqlcon);
            sqlcon.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            ArrayList ans = new ArrayList();
            do
            {
                DataTable tbl = new DataTable("res");
                for (int i = 0; i < sdr.FieldCount; i++)
                {
                    tbl.Columns.Add(sdr.GetName(i));
                }
                while (sdr.Read())
                {
                    DataRow r = tbl.NewRow();
                    for (int i = 0; i < sdr.FieldCount; i++)
                    {
                        r[i] = sdr[i];
                    }
                    tbl.Rows.Add(r);
                }
                ans.Add(tbl);
            } while (sdr.NextResult());
            sqlcon.Close();

            return ans;

        }
       
        public static object ExecuteScalar(string query, string conString)
        {
            SqlConnection sqlcon = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand(query, sqlcon);
            sqlcon.Open();
            Object r = cmd.ExecuteScalar();
            sqlcon.Close();
            return r;
        }
        
        public static DataTable QueryToTable(string query, string conString)
        {
            SqlConnection sqlcon = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand(query, sqlcon);
            sqlcon.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable tbl = new DataTable("result");
            for (int i = 0; i < sdr.FieldCount; i++)
            {
                tbl.Columns.Add(sdr.GetName(i));
            }
            while (sdr.Read())
            {
                DataRow r = tbl.NewRow();
                for (int i = 0; i < sdr.FieldCount; i++)
                {
                    r[i] = sdr[i];
                }
                tbl.Rows.Add(r);
            }
            sqlcon.Close();
            return tbl;
        }
        
        public static string QueryToString(string query, string conString)
        {
            SqlConnection sqlcon = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand(query, sqlcon);
            sqlcon.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();
            string str = sdr[0].ToString();
            sqlcon.Close();
            return str;
        }
        
        public static bool TestConnection(string iServerName, string iDBName, string iUsername, string iPWD)
        {
            bool isOK = true;
            string conString = MakeConnectionString(iServerName, iDBName, iUsername, iPWD);
            SqlConnection sqlcon = new SqlConnection(conString);
            try
            {
                sqlcon.Open();
            }
            catch { isOK = false; }
            finally
            {
                sqlcon.Close();
                sqlcon = null;
            }
            return isOK;
        }
        public static bool TestConnection(string iConnectionString)
        {
            bool isOK = true;
            
            SqlConnection sqlcon = new SqlConnection(iConnectionString);
            try
            {
                sqlcon.Open();
            }
            catch { isOK = false; }
            finally
            {
                sqlcon.Close();
                sqlcon = null;
            }
            return isOK;
        }
        public static DataTable OleDbQueryToTable(string query, string conString)
        {
            OleDbConnection sqlcon = new OleDbConnection(conString);
            OleDbCommand cmd = new OleDbCommand(query, sqlcon);
            sqlcon.Open();
            OleDbDataReader sdr = cmd.ExecuteReader();
            DataTable tbl = new DataTable("result");
            for (int i = 0; i < sdr.FieldCount; i++)
            {
                tbl.Columns.Add(sdr.GetName(i));
            }
            while (sdr.Read())
            {
                DataRow r = tbl.NewRow();
                for (int i = 0; i < sdr.FieldCount; i++)
                {
                    r[i] = sdr[i];
                }
                tbl.Rows.Add(r);
            }
            sqlcon.Close();
            return tbl;
        }
       
        
        public static object OleDbExecuteScalar(string query, string conString)
        {
            OleDbConnection sqlcon = new OleDbConnection(conString);
            OleDbCommand cmd = new OleDbCommand(query, sqlcon);
            sqlcon.Open();
            Object r = cmd.ExecuteScalar();
            sqlcon.Close();
            return r;
        }
        

    }

    public static class Constances
    {
        public static string SQLConnectionFileName = "sql.ini";
        public static string DatabaseFileName = "db.ini";
        public static string FeedFileName = "feed.ini";
        public static string FeedSeprator = "$$$";
        public static string ItemSelectQuery = "select top {0} {1} as item_title ,{2} as item_description,N'{3}'+CAST ({4} as nvarchar) as item_link,{5} as item_pub_date,{6} as item_image_url,{7} as item_guid from {8} order by item_pub_date desc";
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (File.Exists(Server.MapPath( Constances.SQLConnectionFileName)))
        {
            if (File.Exists(Server.MapPath(  Constances.FeedFileName)))
            {
                if (File.Exists(Server.MapPath( Constances.DatabaseFileName)))
                {
                    mvwMain.SetActiveView(vwXML);
                }
                else
                {
                    mvwMain.SetActiveView(vwAdmin);
                    mvwAdmin.SetActiveView(vwItems);
                }
                
            }
            else
            {
                mvwMain.SetActiveView(vwAdmin);
                mvwAdmin.SetActiveView(vwFeed);
            }
        }
        else
        {
            mvwMain.SetActiveView(vwAdmin);
            mvwAdmin.SetActiveView(vwConnection);
        }
    }

    protected void btnTestConnection_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath( Constances.SQLConnectionFileName));
            sw.Write(DbTools.MakeConnectionString(txtServerName.Text, txtDBName.Text, txtUsername.Text, txtPWD.Text));
            sw.Close();
            mvwAdmin.SetActiveView(vwFeed);
        }
    }

    protected void btnSaveItems_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string str = ddlDatabaseTables.SelectedValue;
            str += Constances.FeedSeprator;
            str += ddlTitleColumn.SelectedValue;
            
            str += Constances.FeedSeprator;
            str += ddlDescriptionColumn.SelectedValue;
            str += Constances.FeedSeprator;
            str += txtFeedLinkFormat.Text;
            
            str += Constances.FeedSeprator;
            str += ddlLinkColumn.SelectedValue;
            
            str += Constances.FeedSeprator;
            str += ddlPublishedDateColumn.SelectedValue;
            
            str += Constances.FeedSeprator;
            str += ddlImageUrlColumn.SelectedValue;
            
            str += Constances.FeedSeprator;
            str += ddlGuidColumn.SelectedValue;
            StreamWriter sw = new StreamWriter(Server.MapPath(Constances.DatabaseFileName));
            sw.WriteLine(str);
            sw.Close();
            mvwAdmin.SetActiveView(vwDone);
        }
        
    }

    protected void btnSavefeed_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string str = txtFeedTitle.Text;
            str += Constances.FeedSeprator;
            str +=txtFeedDescription.Text.Replace(Environment.NewLine,"<br/>");
            str += Constances.FeedSeprator;
            str +=txtCopyright.Text;
            str += Constances.FeedSeprator;
            str +=ddlLanguage.SelectedValue;
            str += Constances.FeedSeprator;
            str +=ddlFeedType.SelectedValue;
            str += Constances.FeedSeprator;
            str +=ddlFeedPerSheet.SelectedValue;
            str += Constances.FeedSeprator;
            str += txtFeedLink.Text;
            
            StreamWriter sw = new StreamWriter(Server.MapPath(Constances.FeedFileName));
            sw.WriteLine(str);
            sw.Close();
            mvwAdmin.SetActiveView(vwItems);
        }
    }

    protected void cvConnection_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (DbTools.TestConnection(txtServerName.Text, txtDBName.Text, txtUsername.Text, txtPWD.Text))
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected string loadConnectionString()
    {
        StreamReader sr = new StreamReader(Server.MapPath( Constances.SQLConnectionFileName));
        string str = sr.ReadLine();
        sr.Close();
        return str;
        
    }
    
    
    protected void vwItems_Activate(object sender, EventArgs e)
    {
        bool loaded = bool.Parse(hidLoaded.Value);   
        if (!loaded)
        {
           
            ddlDatabaseTables.DataSource = DbTools.QueryToTable(@"select TABLE_SCHEMA+'.'+TABLE_NAME as table_full_id,TABLE_TYPE+':'+TABLE_SCHEMA+'.'+TABLE_NAME as table_full_name from INFORMATION_SCHEMA.TABLES order by TABLE_TYPE,TABLE_NAME", loadConnectionString());
            ddlDatabaseTables.DataValueField = "table_full_id";
            ddlDatabaseTables.DataTextField =  "table_full_name";
            ddlDatabaseTables.DataBind();
            

            hidLoaded.Value = "true";
        }
        
        
        
    }


    protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
    {

        ddlDescriptionColumn.DataSource = ddlGuidColumn.DataSource = ddlImageUrlColumn.DataSource = ddlLinkColumn.DataSource = ddlPublishedDateColumn.DataSource = ddlTitleColumn.DataSource = DbTools.QueryToTable("SELECT c.COLUMN_NAME+':'+c.DATA_TYPE as column_full_name,c.COLUMN_NAME as column_full_id FROM information_schema.tables t inner join INFORMATION_SCHEMA.COLUMNS c on t.TABLE_NAME=c.TABLE_NAME where t.TABLE_SCHEMA+'.'+t.TABLE_NAME='"+ddlDatabaseTables.SelectedValue+"' order by c.COLUMN_NAME",loadConnectionString());
        ddlDescriptionColumn.DataTextField = ddlGuidColumn.DataTextField = ddlImageUrlColumn.DataTextField = ddlLinkColumn.DataTextField = ddlPublishedDateColumn.DataTextField = ddlTitleColumn.DataTextField = "column_full_name";
        ddlTitleColumn.DataValueField = ddlPublishedDateColumn.DataValueField = ddlLinkColumn.DataValueField = ddlImageUrlColumn.DataValueField = ddlGuidColumn.DataValueField = ddlDescriptionColumn.DataValueField = "column_full_id";
        ddlDescriptionColumn.DataBind();
        ddlGuidColumn.DataBind();
        ddlImageUrlColumn.DataBind();
        ddlLinkColumn.DataBind();
        ddlPublishedDateColumn.DataBind();
        ddlTitleColumn.DataBind();
    }

    private string GetFullyQualifiedUrl(string url)
    {
        return string.Concat(Request.Url.GetLeftPart(UriPartial.Authority), ResolveUrl(url));
    }
    
    protected void vwXML_Activate(object sender, EventArgs e)
    {
        string feedType;
        int feedCount = 0;
        
        string[] sep = {Constances.FeedSeprator};
        StreamReader sr = new StreamReader(Server.MapPath(Constances.FeedFileName));
        string[] feedValues = sr.ReadLine().Split(sep,StringSplitOptions.None);
        sr.Close();        
        
        // Create the feed and specify the feed's attributes
        SyndicationFeed myFeed = new SyndicationFeed();
        myFeed.Title = TextSyndicationContent.CreatePlaintextContent(feedValues[0]);
        myFeed.Description = TextSyndicationContent.CreatePlaintextContent(feedValues[1]);
        myFeed.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(feedValues[6])));
        myFeed.Copyright = TextSyndicationContent.CreatePlaintextContent(feedValues[2]);
        myFeed.Language = feedValues[3];
        feedType = feedValues[4];
        feedCount = int.Parse(feedValues[5]);
        // Creat and populate a list of SyndicationItems
        List<SyndicationItem> feedItems = new List<SyndicationItem>();
        sr = new StreamReader(Server.MapPath(Constances.DatabaseFileName));
        string[] dbValues = sr.ReadLine().Split(sep, StringSplitOptions.None);
        sr.Close();
        
        string sqlt = String.Format(Constances.ItemSelectQuery,feedCount,dbValues[1],dbValues[2],dbValues[3],dbValues[4],dbValues[5],dbValues[6],dbValues[7],dbValues[0]);
        DataTable tbl = DbTools.QueryToTable(sqlt, loadConnectionString());
        SyndicationItem item;
        foreach(DataRow r in tbl.Rows)
        {
            item = new SyndicationItem();
            item.Title = TextSyndicationContent.CreatePlaintextContent(r["item_title"].ToString());
            item.Links.Add(SyndicationLink.CreateAlternateLink(new Uri(r["item_link"].ToString())));
            item.Summary = TextSyndicationContent.CreatePlaintextContent(r["item_description"].ToString());
            
            item.PublishDate = DateTime.Parse(r["item_pub_date"].ToString());
            
            item.Id = r["item_guid"].ToString();
            item.AttributeExtensions.Add(new XmlQualifiedName("image"), r["item_image_url"].ToString());
            feedItems.Add(item);
        }
        myFeed.Items = feedItems;

        XmlWriterSettings outputSettings = new XmlWriterSettings();
        outputSettings.Indent = true; //(Uncomment for readability during testing)
        XmlWriter feedWriter = XmlWriter.Create(Response.OutputStream, outputSettings);

        if (feedType.ToLower().Equals("atom"))
        {
            Response.ContentType = "application/atom+xml";
            Atom10FeedFormatter atomFormatter = new Atom10FeedFormatter(myFeed);
            atomFormatter.WriteTo(feedWriter);
        }
        else
        {
            Response.ContentType = "application/rss+xml";
            Rss20FeedFormatter rssFormatter = new Rss20FeedFormatter(myFeed);
            rssFormatter.WriteTo(feedWriter);
        }
        
        
        
        feedWriter.Close();
    }
</script>


    <asp:MultiView ID="mvwMain" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwAdmin" runat="server">
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            height: 29px;
        }
    </style>
</head>
<body>
    <form id="frmMain" runat="server">


            <asp:MultiView ID="mvwAdmin" runat="server" ActiveViewIndex="0">
                <asp:View ID="vwConnection" runat="server">
                    <asp:Label ID="Label1" runat="server" Text="Connection String Configuration"></asp:Label>
                        <br />
                        <asp:HiddenField ID="hidLoaded" runat="server" Value="false" />
                    <br />
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Server Name:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtServerName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text="Database Name:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDBName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text="User Name:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Password:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPWD" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CustomValidator ID="cvConnection" runat="server" 
                                    ErrorMessage="Invalid Parameter(s)!" ForeColor="Red" 
                                    onservervalidate="cvConnection_ServerValidate" ValidationGroup="Connection"></asp:CustomValidator>
                            </td>
                            <td>
                                <asp:Button ID="btnSaveConnection" runat="server" 
                                    onclick="btnTestConnection_Click" Text="Save &amp; Continue" 
                                    ValidationGroup="Connection" />
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwFeed" runat="server">
                    <asp:Label ID="Label21" runat="server" Text="Feed Properties"></asp:Label>
                    <br />
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label22" runat="server" Text="Feed Title:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFeedTitle" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                    ErrorMessage="Please Provide Feed Title!" ForeColor="Red" 
                                    ControlToValidate="txtFeedTitle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Label ID="Label23" runat="server" Text="Feed Description:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFeedDescription" runat="server" Rows="5" 
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                            <td valign="top">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                                    ErrorMessage="Please Provide Feed Description!" ForeColor="Red" 
                                    ControlToValidate="txtFeedDescription"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <asp:Label ID="Label14" runat="server" Text="Link:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFeedLink" runat="server">http://</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ErrorMessage="Please Provide Link Information!" ForeColor="Red" 
                                    ControlToValidate="txtCopyright"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label24" runat="server" Text="Copyright:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCopyright" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                                    ErrorMessage="Please Provide Copyright Information!" ForeColor="Red" 
                                    ControlToValidate="txtCopyright"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label25" runat="server" Text="Feed Language:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLanguage" runat="server">
                                    <asp:ListItem Value="en">English</asp:ListItem>
                                    <asp:ListItem Value="fa">Persian</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label26" runat="server" Text="Feed Type:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFeedType" runat="server">
                                    <asp:ListItem>RSS</asp:ListItem>
                                    <asp:ListItem>Atom</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style1">
                                <asp:Label ID="Label27" runat="server" Text="Feed Per Sheet:"></asp:Label>
                            </td>
                            <td class="style1">
                                <asp:DropDownList ID="ddlFeedPerSheet" runat="server">
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>15</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="style1">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnSavefeed" runat="server" Text="Save &amp; Continue" 
                                    onclick="btnSavefeed_Click" />
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vwItems" runat="server" onactivate="vwItems_Activate" >
                    
                            <asp:Label ID="Label6" runat="server" 
                                Text="Select Feed Parts From Your Database"></asp:Label>
                        <br />
                            <table>
                                
                                <tr>
                                    <td>
                                        <asp:Label ID="Label28" runat="server" Text="Choos Table:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDatabaseTables" runat="server" 
                                            onselectedindexchanged="ddl_SelectedIndexChanged" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="Title:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTitleColumn" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="ddlTitleColumn" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text="Description:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDescriptionColumn" runat="server" ToolTip="test">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="ddlDescriptionColumn" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Link:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFeedLinkFormat" runat="server" Columns="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                                            ControlToValidate="txtFeedLinkFormat" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLinkColumn" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                                            ControlToValidate="ddlLinkColumn" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label11" runat="server" Text="Published Date:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPublishedDateColumn" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                            ControlToValidate="ddlPublishedDateColumn" ErrorMessage="*" 
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text="Image Url:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlImageUrlColumn" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                            ControlToValidate="ddlImageUrlColumn" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label12" runat="server" Text="Guid:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlGuidColumn" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                            ControlToValidate="ddlGuidColumn" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td colspan="2">
                                        <asp:Button ID="btnSaveItems" runat="server" onclick="btnSaveItems_Click" 
                                            Text="Save &amp; Finish!" />
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                            </table>
                        
                </asp:View>
                <asp:View ID="vwDone" runat="server">
                    <asp:Label ID="Label13" runat="server" 
                        
                        Text="All The Settings Has Been Saved Successfully. Please Refresh This Page."></asp:Label>
                </asp:View>
            </asp:MultiView>
           </form>
</body>
</html>
        </asp:View>
        <asp:View ID="vwXML" runat="server" OnActivate="vwXML_Activate">
        </asp:View>
    </asp:MultiView>
     
