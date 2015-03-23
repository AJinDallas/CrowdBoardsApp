<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwComment.aspx.vb" Inherits="CrowdBoardsApp.rwComment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Post from Board</title>
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
<body style="background-color: #ffffff;">
    <form id="form1" runat="server">
    <div>
        <asp:scriptmanager runat="server" id="ScriptManager1">
            <scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </scripts>
        </asp:scriptmanager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <div>
            <asp:updatepanel id="UpdatePanel1" runat="server">
                <contenttemplate>
                    <table width="100%" cellpadding="5" cellspacing="5">
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Label ID="lblSuccessMessage" runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblErrorMessage" runat="server"  Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                            <span style="font-size:18px; margin-bottom:5px;">Enter Comment</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5"
                                                    Width="350px" >
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnOk" runat="server" Text="Ok" CssClass="primaryButton"></asp:Button>
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryButton">
                                                </asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </contenttemplate>
            </asp:updatepanel>
        </div>
    </div>
    </form>
    <asp:sqldatasource id="sdPostReplies" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        insertcommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Comment) VALUES(@UserID,@PostID,GETDATE(),@Comment)">
        <insertparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="Comment" />
        </insertparameters>
    </asp:sqldatasource>
</body>
</html>
