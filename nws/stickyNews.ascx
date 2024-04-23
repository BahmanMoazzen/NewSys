<%@ Control Language="C#" ClassName="stickyNews" %>



<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        
        //dtlStickyNews.DataSource = AB.News.StickyNews;
        //dtlStickyNews.DataBind();
        rptNews.DataSource=AB.News.StickyNews;
        rptNews.DataBind();
        
    }
</script>
<marquee width="100%" direction="right" behavior="scroll" id="marq" loop="-1" onmouseout="this.start()" onmouseover="this.stop()" scrolldelay="10" scrollamount="2">
<asp:Repeater ID="rptNews" runat="server">
<ItemTemplate><asp:HyperLink ID="hplSticky" Text='<%# Eval("nws_title")%>' NavigateUrl='<%# "/?system=nws&module=show&nws_id="+Eval("nws_id") %>' runat="server"></asp:HyperLink></ItemTemplate>
<SeparatorTemplate> <b> * </b> </SeparatorTemplate>
</asp:Repeater>
</marquee>
