<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Login" Codebehind="Login.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </asp:ScriptManager>
    <div>
    <div style="border-right: 3px outset; border-top: 3px outset; z-index: 103; left: 24px;
            border-left: 3px outset; width: 416px; border-bottom: 3px outset; position: relative;
            top: 24px; height: 312px; background-color: gainsboro;">
            <table style="position: relative; left: 30px; top: 20px; text-align: center;">
                <tr style="height: 50px;">
                    <td style="font-size: 16pt; font-weight: bold;">
                        Crowd Boards Login</td>
                </tr>
                <tr>
                    <td style="height: 39px">
                        <u>Username</u>:
                        <asp:TextBox ID="tbUsername" AccessKey="u" runat="server" Width="153"
                            TabIndex="2" BorderStyle="Inset" BorderWidth="3px" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="height: 39px">
                        <u>Password</u>:
                        <asp:TextBox ID="tbPassword" AccessKey="p" runat="server" TextMode="Password" Width="153"
                            TabIndex="2" BorderStyle="Inset" BorderWidth="3px" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnLogin" runat="server" Width="96px" Text="Login" Height="32px"
                            TabIndex="3" Font-Bold="true"></asp:Button></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="loginValidator" runat="server" Width="344px" Font-Bold="True" ForeColor="red"
                            Text="Use your CommercePlus login"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 28px; text-align: right;">
                        </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:SqlDataSource ID="sdsUserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="select UserID,Password from Users where UserID=@UserID AND Password=@Password">
            <SelectParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="Password" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
