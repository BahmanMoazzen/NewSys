using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class thousandSeprator : System.Web.UI.UserControl
{
    private string text;
    public string Text
    {
        get
        {
            return text;
        }
        set
        {
            text = value;
            lbl.Text = AB.General.ThousandSeprator(value);
        }
    }
    
}