<%@ Control Language="C#" ClassName="Ghesar" %>

<%@ Register src="VerseShower.ascx" tagname="VerseShower" tagprefix="uc4" %>

<script runat="server">

</script>
<table width="855" height="52" border="0" cellpadding="0" cellspacing="0" 
    align="center" dir="rtl">
	<tr>
		<td colspan="3">
			<img src="images/Noori/ghesar_01.gif" width="855" height="15" 
                alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="images/Noori/ghesar_04.gif" width="125" height="37" 
                alt=""></td>
		<td align="center" dir="rtl" height="30">
        <uc4:VerseShower ID="VerseShower1" runat="server" VerseType="1" />
        </td>
		<td rowspan="2">
			<img src="images/Noori/ghesar_02.gif" width="10" height="37" 
                alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/Noori/ghesar_05.gif" width="720" height="7" 
                alt=""></td>
	</tr>
</table>

