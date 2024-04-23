<%@ Control Language="C#" ClassName="frmLoader" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.Title = "تعامل :: " + Page.Title;
        string module = null;
        if (Request.QueryString["module"] != null)
        {
            module = Request.QueryString["module"];
            switch (module)
            {
               
                case "chat":
                    plc.Controls.Add(Page.LoadControl("frm/ChatRoom.ascx"));
                    break;
                case "forum":
                    plc.Controls.Add(Page.LoadControl("frm/Forum.ascx"));
                    break;
                case "show-topic":
                    plc.Controls.Add(Page.LoadControl("frm/ForumTopicList.ascx"));
                    break;
                case "show-statement":
                    plc.Controls.Add(Page.LoadControl("frm/ForumStatementList.ascx"));
                    break;
                case "forum-rep":
                    plc.Controls.Add(Page.LoadControl("frm/ForumRep.ascx"));
                    break;
                case "manage":
                    plc.Controls.Add(Page.LoadControl("frm/ForumManagement.ascx"));
                    break;
                //default:
                //    plc.Controls.Add(Page.LoadControl("usr/ChangeUser.ascx"));
                //    break;
            }
        }
        
    }
</script>

<asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>
