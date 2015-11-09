using System.Data;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;//
using System.Collections.Generic;//

namespace LibraryDAL
{
    public class ChartLayer
    {
        /// <summary>
        /// multioptional method to get any requested book list with paging and sorting 
        /// * required UDF in DB - GetBooks(bool isAvail, int userId)
        /// </summary>
        /// <param name="pagenum"></param>
        /// <param name="pagesize"></param>
        /// <param name="sortdatafield">options - Title, Authors</param>
        /// <param name="sortorder">'asc' or 'desc'</param>
        /// <param name="isAvail"></param>
        /// <param name="userID"></param>
        /// <returns>JSON formatted data  - BookId, Title, Authors, Status('available' or 'DateOut|UserId') </returns>
        public static string GetBooks(int pagenum, int pagesize, string sortdatafield, string sortorder, bool isAvail, int userID)
        {
            string field = (sortdatafield == "") ? "Id" : sortdatafield;
            string query = "SELECT * FROM ( "
                + "  SELECT *, ROW_NUMBER() OVER (ORDER BY " + field + " " + sortorder + ") as row from GetBooks(" + ((isAvail) ? 1 : 0) + "," + userID + ") "
                + " ) a WHERE row > " + pagenum * pagesize + " and row <= " + (pagenum + 1) * pagesize;

            SqlCommand cmd = new SqlCommand(query);
            DataTable dt = DAL.GetData(cmd);
            return DAL.GetJsonData(dt);
        }
        public static int GetBooksCount(bool isAvail, int userID)
        {
            string query = "select Count(*) from GetBooks(" + ((isAvail) ? 1 : 0) + "," + userID + ")";
            SqlCommand cmd = new SqlCommand(query);
            int count = 0;
            try { count = Convert.ToInt32(DAL.GetValue(cmd)); }
            catch { }
            return count;
        }

        public static string GetBookTitle(int id)
        {
            string query = "select Title from Books where id = '" + id + "'";
            SqlCommand cmd = new SqlCommand(query);
            return DAL.GetValue(cmd);
        }

        public static string MoveBook(int bookid, string action, int userId)
        {
            string query = "", res = "Book's moving is failed!", title = GetBookTitle(bookid);
            if (action == "take")
            {
                query = "insert into [Records](BookID,DateOut,DateIn,UserID)"
                    + " values (" + bookid + ",'" + DateTime.Now.ToUniversalTime() + "',null," + userId + ")";
                res = "The \"" + title + "\" was taken!";
            }
            if (action == "return")
            {
                query = "update [Records] set datein='" + DateTime.Now.ToUniversalTime() +
                    "' where userid='" + userId + "' and bookid='" + bookid + "' and datein is null and dateout is not null";
                res = "The \"" + title + "\" was returned!";
            }
            SqlCommand cmd = new SqlCommand(query);
            return res + " " + DAL.GetValue(cmd);
        }
        public static string GetUsingHistory(int bookid)
        {
            string query = "select Name,Surname,DateOut,DateIn from Records, Users" +
                            " where Records.UserID = Users.ID" +
                            " and Records.BookID = " + bookid +
                            " and Records.DateIn is not null " +
                            " order by Records.DateOut";

            SqlCommand cmd = new SqlCommand(query);
            DataTable dt = DAL.GetData(cmd);
            return DAL.GetJsonData(dt);
        }
    }
}
