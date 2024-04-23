<%@ Control Language="C#" ClassName="persianTextBox" %>

<script runat="server">

</script>
<script language="javascript" type="text/javascript">
    var mode, clik;
    mode = 1;
    clik = 1;
    function changelang() {
        if (mode == 1) {
            mode = 0;
            clik = 1;
            window.defaultStatus = "English Mode";
            document.langstat.src = "/images/lang/en.gif";

        }
        else {
            mode = 1;
            clik = 1;
            window.defaultStatus = "زبان فارسی";
            document.langstat.src = "/images/lang/fa.gif";
        }
    }
    function MyKeyDown() {
        var key;
        key = window.event.keyCode;
        if ((window.event.shiftKey && window.event.altKey) || (key = 113)) {
            changelang();
        }
    }
    function MyKeyPress() {
        var keyCode;
        keyCode = window.event.keyCode;
        if (keyCode <= 127) {
            if (mode == 1) {
                var key = String.fromCharCode(keyCode);
                switch (key) {
                    case "&": window.event.keyCode = 1548; break;
                    case "?": window.event.keyCode = 1567; break;
                    case "H": window.event.keyCode = 1570; break;
                    case "h": window.event.keyCode = 1575; break;
                    case "f", "F": window.event.keyCode = 1576; break;
                    case "\\": window.event.keyCode = 1662; break;
                    case "j", "J": window.event.keyCode = 1578; break;
                    case "e", "E": window.event.keyCode = 1579; break;
                    case "[": window.event.keyCode = 1580; break;
                    case "]": window.event.keyCode = 1670; break;
                    case "p", "P": window.event.keyCode = 1581; break;
                    case "o", "O": window.event.keyCode = 1582; break;
                    case "n", "N": window.event.keyCode = 1583; break;
                    case "b", "B": window.event.keyCode = 1584; break;
                    case "v", "V": window.event.keyCode = 1585; break;
                    case "c": window.event.keyCode = 1586; break;
                    case "C": window.event.keyCode = 1688; break;
                    case "s", "S": window.event.keyCode = 1587; break;
                    case "a", "A": window.event.keyCode = 1588; break;
                    case "w", "W": window.event.keyCode = 1589; break;
                    case "q", "Q": window.event.keyCode = 1590; break;
                    case "x", "X": window.event.keyCode = 1591; break;
                    case "z", "Z": window.event.keyCode = 1592; break;
                    case "u", "U": window.event.keyCode = 1593; break;
                    case "y", "Y": window.event.keyCode = 1594; break;
                    case "t", "T": window.event.keyCode = 1601; break;
                    case "r", "R": window.event.keyCode = 1602; break;
                    case ";": window.event.keyCode = 1603; break;
                    case "'": window.event.keyCode = 1711; break;
                    case "g", "G": window.event.keyCode = 1604; break;
                    case "l", "L": window.event.keyCode = 1605; break;
                    case "k", "K": window.event.keyCode = 1606; break;
                    case ",": window.event.keyCode = 1608; break;
                    case "i", "I": window.event.keyCode = 1607; break;
                    case "d": window.event.keyCode = 1740; break;
                    case "D": window.event.keyCode = 1609; break;
                    case "m", "M": window.event.keyCode = 1574; break;
                    case "?": window.event.keyCode = 1567; break;

                }

            }
        }
        window.event.returnValue = true;
    }
</script>


<table width="100" border="0" cellpadding="3" cellspacing="2">
    <tr>
        <td>
            <input id="txtMain" type="text" onkeypress="mykeypress(event)" onkeydown="mykeydown(event)"
                runat="server" name="txtMain" />
        </td>
        <td>
            <img src="/images/lang/fa.gif" name="langstat" width="16" height="16" border="1"
                id="langstat" onclick="changelang()">
        </td>
        <td nowrap class="changelangtext">
            تغيير زبان (F12)
        </td>
    </tr>
</table>
