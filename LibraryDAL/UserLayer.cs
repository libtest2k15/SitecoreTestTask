using System.Data;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;//
using System.Collections.Generic;//


namespace LibraryDAL
{
    public class UserLayer
    {
        public static bool UserExists(string login, string password)
        {
            bool isAuthicated = false;
            using (SqlConnection con = new SqlConnection(DAL.conStr))
            {
                SqlCommand cmd = new SqlCommand("UserExists", con);
                cmd.CommandType = CommandType.StoredProcedure;
                
                cmd.Parameters.Add(new SqlParameter("@Login", login));
                cmd.Parameters.Add(new SqlParameter("@Password", password));

                con.Open();
               
                try 
                {
                    isAuthicated = Convert.ToBoolean(cmd.ExecuteScalar());
                }
                catch 
                {
                }

            }
            return isAuthicated;
        }
        public static bool AddUser(string login, string password, string name, string surname, string email) 
        {
            bool isRegistered = false;
            using (SqlConnection con = new SqlConnection(DAL.conStr))
            {
                SqlCommand cmd = new SqlCommand("AddUser", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@Login", login));
                cmd.Parameters.Add(new SqlParameter("@Name", name));
                cmd.Parameters.Add(new SqlParameter("@Surname", surname));
                cmd.Parameters.Add(new SqlParameter("@Email", email));
                cmd.Parameters.Add(new SqlParameter("@Password", password));

                var returnParameter = cmd.Parameters.Add("@Success", SqlDbType.NVarChar);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                con.Open();
                try
                {
                    isRegistered = Convert.ToBoolean(cmd.ExecuteScalar());
                }
                catch
                {
                }
            }
            return isRegistered;
        }
        public static int GetId(string login)
        {
            string query = "select id from Users where Login = '"+login+"'";
            SqlCommand cmd = new SqlCommand(query);
            int count = 0;
            try { count = Convert.ToInt32(DAL.GetValue(cmd)); }
            catch { }
            return count;
        }

        public static string GetName(string login)
        {
            string query = "select Name from Users where Login = '" + login + "'";
            SqlCommand cmd = new SqlCommand(query);
            return DAL.GetValue(cmd);
        }

        public static string GetSurname(string login)
        {
            string query = "select Surname from Users where Login = '" + login + "'";
            SqlCommand cmd = new SqlCommand(query);
            return DAL.GetValue(cmd);
        }

        public static string GetEmail(string login)
        {
            string query = "select Email from Users where Login = '" + login + "'";
            SqlCommand cmd = new SqlCommand(query);
            return DAL.GetValue(cmd);
        }
    }

}
