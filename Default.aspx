<%@ Page Language="C#" EnableEventValidation="false" ValidateRequest="false" EnableSessionState="True" Buffer="false" %>

<%@ Register Src="gnr/right_banner.ascx" TagName="right_banner" TagPrefix="uc1" %>
<%@ Register Src="gnr/Copyright.ascx" TagName="Copyright" TagPrefix="uc3" %>
<%@ Register Src="gnr/VerseShower.ascx" TagName="VerseShower" TagPrefix="uc4" %>
<%@ Register Src="gnr/TopInfo.ascx" TagName="TopInfo" TagPrefix="uc5" %>
<%@ Register Src="nws/stickyNews.ascx" TagName="stickyNews" TagPrefix="uc2" %>
<%@ Register src="gnr/persianDateBinder.ascx" tagname="persianDateBinder" tagprefix="uc6" %>
<%@ Register src="usr/PersonnelPicBinder.ascx" tagname="PersonnelPicBinder" tagprefix="uc1" %>
<%@ Register src="gnr/FirstTop.ascx" tagname="FirstTop" tagprefix="uc7" %>
<%@ Register src="gnr/Print.ascx" tagname="Print" tagprefix="uc8" %>
<%@ Register src="gnr/today.ascx" tagname="today" tagprefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server" enableviewstate="True">
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = Resources.Resource.txtSiteTitle;
        
        
        if (Session["user"] != null)
        {

            Application.Lock();
            AB.user = new AB.UserInfo();
            AB.user = (AB.UserInfo)Session["user"];
            
            if (!AB.user.IsValid())
            {
                AB.user = null;
                ArrayList onLineUsers = (ArrayList)Application["on-lines"];
                onLineUsers.Remove((AB.UserInfo)Session["user"]);
                Application["on-lines"] = onLineUsers;
                Session["user"] = null;
            }


            Application.UnLock();


        }
        else
        {
            AB.user = null;
        }



        if (Request.QueryString["system"] != null)
        {
            string system = Request.QueryString["system"];
            switch (system)
            {
                case "usr":
                    plc.Controls.Add(Page.LoadControl("usr/usrLoader.ascx"));
                    break;
                case "off":
                    plc.Controls.Add(Page.LoadControl("off/offLoader.ascx"));
                    break;
                case "nws":
                    plc.Controls.Add(Page.LoadControl("nws/nwsLoader.ascx"));
                    break;
                
                case "gnr":
                    plc.Controls.Add(Page.LoadControl("gnr/gnrLoader.ascx"));
                    break;
                case "sys":
                    plc.Controls.Add(Page.LoadControl("sys/sysLoader.ascx"));
                    break;
                case "frm":
                    plc.Controls.Add(Page.LoadControl("frm/frmLoader.ascx"));
                    break;
                case "lin":
                    plc.Controls.Add(Page.LoadControl("lin/linLoader.ascx"));
                    break;
                case "vsl":
                    plc.Controls.Add(Page.LoadControl("vsl/vslLoader.ascx"));
                    break;
                default:
                    plc.Controls.Add(Page.LoadControl("gnr/FirstPage.ascx"));
                    break;

            }

        }
        else
        {
            plc.Controls.Add(Page.LoadControl("gnr/FirstPage.ascx"));
        }

    }

    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="pageHead">

    <link rel="shortcut icon" href="/favicon.ico" />
    
    <link href="NooriStyle.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="gnr/globalJS.js">
    </script>

    <style type="text/css">
        .style4
        {
            width: 522px;
            height: 102px;
        }
    </style>

</head>
<body>
    <form method="post" id="mainForm" runat="server" enctype="multipart/form-data">
  <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>  




<table width="1060" height="857" border="0" cellpadding="0" cellspacing="0" 
        align="center">
	<tr valign="top">
		<td colspan="5" runat="server" id="td1">
			<img src="images/Noori/noori_01.gif" width="1059" height="8" 
                alt=""></td>
		<td runat="server" id="td2">
			<img src="images/Noori/spacer.gif" width="1" height="8" alt=""></td>
	</tr>
	<tr valign="top" >
		<td rowspan="5" class="MainTableLeftTop" runat="server" id="td3">
			<img src="images/Noori/noori_02.gif" width="94" height="436" 
                alt=""></td>
		<td rowspan="2" runat="server" id="td4">
			<img class="style4" src="images/Noori/logo.gif" /></td>
		<td colspan="3" runat="server" id="td5">
			<img src="images/Noori/noori_04.gif" width="443" height="30" 
                alt=""></td>
		<td runat="server" id="td6">
			<img src="images/Noori/spacer.gif" width="1" height="30" alt=""></td>
	</tr>
	<tr valign="top" >
		<td rowspan="2" runat="server" id="td7">
			<img src="images/Noori/noori_05.gif" width="45" height="79" alt=""></td>
		<td runat="server" id="td8">
			<img src="images/Noori/noori_06.gif" width="297" height="72" 
                alt=""></td>
		<td rowspan="4" class="MainTableRightTop" runat="server" id="td9">
			<img src="images/Noori/noori_07.gif" width="101" height="406" 
                alt=""></td>
		<td runat="server" id="td10">
			<img src="images/Noori/spacer.gif" width="1" height="72" alt=""></td>
	</tr>
	<tr>
		<td runat="server" id="td11">
			<img src="images/Noori/noori_08.gif" width="522" height="7" alt=""></td>
		<td runat="server" id="td12">
			<img src="images/Noori/noori_09.gif" width="297" height="7" alt=""></td>
		<td runat="server" id="td13">
			<img src="images/Noori/spacer.gif" width="1" height="7" alt=""></td>
	</tr>
	<tr valign="top">
		<td colspan="3" class="MaincellTop" >
			<table cellpadding="0" cellspacing="0" width="100%" dir="rtl">
                <tr>
                    <td runat="server" id="td15">
                            <uc5:TopInfo ID="TopInfo1" runat="server" />
                        </td>
                    <td align="left" runat="server" id="av3" > 
                        <uc9:today ID="today1" runat="server" />
                       
                           
                    <uc8:Print ID="Print1" runat="server" />
                           
                    </td>
                </tr>
            </table>
        </td>
		<td runat="server" id="td16">
			<img src="images/Noori/spacer.gif" width="1" height="38" alt=""></td>
	</tr>
	<tr valign="top">
		<td colspan="3" rowspan="2" class="MainCell" valign="top" >
        <uc7:FirstTop ID="FirstTop1" runat="server" />
        <table cellpadding="0" cellspacing="0" width="100%" >
            <tbody valign="top">
            <tr>
                <td  runat="server" id="td18" width="200">
                            <uc1:PersonnelPicBinder ID="PersonnelPicBinder1" runat="server" />
                            <br />
                            <uc1:right_banner ID="right_banner" runat="server" />
                        </td>
                <td runat="server" id="av2">
                                              
                           
                            <asp:PlaceHolder ID="plc" runat="server"></asp:PlaceHolder>
                        </td>
            </tr>
        </table>
        </td>
		<td runat="server" id="td19">
			<img src="images/Noori/spacer.gif" width="1" height="289" alt=""></td>
	</tr>
	<tr valign="top">
		<td class="MainTableLeft" runat="server" id="td20">
			<img src="images/Noori/noori_12.gif" width="94" height="353" 
                alt=""></td>
		<td class="MainTableRight" runat="server" id="td21">
			<img src="images/Noori/noori_13.gif" width="101" height="353" 
                alt=""></td>
		<td runat="server" id="td17">
			<img src="images/Noori/spacer.gif" width="1" height="353" alt=""></td>
	</tr>
	<tr valign="top"  >
		<td colspan="5" class="MainTableButtom" runat="server" id="av1">
    <uc3:Copyright ID="Copyright" runat="server" />
    





        </td>
		<td runat="server" id="td14">
			<img src="images/Noori/spacer.gif" width="1" height="60" alt="" /></td>
	</tr>
</table>

    </form>
</body>
</html>
