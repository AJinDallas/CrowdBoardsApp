<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwValidateEmail.aspx.vb"
    Inherits="CrowdBoardsApp.rwValidateEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Validate Email</title>
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
            var oWindow = GetRadWindow();
            oWindow.Close("OK");
        }
    </script>
</head>
<body style ="background-color:#fbfbfb;">
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
                            <table width="80%" border="0" class="contentWhite">
                                <tr>
                                    <td style="vertical-align: top;">
                                        <span style="color:#788586; font-size:22px;">Your Email Address has not been Validated</span>
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span style="color:#788586;">Email Address:</span>
                                        <asp:TextBox ID="email" runat="server" Width="200px" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="emailRequired" runat="server" ControlToValidate="email"
                                            CssClass="LabelheadingRed" ErrorMessage="E-mail is required." ToolTip="E-mail is required."
                                            Display="Dynamic" ValidationGroup="NameValidationGroup">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email Address is not in well formed"
                                            Display="Dynamic" CssClass="LabelheadingRed" ControlToValidate="email" ValidationGroup="NameValidationGroup"
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                    <br />
                                        <asp:Button ID="btnSend" runat="server" Text="Send" ValidationGroup="NameValidationGroup"
                                            CssClass="primaryButton" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryButton" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
     <asp:SqlDataSource ID="sdUserDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select * from Users where Email =@Email and UserName =@UserName">
        <SelectParameters>
            <asp:Parameter Name="Email" />
             <asp:Parameter Name="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>

    </form>
</body>
</html>
