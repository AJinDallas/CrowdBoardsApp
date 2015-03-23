<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwBoost.aspx.vb" Inherits="CrowdBoardsApp.rwBoost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boost</title>
    <link href='http://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
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
<body style="background-color: #2B2B2B;">
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
        <div>
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
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td style="text-align: center;">
                                                <span class="LabelheadingWhite">Select where to Boost</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;">
                                                <div style="margin-top: 10px;">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="https://www.facebook.com/sharer/sharer.php" target="_blank" title="Boost on Facebook"
                                                    style="color: White;">
                                                    <img src="Images/fb_share.jpg" height="30" width="150" />
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="http://twitter.com/share" target="_blank" title="Boost on twitter" style="color: White;">
                                                    <img src="Images/twitter_share.jpg" height="30" width="150" /></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script src="http://platform.linkedin.com/in.js" type="text/javascript"></script>
                                                <script type="IN/Share"></script>
                                                <%--<a href="http://linkedin.com/share" target="_blank" title="share on linkedIn" style="color: White;">
                                                    <img src="Images/linkedin_share.png" height="30" width="150" /></a>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnShare" runat="server" Text="Boost" CssClass="primaryButton" Visible="false">
                                                </asp:Button>
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryButton">
                                                </asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
    <asp:SqlDataSource ID="sdPostReplies" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Comment) VALUES(@UserID,@PostID,GETDATE(),@Comment)">
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="Comment" />
        </InsertParameters>
    </asp:SqlDataSource>
</body>
</html>
