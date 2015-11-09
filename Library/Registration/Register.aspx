<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Library.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Signup</title>
    <link href="../styles/site.css" rel="stylesheet" />
</head>
<body>
    <div style="font-family:Arial" class ="wrapper">
    <form id="form1" runat="server">  
    <table style="border: 1px solid black">
        <tr>
            <td colspan="2">
                <b>User Registration</b>
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>    
            <td>
                :<asp:TextBox ID="txtName" runat="server">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredNameValidator" 
                runat="server" ErrorMessage="Name required" Text="!"
                ControlToValidate="txtName" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </td>    
        </tr>
            <tr>
            <td>
                Surname
            </td>    
            <td>
                :<asp:TextBox ID="txtSurname" runat="server">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredSurnameValidator" 
                runat="server" ErrorMessage="Surname required" Text="!"
                ControlToValidate="txtSurname" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </td>    
        </tr>
         <tr>
            <td>
                Login
            </td>    
            <td>
                :<asp:TextBox ID="txtLogin" runat="server">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredLoginValidator" 
                runat="server" ErrorMessage="Login required" Text="!"
                ControlToValidate="txtLogin" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </td>    
        </tr>
             <tr>
            <td>
                Email
            </td>    
            <td>
                :<asp:TextBox ID="txtEmail" runat="server">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" 
                runat="server" ErrorMessage="Email required" Text="!"
                ControlToValidate="txtEmail" ForeColor="Red" 
                Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" 
                runat="server" ErrorMessage="Invalid Email" ControlToValidate="txtEmail"
                ForeColor="Red" Display="Dynamic" Text="!"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                </asp:RegularExpressionValidator>
            </td>    
        </tr>
        <tr>
            <td>
                Password
            </td>    
            <td>
                :<asp:TextBox ID="txtPassword" TextMode="Password" runat="server">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" 
                runat="server" ErrorMessage="Password required" Text="!"
                ControlToValidate="txtPassword" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </td>    
        </tr>

        <tr>
            <td>
                   
            </td>    
            <td>
                <asp:Button ID="btnRegister" runat="server" Text="Register" 
                onclick="btnRegister_Click"/>
            </td>    
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red">
                </asp:Label>
            </td>    
        </tr>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="ValidationSummary1" ForeColor="Red" runat="server" />
            </td>    
        </tr>
    </table>
    </form>
    </div>
</body>
</html>
