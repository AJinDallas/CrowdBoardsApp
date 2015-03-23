<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwGmailInvite.aspx.vb"
    Inherits="CrowdBoardsApp.rwGmailInvite" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Crowdboard Team Request</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%--  <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
  <%--  <link href="WebContent/Theme/styles/popup.css" rel="stylesheet" type="text/css" />--%>
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
    <style type="text/css">
        .aktextbox
        {
            font-size: 14px;
            line-height: 2em;
            margin-bottom: 6px;
            padding-left: 5px;
            width: 100%;
        }
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
    <div class="container" style="width:100%;  background-color:#fff; padding:5px;">
      
            <asp:updatepanel id="UpdatePanel1" runat="server">
                <contenttemplate>
                <div style="width: 100%; margin-top: 10px;">
                    <table width="100%">
                        <tr>
                            <td style="text-align: center;">
                                <span class="headline">Send CrowdBoard Request</span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="margin-top: 15px;">
                    <table width="100%" border="0">
                        <tr>
                            <td style="width: 30%;">
                            </td>
                            <td style="text-align: justify;">
                                <span class="contentWhiteLarger">User Name</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtgmailusername" runat="server" Width="200px" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtgmailusername"
                                    ErrorMessage="User Name is required" Text="User Name is required." ForeColor="Red"
                                    ValidationGroup="validationGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%;">
                            </td>
                            <td style="text-align: justify;">
                                <span class="contentWhiteLarger">Password</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" Width="200px" 
                                   ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="passwordRequired" runat="server" ControlToValidate="txtpassword"
                                    ErrorMessage="Password is required" Text="Password is required." ForeColor="Red"
                                    ValidationGroup="validationGroup"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr style="margin-top:5px;">
                        
                            <td style="width: 30%;">
                            </td>
                            <td>
                           
                            </td>
                            <td>
                                <asp:Button ID="btnGetContacts" runat="server" Text="Get Contact List" CssClass="send-button"
                                    ValidationGroup="validationGroup" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="text-align: center;">
                                <asp:Label ID="lblMessage" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="contactListDiv" runat="server" style="width: 100%;" visible="false">
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
                                    <asp:DataList ID="nonFriendDatalist" runat="server" RepeatColumns="3" RepeatLayout="Table">
                                        <ItemTemplate>
                                            <div>
                                                <table width="100%" border="0" cellspacing="4">
                                                    <tr>
                                                        <td>
                                                            <asp:HiddenField ID="hdnFriendEmail" runat="server" Value='<%# Container.DataItem("EmailID") %>' />
                                                            <asp:CheckBox ID="cbuser" runat="server" />
                                                            <%# Container.DataItem("EmailID")%>
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
                                <asp:Button ID="btnSendRequest" runat="server" Text="Send Request" CssClass="send-button" />
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
