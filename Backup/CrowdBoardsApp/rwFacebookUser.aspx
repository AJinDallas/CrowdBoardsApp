<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwFacebookUser.aspx.vb"
    Inherits="CrowdBoardsApp.rwFacebookUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create CrowdBoarders UserName</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
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
            var directoryName = document.getElementById("directoryName").value;
            var oWindow = GetRadWindow();          
            var url;
            if (directoryName != "") {
                url = directoryName;
            }
            else {
                url = "Home.aspx";
            }
            oWindow.Close(url);
        }
    </script>
</head>
<body class="backgroundColorAndFontColor">
    <form id="form1" runat="server">
    <asp:scriptmanager runat="server" id="ScriptManager1">
        <scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </scripts>
    </asp:scriptmanager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <asp:panel id="passwordPanel" runat="server">
        <asp:updatepanel id="UpdatePanel1" runat="server">
            <contenttemplate>
                <table width="100%">
                    <tr>
                        <td colspan="2" style="text-align: center;">
                        <asp:HiddenField id="directoryName" runat="server"></asp:HiddenField>
                            <asp:Label ID="lblfacebookUser" runat="server" CssClass="LabelGreenLarge">Thank You for Logging In With Facebook,Please Create a CrowdBoarders UserName!</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <div style="margin-top: 20px;">
                                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 35%; text-align: right;">
                            <label>
                                Username</label>
                        </td>
                        <td style="width: 65%;">
                            <telerik:RadTextBox ID="txtUserName" runat="server" BackColor="#ececee" ForeColor="#262626">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="LoginButton" runat="server" CssClass="primaryButton" Text="LOGIN" />
                        </td>
                    </tr>
                </table>
            </contenttemplate>
        </asp:updatepanel>
    </asp:panel>
    </form>
    <asp:sqldatasource id="sdUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="IF EXISTS(SELECT * FROM  Users Where FacebookUserID=@FacebookUserID) (select userid as status,UserName as UserName,Status as userStatus,DateLastLoggedIn as DateLastLoggedIn from Users where FacebookUserID=@FacebookUserID) else select 'NotExist' as [status]"
        insertcommand="INSERT INTO Users (UserName,FirstName,LastName,DateRegistered,DateLastLoggedIn,Status,FacebookUserID) VALUES (@UserName,@FirstName,@LastName,getdate(),getdate(),1,@FacebookUserID)"
        updatecommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="FacebookUserID" Type="String" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </updateparameters>
        <insertparameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="FacebookUserID" Type="String" />
        </insertparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetUserIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT UserID from Users WHERE UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </selectparameters>
    </asp:sqldatasource>
</body>
</html>
