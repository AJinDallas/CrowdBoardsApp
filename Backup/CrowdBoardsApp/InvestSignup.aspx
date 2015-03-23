<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InvestSignup.aspx.vb"
    Inherits="CrowdBoardsApp.InvestSignup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="WebContent/theme/styles/main.css" />
    <link rel="stylesheet" href="WebContent/theme/styles/login.css" />
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
<%--    <script type="text/javascript" defer="defer" src="https://mylivechat.com/chatwidget.aspx?hccid=72490377"></script>--%>
    <style type="text/css">
        .txtCss
        {
            font-size: 20px;
            line-height: 1.5em;
            margin-left: 8px;
            padding-left: 5px;
            width: 200px;
            color: #788586;
        }
        .rightinput
        {
            font-size: 18px;
            line-height: 2em;
            margin-bottom: 6px;
            padding-left: 5px;
            width: 100%;
            color: #788586;
        }
        
        .main-body .subheading
        {
            font-size: 24px;
            margin-bottom: 18px;
        }
        .main-body .title
        {
            color: #4f4e4e;
            font-size: 42px;
            font-weight: 600;
            margin-bottom: 38px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:scriptmanager runat="server" id="RadScriptManager1">
        <scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </scripts>
    </asp:scriptmanager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">


            var result = false;
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

            function CheckUserName() {

                resetMessages();
                var messageSignUp = document.getElementById("lblMessageSignUp");
                var userName = document.getElementById("txtUserName");
                var userNameX = document.getElementById("lblUserNameX");

                if (userName.value == '') {
                    userNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Username is Required";
                }
                else {
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "WebService/WebService.asmx/CheckUserNameExists",
                        data: "{'userName':'" + userName.value + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccessCallUser,
                        error: OnErrorCallUser

                    });

                }
                return false;

            }

            function OnSuccessCallUser(response) {

                CheckSignUpValidation(response.d);
            }


            function OnErrorCallUser(response) {
                alert(response.status + " " + response.statusText);
            }


            function CheckSignUpValidation(isUserNameExists) {

                var messageSignUp = document.getElementById("lblMessageSignUp");

                var userName = document.getElementById("txtUserName");
                var firstName = document.getElementById("txtFirstName");
                var lastName = document.getElementById("txtLastName");
                var email = document.getElementById("txtEmail");

                var userNameX = document.getElementById("lblUserNameX");
                var firstNameX = document.getElementById("lblFirstNameX");
                var lastNameX = document.getElementById("lblLastNameX");
                var emailX = document.getElementById("lblEmailX");



                if (firstName.value == '') {

                    firstNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "First Name is Required";
                    return false;
                }
                else if (lastName.value == '') {
                    lastNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Last Name is Required";
                    return false;
                }
                else if (isUserNameExists == "1") {
                    userNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry This Username is Already Taken";

                    return false;
                }
                else {
                    CheckEmail(email, emailX, messageSignUp);

                }

                return false;

            }


            function CheckEmail(email, emailX, messageSignUp) {
                if (email.value == '') {
                    emailX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Email is Required";
                    return false;
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "WebService/WebService.asmx/CheckEmailExists",
                        data: "{'emailAddress':'" + email.value + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccessCall,
                        error: OnErrorCall
                    });


                }
                return false;
            }


            function OnSuccessCall(response) {
                CheckSignUpValidation2(response.d);
            }

            function OnErrorCall(response) {

                alert(response.status + " " + response.statusText);
            }

            function CheckSignUpValidation2(isEmailExists) {

                var messageSignUp = document.getElementById("lblMessageSignUp");
                var password = document.getElementById("txtPassword");
                var confirmPassword = document.getElementById("txtConfirmPassword");

                var emailX = document.getElementById("lblEmailX");
                var passwordX = document.getElementById("lblPasswordX");
                var confirmPasswordX = document.getElementById("lblConfirmPasswordX");



                if (isEmailExists == "1") {
                    emailX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry Your Email Address is Not Valid";
                    return false;
                }
                else if (isEmailExists == "2") {

                    emailX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry This Email is Already taken";
                    return false;
                }
                else if (password.value == '') {

                    passwordX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Password is Required";
                    return false;
                }
                else if (confirmPassword.value == '') {

                    confirmPasswordX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Confirm Password is Required";
                    return false;
                }
                else if (password.value != confirmPassword.value) {

                    passwordX.style.visibility = 'visible';
                    confirmPasswordX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry Your Passwords Did Not Match";
                    return false;
                }
                else {
                    //Submit Now
                    var btn;
                    btn = document.getElementById("btnSignup");
                    btn.click();
                    resetMessages();
                }


            }

            function resetMessages() {
                var messageSignUp = document.getElementById("lblMessageSignUp");
                var userNameX = document.getElementById("lblUserNameX");
                var firstNameX = document.getElementById("lblFirstNameX");
                var lastNameX = document.getElementById("lblLastNameX");
                var emailX = document.getElementById("lblEmailX");
                var passwordX = document.getElementById("lblPasswordX");
                var confirmPasswordX = document.getElementById("lblConfirmPasswordX");

                // alert(messageSignUp.style.visibility); 

                messageSignUp.style.visibility = 'hidden';
                userNameX.style.visibility = 'hidden';
                firstNameX.style.visibility = 'hidden';
                lastNameX.style.visibility = 'hidden';
                emailX.style.visibility = 'hidden';
                passwordX.style.visibility = 'hidden';
                confirmPasswordX.style.visibility = 'hidden';
            }
            
        </script>
        <script type="text/javascript">

            function validateLogin() {
                resetLoginMessages();
                var userName = document.getElementById("txtLogInUserName");
                var password = document.getElementById("txtlogInPassword");
                var uerNameLabel = document.getElementById("uerNameLabel");
                var passwordLabel = document.getElementById("passwordLabel");

                if (userName.value == '') {
                    alert('user name');
                    uerNameLabel.innerHTML = "Username is Required";
                    uerNameLabel.style.visibility = 'visible';
                    return false;
                }

                else if (password.value == '') {
                    passwordLabel.innerHTML = "Password is Required";
                    passwordLabel.style.visibility = 'visible';
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "WebService/WebService.asmx/validateLogin",
                    data: "{'userName':'" + userName.value + "','password':'" + password.value + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessValidateLogin,
                    error: OnErrorCallValidateLogin
                });
                return false;
            }
            function OnSuccessValidateLogin(response) {

                if (response.d == "1") {
                    document.getElementById("<%= LoginButtonHidden.ClientID %>").click();
                }
                else if (response.d == "2") {
                    var uerNameLabel = document.getElementById("uerNameLabel");
                    uerNameLabel.innerHTML = "Please Contact Administrator to activate your account";
                    uerNameLabel.style.visibility = 'visible';
                }
                else if (response.d == "0") {
                    openRadWindow();
                }
            }


            function OnErrorCallValidateLogin(response) {
                alert(response.status + " " + response.statusText);

            }

            function resetLoginMessages() {
                var uerNameLabel = document.getElementById("uerNameLabel");
                var passwordLabel = document.getElementById("passwordLabel");
                uerNameLabel.style.visibility = 'hidden';
                passwordLabel.style.visibility = 'hidden';

            }

            function openRadWindow() {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwWrongPassword.aspx";
                manager.open(url, "RadWindow1");
                return false;

            }

        </script>
    </telerik:RadScriptBlock>
    <div id="navbar">
        <ul>
            <li><a class="focus" href="#"></a></li>
            <li><a href="#"></a></li>
            <li><a href="#"></a></li>
        </ul>
    </div>
    <div class="container">
        <div class="main-body" style="height: 625px;">
            <div style="padding: 32px;">
                <div class="title">
                    Become a CrowdBoarder to Invest<span style="float: right; margin-right: 30px;">
                        <asp:label id="messageLable" runat="server" visible="false" style="font-size: 14px;">
                        </asp:label></span></div>
                <div class="left-portion" style="width: 65%;">
                    <div class="subheading">
                        Already a CrowdBoarder?</div>
                    <div>
                        <asp:panel id="loginPanel" runat="server" defaultbutton="LoginButton">
                            <table>
                                <tr valign="top">
                                    <td>
                                        <asp:textbox id="txtLogInUserName" runat="server" placeholder="Username" cssclass="txtCss">
                                        </asp:textbox><br />
                                        <asp:label id="uerNameLabel" runat="server" forecolor="Red" font-size="10pt"></asp:label>
                                    </td>
                                    <td>
                                        <asp:textbox id="txtlogInPassword" runat="server" textmode="Password" cssclass="txtCss"
                                            placeholder="Password">
                                        </asp:textbox><br />
                                        <asp:label id="passwordLabel" runat="server" forecolor="Red" font-size="10pt"></asp:label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:button id="LoginButton" runat="server" text="Sign In" cssclass="sign-in-button"
                                            onclientclick="return validateLogin()" />
                                    </td>
                                </tr>
                            </table>
                            <asp:button id="LoginButtonHidden" runat="server" style="display: none;" />
                        </asp:panel>
                    </div>
                </div>
                <div class="right-portion">
                    <div class="subheading">
                        Sign Up</div>
                    <asp:panel runat="server" id="panelRegister" defaultbutton="lbtnSingup">
                        <div class="signup-information" style="margin-left: 0px; margin-right: 25px;">
                            <asp:label id="lblMessageSignUp" runat="server" text="" forecolor="green" font-size="10pt">
                            </asp:label>
                            <asp:textbox id="txtUserName" runat="server" placeholder="CrowdBoarders Username"
                                cssclass="rightinput">
                            </asp:textbox>
                            <asp:label id="lblUserNameX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                            </asp:label>
                            <div class="twotoa-row">
                                <div>
                                    <asp:textbox id="txtFirstName" runat="server" placeholder="First Name" cssclass="rightinput">
                                    </asp:textbox>
                                    <asp:label id="lblFirstNameX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                                    </asp:label>
                                </div>
                                <div>
                                    <asp:textbox id="txtLastName" runat="server" placeholder="Last Name" cssclass="rightinput">
                                    </asp:textbox>
                                    <asp:label id="lblLastNameX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                                    </asp:label>
                                </div>
                            </div>
                            <asp:textbox id="txtEmail" runat="server" placeholder="Email Address" cssclass="rightinput">
                            </asp:textbox>
                            <asp:label id="lblEmailX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                            </asp:label>
                            <div class="twotoa-row">
                                <div>
                                    <asp:textbox id="txtPassword" runat="server" textmode="Password" placeholder="Password"
                                        cssclass="rightinput">
                                    </asp:textbox>
                                    <asp:label id="lblPasswordX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                                    </asp:label>
                                </div>
                                <div>
                                    <asp:textbox id="txtConfirmPassword" runat="server" textmode="Password" placeholder="Confirm Password"
                                        cssclass="rightinput">
                                    </asp:textbox>
                                    <asp:label id="lblConfirmPasswordX" runat="server" text="*" forecolor="Red" style="dispaly: none;">
                                    </asp:label>
                                </div>
                            </div>
                        </div>
                        <div class="sign-up-button">
                            <asp:linkbutton id="lbtnSingup" runat="server" onclientclick="return CheckUserName();">
                                <span>
                                    <img src="WebContent/theme/images/crowdboarders.png"></span> <span class="sign-up-button-text">
                                        Sign Up </span>
                            </asp:linkbutton>
                            <asp:button id="btnSignup" runat="server" text="Sign Up" style="display: none;" />
                        </div>
                        <div class="login-buttons">
                            <asp:linkbutton id="signInFacebook" runat="server">
                                <img id="img3" runat="server" src="WebContent/theme/images/fbsignin.png" /></asp:linkbutton>
                        </div>
                        <div class="login-buttons">
                            <asp:linkbutton id="signInTwitter" runat="server">
                                <img id="img1" runat="server" src="WebContent/theme/images/tlogin.png" /></asp:linkbutton>
                        </div>
                        <div class="login-buttons">
                            <asp:linkbutton id="signInLinkedIn" runat="server">
                                <img id="img2" runat="server" src="WebContent/theme/images/lsignin.png" /></asp:linkbutton>
                        </div>
                    </asp:panel>
                </div>
            </div>
        </div>
    </div>
    <div>
        <asp:sqldatasource id="sdGetUserIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from Users WHERE UserName=@UserName">
            <selectparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </selectparameters>
        </asp:sqldatasource>

        <asp:SqlDataSource ID="sdGetUserIdDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from Users WHERE UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:sqldatasource id="sdUpdateLastlogin" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
            <updateparameters>
            <asp:Parameter Name="UserName" />
        </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="User_Insert" selectcommandtype="StoredProcedure">
            <selectparameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="uuid" Type="String" />
             <asp:Parameter Name="ReferalURL" Type="String" />
            <asp:Parameter Name="ReferalValue" Type="String" />
            <asp:Parameter Name="ReferalUserID" Type="Int32" />
        </selectparameters>
        </asp:sqldatasource>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>
                <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                    Width="650" Height="550">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    </form>
</body>
</html>
