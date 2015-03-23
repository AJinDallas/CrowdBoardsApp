<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwYahooInvite.aspx.vb"
    Inherits="CrowdBoardsApp.rwYahooInvite" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Crowdboard Team Request</title>
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

        }
    </script>
</head>
<body style="background-color: #fff;">
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
    <div>
        <asp:updatepanel id="UpdatePanel1" runat="server">
            <contenttemplate>
                <div style="width: 100%; margin-top: 10px;">
                    <table width="100%">
                        <tr>
                            <td style="text-align: center;">
                                <span style="color: #788586; font-size: xx-large; padding: 5px 0 0 10px;">Send CrowdBoard Request</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <asp:Label ID="lblMessage" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="width: 100%;">
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <asp:CheckBox ID="cbSelectAll" runat="server" Text="Select All" Font-Bold="true"
                                    AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="margin-top: 15px;">
                                    <asp:DataList ID="nonFriendDatalist" runat="server" RepeatColumns="4" RepeatLayout="Table">
                                        <ItemTemplate>
                                            <div>
                                                <table width="100%" border="0" cellspacing="4">
                                                    <tr>
                                                        <td style="color: #788586;">
                                                            <asp:HiddenField ID="hdnFriendEmail" runat="server" Value='<%# Container.DataItem %>' />
                                                            <asp:CheckBox ID="cbuser" runat="server" />
                                                            <%# Container.DataItem %>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <asp:Button ID="btnSendRequest" runat="server" Text="Send Request" CssClass="primaryButton" />
                            </td>
                        </tr>
                    </table>
                </div>
            </contenttemplate>
        </asp:updatepanel>
    </div>
    </form>
</body>
</html>
