<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwAssignRole.aspx.vb"
    Inherits="CrowdBoardsApp.rwAssignRole" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assign Roles</title>
    <style type="text/css">
        #loginDiv
        {
            position: fixed;
            top: 50%;
            left: 50%;
            width: 30em;
            height: 18em;
            margin-top: -9em; /*set to a negative number 1/2 of your height*/
            margin-left: -15em; /*set to a negative number 1/2 of your width*/
            border: 1px solid #ccc;
            background-color: #f3f3f3;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function closeMe() {
            var oWindow = GetRadWindow();
            oWindow.Close();
        }
        function Cancel() {
            var oWindow = GetRadWindow();
            oWindow.Close("CANCEL");
        }
        function Ok() {
            var oWindow = GetRadWindow();
            oWindow.Close("OK");
        }
    </script>
      <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'/>
    <link href="../Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <div id="loginDiv">
            <table width="100%" cellpadding="5" cellspacing="5">
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblSuccessMessage" runat="server" ForeColor="Green" Visible ="false" ></asp:Label>
                        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible ="false" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="10" width="100%" border="0">
                            <tr>
                                <td style="vertical-align: top;">
                                    <b>Roles</b>
                                </td>
                                <td>
                                    <div>
                                        <asp:CheckBoxList ID="cblRoles" runat="server" RepeatDirection="Horizontal">
                                        </asp:CheckBoxList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnAssignRole" runat="server" Text="Assing Role" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="sdRoles" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select RoleName,RoleId from dbo.aspnet_Roles"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
