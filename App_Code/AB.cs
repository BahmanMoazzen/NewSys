using System;
using System.Data;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Collections;
using System.IO;
using DBTools;
using PersianCalendar;
using System.Web;
using System.Web.UI.WebControls;
using System.Text;

public class AB
{
   
    public static UserInfo user = new UserInfo();


    public class Time
    {
        public int Distance(Time iGuest)
        {
            return (this.Hour - iGuest.Hour) * 60 + this.Minut - iGuest.Minut;
            
        }
        private string fullTime;
        private string[] myTime;
        public Time(string iTime)
        {
            fullTime = iTime;
            myTime = fullTime.Split(':');
        }
        public string FullTime
        {
            set
            {
                fullTime = value;
            }
            get
            {
                return fullTime;
            }
        }
        public int Hour
        {
            get
            {
                int hour = 0;
                
                if (fullTime != String.Empty)
                {

                    hour = int.Parse(myTime[0]);
                }

                return hour;
                
            }
        }
        public int Minut
        {
            get
            {
                int minut = 0;

                if (fullTime != String.Empty)
                {

                    minut = int.Parse(myTime[1]);
                }

                return minut;

            }
        }
    }
    public class UserInfo
    {
        private string email, pwd,displayName,prefix;
        private TimeSpan validDuration = new TimeSpan(0,45, 0);
        private bool active;
        private string keys;
        private int bid;
        private DateTime refreshDate;
        public bool HaveKey(string iKeyId)
        {
            string[] keysToHave = iKeyId.Split('_');
            string[] havingKeys = keys.Split('_');
            bool iHaveKey = true;
            foreach (string toHave in keysToHave)
            {
                bool isInMyKeys = false;
                foreach (string having in havingKeys)
                {

                    if (having.Equals(toHave))
                        isInMyKeys = true;
                }
                iHaveKey = iHaveKey && isInMyKeys;
            }
            return iHaveKey;
        }
        public UserInfo(string iEmail,string iPWD,string iDisplayName,bool iActive,string iKeys,string iBID,string prefix)
        {
            email = iEmail;
            refreshDate = DateTime.Now;
            pwd = iPWD;
            active = iActive;
            displayName = iDisplayName;
            keys = iKeys;
            bid = int.Parse(iBID);

        }
        public bool IsValid()
        {
            bool valid = (validDuration >( DateTime.Now-refreshDate ));
            refreshDate = DateTime.Now;
            return valid;
        }
        public UserInfo()
        {
            email = null;
            refreshDate = DateTime.Now;
            pwd = null;
            active = false;
            displayName = null;
            keys = null;
            bid = 0;
            prefix = null;
            

        }
        public string[] KeysArray
        {
            get
            {
                string[] k =keys.Remove(keys.Length-1,1).Split('_');
                
                return k;
            }
        }
        public string Keys
        {
            get
            {
                return keys;
            }
            set
            {
                keys = value;
            }
        }
        public string BID
        {
            set
            {
                bid = int.Parse(value);
            }
            get
            {
                return bid.ToString();
            }
        }
        public string Email
        {
            get
            {
                return email;
            }
            set
            {
                email = value;
            }
        }
        public string PWD
        {
            get
            {
                return pwd;
            }
            set
            {
                pwd = value;
            }
        }
        public string DisplayName
        {
            get
            {
                return displayName;
            }
            set
            {
                displayName = value;
            }
        }
        public bool Active
        {
            get
            {
                return active;
            }
            set
            {
                active = value;
            }
        }
        public string FullName
        {
            get
            {
                return prefix + " " + displayName;
            }
        }
        public string Prefix
        {
            set
            {
                prefix = value;
            }
            get
            {
                return prefix;
            }
        }
        
    }
    public static class Offs
    {
        public static void AddPurchaseBySystem(string iPid, string iYID, string iAmount,string iDsc, string iSystemRef)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOffPurchase] @pid,@yid,@amount,@dsc,@sysref ,@insertType");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@yid", SqlDbType.Int);
            cmd.Parameters.Add("@amount",SqlDbType.Int );
            
            cmd.Parameters.Add("@inserttype", SqlDbType.Int);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@sysref", SqlDbType.Int);
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            cmd.Parameters["@yid"].Value = int.Parse(iYID);
            cmd.Parameters["@amount"].Value = int.Parse(iAmount); ;
            
            cmd.Parameters["@inserttype"].Value = 3;
            cmd.Parameters["@dsc"].Value = iDsc;
            cmd.Parameters["@sysref"].Value = int.Parse(iSystemRef);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static bool CanInsertTotalTable(string iSystemRef)
        {

            return bool.Parse(DBTools.Convert.QueryToString("EXECUTE [dbo].[spCanInsertTable] " + iSystemRef, Resources.Resource.txtConnectionString));
        }
        public static string InsertTotalTable(DataTable iFigures,string iSystemRef)
        {
            string str = String.Empty;
            for (int i = 0; i < iFigures.Rows.Count; i++)
            {
                if(! iFigures.Rows[i]["sookht"].Equals("0"))
                    AB.Offs.AddOffBySystem(iFigures.Rows[i]["pid"].ToString(), DateTime.Parse("2014-03-20"), DateTime.Parse("2014-03-20"), user.Email, iFigures.Rows[i]["sookht"].ToString(), "1", "2", String.Format("سوخت مرخصي سال 1392  - كد مرجع {0}", iSystemRef), iSystemRef);
                if (!iFigures.Rows[i]["thisyearinc"].Equals("0"))
                    AB.Offs.AddAddetiveBySystem(iFigures.Rows[i]["pid"].ToString(), iFigures.Rows[i]["thisyearinc"].ToString(), "1", user.Email,DateTime.Parse("2014-03-21") , String.Format("افزايش سنواتي سال 1392 - كد مرجع {0}", iSystemRef), iSystemRef);
                if(! iFigures.Rows[i]["bazkh"].Equals("0"))
                    AB.Offs.AddPurchaseBySystem(iFigures.Rows[i]["pid"].ToString(), "1392", iFigures.Rows[i]["bazkh"].ToString(), String.Format("بازخريد مرخصي سال 1392 - كد مرجع {0}", iSystemRef), iSystemRef);
                str += string.Format("نام و نام خانوادگي:{5},شماره استخدامي:{2},سوخت مرخصي:{0},بازخريد مرخصي{4},افزايش سالانه:{1},كد سيستم:{3}<br>", iFigures.Rows[i]["sookht"], iFigures.Rows[i]["thisyearinc"], iFigures.Rows[i]["pid"], iSystemRef, iFigures.Rows[i]["bazkh"], iFigures.Rows[i]["pname"]);
                
            }
            str += "عمليات با موفقيت انجام شد";
            return str;
        }
        public static DataTable LoadTotalReport(string iBID, string iStartDate, string iEnddate)
        {
           
                return DBTools.Convert.QueryToTable(string.Format("EXEC	[dbo].[spOffTotalTable] {0},'{1}','{2}'",iBID,iStartDate,iEnddate), Resources.Resource.txtConnectionString);
            
        }
        public static DataTable LoadHourlyOffCount(string iMID, string iBID)
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spHourlyOffMonthLyReport] " + iMID + " ," + iBID, Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadHourlyOffPaymentFines(string iMID)
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spLoadPaymentFines] " + iMID, Resources.Resource.txtConnectionString);
        }
        public static DataTable SecondTypesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT [OSTName],[OSTID] fROM [dbo].[tblOffSecondTypes] ", Resources.Resource.txtConnectionString, "<انتخاب>");
            }
        }
        public static DataTable SecondTypes(string iRout)
        {
            string isDaily = "1";
            if (iRout.Equals("1"))
                isDaily = "0";
            
           

            return DBTools.Convert.QueryToTable("SELECT [OSTName],[OSTID] fROM [dbo].[tblOffSecondTypes] where isHourly= " + iRout + " or isDaily=" + isDaily, Resources.Resource.txtConnectionString);
            
        }
        public static void UpdateHourlyOff(string iOffId, string iStartTime, string iEndTime, string iDuration,string iDescription)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spUpdateHourlyOff] @offid ,@starttime, @endtime,@duration,@dsc");
            cmd.Parameters.Add("@offid", SqlDbType.Int);
            cmd.Parameters["@offid"].Value = int.Parse(iOffId);
            cmd.Parameters.Add("@starttime", SqlDbType.VarChar);
            cmd.Parameters["@starttime"].Value = iStartTime;
            cmd.Parameters.Add("@endtime", SqlDbType.VarChar);
            cmd.Parameters["@endtime"].Value = iEndTime;
            cmd.Parameters.Add("@duration", SqlDbType.Int);
            cmd.Parameters["@duration"].Value = int.Parse(iDuration);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@dsc"].Value = iDescription;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void DeleteHourlyOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spDeleteHourlyOff] "+iOffId+","+AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static string AddHourlyOff(string iPid,DateTime iStartDate, string iStartTime, string iEndTime, string iDuration,int iOffType,int iSecondType,string iOffCount,string iDescription)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spAddHourlyOffByOperator] @PID ,@OT,@OSTID, @startdate,@starttime ,@endtime,@duration,@it,@adder,@offcount,@dsc");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters.Add("@ot", SqlDbType.Int);
            cmd.Parameters["@ot"].Value = iOffType;
            cmd.Parameters.Add("@OSTID", SqlDbType.Int);
            cmd.Parameters["@OSTID"].Value = iSecondType;
            cmd.Parameters.Add("@it", SqlDbType.Int);
            cmd.Parameters["@it"].Value = 2;
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters.Add("@starttime", SqlDbType.VarChar);
            cmd.Parameters["@starttime"].Value = iStartTime;
            cmd.Parameters.Add("@endtime", SqlDbType.VarChar);
            cmd.Parameters["@endtime"].Value = iEndTime;
            cmd.Parameters.Add("@duration", SqlDbType.Int);
            cmd.Parameters["@duration"].Value = int.Parse(iDuration);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters["@adder"].Value = int.Parse(AB.user.Email);
            cmd.Parameters.Add("@offcount", SqlDbType.Int);
            cmd.Parameters["@offcount"].Value = int.Parse(iOffCount);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@dsc"].Value = iDescription;


            return DBTools.Convert.QueryToString(cmd, Resources.Resource.txtConnectionString);
        }
        public static string AddHourlyOff(string iPid, DateTime iStartDate, string iStartTime, string iEndTime, string iDuration, string iOffType, string iSecondType, string iOffCount, string iDescription)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spAddHourlyOffByOperator] @PID ,@OT,@OSTID, @startdate,@starttime ,@endtime,@duration,@it,@adder,@offcount,@dsc");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters.Add("@ot", SqlDbType.Int);
            cmd.Parameters["@ot"].Value = int.Parse(iOffType);
            cmd.Parameters.Add("@OSTID", SqlDbType.Int);
            cmd.Parameters["@OSTID"].Value = int.Parse(iSecondType);
            cmd.Parameters.Add("@it", SqlDbType.Int);
            cmd.Parameters["@it"].Value = 2;
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters.Add("@starttime", SqlDbType.VarChar);
            cmd.Parameters["@starttime"].Value = iStartTime;
            cmd.Parameters.Add("@endtime", SqlDbType.VarChar);
            cmd.Parameters["@endtime"].Value = iEndTime;
            cmd.Parameters.Add("@duration", SqlDbType.Int);
            cmd.Parameters["@duration"].Value = int.Parse(iDuration);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters["@adder"].Value = int.Parse(AB.user.Email);
            cmd.Parameters.Add("@offcount", SqlDbType.Int);
            cmd.Parameters["@offcount"].Value = int.Parse(iOffCount);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@dsc"].Value = iDescription;


            return DBTools.Convert.QueryToString(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadHourlyOffs
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwOffs] where isHourly=1 and insertBID="+user.BID+" order by OffID desc", Resources.Resource.txtConnectionString);
            }
        }
        public static bool isHourly(string iOffType)
        {
            return bool.Parse(DBTools.Convert.QueryToString("select case ishourly when 1 then 'true' else 'false' end as ishourly from tblOffTypes where OTID = "+iOffType, Resources.Resource.txtConnectionString));
        }
        public static DataTable Cardex(string iPid)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[funOffCardex] (" + iPid + ")", Resources.Resource.txtConnectionString);
        }
        public static DataTable CardexSeperatly(string iPid)
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spCardexSepratly] @pid ="+iPid, Resources.Resource.txtConnectionString);
        }
        public static DataTable Cardex(string iPid,string iOfftype)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[funOffCardexbyType] (" + iPid + "," + iOfftype + ")", Resources.Resource.txtConnectionString);
        }
        public static DataTable CardexSepratly(string iPid, string iOfftype)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[funOffCardexbyType] (" + iPid + "," + iOfftype + ")", Resources.Resource.txtConnectionString);
        }
        public static void UpdateAddetive(string iAdtId, string iDays, DateTime iEffectDate,string iDescription)
        {
            SqlCommand cmd = new SqlCommand("exec [dbo].[spUpdateAddetive] @adtId ,@days ,@offtype,@adder,@effectdate,@dsc");
            cmd.Parameters.Add("@adtid", SqlDbType.BigInt);
            cmd.Parameters["@adtid"].Value = int.Parse(iAdtId);
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters.Add("@effectdate", SqlDbType.DateTime);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters.Add("@offtype", SqlDbType.Int);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            
            cmd.Parameters["@days"].Value = int.Parse(iDays);
            cmd.Parameters["@effectdate"].Value = iEffectDate;
            cmd.Parameters["@adder"].Value = int.Parse(user.Email);
            cmd.Parameters["@offtype"].Value = 1;
            cmd.Parameters["@dsc"].Value = iDescription ;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);

        }
        public static void DeleteAddetive(string iAdtId)
        {
            SqlCommand cmd = new SqlCommand("exec dbo.spDeleteAddetive @adtid");
            cmd.Parameters.Add("@adtid", SqlDbType.BigInt);
            cmd.Parameters["@adtid"].Value = int.Parse(iAdtId);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable RemainChart(string iPID)
        {
            return DBTools.Convert.QueryToTable("exec [dbo].[spOffYearlyUsage] " + iPID + " ", Resources.Resource.txtConnectionString);
        }
        public static DataTable HourlyRemainChart(string iPID)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[funHourlyUsage2] ("+iPID+") order by dsc desc ", Resources.Resource.txtConnectionString);
        }
        public static void AddAddetive(string iPid, string iDays, string iOffType,  string iAdder, DateTime iEffectDate, string iDsc)
        {
            SqlCommand cmd = new SqlCommand("exec [dbo].[spAddAddetive] @pid,@days,@effectdate ,@adder ,@offtype ,@dsc");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters.Add("@effectdate", SqlDbType.DateTime);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters.Add("@offtype", SqlDbType.Int);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            cmd.Parameters["@days"].Value = int.Parse(iDays);
            cmd.Parameters["@effectdate"].Value =iEffectDate;
            cmd.Parameters["@adder"].Value = int.Parse(iAdder);
            cmd.Parameters["@offtype"].Value =int.Parse( iOffType);
            cmd.Parameters["@dsc"].Value = iDsc;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddAddetiveBySystem(string iPid, string iDays, string iOffType, string iAdder, DateTime iEffectDate, string iDsc,string iSystemRef)
        {
            SqlCommand cmd = new SqlCommand("exec [dbo].[spAddAddetiveBySystem] @pid,@days,@effectdate ,@adder ,@offtype ,@dsc,@sysref");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters.Add("@effectdate", SqlDbType.DateTime);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters.Add("@offtype", SqlDbType.Int);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@sysref", SqlDbType.Int);
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            cmd.Parameters["@days"].Value = int.Parse(iDays);
            cmd.Parameters["@effectdate"].Value = iEffectDate;
            cmd.Parameters["@adder"].Value = int.Parse(iAdder);
            cmd.Parameters["@offtype"].Value = int.Parse(iOffType);
            cmd.Parameters["@dsc"].Value = iDsc;
            cmd.Parameters["@sysref"].Value = int.Parse(iSystemRef);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable AddetivesList(string iBID)
        {
            string sqlt = "select * from [dbo].[vwAddetives] ";
            if (! iBID.Equals(String.Empty))
            {
                sqlt += " where bid=" + iBID;
            }
            sqlt += " order by PID";
            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
        }
        
        public static DataTable LoadOff(string iOffid)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM vwOffs WHERE (OffID = "+iOffid+")", Resources.Resource.txtConnectionString);
        }
        public static DataTable ManagerialReport(string iPid, DateTime iStartDate, DateTime iEndDate,string iBID, string iOffType,string iOffStat,ref int iSum)
        {
            string sqlt = "select * from vwOffs where startdate between '" + iStartDate.ToString() + "' and '" + iEndDate.ToString() + "'";
            if (!iBID.Equals(String.Empty))
                sqlt += " and insertbid=" + iBID;
            if (!iPid.Equals(String.Empty))
                sqlt += " and pid=" + iPid;
            if (!iOffType.Equals(String.Empty))
                sqlt += " and offtype=" + iOffType;
            if (!iOffStat.Equals(String.Empty))
                sqlt += " and stat=" + iOffStat;
            sqlt += " order by pid asc,startdate asc";
            
            DataTable tbl=DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
            iSum = 0;
            foreach (DataRow r in tbl.Rows)
            {
                iSum += int.Parse(r["days"].ToString());
            }
            return tbl;
        }
        public static DataTable TypesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT OTName, OTID FROM tblOffTypes ", Resources.Resource.txtConnectionString, "<انتخاب>");
            }
        }
        public static DataTable Types(string iRout)
        {
            

            return DBTools.Convert.QueryToTable("SELECT OTName, OTID FROM tblOffTypes where isHourly= "+iRout, Resources.Resource.txtConnectionString);
            
        }
        public static DataTable Types()
        {


            return DBTools.Convert.QueryToTable("SELECT OTName, OTID FROM tblOffTypes ", Resources.Resource.txtConnectionString);

        }
        public static DataTable HourlyTypesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT OTName, OTID FROM tblOffTypes where ishourly=1 ", Resources.Resource.txtConnectionString, "<انتخاب>");
            }
        }
        public static DataTable StatsForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT [OSttName],OSttID  FROM [dbo].[tblOffStats] ", Resources.Resource.txtConnectionString, "<انتخاب>");
            }
        }
        public static DataTable InsertTypeForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT [OITName],[OIT] FROM [dbo].[tblOffInsertType] ", Resources.Resource.txtConnectionString, "<انتخاب>");
            }
        }
        public static void ConfirmOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXEC [dbo].[spConfirmOff] @offid = "+iOffId+", @Confirmer = "+AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static void SubSignOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXEC [dbo].[spSubSignOff] @offid = " + iOffId + ", @Confirmer = " + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static void SignOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXEC [dbo].[spSignOff] @offid = " + iOffId + ", @Confirmer = " + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static void NotConfirmOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXEC [dbo].[spNotConfirmOff] @offid = " + iOffId + ", @Confirmer = " + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static void NotSignOff(string iOffId)
        {
            DBTools.Convert.ExecuteScalar("EXEC [dbo].[spNotSignOff] @offid = " + iOffId + ", @Confirmer = " + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static DataTable ToConfirm()
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spOffsToConfirmList]	@pid="+AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static DataTable ToSign()
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spOffsToSignList]	@pid=" + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static DataTable ToSubSign()
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spOffsToSubSignList]	@pid=" + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static DataTable BossOffsToSign()
        {
            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spBossOffsToSignList]	@pid=" + AB.user.Email, Resources.Resource.txtConnectionString);
        }
        public static void ReturnOff(string iOffId, string iDesc)
        {
            SqlCommand cmd = new SqlCommand("exec [dbo].[spReturnOff] @offid,@dsc,@adder");
            cmd.Parameters.Add("@offid", SqlDbType.Int);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters["@offid"].Value = int.Parse(iOffId);
            cmd.Parameters["@dsc"].Value = iDesc;
            cmd.Parameters["@adder"].Value = int.Parse(user.Email);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static string Remain(string iPID)
        {
            return DBTools.Convert.QueryToString("EXEC	[dbo].[spOffRemain] @pid="+iPID, Resources.Resource.txtConnectionString);
        }
        public static DataTable MyOffs(string iEmail)
        {

            return DBTools.Convert.QueryToTable("select * from vwOffs where pid=" + iEmail + " order by startdate desc,stat desc", Resources.Resource.txtConnectionString);

        }
        public static DataTable LoadOffs(string iPid)
        {
            return DBTools.Convert.QueryToTable("select * from vwOffs where pid=" + iPid + " order by startdate desc", Resources.Resource.txtConnectionString);
        }
        public static bool IsExists(string iPid, DateTime iStartDate, DateTime iEndDate)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spIsOffExists] @pid,@startdate,@enddate");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters.Add("@enddate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters["@enddate"].Value = iEndDate;
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            string tmp = DBTools.Convert.QueryToString(cmd,Resources.Resource.txtConnectionString);
            return bool.Parse(tmp);
        }
        public static bool IsHourlyOffExists(string iPid, DateTime iStartDate, string iStartTime, string iEndTime)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spIsHourlyOffExists] @pid,@startdate,@starttime ,@endtime");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters.Add("@starttime", SqlDbType.NVarChar);
            cmd.Parameters.Add("@endtime", SqlDbType.NVarChar);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters["@starttime"].Value = iStartTime;
            cmd.Parameters["@endtime"].Value = iEndTime;
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            string tmp = DBTools.Convert.QueryToString(cmd, Resources.Resource.txtConnectionString);
            return bool.Parse(tmp);
        }
        public static bool IsExists(string iPid, DateTime iStartDate, int iType)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spIsHourlyOffExists] @pid,@startdate,@type");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters.Add("@type",SqlDbType.Int);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters["@type"].Value = iType;
            cmd.Parameters["@pid"].Value = int.Parse(iPid);
            string tmp = DBTools.Convert.QueryToString(cmd, Resources.Resource.txtConnectionString);
            return bool.Parse(tmp);
        }
        public static void DaysBetween(DateTime iStartDate, DateTime iEndDate, ref string iDays, ref string iHollyDays)
        {
            double days = ( iEndDate-iStartDate).TotalDays+1;
            iDays =days.ToString();
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spHollyDays] @sd ,@ed");
            cmd.Parameters.Add("@sd",SqlDbType.Date);
            cmd.Parameters.Add("@ed",SqlDbType.Date);
            cmd.Parameters["@sd"].Value=iStartDate;
            cmd.Parameters["@ed"].Value=iEndDate;
            iHollyDays = DBTools.Convert.QueryToString(cmd, Resources.Resource.txtConnectionString);

            


        }
        public static void AddOff( DateTime iStartDate, DateTime iEndDate, string iDays)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOff] @PID,@ot,@startdate,@enddate,@days,@it");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters["@PID"].Value=int.Parse(AB.user.Email);
            cmd.Parameters.Add("@ot", SqlDbType.Int);
            cmd.Parameters["@ot"].Value=1;
            cmd.Parameters.Add("@it", SqlDbType.Int);
            cmd.Parameters["@it"].Value=1;
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value=iStartDate;
            cmd.Parameters.Add("@enddate", SqlDbType.Date);
            cmd.Parameters["@enddate"].Value=iEndDate;
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters["@days"].Value =int.Parse( iDays);
            
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        //public static void AddOff(string iPid, DateTime iStartDate, DateTime iEndDate, string iDays,int iInsertType)
        //{
        //    SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOff] @PID,@ot,@startdate,@enddate,@days,@it,@stat");
        //    cmd.Parameters.Add("@PID", SqlDbType.Int);
        //    cmd.Parameters["@PID"].Value = int.Parse(iPid);
        //    cmd.Parameters.Add("@ot", SqlDbType.Int);
        //    cmd.Parameters["@ot"].Value = 1;
        //    cmd.Parameters.Add("@it", SqlDbType.Int);
        //    cmd.Parameters["@it"].Value = iInsertType;
        //    cmd.Parameters.Add("@startdate", SqlDbType.Date);
        //    cmd.Parameters["@startdate"].Value = iStartDate;
        //    cmd.Parameters.Add("@enddate", SqlDbType.Date);
        //    cmd.Parameters["@enddate"].Value = iEndDate;
        //    cmd.Parameters.Add("@days", SqlDbType.Int);
        //    cmd.Parameters["@days"].Value = int.Parse(iDays);
        //    DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        //}
        //public static void AddOff(string iPid, DateTime iStartDate, DateTime iEndDate, string iDays,int iInsertType,int iOffType)
        //{
        //    SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOff] @PID,@ot,@startdate,@enddate,@days,@it");
        //    cmd.Parameters.Add("@PID", SqlDbType.Int);
        //    cmd.Parameters["@PID"].Value = int.Parse(iPid);
        //    cmd.Parameters.Add("@ot", SqlDbType.Int);
        //    cmd.Parameters["@ot"].Value = iOffType;
        //    cmd.Parameters.Add("@it", SqlDbType.Int);
        //    cmd.Parameters["@it"].Value = iInsertType;
        //    cmd.Parameters.Add("@startdate", SqlDbType.Date);
        //    cmd.Parameters["@startdate"].Value = iStartDate;
        //    cmd.Parameters.Add("@enddate", SqlDbType.Date);
        //    cmd.Parameters["@enddate"].Value = iEndDate;
        //    cmd.Parameters.Add("@days", SqlDbType.Int);
        //    cmd.Parameters["@days"].Value = int.Parse(iDays);
        //    DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        //}
        public static void AddOffByOperator(string iPid, DateTime iStartDate, DateTime iEndDate,string iAdder, string iDays,  string iOffType,string iSecondType,string dsc)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOffByOperator] @PID,@ot,@startdate,@enddate,@days,@it,@adder,@dsc,@ostid");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters.Add("@ot", SqlDbType.Int);
            cmd.Parameters["@ot"].Value =int.Parse( iOffType);
            cmd.Parameters.Add("@ostid", SqlDbType.Int);
            cmd.Parameters["@ostid"].Value = int.Parse(iSecondType);
            cmd.Parameters.Add("@it", SqlDbType.Int);
            cmd.Parameters["@it"].Value = 2;
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters.Add("@enddate", SqlDbType.Date);
            cmd.Parameters["@enddate"].Value = iEndDate;
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters["@days"].Value = int.Parse(iDays);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@dsc"].Value = dsc;
            cmd.Parameters.Add("@Adder", SqlDbType.Int);
            cmd.Parameters["@adder"].Value = int.Parse(iAdder);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddOffBySystem(string iPid, DateTime iStartDate, DateTime iEndDate, string iAdder, string iDays, string iOffType, string iSecondType, string iDsc,string iSystemRef)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddOffBySystem] @PID,@ot,@startdate,@enddate,@days,@it,@adder,@dsc,@ostid,@sysref");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters.Add("@ot", SqlDbType.Int);
            cmd.Parameters["@ot"].Value = int.Parse(iOffType);
            cmd.Parameters.Add("@ostid", SqlDbType.Int);
            cmd.Parameters["@ostid"].Value = int.Parse(iSecondType);
            cmd.Parameters.Add("@it", SqlDbType.Int);
            cmd.Parameters["@it"].Value = 3;
            cmd.Parameters.Add("@startdate", SqlDbType.Date);
            cmd.Parameters["@startdate"].Value = iStartDate;
            cmd.Parameters.Add("@enddate", SqlDbType.Date);
            cmd.Parameters["@enddate"].Value = iEndDate;
            cmd.Parameters.Add("@days", SqlDbType.Int);
            cmd.Parameters["@days"].Value = int.Parse(iDays);
            cmd.Parameters.Add("@dsc", SqlDbType.NVarChar);
            cmd.Parameters["@dsc"].Value = iDsc;
            cmd.Parameters.Add("@Adder", SqlDbType.Int);
            cmd.Parameters["@adder"].Value = int.Parse(iAdder);
            cmd.Parameters.Add("@sysref", SqlDbType.Int);
            cmd.Parameters["@sysref"].Value = int.Parse(iSystemRef);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        
    }
    public static class General
    {

        public static string ThousandSeprator(string iNumber)
        {
            int sepratorPlace = 3;
            int length = iNumber.Length;
            string seprated = String.Empty;
            decimal packs = length / sepratorPlace;
            packs = Math.Round(packs);
            int remain = 0;
            Math.DivRem(length,sepratorPlace,out remain);
            
            for (int i = 1; i <= packs; i++)
            {
                seprated = "," +iNumber.Substring(length - (i * sepratorPlace), sepratorPlace) +seprated  ;

                
            }
            if (remain.Equals(0))
            {
                seprated = seprated.Substring(1, seprated.Length - 1);
            }
            else
            {
                seprated = iNumber.Substring(0, remain) + seprated;
            }
            return seprated;
        }
        public static void AddYear(string iYearId, DateTime iStartDate, DateTime iEndDate)
        {
            SqlCommand cmd = new SqlCommand("exec spAddYear @YearID,@StartDate,@EndDate");
            cmd.Parameters.Add("@YearID", SqlDbType.Int);
            cmd.Parameters.Add("@StartDate", SqlDbType.DateTime);
            cmd.Parameters.Add("@EndDate", SqlDbType.DateTime);
            cmd.Parameters["@yearID"].Value = int.Parse(iYearId);
            cmd.Parameters["@StartDate"].Value = iStartDate;
            cmd.Parameters["@EndDate"].Value = iEndDate;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddMonth(string iYearId,string iMonthId, DateTime iStartDate, DateTime iEndDate)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spAddMonth] @mid ,@yearid,@startdate,@enddate ");
            cmd.Parameters.Add("@mid", SqlDbType.Int);
            cmd.Parameters.Add("@YearID", SqlDbType.Int);
            cmd.Parameters.Add("@StartDate", SqlDbType.DateTime);
            cmd.Parameters.Add("@EndDate", SqlDbType.DateTime);
            cmd.Parameters["@mid"].Value = int.Parse(iMonthId);
            cmd.Parameters["@yearID"].Value = int.Parse(iYearId);
            cmd.Parameters["@StartDate"].Value = iStartDate;
            cmd.Parameters["@EndDate"].Value = iEndDate;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable Years
        {
            get
            {
                return DBTools.Convert.QueryToTable("select * from tblYears order by YearId desc", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable YearsForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("select yearid as yearname,yearid from tblYears order by YearId desc", Resources.Resource.txtConnectionString,"<انتخاب سال>");
            }
        }
        public static DataTable MonthsForBinding(string iYearid)
        {

            return DBTools.Convert.QueryToBinding("SELECT [MID] as MName,MID  FROM [dbo].[tblMonths] where YearID="+iYearid+" order by mid asc", Resources.Resource.txtConnectionString, "<انتخاب ماه>");
            
        }
        public static string CurrentYearID
        {
            get
            {
                return DBTools.Convert.QueryToString("SELECT [YearId] FROM [dbo].[tblYears]  where GETDATE() between StartDate and EndDate", Resources.Resource.txtConnectionString);
            }
        }
        public static string CurrentMonthID
        {
            get
            {
                
                    return DBTools.Convert.QueryToString("SELECT [MID]   FROM [dbo].[tblMonths] where GETDATE() between StartDate and EndDate", Resources.Resource.txtConnectionString);
                
            }
        }
        
        public static DataTable Months(string iYearId)
        {
            
            return DBTools.Convert.QueryToTable("select * from tblMonths where YearId="+iYearId+" order by MId desc", Resources.Resource.txtConnectionString);
            
        }
        public static void DeleteMonth(string iMID)
        {
            DBTools.Convert.ExecuteScalar("delete from tblMonths where Mid=" + iMID, Resources.Resource.txtConnectionString);
        }
        public static void DeleteYear(string iYearID)
        {
            DBTools.Convert.ExecuteScalar("delete from tblYears where yearid="+iYearID, Resources.Resource.txtConnectionString);
        }
        public static DataTable Branches
        {
            get
            {
                return DBTools.Convert.QueryToTable("select * from vwBranches order by BID", Resources.Resource.txtConnectionString);

            }
        }
        public static string BranchName(string iBid)
        {
            return DBTools.Convert.QueryToString("SELECT [BName] FROM [dbo].[tblBranches] where BID = "+iBid, Resources.Resource.txtConnectionString);

            
        }
        public static DataTable BrancheCirclesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("select BCName,BCID from tblBranchCircles order by BCID", Resources.Resource.txtConnectionString,"<انتخاب دايره>");

            }
        }
        public static DataTable RolesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT [RName], [RID] FROM [dbo].[tblRules]", Resources.Resource.txtConnectionString, "<انتخاب نقش>");

            }
        }
        public static DataTable BranchPersonnelsForBinding(string iBranchCode)
        {
            return DBTools.Convert.QueryToDropDown("SELECT pname,pid  FROM [vwPersonnelsBranches] where BID=" + iBranchCode, Resources.Resource.txtConnectionString,"<انتخاب كارمند>");
        }
        public static DataTable GradesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [GradeName],[GRID] FROM [dbo].[tblGrades]" , Resources.Resource.txtConnectionString, "<انتخاب مقطع تحصيلي>");
            }
        }
        public static void AddBranch(string iBName, string iBID,string iAddress,string iParent,string iGrade,string iMax,string iContracted,string iRewardCount)
        {
            SqlCommand cmd = new SqlCommand("exec dbo.spAddBranch @BID,@BName,@address,@bparent ,@bgrade ,@max,@contracted,@reward_count");
            cmd.Parameters.Add("@BID", SqlDbType.Int);
            cmd.Parameters.Add("@BName", SqlDbType.VarChar);
            cmd.Parameters.Add("@address", SqlDbType.VarChar);
            cmd.Parameters.Add("@bparent", SqlDbType.Int);
            cmd.Parameters.Add("@max", SqlDbType.Int);
            cmd.Parameters.Add("@contracted", SqlDbType.Int);
            cmd.Parameters.Add("@bgrade", SqlDbType.VarChar);
            cmd.Parameters.Add("@reward_count", SqlDbType.Int);
            cmd.Parameters["@BID"].Value =int.Parse(iBID);
            cmd.Parameters["@max"].Value = int.Parse(iMax);
            cmd.Parameters["@contracted"].Value = int.Parse(iContracted);
            cmd.Parameters["@bparent"].Value = int.Parse(iParent);
            cmd.Parameters["@BName"].Value = iBName;
            cmd.Parameters["@bgrade"].Value = iGrade;
            cmd.Parameters["@address"].Value = iAddress;
            cmd.Parameters["@reward_count"].Value = int.Parse(iRewardCount);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void UpdateBranch(string iBName, string iBID, string iAddress, string iParent, string iGrade, string iMax, string iContracted,string iRewardCount)
        {
            SqlCommand cmd = new SqlCommand("exec dbo.spUpdateBranch @BID,@BName,@address,@bparent ,@bgrade ,@max,@contracted,@reward_count");

            cmd.Parameters.Add("@BID", SqlDbType.Int);
            cmd.Parameters.Add("@BName", SqlDbType.VarChar);
            cmd.Parameters.Add("@address", SqlDbType.VarChar);
            cmd.Parameters.Add("@bparent", SqlDbType.Int);
            cmd.Parameters.Add("@max", SqlDbType.Int);
            cmd.Parameters.Add("@contracted", SqlDbType.Int);
            cmd.Parameters.Add("@bgrade", SqlDbType.VarChar);
            cmd.Parameters.Add("@reward_count", SqlDbType.Int);
            cmd.Parameters["@max"].Value = int.Parse(iMax);
            cmd.Parameters["@contracted"].Value = int.Parse(iContracted);
            cmd.Parameters["@bparent"].Value = int.Parse(iParent);
            cmd.Parameters["@BID"].Value =int.Parse( iBID);
            cmd.Parameters["@BName"].Value = iBName;
            cmd.Parameters["@address"].Value = iAddress;
            cmd.Parameters["@bgrade"].Value = iGrade;
            cmd.Parameters["@reward_count"].Value = int.Parse(iRewardCount);

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void DeleteBranch(string iBID)
        {

            DBTools.Convert.ExecuteScalar("DELETE FROM  [tblBranches] WHERE BID=" + iBID, Resources.Resource.txtConnectionString);
        }
        public static void AddOffDay(DateTime iDate, string iDesc)
        {
            SqlCommand cmd = new SqlCommand("exec dbo.spAddOffDay @date,@desc");
            cmd.Parameters.Add("@date", SqlDbType.Date);
            cmd.Parameters.Add("@desc", SqlDbType.VarChar);
            cmd.Parameters["@date"].Value = iDate;
            cmd.Parameters["@desc"].Value = iDesc;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void UpdateOffDay(string iOffDayID, DateTime iDate, string iDesc)
        {
            SqlCommand cmd = new SqlCommand("exec dbo.spUpdateOffDay @id,@date,@desc");
            cmd.Parameters.Add("@id", SqlDbType.Int);
            cmd.Parameters.Add("@date", SqlDbType.Date);
            cmd.Parameters.Add("@desc", SqlDbType.VarChar);
            cmd.Parameters["@id"].Value = int.Parse(iOffDayID);
            cmd.Parameters["@date"].Value = iDate;
            cmd.Parameters["@desc"].Value = iDesc;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void DeleteOffDay(string iOffDayID)
        {
            DBTools.Convert.ExecuteScalar("DELETE FROM [dbo].[tblOffDays] WHERE OffDayID="+iOffDayID, Resources.Resource.txtConnectionString);
        }
        public static DataTable OffDays
        {
            get
            {
                return DBTools.Convert.QueryToTable("select * from tblOffDays order by OffDayDate desc", Resources.Resource.txtConnectionString);

            }
        }
        public static DataTable BranchPhones(string iBID)
        {
            return DBTools.Convert.QueryToTable("select * from dbo.tblBranchesPhones where BID = " + iBID, Resources.Resource.txtConnectionString);
        }
        public static string RemoveHashWord(string iContext)
        {
            string[] hashes = Resources.Resource.txtRemovableWords.Split(';');
            foreach (string s in hashes)
            {
                iContext = iContext.Replace(s, String.Empty);
            }
            return iContext;
            
        }
        public static string ReplaceWordWithLink(string iContext,string iKeyword,string iLinkUrl)
        {
            char[] seprators = { ',', ';', '-', '،', '؛', ' ', ':', '.' };
            string[] hashes = Resources.Resource.txtRemovableWords.Split(';');
            string[] keywords = iKeyword.Split(seprators);
            ArrayList distinctKeys= new ArrayList();
            foreach (string s in keywords)
            {
                bool addWord=true;
                if (distinctKeys.Contains(s))
                    addWord = false;
                foreach (string str in hashes)
                {
                    if (str.Equals(s))
                    {
                        addWord = false;
                        break;
                    }
                }
                if (addWord)
                    distinctKeys.Add(s);
                    
            }
            
            foreach (string s in distinctKeys.ToArray(typeof(string)))
            {
                if (!s.Equals(String.Empty))
                {
                    iContext = iContext.Replace(s, String.Format("<a href=\"{0}\" title=\"{1}\">{1}</a>",iLinkUrl, s));
                }
            }
            return iContext;

        }
        public static DataTable LoadComments(string iPageRef)
        {
            return DBTools.Convert.QueryToTable("SELECT comid, com_context, com_display_name, com_email, com_website, page_ref, com_date, is_private FROM  GNR.comments WHERE (page_ref = '" + iPageRef + "') and (is_private=0) ORDER BY com_date DESC", Resources.Resource.txtConnectionString);
        }
        public static void AddComent(string iPageRef, string iName, string iEmail, string iWebsite, string iContext, string iType)
        {
            SqlCommand cmd = new SqlCommand("EXEC [GNR].[sp_add_comment] @context,@display_name,@email,@website,@ref,@is_private");
            cmd.Parameters.Add(new SqlParameter("@context", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@display_name", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@website", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@ref", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@is_private", SqlDbType.Bit));
            cmd.Parameters["@context"].Value = iContext;
            cmd.Parameters["@display_name"].Value = iName;
            cmd.Parameters["@email"].Value = iEmail;
            cmd.Parameters["@website"].Value = iWebsite;
            cmd.Parameters["@ref"].Value = iPageRef;
            cmd.Parameters["@is_private"].Value =bool.Parse( iType);

                
            
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            
        }
        public static DataTable BranchesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [BName],[BID] FROM [tblBranches]", Resources.Resource.txtConnectionString, "<نام شعبه>");
            }
        }
        public static DataTable Search(string iQuery,string iWhois)
        {
            SqlCommand cmd = new SqlCommand("exec [GNR].[sp_search] @word,@whois");
            cmd.Parameters.Add("@word", SqlDbType.NVarChar);
            cmd.Parameters.Add("@whois", SqlDbType.NVarChar);
            cmd.Parameters["@word"].Value = iQuery.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@whois"].Value = iWhois;
            return DBTools.Convert.QueryToTable(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable RightBanner()
        {

            string sqlt = "select link_template from tblRightLinks where link_visibility_stat=0";
            if (AB.user != null)
            {
                foreach (string key in AB.user.KeysArray)
                {
                    if (!key.Equals(String.Empty))
                        sqlt += " or link_visibility_stat=" + key;
                }
                
            }
            

            sqlt += " order by link_order asc";

            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
            
        }
        public static string GetVerse(string iVerseType)
        {

            return DBTools.Convert.ExecuteScalar("EXEC spSelectStatement " + iVerseType, Resources.Resource.txtConnectionString).ToString();
            
        }
        public static DataTable LatestContent(string iCount)
        {
            return null;// DBTools.Convert.QueryToTable("select top " + iCount + " * from GNR.vw_all_content_user order by add_date desc", Resources.Resource.txtConnectionString);
        }
    }
    public static class Posts
    {
        public static void Add(string iPostName, bool iNeedSign, bool iNeedSubSign, bool iNeedConfirm, bool iSignOutside)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spAddPost] @poname,@offneedconfirm ,@offneedsubsign,@offneedsign ,@offsignoutside");
            cmd.Parameters.Add("@poname", SqlDbType.NVarChar);
            cmd.Parameters.Add("@offneedconfirm", SqlDbType.Bit);
            cmd.Parameters.Add("@offneedsubsign", SqlDbType.Bit);
            cmd.Parameters.Add("@offneedsign", SqlDbType.Bit);
            cmd.Parameters.Add("@offsignoutside", SqlDbType.Bit);
            cmd.Parameters["@poname"].Value = iPostName;
            cmd.Parameters["@offneedconfirm"].Value = iNeedConfirm;
            cmd.Parameters["@offneedsubsign"].Value = iNeedSubSign;
            cmd.Parameters["@offneedsign"].Value = iNeedSign;
            cmd.Parameters["@offsignoutside"].Value = iSignOutside;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);


        }
        public static void Delete(string iPOID)
        {
            DBTools.Convert.ExecuteScalar("DELETE FROM [dbo].[tblPosts] WHERE POID = " + iPOID, Resources.Resource.txtConnectionString);
        }
        public static DataTable AllWithSelectedRules(string iRid)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spRulePosts] " + iRid, Resources.Resource.txtConnectionString);

        }
        public static DataTable ListForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [POName],[POID] FROM [tblPosts]", Resources.Resource.txtConnectionString, "<نام سمت>");
            }
        }
        public static DataTable List
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT * FROM [tblPosts]", Resources.Resource.txtConnectionString);
            }
        }
    }
    public static class User
    {
        public static DataTable TotalReport
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwPersonnelAllData] where psid=1  order by bid", Resources.Resource.txtConnectionString);
            }
        }
        public static string CountPersonnel(string iStat,string iSex, string iGrId, string iLower, string iUpper)
        {
            return DBTools.Convert.QueryToString("SELECT COUNT( [PID]) FROM [dbo].[vwPersonnelsBranches] where PSID=" + iStat + " and PSex=" + iSex + " and GRID=" + iGrId + " and ( DATEDIFF(YY,DOE,GETDATE()) between " + iLower + " and " + iUpper + " )", Resources.Resource.txtConnectionString);
        }
        public static DataTable ListPersonnel(string iStat, string iSex, string iGrId, string iLower, string iUpper)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[vwPersonnelsBranches] where PSID=" + iStat + " and PSex=" + iSex + " and GRID=" + iGrId + " and ( DATEDIFF(YY,DOE,GETDATE()) between " + iLower + " and " + iUpper + " )", Resources.Resource.txtConnectionString);
        }
        public static DataTable ManagerialReport(string iPid,string iBID,string iBCID,string iPOID,string iGRID, string iStartDate, string iEndDate,string iETID,string iSex,string iTTID,string iRID, ref int iCount)
        {
            string sqlt = "SELECT *  FROM [vwPersonnelsBranches] where psid=1 " ;
            if (!(iStartDate.Equals(String.Empty) && iEndDate.Equals(String.Empty)))
                sqlt += " and (DOE between '" + iStartDate + "'  and '" + iEndDate + "')";
            if (!iBID.Equals(String.Empty))
                sqlt += " and bid=" + iBID;
            if (!iBCID.Equals(String.Empty))
                sqlt += " and bcid=" + iBCID;
            if (!iPid.Equals(String.Empty))
                sqlt += " and pid=" + iPid;
            if (!iPOID.Equals(String.Empty))
                sqlt += " and poid=" + iPOID;
            if (!iGRID.Equals(String.Empty))
                sqlt += " and grid=" + iGRID;
            if (!iETID.Equals(String.Empty))
                sqlt += " and etid=" + iETID;
            if (!iSex.Equals(String.Empty))
                sqlt += " and psex=" + iSex;
            if (!iTTID.Equals(String.Empty))
                sqlt += " and ttid=" + iTTID;
            if (!iRID.Equals(String.Empty))
                sqlt += " and RID=" + iRID;

            sqlt += " order by pid asc";

            DataTable tbl = DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
            iCount = 0;
            foreach (DataRow r in tbl.Rows)
            {
                iCount += 1;
            }
            return tbl;
        }
        public static DataTable ChartDescription(string iBID)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwChartDesc] where bid =" + iBID, Resources.Resource.txtConnectionString);
        }
        public static DataTable TransfereTypeForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [TTName],[TTID]  FROM [dbo].[tblTransfereTypes]", Resources.Resource.txtConnectionString, "<نحوه انتقال>");
            }
        }
        public static DataTable BranchPersonnelList(string iBid)
        {
            return DBTools.Convert.QueryToTable("SELECT [PID],[PName],[POName], TTName  FROM [dbo].[vwPersonnelsBranches] where [PSid]=1 and BID =" + iBid + "    order by PID", Resources.Resource.txtConnectionString);
            
        }
        public static DataTable Chart
        {
            get
            {
                DataTable tbl = DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwChart]", Resources.Resource.txtConnectionString);
                DataRow mr = tbl.NewRow();
                int smCount = 0, smContracted = 0, smTotal = 0;
                foreach (DataRow r in tbl.Rows)
                {
                    smCount += int.Parse(r["count"].ToString());
                    smTotal += int.Parse(r["personnelsum"].ToString());
                    smContracted += int.Parse(r["BCurrentContractedPersonnel"].ToString());
                }
                mr["bid"] = 0;
                mr["bname"] = "جمع";
                mr["count"] = smCount;
                mr["personnelsum"] = smTotal;
                mr["BCurrentContractedPersonnel"] = smContracted;
                tbl.Rows.Add(mr);
                return tbl;
                
            }
        }
        public static void DeleteEmployment(string iPid, DateTime iStartDay)
        {
            DBTools.Convert.ExecuteScalar("delete from tblPersonnelsBranches where PID="+iPid+" and StartDay='"+iStartDay+"'", Resources.Resource.txtConnectionString);


        }
        public static void DeleteGrade(string iPid, DateTime iEffectDate)
        {
            DBTools.Convert.ExecuteScalar("delete from tblPersonnelsGrades where PID=" + iPid + " and GRGetDate='" + iEffectDate+"'", Resources.Resource.txtConnectionString);
        }


        public static DataTable LoadPersonnelBranches(string iPid)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwPersonnelBranchesList]  where PID=" + iPid+" order by StartDay desc", Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadPersonnelGrades(string iPid)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwPersonnelGradesList] where pid=" + iPid+" order by grgetdate desc", Resources.Resource.txtConnectionString);
        }
        public static DataTable MilitaryStatsForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [MSName],[MSId] FROM [tblMilitaryStats]", Resources.Resource.txtConnectionString, "<وضعيت نظام وظيفه>");
            }
        }
        public static DataTable PersonnelStatusForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [PSName],[PSID]  FROM [dbo].[tblPersonnelStats]", Resources.Resource.txtConnectionString, "<وضعيت شاغل>");
            }
        }
        public static DataTable LoadArchiveIDs(string iPID)
        {
            return DBTools.Convert.QueryToTable("SELECT [OffArchiveID]  N'رديف مرخصي',[ArchiveID]  N'شماره بايگاني'  FROM [dbo].[tblPersonnels] where PID=" + iPID, Resources.Resource.txtConnectionString);
        }
        public static void AddPersonnel(string iPID, string iPName, string iPSex, string iPMarried,string iPChildren, DateTime iPDOE, DateTime iPDOB,string iEmploymentType,string iMilitaryStatus,string iEmployeeStatus,string iPOE,string iPOB, string iPNID, string iPIDNumber, string iPSerialClass, string iPSerial , string iPAddress, string iPPhone, string iPCellPhone,string iPostalCode,string iArchiveId,string iOffArchiveId)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddEmployee] @pid ,@pname ,@psex ,@pmarried ,@pchildren ,@pdoe ,@pdob ,@poe ,@pob ,@pnid ,@pidnumber ,@pserialclass ,@pserial ,@paddress ,@pphone ,@pcellphone ,@employmenttype ,@militarystat ,@postalcode ,@pstat,@archieId,@offArchiveId");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters["@pid"].Value = int.Parse(iPID);
            cmd.Parameters.Add("@pname", SqlDbType.NVarChar);
            cmd.Parameters["@pname"].Value = iPName;
            cmd.Parameters.Add("@psex", SqlDbType.Bit);
            cmd.Parameters["@psex"].Value = bool.Parse(iPSex);
            cmd.Parameters.Add("@pmarried", SqlDbType.Bit);
            cmd.Parameters["@pmarried"].Value = bool.Parse(iPMarried);
            cmd.Parameters.Add("@pchildren", SqlDbType.Int);
            cmd.Parameters["@pchildren"].Value = int.Parse(iPChildren);
            cmd.Parameters.Add("@pdoe", SqlDbType.DateTime);
            cmd.Parameters["@pdoe"].Value =iPDOE;
            cmd.Parameters.Add("@pdob", SqlDbType.DateTime);
            cmd.Parameters["@pdob"].Value = iPDOB;
            cmd.Parameters.Add("@poe", SqlDbType.NVarChar);
            cmd.Parameters["@poe"].Value = iPOE;
            cmd.Parameters.Add("@pob", SqlDbType.NVarChar);
            cmd.Parameters["@pob"].Value = iPOB;
            cmd.Parameters.Add("@pnid", SqlDbType.Char);
            cmd.Parameters["@pnid"].Value = iPNID;
            cmd.Parameters.Add("@pidnumber", SqlDbType.NChar);
            cmd.Parameters["@pidnumber"].Value = iPIDNumber;
            cmd.Parameters.Add("@pserialclass", SqlDbType.Char);
            cmd.Parameters["@pserialclass"].Value = iPSerialClass;
            cmd.Parameters.Add("@pserial", SqlDbType.Int);
            cmd.Parameters["@pserial"].Value = int.Parse(iPSerial);
            cmd.Parameters.Add("@paddress", SqlDbType.NVarChar);
            cmd.Parameters["@paddress"].Value = iPAddress;
            cmd.Parameters.Add("@pphone", SqlDbType.VarChar);
            cmd.Parameters["@pphone"].Value = iPPhone;
            cmd.Parameters.Add("@pcellphone", SqlDbType.VarChar);
            cmd.Parameters["@pcellphone"].Value = iPCellPhone;
            cmd.Parameters.Add("@employmenttype", SqlDbType.Int);
            cmd.Parameters["@employmenttype"].Value = int.Parse(iEmploymentType);
            cmd.Parameters.Add("@militarystat", SqlDbType.Int);
            cmd.Parameters["@militarystat"].Value = int.Parse(iMilitaryStatus);
            cmd.Parameters.Add("@postalcode", SqlDbType.VarChar);
            cmd.Parameters["@postalcode"].Value = iPostalCode;
            cmd.Parameters.Add("@pstat", SqlDbType.Int);
            cmd.Parameters["@pstat"].Value =int.Parse(iEmployeeStatus);
            cmd.Parameters.Add("@archieId", SqlDbType.Int);
            cmd.Parameters["@archieId"].Value = int.Parse(iArchiveId);
            cmd.Parameters.Add("@offArchiveId", SqlDbType.Int);
            cmd.Parameters["@offArchiveId"].Value = int.Parse(iOffArchiveId);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            
        }
        public static void LoadPersonnel(string iPid, TextBox iPName, DropDownList iSex, DropDownList iMariageStatus, TextBox iPChildren, TextBox iPOB, TextBox iPOE, TextBox iNid, TextBox iIDNumber, TextBox iSeri, TextBox iSerial, TextBox iAddress, TextBox iPostalCode, TextBox iPhone, TextBox iMobile, ref DateTime iDOE, ref  string iEmploymentType, ref string iMilitaryStatus, ref string iPersonnelStatus, ref DateTime iDOB, ref string iArchiveId, ref string iOffArchiveId)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[tblPersonnels] where pid="+iPid,Resources.Resource.txtConnectionString);
            iPName.Text = tbl.Rows[0]["pname"].ToString();
            if (bool.Parse(tbl.Rows[0]["psex"].ToString()))
                iSex.SelectedValue = "True";
            else
                iSex.SelectedValue = "False";
            if (bool.Parse(tbl.Rows[0]["pmarried"].ToString()))
                iMariageStatus.SelectedValue = "True";
            else
                iMariageStatus.SelectedValue = "False";
            iPChildren.Text = tbl.Rows[0]["pchildren"].ToString();
            iPOB.Text = tbl.Rows[0]["POB"].ToString();
            iPOE.Text = tbl.Rows[0]["POE"].ToString();
            iNid.Text = tbl.Rows[0]["pnid"].ToString();
            iIDNumber.Text = tbl.Rows[0]["pidnumber"].ToString();
            iSeri.Text = tbl.Rows[0]["pserialclass"].ToString();
            iSerial.Text = tbl.Rows[0]["pserial"].ToString();
            iAddress.Text = tbl.Rows[0]["paddress"].ToString();
            iPostalCode.Text = tbl.Rows[0]["postalcode"].ToString();
            iPhone.Text = tbl.Rows[0]["pphone"].ToString();
            iMobile.Text = tbl.Rows[0]["pcellphone"].ToString();
            iDOE = DateTime.Parse(tbl.Rows[0]["pDOE"].ToString());
            iEmploymentType = tbl.Rows[0]["employmenttype"].ToString();
            iMilitaryStatus = tbl.Rows[0]["militarystat"].ToString();
            iPersonnelStatus = tbl.Rows[0]["pstat"].ToString();
            iOffArchiveId = tbl.Rows[0]["OffArchiveID"].ToString();
            iArchiveId = tbl.Rows[0]["ArchiveID"].ToString();
            iDOB = DateTime.Parse(tbl.Rows[0]["pdob"].ToString());
            

            
        }
        public static void ChangePersonnel(string iPID, string iPName, string iPSex, string iPMarried, string iPChildren, DateTime iPDOE, DateTime iPDOB, string iEmploymentType, string iMilitaryStatus, string iEmployeeStatus, string iPOE, string iPOB, string iPNID, string iPIDNumber, string iPSerialClass, string iPSerial, string iPAddress, string iPPhone, string iPCellPhone, string iPostalCode, string iArchiveId, string iOffArchiveId)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spChangeEmployee] @pid ,@pname ,@psex ,@pmarried ,@pchildren ,@pdoe ,@pdob ,@poe ,@pob ,@pnid ,@pidnumber ,@pserialclass ,@pserial ,@paddress ,@pphone ,@pcellphone ,@employmenttype ,@militarystat ,@postalcode ,@pstat,@archieId,@offArchiveId");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters["@pid"].Value = int.Parse(iPID);
            cmd.Parameters.Add("@pname", SqlDbType.NVarChar);
            cmd.Parameters["@pname"].Value = iPName;
            cmd.Parameters.Add("@psex", SqlDbType.Bit);
            cmd.Parameters["@psex"].Value = bool.Parse(iPSex);
            cmd.Parameters.Add("@pmarried", SqlDbType.Bit);
            cmd.Parameters["@pmarried"].Value = bool.Parse(iPMarried);
            cmd.Parameters.Add("@pchildren", SqlDbType.Int);
            cmd.Parameters["@pchildren"].Value = int.Parse(iPChildren);
            cmd.Parameters.Add("@pdoe", SqlDbType.DateTime);
            cmd.Parameters["@pdoe"].Value = iPDOE;
            cmd.Parameters.Add("@pdob", SqlDbType.DateTime);
            cmd.Parameters["@pdob"].Value = iPDOB;
            cmd.Parameters.Add("@poe", SqlDbType.NVarChar);
            cmd.Parameters["@poe"].Value = iPOE;
            cmd.Parameters.Add("@pob", SqlDbType.NVarChar);
            cmd.Parameters["@pob"].Value = iPOB;
            cmd.Parameters.Add("@pnid", SqlDbType.Char);
            cmd.Parameters["@pnid"].Value = iPNID;
            cmd.Parameters.Add("@pidnumber", SqlDbType.NChar);
            cmd.Parameters["@pidnumber"].Value = iPIDNumber;
            cmd.Parameters.Add("@pserialclass", SqlDbType.Char);
            cmd.Parameters["@pserialclass"].Value = iPSerialClass;
            cmd.Parameters.Add("@pserial", SqlDbType.Int);
            cmd.Parameters["@pserial"].Value = int.Parse(iPSerial);
            cmd.Parameters.Add("@paddress", SqlDbType.NVarChar);
            cmd.Parameters["@paddress"].Value = iPAddress;
            cmd.Parameters.Add("@pphone", SqlDbType.VarChar);
            cmd.Parameters["@pphone"].Value = iPPhone;
            cmd.Parameters.Add("@pcellphone", SqlDbType.VarChar);
            cmd.Parameters["@pcellphone"].Value = iPCellPhone;
            cmd.Parameters.Add("@employmenttype", SqlDbType.Int);
            cmd.Parameters["@employmenttype"].Value = int.Parse(iEmploymentType);
            cmd.Parameters.Add("@militarystat", SqlDbType.Int);
            cmd.Parameters["@militarystat"].Value = int.Parse(iMilitaryStatus);
            cmd.Parameters.Add("@postalcode", SqlDbType.VarChar);
            cmd.Parameters["@postalcode"].Value = iPostalCode;
            cmd.Parameters.Add("@pstat", SqlDbType.Int);
            cmd.Parameters["@pstat"].Value = int.Parse(iEmployeeStatus);
            cmd.Parameters.Add("@archieId", SqlDbType.Int);
            cmd.Parameters["@archieId"].Value = int.Parse(iArchiveId);
            cmd.Parameters.Add("@offArchiveId", SqlDbType.Int);
            cmd.Parameters["@offArchiveId"].Value = int.Parse(iOffArchiveId);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);

        }
        public static DataTable EmploymentTypesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [ETName],[ETId] FROM [tblEmploymentTypes]", Resources.Resource.txtConnectionString, "<نوع استخدام>");
            }
        }
        public static string Name(string iPID)
        {
            string temp = String.Empty;
            try
            {
                temp = DBTools.Convert.QueryToString("select PName from dbo.tblPersonnels where pid=" + iPID, Resources.Resource.txtConnectionString);
            }
            catch
            {
                temp = Resources.Resource.txtPersonnelIDIsNotValid;
            }
            return temp;
            
            
        }
        public static bool IsVisible(string iPID)
        {
            string txt = DBTools.Convert.QueryToString("SELECT COUNT(*)  FROM [dbo].[vwPersonnelsBranches] where PID=" + iPID + " and BID in (select BID from tblBranches where BID=" + AB.user.BID + " or BParent =" + AB.user.BID + ")", Resources.Resource.txtConnectionString);
            if (txt.Equals("1"))
            {
                txt = "true";
            }
            else
            {
                txt = "false";
            }
            return bool.Parse(txt);
        }
        public static string Name(string iPID,string iBID)
        {
            string temp = String.Empty;
            try
            {
                temp = DBTools.Convert.QueryToString("select PName from [dbo].[vwPersonnelsBranches] where pid=" + iPID + " and BID=" + iBID, Resources.Resource.txtConnectionString);
            }
            catch
            {
                temp = Resources.Resource.txtPersonnelIDIsNotValid;
            }
            return temp;


        }
        public static DataTable SelectedPersonnelList(ArrayList iPIDList)
        {
            if (iPIDList.Count > 0)
            {
                string sqlt = "SELECT  * FROM [dbo].[vwPersonnelsBranches] where";
                for (int i = 0; i < iPIDList.Count; i++)
                {
                    sqlt += " PID=" + iPIDList[i].ToString();
                    if (iPIDList.Count - i > 1)
                        sqlt += " or";
                }
                sqlt += " order by pid asc";
                return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
            }
            else
                return null;
        }
        public static DataTable SearchPersonnels(string iQuery, string iIP)
        {
            iQuery = iQuery.Replace("ک", "ك").Replace("ی", "ي");
            return DBTools.Convert.QueryToTable("EXEC [dbo].[spSearchPersonnel] @q ='"+iQuery+"'", Resources.Resource.txtConnectionString);
        }
        public static void UpdateDates(string iPid, DateTime iDOB, DateTime iDOE)
        {
            SqlCommand cmd = new SqlCommand("UPDATE [dbo].[tblPersonnels] SET [PDOB] = @DOB,[PDOE] =@DOE WHERE [PID] =@PID");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters.Add("@DOB", SqlDbType.Date);
            cmd.Parameters.Add("@DOE", SqlDbType.Date);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters["@DOE"].Value = iDOE;
            cmd.Parameters["@DOB"].Value = iDOB;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);

        }
        public static void AddUsername(string iPid, string iPWD, bool iIsActive)
        {
            SqlCommand cmd = new SqlCommand("EXEC  [dbo].[spAddUsername] @pid,@pwd,@isactive");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@pwd", SqlDbType.NVarChar);
            cmd.Parameters.Add("@isactive", SqlDbType.Bit);
            cmd.Parameters["@pid"].Value=int.Parse(iPid);
            cmd.Parameters["@pwd"].Value = iPWD;
            cmd.Parameters["@isactive"].Value = iIsActive;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddSchool(string iPid, string iGrid, DateTime iEffectDate, string iGrName, string iDesc)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spAddSchool] @pid ,@grid ,@getdate ,@grname ,@desc ,@adder");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@grid", SqlDbType.Int);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters.Add("@grname", SqlDbType.NVarChar);
            cmd.Parameters.Add("@desc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@getdate", SqlDbType.DateTime);
            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters["@grID"].Value = int.Parse(iGrid);
            cmd.Parameters["@adder"].Value = int.Parse(user.Email);
            cmd.Parameters["@grname"].Value = iGrName ;
            cmd.Parameters["@desc"].Value = iDesc;
            cmd.Parameters["@getdate"].Value = iEffectDate;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddEmployment(string iPid, string iBid,string iBCID, string iPOId, DateTime iStartDate,string iTransfereType, string iDesc)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spAddEmployment] @pid ,@bid,@bcid ,@poid,@startdate ,@updater ,@transferetype,@desc");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters.Add("@bid", SqlDbType.Int);
            cmd.Parameters.Add("@bcid", SqlDbType.Int);
            cmd.Parameters.Add("@poid", SqlDbType.Int);
            cmd.Parameters.Add("@startdate", SqlDbType.DateTime);
            cmd.Parameters.Add("@updater", SqlDbType.Int);
            cmd.Parameters.Add("@transferetype", SqlDbType.VarChar);
            cmd.Parameters.Add("@desc", SqlDbType.NVarChar);

            cmd.Parameters["@PID"].Value = int.Parse(iPid);
            cmd.Parameters["@POID"].Value = int.Parse(iPOId);
            cmd.Parameters["@bid"].Value = int.Parse(iBid);
            try
            {
                cmd.Parameters["@bcid"].Value = int.Parse(iBCID);
            }
            catch
            {
                cmd.Parameters["@bcid"].Value = 0;
            }
            cmd.Parameters["@StartDate"].Value = iStartDate;
            cmd.Parameters["@updater"].Value = user.Email;
            cmd.Parameters["@transferetype"].Value = iTransfereType;
            cmd.Parameters["@desc"].Value = iDesc;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void UpdatePersonnel(string iPID, string iPOID, string iBID, DateTime iStartDate,byte iIsPermanent,string iDesc,string iGrName,string iGrID,DateTime iDOB,DateTime iDOE)
        {

            SqlCommand cmd = new SqlCommand("exec dbo.spUpdatePersonnel @PID,@POID,@BID,@startdate,@Updater,@isPermanent,@desc,@grname,@grid,@DOB,@DOE");
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters.Add("@POID", SqlDbType.Int);
            cmd.Parameters.Add("@BID", SqlDbType.Int);
            cmd.Parameters.Add("@startDate", SqlDbType.Date);
            cmd.Parameters.Add("@updater", SqlDbType.Int);
            cmd.Parameters.Add("@isPermanent", SqlDbType.Bit);
            cmd.Parameters.Add("@desc", SqlDbType.VarChar);
            cmd.Parameters.Add("@grname", SqlDbType.VarChar);
            cmd.Parameters.Add("@GRID", SqlDbType.Int);
            cmd.Parameters.Add("@DOB", SqlDbType.Date);
            cmd.Parameters.Add("@DOE", SqlDbType.Date);

            cmd.Parameters["@PID"].Value = int.Parse(iPID);
            cmd.Parameters["@POID"].Value = int.Parse(iPOID);
            cmd.Parameters["@bid"].Value = int.Parse(iBID);
            cmd.Parameters["@StartDate"].Value = iStartDate;
            cmd.Parameters["@updater"].Value = user.Email;
            cmd.Parameters["@isPermanent"].Value = iIsPermanent;
            cmd.Parameters["@desc"].Value = iDesc;
            cmd.Parameters["@grname"].Value = iGrName;
            cmd.Parameters["@grid"].Value = int.Parse( iGrID);
            cmd.Parameters["@DOB"].Value = iDOB;
            cmd.Parameters["@DOE"].Value = iDOE;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddPersonnel(string iPName,string iPID, string iPOID, string iBID, DateTime iStartDate, bool iIsPermanent)
        {

            SqlCommand cmd = new SqlCommand("exec dbo.spAddPersonnel @PName,@PID,@POID,@BID,@startdate,@Updater,@isPermanent");
            cmd.Parameters.Add("@PName", SqlDbType.NVarChar);
            cmd.Parameters.Add("@PID", SqlDbType.Int);
            cmd.Parameters.Add("@POID", SqlDbType.Int);
            cmd.Parameters.Add("@BID", SqlDbType.Int);
            cmd.Parameters.Add("@startDate", SqlDbType.Date);
            cmd.Parameters.Add("@updater", SqlDbType.Int);
            cmd.Parameters.Add("@isPermanent", SqlDbType.Bit);
            cmd.Parameters["@PName"].Value = iPName;
            cmd.Parameters["@PID"].Value = int.Parse(iPID);
            cmd.Parameters["@POID"].Value = int.Parse(iPOID);
            cmd.Parameters["@bid"].Value = int.Parse(iBID);
            cmd.Parameters["@StartDate"].Value = iStartDate;
            cmd.Parameters["@updater"].Value = 155820;
            cmd.Parameters["@isPermanent"].Value = iIsPermanent;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }

        public static DataTable AllPersonnels
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT  * FROM [dbo].[vwPersonnelsBranches] order by PID desc", Resources.Resource.txtConnectionString);
 
            }
        }
        public static bool IsUserLoggedIn()
        {
            return user != null;
        }
        public static void AddUser(UserInfo iUser)
        {
            


            
            

           


            

        }
       
       
        public static UserInfo Login(string iEmail, string iPWD)
        {
            SqlCommand cmd = new SqlCommand("EXEC spLoginUser @PID ,@password");
            cmd.Parameters.Add("@PID", SqlDbType.NVarChar);
            cmd.Parameters.Add("@password", SqlDbType.NVarChar);
            cmd.Parameters["@PID"].Value = iEmail;
            cmd.Parameters["@password"].Value = iPWD;
            DataTable tbl = DBTools.Convert.QueryToTable(cmd, Resources.Resource.txtConnectionString);
            if ( tbl.Rows[0]["Erno"].ToString().Equals("0"))
                return null;
            else
                return new UserInfo(tbl.Rows[0]["PID"].ToString(), String.Empty, tbl.Rows[0]["display_name"].ToString(), true, tbl.Rows[0]["Permissions"].ToString(), tbl.Rows[0]["BID"].ToString(), tbl.Rows[0]["prefix"].ToString());


            
                
            
            


        }
        public static UserInfo LoadUser(string iEmail)
        {
            SqlCommand cmd = new SqlCommand("EXEC [USR].[sp_load_user] @email");
            cmd.Parameters.Add("@email", SqlDbType.NVarChar);
            
            cmd.Parameters["@email"].Value = iEmail;
            
            DataTable tbl = DBTools.Convert.QueryToTable(cmd, Resources.Resource.txtConnectionString);
            if (tbl.Rows.Count<=0)
                return null;
            else
                return new UserInfo(tbl.Rows[0]["email"].ToString(), tbl.Rows[0]["password"].ToString(), tbl.Rows[0]["display_name"].ToString(), bool.Parse(tbl.Rows[0]["active"].ToString()), tbl.Rows[0]["keys"].ToString(), tbl.Rows[0]["bid"].ToString(), tbl.Rows[0]["prefix"].ToString());

        }
        
        
        public static void ChangePassword(string iPID, string iNewPassword)
        {
            SqlCommand cmd = new SqlCommand("exec spChangePWD @PID,@newPWD");
            cmd.Parameters.Add("@newPWD", SqlDbType.NVarChar);
            cmd.Parameters.Add("@PID", SqlDbType.NVarChar);
            cmd.Parameters["@newPWD"].Value = iNewPassword.Replace('ك', 'ک').Replace('ي', 'ی');
            cmd.Parameters["@PID"].Value = iPID;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);


        }
        public static string UserType(string iEmail,ref string Sex,ref string DisplayName, ref string TypeId)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("SELECT  [user_type_id],[display_name],[sex],[user_type_name] FROM [USR].[vw_users_types] where email='" + iEmail + "'", Resources.Resource.txtConnectionString);
            TypeId = tbl.Rows[0][0].ToString();
            DisplayName = tbl.Rows[0][1].ToString();
            Sex = tbl.Rows[0][2].ToString();
            return tbl.Rows[0][3].ToString();


        }
    }
    public static class Permissions
    {
        public static void AddUserPermission(string iPID, string iPerid)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spAddUserPermission]	@pid ,@perid ,@adder");
            cmd.Parameters.Add("@pid", SqlDbType.Int);
            cmd.Parameters["@pid"].Value = int.Parse(iPID);
            cmd.Parameters.Add("@perid", SqlDbType.Int);
            cmd.Parameters["@perid"].Value = int.Parse(iPerid);
            cmd.Parameters.Add("@adder", SqlDbType.Int);
            cmd.Parameters["@adder"].Value =int.Parse(user.Email);
            
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void DeleteUserPermission(string iPID, string iPerid)
        {
            DBTools.Convert.ExecuteScalar("delete from tbluserspermissions where pid="+iPID+" and perid="+iPerid , Resources.Resource.txtConnectionString);
        }
        public static DataTable ListAllForDropDown
        {
            get
            {
                return DBTools.Convert.QueryToBinding("select PerName ,PerID  from tblPermissions", Resources.Resource.txtConnectionString, "<انتخاب مجوز>");
            }
        }
        public static DataTable ListMineForDropDown
        {
            get
            {
                return DBTools.Convert.QueryToBinding("select PerName ,PerID  from vwAllPermissions where PID=" + user.Email, Resources.Resource.txtConnectionString, "<انتخاب مجوز>");
            }
        }
        public static DataTable Names(string iKeys)
        {
            iKeys = iKeys.Remove(iKeys.Length - 1);
            string[] keys = iKeys.Split('_');
            string q = "SELECT [PerID],[PerName] FROM [dbo].[tblPermissions] where PerID =" + keys[0];
            for (int i = 1; i < keys.Length; i++)
            {
                q += " or PerID =" + keys[i];
            }

            return DBTools.Convert.QueryToTable(q, Resources.Resource.txtConnectionString);
        }
        public static DataTable AllWithSelectedRules(string iRid)
        {
            
                return DBTools.Convert.QueryToTable("EXEC	[dbo].[spRulePermissions] "+iRid, Resources.Resource.txtConnectionString);
            
        }
        public static DataTable AllUserPermission
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwUsersPermissions]", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable MyUserPermission
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwUsersPermissions] where adder="+user.Email, Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable List
        {
            get
            {
                return DBTools.Convert.QueryToTable("select * from tblPermissions", Resources.Resource.txtConnectionString);
            }

        }

    }
    public static class Rules
    {
        public static void Delete(string iRid)
        {
            DBTools.Convert.ExecuteScalar("delete from tblRules where rid="+iRid, Resources.Resource.txtConnectionString);
        }
        public static void UpdateRule(string iRid,string iRName)
        {
            DBTools.Convert.ExecuteScalar("UPDATE [dbo].[tblRules] SET [RName] = N'" + iRName + "' WHERE RID=" + iRid, Resources.Resource.txtConnectionString);
        }
        public static void UpdatePermissions(CheckBoxList iChangeList, string iRid)
        {
            string sqlt = "begin tran";
            sqlt += " delete from dbo.tblRulesPermissions where RID = " + iRid;
            foreach (ListItem l in iChangeList.Items)
            {
                if (l.Selected)
                {
                    sqlt += " insert into dbo.tblRulesPermissions values(" + iRid + "," + l.Value + ",1)";
                }
            }
            sqlt += " commit tran";
            DBTools.Convert.ExecuteScalar(sqlt, Resources.Resource.txtConnectionString);

        }
        public static void UpdatePosts(CheckBoxList iChangeList, string iRid)
        {
            string sqlt = "begin tran";
            sqlt += " delete from dbo.tblPostsRules where RID = " + iRid;
            foreach (ListItem l in iChangeList.Items)
            {
                if (l.Selected)
                {
                    sqlt += " insert into dbo.tblPostsRules values(" + l.Value + "," + iRid + ") ";
                }
            }
            sqlt += " commit tran";
            DBTools.Convert.ExecuteScalar(sqlt, Resources.Resource.txtConnectionString);

        }
        public static void LoadPermissionsInCheckList(ListItemCollection iPermissions , string iRid)
        {
            DataTable tbl = AB.Permissions.AllWithSelectedRules(iRid);

            foreach (DataRow r in tbl.Rows)
            {
                ListItem li = new ListItem();
                li.Selected=bool.Parse(r["selected"].ToString());
                li.Text=r["PerName"].ToString();
                li.Value=r["perId"].ToString();

                iPermissions.Add(li);
            }

        }
        public static void LoadPostsInCheckList(ListItemCollection iPosts, string iRid)
        {
            DataTable tbl = AB.Posts.AllWithSelectedRules(iRid);

            foreach (DataRow r in tbl.Rows)
            {
                ListItem li = new ListItem();
                li.Selected = bool.Parse(r["selected"].ToString());
                li.Text = r["PoName"].ToString();
                li.Value = r["POId"].ToString();

                iPosts.Add(li);
            }
        }

        public static void AddRule(string iRName)
        {
            SqlCommand cmd = new SqlCommand("EXEC	[dbo].[spAddRule] @rname");
            cmd.Parameters.Add("@rname", SqlDbType.NVarChar);
            cmd.Parameters["@rname"].Value = iRName;
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable Permissions(string iRid)
        {
            return DBTools.Convert.QueryToTable("SELECT * from vwSimpleRulePermissions where RID=" + iRid, Resources.Resource.txtConnectionString);
        }

        public static DataTable Posts(string iRid)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwRulesPosts] where RID= " + iRid, Resources.Resource.txtConnectionString);
        }
        public static DataTable List
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM tblRules ", Resources.Resource.txtConnectionString);

            }
        }
    }
    public static class News
    {
        
        public static void AddNews(string iTitle,string iContext,string iKeyWord,string iEmail,bool iIsSticky)
        {
            SqlCommand cmd = new SqlCommand("EXEC [spaddnews] @title , @context ,@user_ref,@keyword,@is_sticky,@bid");
            cmd.Parameters.Add(new SqlParameter("@title",SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@context", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@user_ref", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@keyword", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@is_sticky",SqlDbType.Bit));
            cmd.Parameters.Add(new SqlParameter("@bid", SqlDbType.Int));
            cmd.Parameters["@title"].Value = iTitle.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@context"].Value = iContext.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@keyword"].Value = iKeyWord.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@user_ref"].Value=iEmail;
            cmd.Parameters["@is_sticky"].Value = iIsSticky;
            cmd.Parameters["@bid"].Value =int.Parse( user.BID);
            //if (iIsSticky)
            //    cmd.Parameters["@is_sticky"].Value = "1";
            //else
            //    cmd.Parameters["@is_sticky"].Value = "0";
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);

        }
        public static DataTable StickyNews
        {
            get
            {
                return null;// DBTools.Convert.QueryToTable("SELECT nws_id, nws_title FROM NWS.news where is_sticky=1 order by nws_add_date desc", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable LatestNewsAbstract(byte iCount)
        {
            return DBTools.Convert.QueryToTable("SELECT top " + iCount.ToString() + " * FROM         vwnewslist order by nws_add_date desc", Resources.Resource.txtConnectionString);
            
        }
        public static void LoadNews(long iNwsid, ref string Title, ref string Context,  ref string Email,ref string DisplayName,ref string TypeName,ref string UserCode, ref string Keyword, ref int Visits, ref DateTime AddDate,ref string BID)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("EXEC	[sploadnews] " + iNwsid, Resources.Resource.txtConnectionString);
            Title = tbl.Rows[0]["nws_title"].ToString();
            Context = tbl.Rows[0]["nws_context"].ToString();
            Keyword = tbl.Rows[0]["nws_keyword"].ToString();
            Visits = int.Parse(tbl.Rows[0]["nws_visits"].ToString());
            BID = tbl.Rows[0]["BID"].ToString();
            AddDate = DateTime.Parse(tbl.Rows[0]["nws_add_date"].ToString());
            DisplayName = tbl.Rows[0]["display_name"].ToString();
            TypeName = tbl.Rows[0]["user_type_name"].ToString();
            UserCode = tbl.Rows[0]["user_code"].ToString();
            Email = tbl.Rows[0]["email"].ToString();
        }
        public static DataTable MyNews
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT     nws_id, nws_title, nws_add_date, nws_visits, status_name FROM         NWS.vw_news WHERE     (email = N'" + user.Email + "') ORDER BY nws_add_date DESC", Resources.Resource.txtConnectionString);

            }

        }
        public static void Delete(string iNwsId)
        {
            DBTools.Convert.ExecuteScalar("delete from tblnews where nws_id=" + iNwsId,Resources.Resource.txtConnectionString);

        }
        public static void LoadForChange(string iNwsId, ref string Title, ref string Context, ref string Keyword,ref bool IsSticky)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("select nws_title,nws_context,nws_keyword,is_sticky from tblnews where nws_id=" + iNwsId, Resources.Resource.txtConnectionString);
            Title = tbl.Rows[0]["nws_title"].ToString();
            Context = tbl.Rows[0]["nws_context"].ToString();
            Keyword = tbl.Rows[0]["nws_keyword"].ToString();
            IsSticky = bool.Parse(tbl.Rows[0]["is_sticky"].ToString());

            
        }

        public static void Change(string iNwsId,string iTitle, string iContext, string iKeyword,bool iIsSticky)
        {
            SqlCommand cmd = new SqlCommand("EXEC [spchangenews] @nws_id, @title,	@context ,@keyword,@is_sticky,@bid");
            cmd.Parameters.Add(new SqlParameter("@nws_id",SqlDbType.BigInt));

            cmd.Parameters.Add(new SqlParameter("@title", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@context", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@keyword", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@is_sticky", SqlDbType.Bit));
            cmd.Parameters.Add(new SqlParameter("@bid", SqlDbType.Int));
            cmd.Parameters["@nws_id"].Value = long.Parse(iNwsId);
            cmd.Parameters["@title"].Value = iTitle.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@context"].Value = iContext.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@keyword"].Value = iKeyword.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@is_sticky"].Value = iIsSticky;
            cmd.Parameters["@bid"].Value = int.Parse(user.BID);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);




        }
        public static DataTable LoadAll
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT * FROM vwNews  ORDER BY nws_add_date DESC", Resources.Resource.txtConnectionString);

            }
        }
        public static void AddComment(string iNwsId, string iTitle, string iContext, string iDisplayName, string iEmail)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [NWS].[sp_add_comment] @nws_id  ,@title  ,@context  ,@email  ,@display_name");
            cmd.Parameters.Add(new SqlParameter("@title",SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@context", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@email", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@display_name", SqlDbType.NVarChar));
            cmd.Parameters.Add(new SqlParameter("@nws_id", SqlDbType.BigInt));
            cmd.Parameters["@title"].Value = iTitle.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@context"].Value = iContext.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@display_name"].Value = iDisplayName.Replace('ك', 'ک').Replace('ي', 'ی').Replace("  ", " ").Trim();
            cmd.Parameters["@email"].Value=iEmail;
            cmd.Parameters["@nws_id"].Value=long.Parse(iNwsId);
            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static DataTable Comments(string iNwsId)
        {
            return DBTools.Convert.QueryToTable("SELECT     com_title, com_context, com_display_name, com_email FROM         NWS.news_comments WHERE     (nws_id_ref = "+iNwsId+")", Resources.Resource.txtConnectionString);

        }
    }
    public static class Advertisment
    {
       public static DataTable LoadAdver(string iCampainId,string iLoacation,string iTitle)
       {
           return DBTools.Convert.QueryToTable("EXEC [GNR].[sp_load_adver] " + iCampainId + ",N'" + iLoacation + "',N'" + iTitle + "'", Resources.Resource.txtConnectionString);
       }
       public static void RegisterAdver(string iAdverId, string iUrl, string iTitle)
       {
           DBTools.Convert.ExecuteScalar("exec gnr.sp_register_adver "+iAdverId+",N'"+iUrl+"',N'"+iTitle+"'", Resources.Resource.txtConnectionString);
       }
       public static void GetDimantion(string iCampId,ref string Width,ref string Height)
       {
           DataTable tbl = DBTools.Convert.QueryToTable("SELECT box_width, box_height FROM  GNR.campains WHERE (campid ="+iCampId+")", Resources.Resource.txtConnectionString);
           Width = tbl.Rows[0]["box_width"].ToString();
           Height = tbl.Rows[0]["box_height"].ToString();
       }

    }
    public static class Statistics
    {
        public static void AddPageStatistic(string iPid, string iUrl,string iIP)
        {
            string sqlt = "INSERT INTO [dbo].[tblPageStatistics] ([pid],[staturl],[statIP]) VALUES ("+iPid+","+iUrl+","+iIP+")";
            DBTools.Convert.ExecuteScalar(sqlt, Resources.Resource.txtConnectionString);
        }
    }
    public static class System
    {
        public static DataTable LoadBranches(string iBID)
        {
            string sqlt = String.Empty;
            if (!iBID.Equals(String.Empty))
            {
                sqlt = String.Format("select bid from tblBranches where bid={0}", iBID);
            }
            else
            {
                sqlt = "select bid from tblBranches";
            }
            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
        }
        public static class SATNA
        {
            public static DataTable SatnaGroupChange
            {
                get
                {
                    return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwsatnaGroup] where  stat=1 order by bid asc", Resources.Resource.txtConnectionString);
                }
            }
            public static void DeleteSATNAMember(string iBID, string iPID)
            {
                DBTools.Convert.ExecuteScalar("delete from tblSATNAGroup where bid=" + iBID + " and PID=" + iPID, Resources.Resource.txtConnectionString);
            }
            public static void RegisterSatnaMember(string iBID, string iPID)
            {
                DBTools.Convert.ExecuteScalar("update tblSatnaGroup set stat=2 where bid=" + iBID + " and PID=" + iPID, Resources.Resource.txtConnectionString);
            }
            public static bool IsSATNAGroupHasRegisterer(string iBID)
            {
                return bool.Parse(DBTools.Convert.QueryToString("EXECUTE [dbo].[spIsSATNAGroupHasMember]  " + iBID + ",0", Resources.Resource.txtConnectionString));
            }
            public static bool IsSATNAGroupHasConfirmer(string iBID)
            {
                return bool.Parse(DBTools.Convert.QueryToString("EXECUTE [dbo].[spIsSATNAGroupHasMember]  " + iBID + ",1", Resources.Resource.txtConnectionString));
            }
            public static void AddSATNAMember(string iBID, string iPID, string iRole, string iComputerNumber)
            {
                SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddSatnaMember] @BID,@pid,@adder,@role,@CompNumber");
                cmd.Parameters.Add("@BID", SqlDbType.Int);
                cmd.Parameters.Add("@pid", SqlDbType.Int);
                cmd.Parameters.Add("@Role", SqlDbType.Int);
                cmd.Parameters.Add("@compNumber", SqlDbType.Int);
                cmd.Parameters.Add("@adder", SqlDbType.Int);
                cmd.Parameters["@BID"].Value = int.Parse(iBID);
                cmd.Parameters["@pID"].Value = int.Parse(iPID);
                cmd.Parameters["@compNumber"].Value = int.Parse(iComputerNumber);
                cmd.Parameters["@Role"].Value = int.Parse(iRole);
                cmd.Parameters["@adder"].Value = int.Parse(user.Email);
                DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            }
            public static DataTable SATNAGroup(string iBID)
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwSatnaGroup] where BID =" + iBID, Resources.Resource.txtConnectionString);
            }
           
        }
        public static class ATM
        {
            public static void DeleteATMMEmber(string iBID, string iPID)
            {
                DBTools.Convert.ExecuteScalar("delete from tblATMGroup where bid=" + iBID + " and PID=" + iPID, Resources.Resource.txtConnectionString);
            }
            public static void RegisterATMMember(string iBID, string iPID)
            {
                DBTools.Convert.ExecuteScalar("update tblATMGroup set stat=2 where bid=" + iBID + " and PID=" + iPID, Resources.Resource.txtConnectionString);
            }
            public static bool IsATMGroupHas3Member(string iBID)
            {
                return bool.Parse(DBTools.Convert.QueryToString("EXEc [dbo].[spIsATMHasMember] " + iBID + " ,3", Resources.Resource.txtConnectionString));
            }
            public static void AddATMMember(string iBID, string iPID, string iPhone, string iMobile)
            {
                SqlCommand cmd = new SqlCommand("EXEC [dbo].[spAddATMMember] @BID ,@pid,@Phonenumber,@mobilenumber,@adder");
                cmd.Parameters.Add("@BID", SqlDbType.Int);
                cmd.Parameters.Add("@pid", SqlDbType.Int);
                cmd.Parameters.Add("@Phonenumber", SqlDbType.VarChar);
                cmd.Parameters.Add("@mobilenumber", SqlDbType.VarChar);
                cmd.Parameters.Add("@adder", SqlDbType.Int);
                cmd.Parameters["@BID"].Value = int.Parse(iBID);
                cmd.Parameters["@pID"].Value = int.Parse(iPID);
                cmd.Parameters["@Phonenumber"].Value = iPhone;
                cmd.Parameters["@mobilenumber"].Value = iMobile;
                cmd.Parameters["@adder"].Value = int.Parse(user.Email);
                DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            }
            public static DataTable ATMGroupChange
            {
                get
                {
                    return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwAtmGroup] where  stat=1 order by bid asc", Resources.Resource.txtConnectionString);
                }
            }
            public static DataTable ATMGroup(string iBID)
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwAtmGroup] where BID =" + iBID, Resources.Resource.txtConnectionString);
            }
            
        }
        
        
    }
    public static class Forum
    {
        public static void Export(string iPath)
        {
            StreamWriter sw = new StreamWriter(iPath,false,Encoding.Unicode);
            DataTable tbl = DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwForum]", Resources.Resource.txtConnectionString);
            int columns = tbl.Columns.Count;
            string s = String.Empty;
            for (int i = 0; i < columns; i++)
                {
                    s += tbl.Columns[i].ColumnName;
                    s += ";";
                }

            sw.WriteLine(s.Remove(s.Length-1,1));
            foreach (DataRow r in tbl.Rows)
            {
                s = String.Empty;
                for (int i = 0; i < columns; i++)
                {
                    s += r[i].ToString();
                    s += ";";
                }
                sw.WriteLine(s.Remove(s.Length-1, 1));
            }
            
            
            sw.Close();
        }
        public static DataTable SearchForum(string iQuery, string iIP)
        {
            iQuery = iQuery.Replace("ک", "ك").Replace("ی", "ي");
            return DBTools.Convert.QueryToTable("EXEC [dbo].[spSearchForum] @q ='" + iQuery + "'", Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadRooms
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT [FID] ,[FText] ,[FTitle] ,subcount FROM [dbo].[vwForum] where FType=1", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable LoadMine(string iFType)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwForum] where fadder="+user.Email+" ftype="+iFType, Resources.Resource.txtConnectionString);
        }
        
        public static DataTable LoadAllDataForBinding
        {
            get
            {
                return DBTools.Convert.QueryToBinding("SELECT [ftypename]+':'+ [FTitle] as ftitle,[FID] FROM [dbo].[vwForum]", Resources.Resource.txtConnectionString,"<لطفا انتخاب كنيد>");
            }
        }
        public static DataTable LoadAllDataForBindingByType(string iFType)
        {

            return DBTools.Convert.QueryToBinding("SELECT [ftypename]+':'+ [FTitle] as ftitle,[FID] FROM [dbo].[vwForum] where FType="+iFType, Resources.Resource.txtConnectionString, "<لطفا انتخاب كنيد>");
           
        }
        public static DataTable LoadAllData
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwForum] order by [FAddDate] desc", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable LoadTopics(string iRoomId)
        {
            return DBTools.Convert.QueryToTable("SELECT [FID] ,[FText] ,[FTitle],subcount  FROM [dbo].[vwForum] where FType=2 and fparent=" + iRoomId, Resources.Resource.txtConnectionString);
            
        }
        public static DataTable LoadActiveUsers(string iCount)
        {
            return DBTools.Convert.QueryToTable("SELECT top " + iCount + " fadder , pname,COUNT(*) as [count] from [dbo].[vwForum] where FType=3 and DATEDIFF(dd,fadddate,getdate())<45 group by FAdder ,pname order by [count] desc", Resources.Resource.txtConnectionString);

        }
        public static DataTable LoadLatestTopics(string iCount)
        {
            return DBTools.Convert.QueryToTable("SELECT top "+iCount+" [FID] ,[FText] ,[FTitle],subcount  FROM [dbo].[vwForum] where FType=2 order by fadddate desc ", Resources.Resource.txtConnectionString);

        }
        public static DataTable LoadLatestOpinions(string iCount)
        {
            return DBTools.Convert.QueryToTable("SELECT top "+iCount+" fparent,fid, FTitle, FText, FAddDate, PName, FParentTitle, FAdder FROM vwForum where FType=3 order by FAddDate desc", Resources.Resource.txtConnectionString);

        }
        public static DataTable LoadStatement(string iTopicId)
        {

            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwForum] where FType=3 and fparent=" + iTopicId+" order by fadddate desc", Resources.Resource.txtConnectionString);

        }
        public static void LoadById(string iFid, ref string FText, ref string FParent, ref string FAdder, ref DateTime FAddDate, ref string FType, ref string FTitle)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("SELECT * FROM tblForum WHERE (FID = " + iFid + ")", Resources.Resource.txtConnectionString);
            FText = tbl.Rows[0]["FText"].ToString();
            FParent = tbl.Rows[0]["FParent"].ToString();
            FAdder = tbl.Rows[0]["FAdder"].ToString();
            FAddDate = DateTime.Parse(tbl.Rows[0]["FAddDate"].ToString());
            FType = tbl.Rows[0]["FType"].ToString();
            FTitle = tbl.Rows[0]["FTitle"].ToString();
        }
        public static void LoadById(string iFid, ref string FText, ref string FTitle)
        {
            DataTable tbl = DBTools.Convert.QueryToTable("SELECT ftext,ftitle FROM tblForum WHERE (FID = " + iFid + ")", Resources.Resource.txtConnectionString);
            FText = tbl.Rows[0]["FText"].ToString();
            FTitle = tbl.Rows[0]["FTitle"].ToString();
        }
        public static void Delete(string iId)
        {
            DBTools.Convert.ExecuteScalar("delete from [dbo].[tblForum] where fid=" + iId, Resources.Resource.txtConnectionString);

        }
        public static void AddRoom(string iTitle)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddForum] @FText,@FParent,@FAdder,@FType,@ftitle");

            cmd.Parameters.Add("@ftext", SqlDbType.NVarChar);
            cmd.Parameters.Add("@fparent", SqlDbType.BigInt);
            cmd.Parameters.Add("@fadder", SqlDbType.Int);
            cmd.Parameters.Add("@ftype", SqlDbType.TinyInt);
            cmd.Parameters.Add("@ftitle", SqlDbType.NVarChar);


            cmd.Parameters["@ftext"].Value = null;
            cmd.Parameters["@fparent"].Value = null;
            cmd.Parameters["@fadder"].Value = user.Email;
            cmd.Parameters["@ftype"].Value = 1;
            cmd.Parameters["@ftitle"].Value = iTitle;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void ChangeData(string iFID,string iFTitle,string iFText,DateTime iFAddDate,string iFAdder,string iFType,string iFParent)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spChangeForum] @fid,@FText,@FParent,@FAdder,@FAddDate,@FType,@ftitle");
            cmd.Parameters.Add("@fid", SqlDbType.BigInt);
            cmd.Parameters.Add("@ftext", SqlDbType.NVarChar);
            cmd.Parameters.Add("@fparent", SqlDbType.BigInt);
            cmd.Parameters.Add("@fadder", SqlDbType.Int);
            cmd.Parameters.Add("@faddDate", SqlDbType.DateTime);
            cmd.Parameters.Add("@ftype", SqlDbType.TinyInt);
            cmd.Parameters.Add("@ftitle", SqlDbType.NVarChar);

            cmd.Parameters["@fid"].Value = int.Parse(iFID);
            cmd.Parameters["@ftext"].Value = iFText;
            if (iFParent.Equals(String.Empty))
                cmd.Parameters["@fparent"].Value =null;
            else
                cmd.Parameters["@fparent"].Value = int.Parse(iFParent);
            cmd.Parameters["@fadder"].Value = int.Parse(iFAdder);
            cmd.Parameters["@faddDate"].Value = iFAddDate;
            cmd.Parameters["@ftype"].Value = int.Parse(iFType);
            cmd.Parameters["@ftitle"].Value = iFTitle;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void AddTopic(string iTitle,string iRoomNumber,string iTopicDescription)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddForum] @FText,@FParent,@FAdder,@FType,@ftitle");

            cmd.Parameters.Add("@ftext", SqlDbType.NVarChar);
            cmd.Parameters.Add("@fparent", SqlDbType.BigInt);
            cmd.Parameters.Add("@fadder", SqlDbType.Int);
            cmd.Parameters.Add("@ftype", SqlDbType.TinyInt);
            cmd.Parameters.Add("@ftitle", SqlDbType.NVarChar);


            cmd.Parameters["@ftext"].Value = iTopicDescription;
            cmd.Parameters["@fparent"].Value = int.Parse(iRoomNumber);
            cmd.Parameters["@fadder"].Value = user.Email;
            cmd.Parameters["@ftype"].Value = 2;
            cmd.Parameters["@ftitle"].Value = iTitle;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }

        public static void AddData(string iTitle, string iParent, string iType, string iTopicDescription)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddForum] @FText,@FParent,@FAdder,@FType,@ftitle");

            cmd.Parameters.Add("@ftext", SqlDbType.NVarChar);
            cmd.Parameters.Add("@fparent", SqlDbType.BigInt);
            cmd.Parameters.Add("@fadder", SqlDbType.Int);
            cmd.Parameters.Add("@ftype", SqlDbType.TinyInt);
            cmd.Parameters.Add("@ftitle", SqlDbType.NVarChar);
            
            cmd.Parameters["@ftext"].Value = iTopicDescription;
            if (!iParent.Equals(String.Empty))
                cmd.Parameters["@fparent"].Value = int.Parse(iParent);
            else
                cmd.Parameters["@fparent"].Value = 0;
            cmd.Parameters["@fadder"].Value = user.Email;
            cmd.Parameters["@ftype"].Value = int.Parse(iType);
            cmd.Parameters["@ftitle"].Value = iTitle;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        
        public static void AddStatement(string iStatement, string iTopicNumber)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddForum] @FText,@FParent,@FAdder,@FType,@ftitle");

            cmd.Parameters.Add("@ftext", SqlDbType.NVarChar);
            cmd.Parameters.Add("@fparent", SqlDbType.BigInt);
            cmd.Parameters.Add("@fadder", SqlDbType.Int);
            cmd.Parameters.Add("@ftype", SqlDbType.TinyInt);
            cmd.Parameters.Add("@ftitle", SqlDbType.NVarChar);

            cmd.Parameters["@ftext"].Value =iStatement;
            cmd.Parameters["@fparent"].Value = int.Parse(iTopicNumber);
            cmd.Parameters["@fadder"].Value = user.Email;
            cmd.Parameters["@ftype"].Value = 3;
            cmd.Parameters["@ftitle"].Value = null;

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static class Chat
        {
            public static DataTable loadStatments(string iStartDate)
            {
                
                    return  DBTools.Convert.QueryToTable("SELECT top 10 *  FROM [dbo].[vwChat] where adddate>'"+iStartDate+"'  order by chtid desc", Resources.Resource.txtConnectionString);
                
            }
            public static void AddStatement(string iPID, string iStatement)
            {
                SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddstatment] @pid,@statement");
                
                cmd.Parameters.Add("@pid", SqlDbType.Int);
                cmd.Parameters.Add("@statement", SqlDbType.NVarChar);
                
                
                cmd.Parameters["@pID"].Value = int.Parse(iPID);
                cmd.Parameters["@statement"].Value = iStatement;
                
                DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
                
            }
        }
    }
    public static class Convert
    {
        public static DataTable loadGardesh
        {
            get
            {
               return DBTools.Convert.QueryToTable("SELECT  *  FROM [dbo].[_vw_gardesh_all]", Resources.Resource.txtConnectionString);
            }
        }
        public static void UpdateGardesh(string iPID,string iBID,string iPOID,string iStartday)
        {
            DBTools.Convert.ExecuteScalar("INSERT INTO [dbo].[tblPersonnelsBranches]   ([PID],[BID],[POID],[StartDay],[updater],[updateDate],[desc],[transfereType] ,[BCID]) VALUES   ("+iPID+","+iBID+","+iPOID+",'"+iStartday+"',155820,getdate(),'Convert',1,null)", Resources.Resource.txtConnectionString);
            
        }
    }
    public static class LoanInfo
    {
        public static class Answers
        {
            public static DataTable TotalReport(string iLIID)
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwLoanInfoSummery] where liid="+iLIID, Resources.Resource.txtConnectionString);

            }
            public static DataTable DetailReport(string iLIID)
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwLoanInfoAnswers] where LIID="+iLIID+"  order by LIID,bid,LIPID", Resources.Resource.txtConnectionString);
            }
            public static DataTable BranchStats(string iLIID)
            {
                return DBTools.Convert.QueryToTable("SELECT distinct bid,BName,astat  FROM [dbo].[vwLoanInfoAnswers] where astat=3 and LIID =" + iLIID, Resources.Resource.txtConnectionString);
            }
            public static void SetBranchAnswerStat(string iLIID, string iBID, string iStat)
            {
                DBTools.Convert.ExecuteScalar("update dbo.tblLoanInfoAnswers set AStat=" + iStat + " where bid = " + iBID + " and lipid in (select lipid from dbo.tblLoanInfoParams where LIID=" + iLIID + ")", Resources.Resource.txtConnectionString);
            }
            public static void Add(ArrayList iAnswers,string iStat)
            {
                string codeTemp = "EXECUTE [dbo].[spAddLoanInfoAnswers] {0},{1},{2},{3},{4}";
                string sqlt = String.Empty;
                for (int i = 0; i < iAnswers.Count; i++)
                {
                    ListItem li =(ListItem) iAnswers[i];
                    sqlt += String.Format(codeTemp, li.Text, li.Value, user.Email, user.BID,iStat)+";\n";

                }
                

                DBTools.Convert.ExecuteScalar(sqlt, Resources.Resource.txtConnectionString);
            }
            public static string AnswerStat(string iLIID,string iBID)
            {

                string stat = DBTools.Convert.QueryToString("EXECUTE [dbo].[spCheckLoanInfoAnswerStat] "+iLIID+","+iBID, Resources.Resource.txtConnectionString);
                return stat;
            }
            public static bool CanAnswer(string iLIID)
            {
                string stat = AnswerStat(iLIID,user.BID);
                if (stat.Equals("3"))
                    return false;
                else
                    return true;

            }
            public static void Load(string iLIPID, string iBID)
            {
            }
            
            
        }
        public static class Params
        {
            public static DataTable LoadForInput(string iLIID)
            {
                return DBTools.Convert.QueryToTable("exec spLoadBranchLoanInfoAnswer "+user.BID+","+iLIID, Resources.Resource.txtConnectionString);
            }
            public static DataTable Load(string iLIID)
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[tblLoanInfoParams]  where LIID=" + iLIID, Resources.Resource.txtConnectionString);
            }
            public static void Add(string iLIID, string iTitle, string iDesc, string iMinValue, string iMaxValue)
            {
                SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spAddLoanInfoParam] @LIID,@LIPTitle,@LIPDesc ,@MinValue  ,@MaxValue");
                cmd.Parameters.Add("@LIID", SqlDbType.Int);
                cmd.Parameters.Add("@LIPTitle", SqlDbType.NVarChar);
                cmd.Parameters.Add("@LIPDesc", SqlDbType.NVarChar);
                cmd.Parameters.Add("@MinValue", SqlDbType.Int);
                cmd.Parameters.Add("@MaxValue", SqlDbType.Int);

                cmd.Parameters["@LIID"].Value = int.Parse(iLIID);
                cmd.Parameters["@LIPTitle"].Value = iTitle;
                cmd.Parameters["@LIPDesc"].Value = iDesc;
                if(iMinValue.Equals(String.Empty))
                    cmd.Parameters["@MinValue"].Value = 0;
                else
                    cmd.Parameters["@MinValue"].Value = int.Parse(iMinValue);
                if(iMaxValue.Equals(String.Empty))
                    cmd.Parameters["@MaxValue"].Value =0;
                else
                    cmd.Parameters["@MaxValue"].Value = int.Parse(iMaxValue);
                

                DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            }
            public static void Delete(string iLIPID)
            {
                DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spDeleteLoanInfoParam] " + iLIPID, Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable LoadAll
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[tblLoanInfos]", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable LoadForInput()
        {

            return DBTools.Convert.QueryToTable("SELECT *,DATEADD(dd,-1,LIEnd) as endDateCaption  FROM [dbo].[tblLoanInfos]  where GETDATE() between LIStart and LIEnd", Resources.Resource.txtConnectionString);
            
        }
        public static void Delete(string iLIID)
        {
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spDeleteLoanInfo] " + iLIID, Resources.Resource.txtConnectionString);
        }
        public static void Add(string iName,string iDesc,DateTime iStart,DateTime iEnd,string iStat)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [edari].[dbo].[spAddLoanInfo] @LIName,@LIDesc,@LIStart,@LIEnd,@LIAdder,@LIStat");
            cmd.Parameters.Add("@LIName", SqlDbType.NVarChar);
            cmd.Parameters.Add("@LIDesc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@LIStart", SqlDbType.SmallDateTime);
            cmd.Parameters.Add("@LIEnd", SqlDbType.SmallDateTime);
            cmd.Parameters.Add("@LIAdder", SqlDbType.Int);
            cmd.Parameters.Add("@LIStat", SqlDbType.Int);
            cmd.Parameters["@LIName"].Value = iName;
            cmd.Parameters["@LIDesc"].Value = iDesc;
            cmd.Parameters["@LIStart"].Value = iStart;
            cmd.Parameters["@LIEnd"].Value = iEnd;
            cmd.Parameters["@LIAdder"].Value = user.Email;
            cmd.Parameters["@LIStat"].Value =int.Parse( iStat);

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void Update(string iLIID, string iName, string iDesc, DateTime iStart, DateTime iEnd, string iStat)
        {
            SqlCommand cmd = new SqlCommand("EXECUTE [dbo].[spChangeLoanInfo]    @LIID  ,@LIName  ,@LIDesc  ,@LIStart  ,@LIEnd  ,@LIAdder  ,@LIStat");
            cmd.Parameters.Add("@LIID", SqlDbType.NVarChar);
            cmd.Parameters.Add("@LIName", SqlDbType.NVarChar);
            cmd.Parameters.Add("@LIDesc", SqlDbType.NVarChar);
            cmd.Parameters.Add("@LIStart", SqlDbType.SmallDateTime);
            cmd.Parameters.Add("@LIEnd", SqlDbType.SmallDateTime);
            cmd.Parameters.Add("@LIAdder", SqlDbType.Int);
            cmd.Parameters.Add("@LIStat", SqlDbType.Int);
            cmd.Parameters["@LIID"].Value = iLIID;
            cmd.Parameters["@LIName"].Value = iName;
            cmd.Parameters["@LIDesc"].Value = iDesc;
            cmd.Parameters["@LIStart"].Value = iStart;
            cmd.Parameters["@LIEnd"].Value = iEnd;
            cmd.Parameters["@LIAdder"].Value = user.Email;
            cmd.Parameters["@LIStat"].Value = int.Parse(iStat);

            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
    }
    public static class Vosool
    {
        public static string AddContract(string iBid, string iMajor, string iMinor,string iDisplayName,string iType)
        {
            return  DBTools.Convert.QueryToString("EXECUTE [dbo].[spAddContract] " + iBid + "," + iMajor + " ," + iMinor+ " ,N'" +iDisplayName+ "' ," +iType, Resources.Resource.txtConnectionString);
        }
        public static void AddContractLog(string iConId,string iMonthId,string iCount,string iAmount)
        {
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spAddMoavaghLog] " + iConId + "," + iMonthId + " ," + iAmount + " ," + iCount, Resources.Resource.txtConnectionString);
        }
        public static void UpdateContractDetails(string iConId, string iTel, string iGuaranteeName, string iGuaranteeTel, string iPayerName, string iPayerTel, string iResidentName, string iResidentTel,string iAddress)
        {
            DBTools.Convert.ExecuteScalar("UPDATE [dbo].[tblVosoolContracts] SET [con_guarantee_name] =N'" + iGuaranteeName + "' ,[con_guarantee_tel] =N'" + iGuaranteeTel + "' ,[con_payer_name] =N'" + iPayerName + "' ,[con_payer_tel] =N'" + iPayerTel + "' ,[con_resident_name] =N'" + iResidentName + "' ,[con_resident_tel] =N'" + iResidentTel + "' ,[con_tel] =N'" + iTel + "' ,[con_addr]=N'"+iAddress+"'  WHERE con_id ="+iConId, Resources.Resource.txtConnectionString);
        }
        public static string ContractStat(string iBid, string iMajor, string iMinor)
        {
            return DBTools.Convert.QueryToString("SELECT [con_stat] FROM [dbo].[tblVosoolContracts] where BID ="+iBid+" and con_major="+iMajor+" and con_minor = "+iMinor, Resources.Resource.txtConnectionString);
        }
        public static string ContractName(string iBid, string iMajor, string iMinor)
        {
            return DBTools.Convert.QueryToString("SELECT [display_name] FROM [dbo].[tblVosoolContracts] where BID =" + iBid + " and con_major=" + iMajor + " and con_minor = " + iMinor, Resources.Resource.txtConnectionString);
        }
        public static DataTable ContractsDetail(string iBid, string iMajor, string iMinor)
        {
            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[tblVosoolContracts] where BID ="+iBid+" and con_major="+iMajor+" and con_minor = "+iMinor, Resources.Resource.txtConnectionString);
        }
        public static void DeleteLog(string iLogId)
        {
            DBTools.Convert.ExecuteScalar("delete FROM dbo.tblVosoolContractsLog where log_id ="+iLogId, Resources.Resource.txtConnectionString);
        }
        public static void DoneReminder(string iRemId)
        {
            DBTools.Convert.ExecuteScalar("UPDATE [dbo].[tblVosoolLogReminders]   SET [is_done] = 1 ,[done_date] = GETDATE() WHERE [rem_id]  ="+iRemId, Resources.Resource.txtConnectionString);
        }
        public static void ConfirmLog(string iLogId,string iConfirmer)
        {
            DBTools.Convert.ExecuteScalar("update dbo.tblVosoolContractsLog set confirmed = 1 , confirmer="+iConfirmer+",confirm_date=getdate() where log_id =" + iLogId, Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadLogs(string iBid,string iMajor,string iMinor)
        {
            string conID = DBTools.Convert.ExecuteScalar("SELECT  con_id  FROM [dbo].[tblVosoolContracts]  where BID = " + iBid + " and con_major = " + iMajor + " and con_minor = " + iMinor, Resources.Resource.txtConnectionString).ToString();
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwVosoolTotalLog] where con_id =" + conID+" order  by add_date desc", Resources.Resource.txtConnectionString);

        }
        public static DataTable LoadBranchLogs(string iBid)
        {
            string q = "SELECT *  FROM [dbo].[vwVosoolLogs]";

            if(! iBid.Equals(String.Empty))
            {
                q+=" where bid = " + iBid ;
            }
            q += "  order by add_date desc";
            return DBTools.Convert.QueryToTable(q, Resources.Resource.txtConnectionString);
            
        }
        
        public static bool IsContractExists(string iBid, string iMajor, string iMinor)
        {
            return bool.Parse(DBTools.Convert.QueryToString("EXECUTE [dbo].[spVosoolIsContractExists] "+iBid+","+iMajor+" ,"+iMinor, Resources.Resource.txtConnectionString));
        }
        public static DataTable DistributionReport(string iBid)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolContractDistribution] @bid =" + iBid, Resources.Resource.txtConnectionString);

        }
        public static DataTable BadAccounts(string iBid)
        {

            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwBadAccounts] where [کد شعبه]="+iBid+"  order by [مجموع بدهکاری] desc" , Resources.Resource.txtConnectionString);

        }
        public static DataTable BadAccounts()
        {

            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwBadAccounts]  order by [مجموع بدهکاری] desc", Resources.Resource.txtConnectionString);

        }
        public static void AssignAllContract(string iPID,string iBID, string iMajorId, string iCount, string iCountTo)
        {

        }
        public static void DisassignAllContract(string iBID, string iMajorId, string iCount, string iCountTo)
        {
            string sqlt = "update vwVosoolContractsAll set PID = null where BID = " + iBID;
            if (!iMajorId.Equals(String.Empty))
            {
                sqlt += " and con_major=" + iMajorId;
            }
            if (!iCount.Equals(String.Empty))
            {
                sqlt += " and moavagh_count>=" + iCount + " and moavagh_count<=" + iCountTo;
            }
            DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);

        }
        public static bool isMoavaghsInserted(string iMID)
        {
            return bool.Parse(DBTools.Convert.QueryToString("if( exists(SELECT [MID] FROM [dbo].[tblVosoolContractsMoavagh] where MID="+iMID+"))	select 'true' else	select 'false'", Resources.Resource.txtConnectionString));
        }
        public static bool isPaymentsInserted(string iMID)
        {
            return bool.Parse(DBTools.Convert.QueryToString("if( exists(SELECT [MID]  FROM [dbo].[tblPayeHoghoogh] where MID="+iMID+"))	select 'true' else	select 'false'", Resources.Resource.txtConnectionString)); 
        }
        public static bool isRewardCalculated(string iMID)
        {
            return  bool.Parse(DBTools.Convert.QueryToString("if( exists(SELECT [MID] FROM [dbo].[tblVosoolRewards] where MID="+iMID+"))	select 'true' else	select 'false'", Resources.Resource.txtConnectionString));
        }
        public static bool isPointCalculated(string iMID)
        {
            return bool.Parse(DBTools.Convert.QueryToString("if (exists(select * from dbo.tblVosoolPoints where MID =" + iMID + "))	select 'true' else	select 'false'", Resources.Resource.txtConnectionString));
        }
        public static bool isStatCalculated(string iMID)
        {
            return bool.Parse(DBTools.Convert.QueryToString("if (exists(select * from dbo.tblVosoolMonthlyStat where MID =" + iMID + "))	select 'true' else	select 'false'", Resources.Resource.txtConnectionString));
        }
        public static DataTable MinorsForBindings
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT CAST( [maj_id] as CHAR(4))+'-'+[maj_name] as maj_name,[maj_id] FROM [dbo].[tblVosoolMajors]", Resources.Resource.txtConnectionString, "<همه سرفصل ها>");
            }
        }
        public static DataTable ContractTypesForBinding
        {
            get
            {
                return DBTools.Convert.QueryToDropDown("SELECT [ct_name],[ct_id] FROM [dbo].[tblVosoolContractTypes]", Resources.Resource.txtConnectionString, "<انواع قرارداد ها>");
            }
        }
        public static DataTable DailyReport
        {
            get
            {
                return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwAbstractall]", Resources.Resource.txtConnectionString);
            }
        }
        public static DataTable DailyReportByDate(DateTime iDate)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolDailyReport] @date='"+iDate.Date.ToShortDateString().Replace("/","-")+"'", Resources.Resource.txtConnectionString);
            
        }
        public static DataTable RegionalSearch(string iQuery,string iBid)
        {

            return DBTools.Convert.QueryToTable("SELECT * FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where bid="+iBid+" and con_addr like '%" + iQuery +"%'", Resources.Resource.txtConnectionString);

        }
        public static DataTable MyContracts(string iPID,string iBID)
        {

            return DBTools.Convert.QueryToTable("SELECT * ,[dbo].[funVosoolContractContacts] ( con_id) as [contact] FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where PID = "+iPID+" and bid = "+iBID+" order by BID,con_major,con_minor", Resources.Resource.txtConnectionString);

        }
        public static DataTable MyContracts(string iPID, string iBID,string iQuery)
        {

            return DBTools.Convert.QueryToTable("SELECT * ,[dbo].[funVosoolContractContacts] ( con_id) as [contact] FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where PID = "+iPID+" and bid = "+iBID+" and (display_name like N'%"+iQuery+"%' or uniq_id='"+iBID+"/"+iQuery+"' ) order by BID,con_major,con_minor", Resources.Resource.txtConnectionString);

        }
        public static DataTable MyAlarms(string iPID)
        {

            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwVosoolLogReminders]  where adder = " + iPID + " and reminder>=0 and is_done =0", Resources.Resource.txtConnectionString);

        }
        public static DataTable MosharekatDailyReportByDate(DateTime iDate)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolMosharekatReport] @date ='" + iDate.Date.ToShortDateString().Replace("/", "-") + "'", Resources.Resource.txtConnectionString);

        }
        public static DataTable ComparativeReport(DateTime iStartDate,DateTime iEndDate)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolComparativeReport] @start_date='" + iStartDate.Date.ToShortDateString().Replace("/", "-") + "',@end_date='" + iEndDate.Date.ToShortDateString().Replace("/", "-") + "'", Resources.Resource.txtConnectionString);

        }
        public static DataTable MosharekatComparativeReport(DateTime iStartDate, DateTime iEndDate)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolMosharekatComparativeReport] @start_date='" + iStartDate.Date.ToShortDateString().Replace("/", "-") + "',@end_date='" + iEndDate.Date.ToShortDateString().Replace("/", "-") + "'", Resources.Resource.txtConnectionString);

        }
        public static DataTable DailyReportTotalByDate(DateTime iDate)
        {

            return DBTools.Convert.QueryToTable("EXEC	[dbo].[spVosoolDailyReportTotal] @date='" + iDate.Date.ToShortDateString().Replace("/", "-") + "'", Resources.Resource.txtConnectionString);

        }
        public static DataTable Contracts(string iBID, string iMajorId,string iCount,string iCountTo)
        {
            string sqlt = "SELECT * FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where bid=" + iBID;
            if (!iMajorId.Equals(String.Empty))
            {
                sqlt += " and con_major=" + iMajorId;
            }
            if (!iCount.Equals(String.Empty))
            {
                sqlt += " and moavagh_count>=" + iCount + " and moavagh_count<=" + iCountTo;
            }
            sqlt += " order by con_major,con_minor";
            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
        }
        public static DataTable UnassignedContracts(string iBID)
        {
            string sqlt = "SELECT * FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where bid=" + iBID;

            sqlt += " and PID is null order by con_major,con_minor";
            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
        }
        public static DataTable Contract(string iBID, string iSearch)
        {
            string sqlt = "";
            if (iSearch.IndexOf("/") < 0)
            {
                sqlt = "SELECT * FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where  pid=" + iSearch;
            }
            else
                sqlt = "SELECT * FROM [dbo].[funVosoolContractsCurrentMoavagh2] () where uniq_id='" + iBID + "/" + iSearch + "'" ;
            sqlt += " order by BID,con_major,con_minor";
            return DBTools.Convert.QueryToTable(sqlt, Resources.Resource.txtConnectionString);
        }
        public static void AssignContract(ArrayList iContracts, string iPID,string iBID)
        {
            string sqlt=String.Empty,sqltemp = "update dbo.tblVosoolContracts set PID = {3} where con_major={0} and con_minor={1} and BID = {2};";
            for (int i = 0; i < iContracts.Count; i++)
            {
                ListItem li = (ListItem)iContracts[i];
                
                sqlt += String.Format(sqltemp, li.Text, li.Value, iBID, iPID);
                
            }
            DBTools.Convert.ExecuteScalar(sqlt, Resources.Resource.txtConnectionString);
        }
        public static DataTable LoadMonthlyStat(string iMID)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwVosoolMonthlyStat] where mid=" + iMID, Resources.Resource.txtConnectionString);

        }
        public static DataTable BranchList(string iMid)
        {
            
            return DBTools.Convert.QueryToTable("select bid , bname,"+iMid+" as mid from tblBranches where BID <>225 order by BID", Resources.Resource.txtConnectionString);
            
        }
        public static void UpdateMonthlyStat(string iStatId,string iGoal,string iReward,string iRewardCount)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[sqVosoolUpdateMonthlyStat] @stat_id ,@reward,@goal,@count");
            cmd.Parameters.Add("@stat_id", SqlDbType.BigInt);
            cmd.Parameters.Add("@reward", SqlDbType.BigInt);
            cmd.Parameters.Add("@goal", SqlDbType.BigInt);
            cmd.Parameters.Add("@count", SqlDbType.Int);

            cmd.Parameters["@stat_id"].Value = Int64.Parse(iStatId);
            cmd.Parameters["@reward"].Value = Int64.Parse(iReward);
            cmd.Parameters["@goal"].Value = Int64.Parse(iGoal);
            cmd.Parameters["@count"].Value = int.Parse(iRewardCount);


            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
        }
        public static void CalculatePoints(string iMID)
        {
            //dorost
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spVosoolCalculateMonthlyPoints2] " + iMID , Resources.Resource.txtConnectionString);
        }
        public static void CalculateMonthlyReward(string iMID, string iReward)
        {
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spVosoolCalculateMonthlyReward] " + iReward + "," + iMID, Resources.Resource.txtConnectionString);
        }
        public static void CalculateRewardShare(string iMID)
        {
            DBTools.Convert.ExecuteScalar("EXECUTE [dbo].[spVosoolCalculateRewardShare] "+iMID, Resources.Resource.txtConnectionString);
            
            
        }
        public static void CalculatePersonnelShare(string iMID)
        {
            

            DBTools.Convert.QueryToString("EXECUTE [dbo].[spVosoolCalculateEveryPersonnelReward] " + iMID, Resources.Resource.txtConnectionString);
        }
        public static void CalculateBranchReward(string iMID,String iBID)
        {
            DBTools.Convert.ExecuteScalar("EXEC	[dbo].[spVosoolCalculatePersonnelRewards] @bid = "+iBID+",@mid = "+iMID, Resources.Resource.txtConnectionString);


        }
        public static DataTable LoadMonthlyReward(string iMID)
        {
            return DBTools.Convert.QueryToTable("SELECT *  FROM [dbo].[vwVosoolRewards] where mid="+iMID+" order by bid ", Resources.Resource.txtConnectionString);
        }
        public static void AddLog(string iText, string iBid, string iMajor, string iMinor, string iAdder,string iStat)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spVosoolAddLog] @bid , @major ,@minor,@message ,@pid ");
            cmd.Parameters.Add("@bid", SqlDbType.Int);
            cmd.Parameters.Add("@major", SqlDbType.Int);
            cmd.Parameters.Add("@minor", SqlDbType.Int);
            cmd.Parameters.Add("@message", SqlDbType.VarChar);
            cmd.Parameters.Add("@pid", SqlDbType.Int);

            cmd.Parameters["@bid"].Value = int.Parse(iBid);
            cmd.Parameters["@major"].Value = int.Parse(iMajor);
            cmd.Parameters["@minor"].Value = int.Parse(iMinor);
            cmd.Parameters["@message"].Value = iText;
            cmd.Parameters["@pid"].Value = int.Parse(iAdder);


            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);
            DBTools.Convert.ExecuteScalar("UPDATE [dbo].[tblVosoolContracts] SET [con_stat] ="+iStat+"  WHERE BID ="+iBid+" and con_major="+iMajor+" and con_minor ="+iMinor, Resources.Resource.txtConnectionString);

        }
        public static void AddLogReminder(DateTime iRemindDate, string iBid, string iMajor, string iMinor, string iAdder)
        {
            SqlCommand cmd = new SqlCommand("EXEC [dbo].[spVosoolAddReminder] @bid ,@major,@minor,@date ,@pid  ");
            cmd.Parameters.Add("@bid", SqlDbType.Int);
            cmd.Parameters.Add("@major", SqlDbType.Int);
            cmd.Parameters.Add("@minor", SqlDbType.Int);
            cmd.Parameters.Add("@date", SqlDbType.Date);
            cmd.Parameters.Add("@pid", SqlDbType.Int);

            cmd.Parameters["@bid"].Value = int.Parse(iBid);
            cmd.Parameters["@major"].Value = int.Parse(iMajor);
            cmd.Parameters["@minor"].Value = int.Parse(iMinor);
            cmd.Parameters["@date"].Value = iRemindDate;
            cmd.Parameters["@pid"].Value = int.Parse(iAdder);


            DBTools.Convert.ExecuteScalar(cmd, Resources.Resource.txtConnectionString);

        }

    }
}
