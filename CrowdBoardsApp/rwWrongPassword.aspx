<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwWrongPassword.aspx.vb"
    Inherits="CrowdBoardsApp.rwWrongPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Wrong Password</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/popup.css" rel="stylesheet" type="text/css" />
    <%--<link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/DateFormat.js" type="text/javascript"></script>
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
        }
        .sign-in-button:hover, .send-button:hover, .copy-button:hover, .email-button:hover
        {
            background: none repeat scroll 0 0 #3c6c79;
        }
    </style>
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
            //            function Ok() {
            //                var oWindow = GetRadWindow();
            //                var url = "Home.aspx";
            //                oWindow.Close(url);
            //            }

            function ToBoardPage(dirName) {
                var url;
                var oWindow = GetRadWindow();
                url = "/" + dirName + "?fromSearch=1";
                oWindow.Close(url);
            }
            function Ok(page) {
                //alert(page);
                var url;
                var oWindow = GetRadWindow();
                //                if (page == "Terms") {
                //                    url = "Terms.aspx";
                //                }
                //                else if (page == "AboutUs") {
                //                    // alert("a");
                //                    url = "AboutUs.aspx";
                //                }
                //                else if (page == "FAQ") {
                //                    url = "FAQ.aspx";
                //                }
                //                else if (page == "WhatIs") {
                //                    url = "WhatIs.aspx";
                //                }
                //                else if (page == "ContactUs") {
                //                    url = "ContactUs.aspx";
                //                }
                //                else if (page == "Search") {
                //                    url = "Search.aspx";
                //                }
                //                else {
                url = "Home.aspx";
                //}
                oWindow.Close(url);
            }
        </script>
        <script language="javascript" type="text/javascript">

            var result = false;
            function CheckUserName() {

                resetMessages();
                var messageSignUp = document.getElementById("lblMessageSignUp");
                var userName = document.getElementById("txtUserName");
                var userNameX = document.getElementById("lblUserNameX");

                if (userName.value == '') {
                    userNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "UserName is Required";
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


                if (isUserNameExists == "1") {
                    userNameX.style.visibility = 'visible';
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry This Username is Already Taken";

                    return false;
                }
                else if (firstName.value == '') {

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
                    document.getElementById("btnSignup").click();
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
    </telerik:RadScriptBlock>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="popup-container" style="width: 100%;">
                        <div class="first-block">
                            <div>
                                <asp:Label ID="messageLable" runat="server" Visible="false"></asp:Label>
                            </div>
                            <div class="headline">
                                Your Username/Password was incorrect</div>
                            <div>
                                <asp:TextBox ID="txtLogInUserName" runat="server" placeholder="Username">
                                </asp:TextBox>
                                <asp:TextBox ID="txtlogInPassword" runat="server" TextMode="Password" placeholder="Password">
                                </asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtLogInUserName"
                                    ErrorMessage="User Name is required" Text="User Name is required." ForeColor="Red" Font-Size="smaller"
                                    ValidationGroup="LoginValidationGroup"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtlogInPassword"
                                    ErrorMessage="Password is required" Text="Password is required." ForeColor="Red" Font-Size="smaller"
                                    ValidationGroup="LoginValidationGroup"></asp:RequiredFieldValidator>
                            </div>
                            <div class="button-container">
                                <asp:Button ID="LoginButton" runat="server" Text="Sign In" CssClass="sign-in-button"
                                    ValidationGroup="LoginValidationGroup" />
                            </div>
                        </div>
                        <div class="second-block">
                            <div class="headline">
                                Forgot your password? Enter your email address</div>
                            <div>
                                <asp:Label ID="lblEmailMessage" runat="server" Text="" CssClass="LabelGreenLarger"></asp:Label>
                            </div>
                            <div>
                                <asp:TextBox ID="txtEmailSend" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="emailRequired" runat="server" ControlToValidate="txtEmailSend"
                                    ForeColor="Red" ErrorMessage="E-mail is required." ToolTip="E-mail is required."
                                    Display="Dynamic" ValidationGroup="EmailValidationGroup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email Address is not well formed"
                                    Display="Dynamic" ForeColor="Red" ControlToValidate="txtEmailSend" ValidationGroup="EmailValidationGroup"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="button-container">
                                <asp:Button ID="imgSendEmail" runat="server" CssClass="send-button" Text="Send" ValidationGroup="EmailValidationGroup" />
                            </div>
                        </div>
                        <div class="third-block">
                            <div class="sign-up-container">
                                <div class="title">
                                    Sign Up</div>
                                <div>
                                    <asp:Label ID="lblMessageSignUp" runat="server" Text="" ForeColor="Red" CssClass="LabelGreenLarger"></asp:Label>
                                </div>
                                <br />
                                <div class="signup-information">
                                    <form action="" style="padding-left: 25px; padding-right: 25px;">
                                    <asp:TextBox ID="txtUserName" CssClass="aktextbox" runat="server" placeholder="CrowdBoarders Username">
                                    </asp:TextBox>
                                    <asp:Label ID="lblUserNameX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></br>
                                    <div class="twotoa-row">
                                        <div>
                                            <asp:TextBox ID="txtFirstName" CssClass="aktextbox" runat="server" placeholder="First Name">
                                            </asp:TextBox>
                                            <asp:Label ID="lblFirstNameX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></div>
                                        <div>
                                            <asp:TextBox ID="txtLastName" CssClass="aktextbox" runat="server" placeholder="Last Name">
                                            </asp:TextBox>
                                            <asp:Label ID="lblLastNameX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></div>
                                    </div>                                    
                                    <asp:TextBox ID="txtEmail" CssClass="aktextbox" runat="server" placeholder="Email Address">
                                    </asp:TextBox>
                                    <asp:Label ID="lblEmailX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></br>
                                    <div class="twotoa-row">
                                        <div>
                                            <asp:TextBox ID="txtPassword" CssClass="aktextbox" runat="server" TextMode="Password"
                                                placeholder="Password">
                                            </asp:TextBox>
                                            <asp:Label ID="lblPasswordX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></div>
                                        <div>
                                            <asp:TextBox ID="txtConfirmPassword" CssClass="aktextbox" runat="server" TextMode="Password"
                                                placeholder="Confirm Password">
                                            </asp:TextBox>
                                            <asp:Label ID="lblConfirmPasswordX" runat="server" Text="x" ForeColor="Red" CssClass="LabelheadingRed"></asp:Label></div>
                                    </div>
                                    </form>
                                </div>
                                <div class="sign-up-button">
                                    <asp:LinkButton ID="lbtnSingup" runat="server" OnClientClick="return CheckUserName();">
                                <span>
                                      <img src="WebContent/theme/images/crowdboarders.png"></span> <span class="sign-up-button-text">
                                            Sign Up </span>
                                    </asp:LinkButton>
                                    <asp:Button ID="btnSignup" runat="server" Text="Sign Up" Style="display: none;" />
                                </div>
                                <div class="login-buttons">
                                    <a href="">
                                        <img src="WebContent/Theme/images/fbsignin.png" /></a>
                                </div>
                                <div class="login-buttons">
                                    <a href="">
                                        <img src="WebContent/Theme/images/tlogin.png" /></a>
                                </div>
                                <div class="login-buttons">
                                    <a href="">
                                        <img src="WebContent/Theme/images/lsignin.png" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
    <asp:SqlDataSource ID="sdGetUserIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID,Status from Users WHERE UserName=@UserName">
        <SelectParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateLastlogin" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <UpdateParameters>
            <asp:Parameter Name="UserName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateUserByEmailID" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Users SET uuid=@uuid WHERE UserID=@UserID">
        <UpdateParameters>
            <asp:Parameter Name="uuid" />
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUsers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="User_Insert" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="uuid" Type="String" />
             <asp:Parameter Name="ReferalURL" Type="String" />
            <asp:Parameter Name="ReferalValue" Type="String" />
            <asp:Parameter Name="ReferalUserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
