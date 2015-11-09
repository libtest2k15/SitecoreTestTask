using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using LibraryBL;

namespace Library
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (LibraryBL.User.Register(txtLogin.Text, txtPassword.Text, txtName.Text, txtSurname.Text, txtEmail.Text))
                    {
                        Response.Redirect("~/Login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Login '" + txtLogin.Text + "' is used, please choose another one";
                    }
                }
            }
        

    }
}