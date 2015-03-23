<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwGoogle.aspx.vb" Inherits="CrowdBoardsApp.rwGoogle" %>

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
            oWindow.Close("OK");
        }
    </script>
    <style>
        .sign-in-button, .send-button, .copy-button, .email-button
        {
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            padding: 4px 8px 5px;
            margin-top: 5px;
        }
        .sign-in-button:hover, .send-button:hover, .copy-button:hover, .email-button:hover
        {
            background: none repeat scroll 0 0 #3c6c79;
        }
    </style>
</head>
<body>
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
        <table style="width: 100%; border: 0px solid red;">
            <tr>
                <td style="text-align: center;">
                    <span style="font-size: 20px; color:#788586;">Send CrowdBoard Request</span>
                </td>
                <td>
                    <asp:button id="sendMailButton" runat="server" text="Invite" cssclass="send-button" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:label id="lblMessage" runat="server"></asp:label>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="grIntrestList" runat="server" AutoGenerateColumns="False" AllowMultiRowSelection="true"
            Width="98%" GridLines="None" AllowSorting="true">
            <MasterTableView CommandItemDisplay="Top" DataKeyNames="Email">
                <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="false" />
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" ItemStyle-Width="15"
                        HeaderText="Select All">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image" ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:image id="Image1" width="35" height="35" imageurl='<%# Eval("PhotoUrl") %>'
                                runat="server" onerror="this.src='Images/user_m.jpg';" />
                        </ItemTemplate>
                       
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="Name" HeaderText="Name" HeaderStyle-Width="100" />
                    <telerik:GridBoundColumn DataField="Email" HeaderText="Email Address" HeaderStyle-Width="100" />
                </Columns>
            </MasterTableView>
            <ClientSettings EnableRowHoverStyle="true">
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <ExportSettings FileName="Intrest List">
            </ExportSettings>
        </telerik:RadGrid>
    </div>
    </form>
</body>
</html>
