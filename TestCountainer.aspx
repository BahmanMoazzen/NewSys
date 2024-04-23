<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>

<%@ Register src="gnr/persianDatePicker.ascx" tagname="persianDatePicker" tagprefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            gvw.DataSource = AB.Convert.loadGardesh;
            gvw.DataBind();
        }
        
        
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        foreach (GridViewRow r in gvw.Rows)
        {
           // AB.Convert.UpdateGardesh(((Label)r.FindControl("Label1")).Text, ((Label)r.FindControl("Label2")).Text, ((Label)r.FindControl("Label3")).Text, ((persianDatePicker)r.FindControl("persianDatePicker1")).GeorgianDate.ToString());
            string sqlt = String.Format("INSERT INTO [dbo].[tblPersonnelsBranches]   ([PID],[BID],[POID],[StartDay],[updater],[updateDate],[desc],[transfereType] ,[BCID]) VALUES   ({0},{1},{2},'{3}',155820,getdate(),'Convert',1,null)<br>", ((Label)r.FindControl("Label1")).Text, ((Label)r.FindControl("Label2")).Text, ((Label)r.FindControl("Label3")).Text, ((persianDatePicker)r.FindControl("persianDatePicker1")).GeorgianDate.ToString());
            Response.Write(sqlt);
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="gnr/jquery.ptTimeSelect.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="gnr/jquery-1.9.1.js"></script>
<script language="javascript" type="text/javascript" src="gnr/jquery.ptTimeSelect.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click1" 
        Text="Button" />
    
        <asp:GridView ID="gvw" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("pid") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("bid") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("poid") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <uc2:persianDatePicker Text='<%# Eval("startday") %>' ID="persianDatePicker1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="pname" />
            </Columns>
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
