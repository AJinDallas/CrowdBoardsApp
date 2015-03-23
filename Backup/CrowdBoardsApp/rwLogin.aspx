<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwLogin.aspx.vb" Inherits="CrowdBoardsApp.rwLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
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
       function Ok(page) {

           var url;
           var oWindow = GetRadWindow();
           if (page == "Search") {

               url = "Search.aspx";
           }
           else if (page == "SignUp") {

               url = "Default.aspx";
           }
           else {

               url = "/" + page;
           }

           oWindow.Close(url);
       }
    </script>
</head>
<body class="backgroundColorAndFontColor">
     <form id="form1" runat="server">
    <div>
        <asp:ScriptManager runat="server" ID="ScriptManager1">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table width="100%" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Label ID="lblSuccessMessage" runat="server" CssClass="LabelGreenLarge" Visible="false"></asp:Label>
                            <asp:Label ID="lblErrorMessage" runat="server" CssClass="LabelheadingRed" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 12%; vertical-align: top;">
                                        User Name
                                    </td>
                                    <td style="width: 28%;">
                                        <telerik:RadTextBox ID="txtLogInUserName" runat="server" Width="100%" BackColor="#ececee"
                                            ForeColor="#262626">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtLogInUserName"
                                            ErrorMessage="User Name is required" Text="User Name is required." ForeColor="Red"
                                            ValidationGroup="LoginValidationGroup"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 10%; vertical-align: top;">
                                        Password
                                    </td>
                                    <td style="width: 30%;">
                                        <telerik:RadTextBox ID="txtlogInPassword" runat="server" TextMode="Password" Width="100%"
                                            BackColor="#ececee" ForeColor="#262626">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtlogInPassword"
                                            ErrorMessage="Password is required" Text="Password is required." ForeColor="Red"
                                            ValidationGroup="LoginValidationGroup"></asp:RequiredFieldValidator><br />
                                    </td>
                                    <td style="width: 20%; vertical-align: top;">
                                        <asp:Button ID="LoginButton" runat="server" Text="Sign In" CssClass="primaryMiniButton"
                                            ValidationGroup="LoginValidationGroup" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="text-align:center;">
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryMiniButton" OnClientClick="return Ok('Search');" />&nbsp;
                                        <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="primaryMiniButton" OnClientClick="return Ok('SignUp');"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="sdGetUserIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from Users WHERE UserName=@UserName">
        <SelectParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateLastlogin" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <UpdateParameters>
            <asp:Parameter Name="UserName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
