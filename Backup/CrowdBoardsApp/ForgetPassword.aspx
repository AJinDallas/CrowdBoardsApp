<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ForgetPassword.aspx.vb"
    Inherits="CrowdBoardsApp.ForgetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forget Password</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body class="backgroundColorAndFontColor">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1">
      <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
  </asp:ScriptManager>
   <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
     <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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
             //            var oWindow = GetRadWindow();
             //            oWindow.Close("OK");
             var oWindow = GetRadWindow();
             var url = "Home.aspx";
             oWindow.Close(url);
         }
    </script>
     </telerik:RadScriptBlock>
    
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblForgetPassword" runat="server" CssClass="LabelGreenLarge">Please Reset Your Password!</asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="margin-top: 20px;">
                            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 35%; text-align: right;">
                        <label>
                            New Password</label>
                    </td>
                    <td style="width: 65%;">
                        <telerik:RadTextBox ID="txtPassword" runat="server" TextMode="Password" BackColor="#ececee" ForeColor="#262626">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="txtPassword"
                            Display="Dynamic" ErrorMessage="Password is required." ToolTip="Password is required."
                            ForeColor="Red" SetFocusOnError="true" ValidationGroup="forgotPasswordEmail">x</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        Confirm New Password
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtConfirmPassword" runat="server" TextMode="Password" BackColor="#ececee" ForeColor="#262626">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="txtConfirmPassword"
                            Display="Dynamic" ErrorMessage="Confirm Password is required." ForeColor="Red"
                            SetFocusOnError="true" ToolTip="Confirm Password is required." ValidationGroup="forgotPasswordEmail">x</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="txtPassword"
                            ControlToValidate="txtConfirmPassword" Display="Dynamic" ForeColor="Red" ToolTip="The Password and Confirmation Password must match."
                            ErrorMessage="The Password and Confirmation Password must match." SetFocusOnError="true"
                            ValidationGroup="forgotPasswordEmail">x</asp:CompareValidator>
                        <asp:RegularExpressionValidator ID="passwordRegularExpressionValidator" runat="server"
                            ControlToValidate="txtConfirmPassword" ValidationExpression="^(?=.*\d).{7,15}$"
                            ErrorMessage="Password must be a minumum of 7 characters at least one Numaric value" ValidationGroup="forgotPasswordEmail"
                            CssClass="validation" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="LoginButton" runat="server" CssClass="primaryButton" Text="Sign In"
                            ValidationGroup="forgotPasswordEmail" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="sdGetUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID,UserName,FirstName,LastName,Email,Status,uuid,DateLastLoggedIn from Users WHERE uuid=@uuid and UserID=@UserID"
        UpdateCommand="UPDATE Users SET uuid=null where UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="uuid" />
            <asp:Parameter Name="UserID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateLastlogin" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <UpdateParameters>
            <asp:Parameter Name="UserName" />
        </UpdateParameters>
    </asp:SqlDataSource>
</body>
</html>
