using System;
using System.Collections.Generic;
using System.Configuration;//
using System.Data;//
using System.Data.SqlClient;//
using System.Linq;
using System.Web;
using System.Web.Script.Services;//
using System.Web.Services;//
using System.Web.UI;
using System.Web.UI.WebControls;
using LibraryBL;
using System.Web.Security;
using System.Net.Mail;//

namespace Library
{
    public partial class BookList : System.Web.UI.Page
    {
        static BooksChart bc;
        public static User curUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            bc = new BooksChart(User.Identity.Name);
            curUser = new User(User.Identity.Name);
            container.Attributes.Add("UserId", curUser.Id.ToString());
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetBooks(int pagenum, int pagesize, string sortdatafield, string sortorder, int mode)
        {
            bc.SetMode(mode);
            return bc.GetBooks(pagenum,pagesize,sortdatafield, sortorder); 
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static int GetTotalRowsCount()
        {
            return bc.GetRowsCount();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static string OnMoveBook(int bookid, string action)
        {
           return bc.MoveBook(bookid, action);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static string BookHistory(int bookid)
        {
           return bc.GetBookHistory(bookid);
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static string SendReminder(string[] borrowList)
        {
            string body = "You took the following books in our library: \n";
            SmtpClient smtpClient = new SmtpClient();
            MailMessage mail = new MailMessage();

            mail.From = new MailAddress("libtest2k15@gmail.com", "Borrowed books");
            mail.To.Add(new MailAddress(curUser.Email));
            for (int i = 0; i < borrowList.Count(); i++)
            {
                body += (i+1) + "). \"" + borrowList[i] + "\";\n";
            }
            mail.Body = body;
            try
            {
                smtpClient.Send(mail);
            }
            catch(Exception ex) 
            {
                return ex.Message;
            }
            return "Reminder was sended!";
        }
    }
}