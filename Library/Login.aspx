<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Library.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="styles/site.css" rel="stylesheet" />
</head>
<body>
    <div class="wrapper">
    <form id="form1" runat="server">
    <div style="font-family:Arial">
    <table style="border: 1px solid black">
        <tr>
            <td colspan="2">
                <b>Login</b><br/>
                <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
            </td>
        </tr>

        <tr>
            <td>
                User Name
            </td>    
            <td>
                :<asp:TextBox ID="txtLogin" runat="server">
                </asp:TextBox>
            </td>    
        </tr>
        <tr>
            <td>
                Password
            </td>    
            <td>
                :<asp:TextBox ID="txtPassword" TextMode="Password" runat="server">
                </asp:TextBox>
            </td>    
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="chkBoxRememberMe" Text="Remember Me" runat="server" Font-Size="Small" />        
            </td>    
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </td>    
        </tr>
    </table>
<br />
<a href="Registration/Register.aspx">Click here to register</a> 
if you do not have a user name and password.
</div>
    </form>
    </div>
</body>
</html>
