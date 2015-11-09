using System.Data;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;//
using System.Collections.Generic;//

namespace LibraryDAL
{
    static class DAL
    {
        public static string conStr = ConfigurationManager.ConnectionStrings["LibraryDB"].ConnectionString;
        /// <summary>
        /// Serialize DataTable instance into JSON format
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string GetJsonData(DataTable dt)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {

                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
        public static DataTable GetData(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }
        public static string GetValue(SqlCommand cmd)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                cmd.Connection = con;
                con.Open();
                var res = cmd.ExecuteScalar();
                con.Close();
                return res != null ? res.ToString() : string.Empty;
            }
        }
    }
}
