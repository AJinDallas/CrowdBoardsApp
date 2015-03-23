<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContactUs.aspx.vb" Inherits="CrowdBoardsApp.ContactUs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/popup.css" rel="stylesheet" type="text/css" />
    <%--<link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .pContent
        {
            margin-left: 30px;
            text-align: justify;
            font-size: larger;
        }
        .spanHeader
        {
            font-weight: 700;
            font-size: larger;
        }
        .spanMargin
        {
            margin-left: 10px;
        }
        .mainHeading
        {
            font-weight: bold;
            font-size: xx-large;
            margin-top: 15px;
            text-align: center;
        }
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
        }
        .sign-in-button:hover, .send-button:hover, .copy-button:hover, .email-button:hover
        {
            background: none repeat scroll 0 0 #3c6c79;
        }
    </style>
</head>
<body style="background-color: #2B2B2B; color: #F0F2FD;">
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
    </telerik:RadScriptBlock>
    <div class="container" style="height: auto; width: 100%;">
        <div class="popup-container" style="width: 100%; min-height: 489px;">
            <div class="third-block">
                <div class="sign-up-container">
                    <div style="font-size: 24px; font-weight: 600; margin-bottom: 18px; margin-top: 40px;
                        color: #788586; text-align: center; width: 100%;">
                        Contact Us</div>
                    <br />
                    <div>
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
                    <br />
                    <div class="signup-information">
                        <form action="" style="padding-left: 25px; padding-right: 25px;">
                        <div class="twotoa-row">
                            <div style="width: 97%;">
                                <asp:TextBox ID="txtFirstName" CssClass="aktextbox" runat="server" placeholder="First Name">
                                </asp:TextBox></div>
                            <div style="width: 1%;">
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                    Display="Dynamic" ForeColor="Red" Text="*" ErrorMessage="Enter First Name" ValidationGroup="submit"></asp:RequiredFieldValidator></div>
                        </div>
                        <div class="twotoa-row">
                            <div style="width: 97%;">
                                <asp:TextBox ID="txtLastName" CssClass="aktextbox" runat="server" placeholder="Last Name">
                                </asp:TextBox></div>
                            <div style="width: 1%;">
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                                    Display="Dynamic" ForeColor="Red" Text="*" ErrorMessage="Enter Last Name" ValidationGroup="submit"></asp:RequiredFieldValidator></div>
                        </div>
                        <div class="twotoa-row">
                            <div style="width: 97%;">
                                <asp:TextBox ID="txtEmail" CssClass="aktextbox" runat="server" placeholder="Email Address">
                                </asp:TextBox>
                                <asp:RegularExpressionValidator ID="txtEmailRegularExpressionValidator" runat="server"
                                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtEmail" ValidationGroup="submit"
                                    ErrorMessage="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                            <div style="width: 1%;">
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    Display="Dynamic" ForeColor="Red" Text="*" ErrorMessage="Enter Email Address"
                                    ValidationGroup="submit"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="twotoa-row">
                            <div style="width: 97%;">
                                <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Rows="6" CssClass="aktextbox"
                                    placeholder="Question">
                                </asp:TextBox></div>
                            <div style="width: 1%;">
                                <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion"
                                    Display="Dynamic" ForeColor="Red" Text="*" ErrorMessage="Enter Question" ValidationGroup="submit"></asp:RequiredFieldValidator></div>
                        </div>
                        </form>
                    </div>
                    <div>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="submit"
                            CssClass="send-button"></asp:Button>
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="return closeMe();"
                            CssClass="send-button"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Width="650" Height="550">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:SqlDataSource ID="sdUserInformation" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select main.*,U.Email from(SELECT userid,FirstName,LastName FROM vwUserInfo 
Where UserID=@UserID)main inner join Users U on U.UserID =main.userid">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>


      <asp:SqlDataSource ID="sdContactUs" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
       InsertCommandType="StoredProcedure"
            InsertCommand="ContactUsInsertUpdate">               
            <InsertParameters>
                <asp:Parameter Name="FirstName" />
                <asp:Parameter Name="LastName" />
                <asp:Parameter Name="Email" />
                <asp:Parameter Name="QuestionText" />
            </InsertParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
