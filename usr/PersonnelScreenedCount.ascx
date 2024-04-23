<%@ Control Language="C#" ClassName="PersonnelScreenedCount" %>
<%@ Import Namespace="System.Data" %>
<%@ Register src="chartDescription.ascx" tagname="chartdescription" tagprefix="uc5" %>
<%@ Register src="LoginSystem.ascx" tagname="loginsystem" tagprefix="uc3" %>
<%@ Register src="../gnr/progressPanelContent.ascx" tagname="progresspanelcontent" tagprefix="uc4" %>
<%@ Register src="branchUserControl.ascx" tagname="branchusercontrol" tagprefix="uc4" %>
<%@ Register src="../gnr/tableTitle.ascx" tagname="tabletitle" tagprefix="uc1" %>
<%@ Register src="personnelIDBinder.ascx" tagname="personnelidbinder" tagprefix="uc1" %>
<%@ Register src="countShower.ascx" tagname="countShower" tagprefix="uc2" %>
<%@ Register src="../gnr/persianDatePicker.ascx" tagname="persiandatepicker" tagprefix="uc5" %>
<%@ Register src="../gnr/branchesList.ascx" tagname="brancheslist" tagprefix="uc8" %>
<%@ Register src="../gnr/gradesDropDown.ascx" tagname="gradesDropDown" tagprefix="uc7" %>
<%@ Register src="transfereTypeDropDown.ascx" tagname="transfereTypeDropDown" tagprefix="uc14" %>
<%@ Register src="employmentTypeDropDown.ascx" tagname="employmentTypeDropDown" tagprefix="uc10" %>
<%@ Register src="../gnr/branchCirclesDropDown.ascx" tagname="branchCirclesDropDown" tagprefix="uc4" %>
<%@ Register src="../gnr/postsList.ascx" tagname="postsList" tagprefix="uc9" %>
<%@ Register src="../gnr/rolesDropDown.ascx" tagname="rolesDropDown" tagprefix="uc11" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "شمارش غربالي كاركنان :: " + Page.Title;
        LoginSystem1.CheckSecurity("1_29_", mvw, vwPage, vwLogin);

    }


    protected int columnCount = 0;
    protected void btnShow_Click(object sender, EventArgs e)
    {
        pnlTable.Visible = true;
        int count = 0;
        DataTable all = AB.User.ManagerialReport(pib.PID, ddlBranches.BID, ddlBranchCircles.BCID, ddlPosts.POID, ddlGrades.GradeID, pdpStart.StringDate, pdpEnd.StringDate, ddlEmploymentType.ETID, ddlSex.SelectedValue, ddlTransfereType.TTID,ddlRoles.RID, ref count);
        columnCount = all.Columns.Count;
        DataTable[,] screened = new DataTable[16, 8];
        for (int i = 0; i<16; i++)
        {
            for (int j = 0; j < 8; j++)
            {
                screened[i, j] = new DataTable("result");
                for (int k = 0; k < columnCount; k++)
                {

                    screened[i, j].Columns.Add(all.Columns[k].ColumnName);
                }
            }
        }
        
        foreach (DataRow r in all.Rows)
        {
            if (! bool.Parse( r["psex"].ToString()))
            {
                addRow(screened[14, 7],r);
                switch (r["grid"].ToString())
                {
                    case "1":
                        addRow(screened[0, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[0,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[0, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[0, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[0, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[0, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[0, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[0, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "2":
                        addRow(screened[0, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[0,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[0, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[0, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[0, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[0, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[0, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[0, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "3":
                        addRow(screened[2, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[2,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[2, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[2, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[2, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[2, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[2, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[2, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "4":
                        addRow(screened[4, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[4,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[4, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[4, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[4, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[4, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[4, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[4, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "5":
                        addRow(screened[6, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[6,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[6, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[6, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[6, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[6, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[6, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[6, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "6":
                        addRow(screened[8, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[8,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[8, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[8, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[8, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[8, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[8, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[8, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "7":
                        addRow(screened[10, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[10,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[10, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[10, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[10, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[10, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[10, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[10, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                    case "8":
                        addRow(screened[12, 7],r);
                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 < 5)
                        {
                            addRow(screened[12,0],r);
                            addRow(screened[14, 0],r);
                        }
                        else
                        {
                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 10)
                            {
                                addRow(screened[12, 1],r);
                                addRow(screened[14, 1],r);
                            }
                            else
                            {
                                if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[12, 2],r);
                                    addRow(screened[14, 2],r);
                                }
                                else
                                {
                                    if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[12, 3],r);
                                        addRow(screened[14, 3],r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[12, 4],r);
                                            addRow(screened[14, 4],r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now-DateTime.Parse(r["doe"].ToString()) ).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[12, 5],r);
                                                addRow(screened[14, 5],r);
                                            }
                                            else
                                            {

                                                addRow(screened[12, 6],r);
                                                addRow(screened[14, 6],r);
                                                
                                                
                                            }
                                        }
                                    }
                                } 
                            }
                        }
                        break;
                        
                        
                        
                }
                
            }
            else
            {
                
                addRow(screened[15, 7],r);
                switch (r["grid"].ToString())
                {
                    case "1":
                        addRow(screened[1, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[1, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[1, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[1, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[1, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[1, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[1, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[1, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "2":
                        addRow(screened[1, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[1, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[1, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[1, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[1, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[1, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[1, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[1, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "3":
                        addRow(screened[3, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[3, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[3, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[3, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[3, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[3, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[3, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[3, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "4":
                        addRow(screened[5, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[5, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[5, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[5, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[5, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[5, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[5, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[5, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "5":
                        addRow(screened[7, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[7, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[7, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[7, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[7, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[7, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[7, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[7, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "6":
                        addRow(screened[9, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[9, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[9, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[9, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[9, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[9, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[9, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[9, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "7":
                        addRow(screened[11, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[11, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[11, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[11, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[11, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[11, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[11, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[11, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    case "8":
                        addRow(screened[13, 7], r);
                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 < 5)
                        {
                            addRow(screened[13, 0], r);
                            addRow(screened[15, 0], r);
                        }
                        else
                        {
                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 10)
                            {
                                addRow(screened[13, 1], r);
                                addRow(screened[15, 1], r);
                            }
                            else
                            {
                                if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 15)
                                {
                                    addRow(screened[13, 2], r);
                                    addRow(screened[15, 2], r);
                                }
                                else
                                {
                                    if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 20)
                                    {
                                        addRow(screened[13, 3], r);
                                        addRow(screened[15, 3], r);
                                    }
                                    else
                                    {
                                        if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 25)
                                        {
                                            addRow(screened[13, 4], r);
                                            addRow(screened[15, 4], r);
                                        }
                                        else
                                        {
                                            if ((DateTime.Now - DateTime.Parse(r["doe"].ToString())).TotalDays / 365 <= 30)
                                            {
                                                addRow(screened[13, 5], r);
                                                addRow(screened[15, 5], r);
                                            }
                                            else
                                            {

                                                addRow(screened[13, 6], r);
                                                addRow(screened[15, 6], r);


                                            }
                                        }
                                    }
                                }
                            }
                        }
                        break;



                }
                
            }
        }
        //inserting count into page
        litSum.Text = count.ToString();
        for (int i = 0; i < 16; i++)
        {
            for (int j = 0; j < 8; j++)
            {
                countShower csh = (countShower)this.FindControl("countShower" + (j+ 1).ToString() + "_" + (i + 1).ToString());
                csh.Personnels = screened[i, j];
            }
        }
        
        
    }
    protected void addRow(DataTable iToInsert, DataRow iRow)
    {
        DataRow r = iToInsert.NewRow();
        for (int i=0; i < columnCount; i++)
        {
            r[i] = iRow[i];
        }
        iToInsert.Rows.Add(r);
    }
</script>





<asp:MultiView ID="mvw" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwLogin" runat="server">
        
        
        <uc3:LoginSystem ID="LoginSystem1" runat="server" />
        
        
    </asp:View>
    <asp:View ID="vwPage" runat="server" >
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:tableTitle ID="tableTitle1" runat="server" Text="شمارش غربالي كاركنان" />
                <br />
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                       
                        <td width="20%">
                            <asp:Label ID="Label1" runat="server" CssClass="FormCaption" Text="كارمند:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label7" runat="server" CssClass="FormCaption" Text="محل خدمت:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label2" runat="server" CssClass="FormCaption" 
                                Text="شروع بازه زماني:"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label3" runat="server" CssClass="FormCaption" 
                                Text="پايان بازه زماني:"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label9" runat="server" CssClass="FormCaption" Text="جنسيت:"></asp:Label>
                        </td>
                       
                    </tr>
                    <tr valign="top">
                        <td>
                            <uc1:personnelIDBinder ID="pib" runat="server" />
                        </td>

                        <td>
                            <uc8:branchesList ID="ddlBranches" runat="server" BID="225" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpStart" runat="server" />
                        </td>
                        <td>
                            <uc5:persianDatePicker ID="pdpEnd" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSex" runat="server" CssClass="FormTextBox">
                                <asp:ListItem Selected="True" Value="">&lt;انتخاب كنيد&gt;</asp:ListItem>
                                <asp:ListItem Value="1">مرد</asp:ListItem>
                                <asp:ListItem Value="0">زن</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        
                    </tr>
                    <tr>
                     <td width="20%">
                            <asp:Label ID="Label8" runat="server" CssClass="FormCaption" 
                                Text="نوع استخدام:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label10" runat="server" CssClass="FormCaption" 
                                Text="نوع انتقال:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label4" runat="server" CssClass="FormCaption" 
                                Text="مدرك تحصيلي:"></asp:Label>
                        </td>
                        <td width="20%">
                            <asp:Label ID="Label5" runat="server" CssClass="FormCaption" 
                                Text="پست سازماني:"></asp:Label>
                        </td><td width="20%">
                            <asp:Label ID="Label11" runat="server" CssClass="FormCaption" Text="نام دايره:"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                    <td>
                            <uc10:employmentTypeDropDown ID="ddlEmploymentType" runat="server" ETID="" />
                        </td>
                        <td>
                            <uc14:transfereTypeDropDown ID="ddlTransfereType" runat="server" TTID="" />
                        </td>
                        <td>
                            <uc7:gradesDropDown ID="ddlGrades" runat="server" GradeID="" 
                                />
                        </td>
                        <td>
                            <uc9:postsList ID="ddlPosts" runat="server" POID="" />
                        </td>
                            <td>
                                <uc4:branchCirclesDropDown BCID="" ID="ddlBranchCircles" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <uc11:rolesDropDown ID="ddlRoles" RID="" runat="server" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                <asp:Button ID="btnShow" runat="server" CssClass="FormButtom" 
                    onclick="btnShow_Click" Text="نمايش" CausesValidation="False" />
                
                
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <uc4:progressPanelContent ID="progressPanelContent1" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Panel ID="pnlTable" Visible="false" runat="server">
                
                <p>
                <asp:Label ID="Label12" runat="server" CssClass="FormCaption" 
                    Text="جمع كل شمارش شده:"></asp:Label>
                <asp:Literal ID="litSum" runat="server"></asp:Literal></p>
                <table border="1" cellpadding="0" cellspacing="0" class="style1" 
                    style="border-style: 1; border-width: 1px; border-color: #000000;">
                    <tr align="center">
                    <td>
                            <asp:Literal ID="Literal1" runat="server" Text="تحصيلات"></asp:Literal>
                        </td>
                    
                        
                        <td colspan="2">
                            <asp:Literal ID="Literal2" runat="server" Text="ابتدائي و كمتر"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal3" runat="server" Text="سيكل"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal4" runat="server" Text="ديپلم"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal5" runat="server" Text="فوق ديپلم"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal6" runat="server" Text="ليسانس"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal7" runat="server" Text="فوق ليسانس"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal8" runat="server" Text="دكتري"></asp:Literal>
                        </td>
                        <td colspan="2">
                            <asp:Literal ID="Literal9" runat="server" Text="مجموع"></asp:Literal>
                        </td>
                        <tr>
                        <td width="20%">
                            &nbsp;</td>
                        <td width="5%">
                            <asp:Literal ID="Literal10" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal18" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal11" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal19" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal12" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal20" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal13" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal21" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal14" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal22" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal15" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal23" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal16" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal24" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal17" runat="server" Text="زن"></asp:Literal>
                        </td>
                        <td width="5%">
                            <asp:Literal ID="Literal25" runat="server" Text="مرد"></asp:Literal>
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal26" runat="server" Text="كمتر از 5 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower1_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal27" runat="server" Text="بين 5 تا 10 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower2_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal28" runat="server" Text="بين 11 تا 15 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower3_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal29" runat="server" Text="بين 16 تا 20 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower4_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal30" runat="server" Text="بين 21 تا 25 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower5_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal31" runat="server" Text="بين 26 تا 30 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower6_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal32" runat="server" Text="بيش از 30 سال"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower7_16" runat="server" />
                        </td>
                        
                    </tr>
                    <tr align="center" valign="top">
                        <td>
                            <asp:Literal ID="Literal33" runat="server" Text="جمع"></asp:Literal>
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_1" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_2" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_3" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_4" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_5" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_6" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_7" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_8" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_9" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_10" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_11" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_12" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_13" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_14" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_15" runat="server" />
                        </td>
                        <td>
                            <uc2:countShower ID="countShower8_16" runat="server" />
                        </td>
                        
                    </tr>
                </table>
                </asp:Panel>
            </ContentTemplate>
            
        </asp:UpdatePanel>
        
        
    </asp:View>
</asp:MultiView>











    

