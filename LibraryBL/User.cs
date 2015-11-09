using LibraryDAL;
using System;//
using System.Web.Security;
using System.Data;//


namespace LibraryBL
{
    public class User
    {
        public string Login { get; private set; }
        public string Name { get { return UserLayer.GetName(Login); }}
        public string Surname { get { return UserLayer.GetSurname(Login);}}
        public string Email { get { return UserLayer.GetEmail(Login); } }

        public int Id { get { return UserLayer.GetId(Login); } }

        public User(string login)
        {
            Login = login;
        }
        public static bool Register(string login, string password, string name, string surname, string email)
        {
            // enable password encryption
            var encryptPassword = FormsAuthentication.
                    HashPasswordForStoringInConfigFile(password, "SHA1");
            return UserLayer.AddUser(login, encryptPassword, name, surname, email);
        }
        public static bool Authenticate(string login, string password)
        {
            // enable password encryption
            var encryptPassword = FormsAuthentication.
                    HashPasswordForStoringInConfigFile(password, "SHA1");
            return UserLayer.UserExists(login, encryptPassword);
        }

    }
}
