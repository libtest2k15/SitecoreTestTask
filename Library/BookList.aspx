<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookList.aspx.cs" Inherits="Library.BookList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        Library [<%  = User.Identity.Name %>]
    </title>
    <link href="styles/jqx.base.css" rel="stylesheet" />
    <link href="styles/site.css" rel="stylesheet" />
    <script src="scripts/jquery-1.11.1.min.js"></script>
    <script src="scripts/dev-app.js"></script>
    <script src="scripts/jqxcore.js"></script>
    <script src="scripts/jqxdata.js"></script>
    <script src="scripts/jqxbuttons.js"></script>
    <script src="scripts/jqxscrollbar.js"></script>
    <script src="scripts/jqxlistbox.js"></script>
    <script src="scripts/jqxdropdownlist.js"></script>
    <script src="scripts/jqxdatatable.js"></script>
    <script src="scripts/jqxwindow.js"></script>
    <script src="scripts/jqxnotification.js"></script> 
</head>
<body>
    <div id="container" class="wrapper" runat="server">
    <h2>Welcome, <% =curUser.Name+" "+curUser.Surname %>!</h2>
    <form id="form1" runat="server">
        <asp:Button id="logout" runat="server" Text="Logout" OnClick="logout_Click"></asp:Button>
        <asp:RadioButtonList ID="RadioButtonList" runat="server" AutoPostBack="false" RepeatDirection="Horizontal">
            <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
            <asp:ListItem Value="1">Available</asp:ListItem>
            <asp:ListItem Value="2">Taken</asp:ListItem>
                </asp:RadioButtonList>
        <div>
            <div id="Table">                
            </div>
        </div>
    </form>
    </div>
        <div id='modal'>
            <div>Header</div>
            <div>Content</div>
        </div>
    <div class="history-template" style="display:none;">
        <table>
            <thead>
                <tr>
                    <th>User</th>
                    <th>From</th>
                    <th>To</th>
                </tr>
            </thead>
            <tbody class="history-content">
            </tbody>
        </table>
    </div>
    <div class="notification">
    </div>
</body>
</html>
