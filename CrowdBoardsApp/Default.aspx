<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="CrowdBoardsApp._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Crowdboarders: People who make a difference</title>
    <meta name="description" content="Create CrowdBoards to raise money for anything, invest in CrowdBoards everywhere" />
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="WebContent/theme/styles/main.css" />
    <link rel="stylesheet" href="WebContent/theme/styles/login.css" />
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .popup_box
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 450px;
            width: 600px;
            background: #ececee;
            left: 350px;
            top: 60px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: hidden;
        }
    </style>
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
        
        .playButton
        {
            margin-top: 137px;
            margin-left: 383px;
            opacity: 0.69;
            background-color: #75b4c6;
            border: 2px solid white;
            border-radius: 25px;
        }
        .playButton:hover
        {
            border: 2px solid #75b4c6;
            background-color: #788586;
            -ms-transform: translate(2px,2px); /* IE 9 */
            -webkit-transform: translate(2px,2px); /* Chrome, Safari, Opera */
            transform: translate(2px,2px); /* Standard syntax */
        }
    </style>
</head>
<body style="background-color: #DCDCDC; z-index: 120; margin: 0px;">
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



            function openRadWindow() {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwWrongPassword.aspx";
                manager.open(url, "RadWindow1");
                return false;

            }

            function openContactUsRadWindow() {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "ContactUs.aspx";
                manager.open(url, "RadWindow1");
                return false;

            }

            function resetLoginMessages() {
                var uerNameLabel = document.getElementById("uerNameLabel");
                var passwordLabel = document.getElementById("passwordLabel");
                uerNameLabel.style.visibility = 'hidden';
                passwordLabel.style.visibility = 'hidden';

            }

            function loadPopupBoxVideo() {    // To Load the Popupbox
                $('#popup_box_Video').fadeIn("slow");
                return false;
            }

            function unloadPopupBoxVideo() {    // TO Unload the Popupbox
                //                                var media = $find("= RadMediaPlayer1.ClientID %>");             
                //                                media.stop();
                $('#popup_box_Video').fadeOut("slow");
                return false;
            }        
        
        </script>
    </telerik:RadScriptBlock>
    <div class="popup_box" id='popup_box_Video'>
        <div style="text-align: right;">
            <a id="popupBoxCloseYoutube" onclick="return unloadPopupBoxVideo();">
                <img src="Images/btncross.png" alt='Close' style="cursor: default; height: 20px;
                    width: 20px;" /></a></div>
        <!--Change wideo width and height here-->
        <div style="overflow: hidden;">
            <label style="font-size: medium; font-weight: bold; color: Black;">
                Quick guide to Crowdboarding</label>
            <div id="wideo-embed-block" wideo-width="580" wideo-height="420" wideo-id="4430091406482578874"
                autoplay="false" style="overflow: hidden;">
            </div>
            <script type="text/javascript">
                (function () {
                    var x = document.createElement('script'), s = document.getElementsByTagName('script')[0]; x.async = true;
                    x.src = '../js/wideoembed.js'; s.parentNode.insertBefore(x, s)
                })();
            </script>
        </div>
        <%-- <telerik:RadMediaPlayer ID="RadMediaPlayer1" runat="server" Width="580px" BackColor="#262626"
                StartVolume="80" Height="400px" StartTime="0" Muted="false" AutoPlay="false"
                Title="Quick guide to Crowdboarding"  >
               
                <Sources>
                <telerik:MediaPlayerSource  Path="https://www.youtube.com/watch?v=awoavhXFm70"/>
                </Sources>
            </telerik:RadMediaPlayer>--%>
    </div>
    <div class="first-row">
        <div class="floating-left">
            <img src="WebContent/theme/images/crowdboardersbanner.png" />
        </div>
        <div class="floating-right">
            <div>
                <asp:Panel ID="loginPanel" runat="server" DefaultButton="LoginButton">
                    <table>
                        <tr valign="top">
                            <td>
                                <span style="font-size: 30px; font-weight: 600;">Sign In</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtLogInUserName" runat="server" placeholder="Username" CssClass="txtCss">
                                </asp:TextBox><br />
                                <asp:Label ID="uerNameLabel" runat="server" ForeColor="Red" Font-Size="10pt"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtlogInPassword" runat="server" TextMode="Password" CssClass="txtCss"
                                    placeholder="Password">
                                </asp:TextBox><br />
                                <asp:Label ID="passwordLabel" runat="server" ForeColor="Red" Font-Size="10pt"></asp:Label>
                            </td>
                            <td>
                                &nbsp;
                                <asp:Button ID="LoginButton" runat="server" Text="Sign In" CssClass="sign-in-button"
                                    OnClientClick="return validateLogin()" />
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="messageLable" runat="server" Visible="false"></asp:Label>
                    <asp:Button ID="LoginButtonHidden" runat="server" Style="display: none;" />
                </asp:Panel>
            </div>
        </div>
    </div>
    <div class="container" style="height: 100%;">
        <div class="main-body">
            <div class="left-portion">
                <div class="main-picture" style="background-image: url(WebContent/theme/images/homepage.jpg);
                    height: 495px; width: 100%;">
                    <%--  <img src="WebContent/theme/images/crowdboardcollage.jpg" />--%>
                    <asp:ImageButton ID="ibtnPlay" ImageUrl="WebContent/theme/Images/Play.png" CssClass="playButton"
                        ToolTip="Quick guide to Crowdboarding" runat="server" OnClientClick="return loadPopupBoxVideo();" />
                </div>
                <div class="informative-links">
                    <div class="left">
                        <a href="MoreInfo/howitworks.html">How it Works</a></div>
                    <div class="middle">
                        <a href="MoreInfo/youareacrowdboarder.html">You are a CrowdBoarder</a></div>
                    <div class="right">
                        <a href="MoreInfo/industrycomparison.html">Industry Comparison</a></div>
                </div>
            </div>
            <div class="right-portion">
                <div class="title">
                    Sign Up</div>
                <%-- <asp:updatepanel id="userUpdatePanel" runat="server">
                    <contenttemplate>--%>
                <div class="signup-information" style="margin-left: 25px; margin-right: 25px;">
                    <asp:Label ID="lblMessageSignUp" runat="server" Text="" ForeColor="green" Font-Size="10pt"></asp:Label>
                    <br />
                    <br />
                    <asp:TextBox ID="txtUserName" runat="server" placeholder="CrowdBoarders Username"
                        CssClass="rightinput">
                    </asp:TextBox>
                    <asp:Label ID="lblUserNameX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                    </asp:Label>
                    <div class="twotoa-row">
                        <div>
                            <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" CssClass="rightinput">
                            </asp:TextBox>
                            <asp:Label ID="lblFirstNameX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                            </asp:Label>
                        </div>
                        <div>
                            <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" CssClass="rightinput">
                            </asp:TextBox>
                            <asp:Label ID="lblLastNameX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                            </asp:Label>
                        </div>
                    </div>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email Address" CssClass="rightinput">
                    </asp:TextBox>
                    <asp:Label ID="lblEmailX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                    </asp:Label>
                    <div class="twotoa-row">
                        <div>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"
                                CssClass="rightinput">
                            </asp:TextBox>
                            <asp:Label ID="lblPasswordX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                            </asp:Label>
                        </div>
                        <div>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password"
                                CssClass="rightinput">
                            </asp:TextBox>
                            <asp:Label ID="lblConfirmPasswordX" runat="server" Text="*" ForeColor="Red" Style="dispaly: none;">
                            </asp:Label>
                        </div>
                    </div>
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
                    <asp:LinkButton ID="signInFacebook" runat="server">
                        <img id="img3" runat="server" src="WebContent/theme/images/fbsignin.png" /></asp:LinkButton>
                </div>
                <div class="login-buttons">
                    <asp:LinkButton ID="signInTwitter" runat="server">
                        <img id="img1" runat="server" src="WebContent/theme/images/tlogin.png" /></asp:LinkButton>
                </div>
                <div class="login-buttons">
                    <asp:LinkButton ID="signInLinkedIn" runat="server">
                        <img id="img2" runat="server" src="WebContent/theme/images/lsignin.png" /></asp:LinkButton>
                </div>
                <div class="login-buttons">
                    <a target="_top" href="http://www.crowdsourcing.org/caps#19356">
                        <img width="175" height="50" border="0" alt="Crowdfunding Accredited Platform" src="http://static.crowdsourcing.org/images/caps-badge-light.png">
                    </a>
                </div>
                <%--   </contenttemplate>
                </asp:updatepanel>--%>
            </div>
        </div>
    </div>
    <footer class="last-row">
    <div class ="float-left">
    <asp:hyperlink id="HyperLink1" runat="server" text=" Can I see some CrowdBoards?"
                                    font-underline="false" navigateurl="~/Search.aspx"></asp:hyperlink> 
                                </asp:hyperlink>
    </div>
		<div class = "float-right">
			 <asp:linkbutton id="lbtnAboutUs" runat="server" text="About Us" 
                                    postbackurl="~/AboutUs.aspx">
                                </asp:linkbutton> <asp:linkbutton id="lbtnFAQ" runat="server" text="FAQ" postbackurl="~/FAQ.aspx">
                                </asp:linkbutton> <asp:linkbutton id="lbtnTermsofService" runat="server" text="Terms of Service" 
                                    postbackurl="~/Terms.aspx">
                                </asp:linkbutton><asp:linkbutton id="lbnContactUs" runat="server" text="Contact Us" 
                                    onclientclick="return openContactUsRadWindow();">
                                </asp:linkbutton>
		</div>
  </footer>
    <asp:SqlDataSource ID="sdGetUserIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from Users WHERE UserName=@UserName">
        <SelectParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetUserIdDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from Users WHERE UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateLastlogin" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <UpdateParameters>
            <asp:Parameter Name="UserName" />
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Width="650" Height="550">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </form>
</body>
</html>
