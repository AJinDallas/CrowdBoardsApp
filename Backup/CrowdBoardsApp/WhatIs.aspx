<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WhatIs.aspx.vb" Inherits="CrowdBoardsApp.WhatIs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>What Is</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</head>
<body style="background-color: #90C1F7;">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function OnClientClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
                else if (arg != null) {
                    window.location = arg;
                }
            }

            function openRadWindow() {
                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwLogin.aspx?page=WhatIs";
                manager.open(url, "RadWindow1");
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    <div style="width: 100%;">
        <div style="height: 30px; background-color: #ececee; color: #262626; position: fixed;
            width: 100%;">
            <table width="100%" border="0">
                <tr>
                    <td>
                        &nbsp;<asp:LinkButton ID="lbtnHome" runat="server" Text="Home" ForeColor="#262626"></asp:LinkButton>
                    </td>
                    <td style="text-align: center; font-size: Large;">
                        <div id="updatesDiv" runat="server" class="LabelBlack">
                            Notifications&nbsp;<asp:Label ID="lblUpdates" runat="server" CssClass="LabelheadingRed"></asp:Label></div>
                    </td>
                    <td style="width: 60%; text-align: right;">
                        <div>
                            <asp:LinkButton ID="lbtnBack" runat="server" Text="Back" ForeColor="#262626" PostBackUrl="javascript:history.go(-1);"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnLogout" runat="server" Text="Logout" ForeColor="#262626"></asp:LinkButton>&nbsp;&nbsp;
                            <asp:LinkButton ID="lbtnSignMeUp" runat="server" Text="Sign Me Up" Visible="false"
                                ForeColor="#262626" PostBackUrl="~/Default.aspx"></asp:LinkButton>&nbsp;&nbsp;
                            <asp:LinkButton ID="lbtnLogin" runat="server" Text="Login" Visible="false" ForeColor="#262626"
                                OnClientClick="return openRadWindow();"></asp:LinkButton>&nbsp;&nbsp;
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="background-image: url('Images/WhatIsheader.png'); height: 250px; background-color: #90C1F7;
            background-repeat: no-repeat;">
        </div>
        <div style="background-image: url('Images/whatIsMain.png'); height: 690px; background-color: #90C1F7;
            background-repeat: no-repeat;">
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Width="600" Height="200">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </form>
</body>
</html>
