<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyProfile.aspx.vb" Inherits="CrowdBoardsApp.MyProfile"
    MasterPageFile="~/MasterPage/Site.Master" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>My Profile</title>
    <link href="WebContent/Theme/styles/editprofile.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .horizontalDirection
        {
            float: left;
            width: 25%;
            height: 75px;
        }
        
        .horizontal
        {
            float: left;
            width: 12%;
            height: 75px;
        }
        .popup_box_all
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 320px;
            width: 600px;
            left: 400px;
            top: 190px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        
        
        .riSingle .riTextBox[type="text"]
        {
            margin: 2 !importent;
            height: 32px;
            margin-top: 6px;
        }
        
        
        html body .input:hover
        {
            border-color: #3c6c79;
        }
        .container
        {
            min-height: 785px;
        }
    </style>
    <style type="text/css">
        .popup_ChangePassword
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 300px;
            width: 500px;
            left: 320px;
            top: 150px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        /* popup_box DIV-Styles*/
        .popup_box
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 450px;
            width: 620px;
            background: #ececee;
            left: 300px;
            top: 150px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
        }
        
        .popup_box_boost
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 200px;
            width: 460px;
            left: 300px;
            top: 150px;
            z-index: 200; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        
        /* This is for the positioning of the Close Link */
        #popupBoxClose
        {
            font-size: 20px;
            line-height: 15px;
            right: 5px;
            top: 5px;
            position: absolute;
            color: #6fa5e2;
            font-weight: 500;
        }
        
        .RadSlider_Vista .rslItem, .RadSlider_Vista .rslLargeTick span
        {
            color: #ffffff;
        }
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
        }
        #fileAttachRadAsyncUpload. RadUpload_Default .ruButton
        {
            /*it is an example URL*/
            background-color: url("Images/ruSprite.png");
        }
        .LabelheadingWhite
        {
            font-size: 16px;
            margin-bottom: 5px;
        }
        
        .email-button
        {
            padding: 4px 8px 5px;
            font-size: 18px;
            font-weight: 600;
            background-color: #75B4C6;
            color: #ffffff;
            border-radius: 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border: none;
            cursor: pointer;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            -moz-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
        }
        
        .email-button:hover
        {
            background: #3C6C79;
        }
    </style>
    <style>
        .textbox
        {
            -webkit-border-radius: 0px;
            -moz-border-radius: 0px;
            border-radius: 0px;
            border: 1px solid #848484;
            outline: 0;
            height: 30px;
            width: 275px;
            margin-top: 5px;
        }
    </style>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <%--<script src="https://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>--%>
    <link rel="icon" type="image/ico" href="https://crowdboarders.com/Images/favicon.ico" />
    <script type="text/javascript" src="https://js.balancedpayments.com/v1/balanced.js"></script>
    <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <asp:hiddenfield id="balancedBankAccountURI" runat="server" />
    <asp:button id="btnCreateAccount" runat="server" text="Create Account" style="display: none;" />
    <asp:button id="btnSave" runat="server" text="saveChangeButton" style="display: none;"
        validationgroup="submit" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            balanced.init('<%=apiMarketplace %>');
            Stripe.setPublishableKey('<%=stripePublishableKey %>');

            function loadPopupcreateBalacedAccount() {    // To Load the Popupbox

                var firstName = document.getElementById("ctl00_BodyContent_txtFirstName").value;
                var lastName = document.getElementById("ctl00_BodyContent_txtLastName").value;
                var email = document.getElementById("ctl00_BodyContent_txtEmailAddress").value;
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var valid = 1;
                if (!filter.test(email)) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Please provide valid email address";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }
                if ($.trim(firstName).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "First Name field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if ($.trim(lastName).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Last Name field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if ($.trim(email).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Email field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if (valid == 1) {
                    //                var wholeName = document.getElementById("txtFirstName").value + " " + document.getElementById("txtLastName").value;
                    //                document.getElementById("txtName").value = wholeName;
                    //                document.getElementById("txtEmailForBankAccount").value = document.getElementById("txtEmailAddress").value;
                    $('#createBalacedAccountDiv').fadeIn("slow");
                    return false;
                }
                else {
                    return false;
                }

            }
            function unloadPopupcreateBalacedAccount() {    // TO Unload the Popupbox
                $('#createBalacedAccountDiv').fadeOut("slow");
                return false;
            }

            function validateBankAccountEntries() {

                var namaeAcc = document.getElementById("BodyContent_txtName").value;

                var emailAddressAcc = document.getElementById("BodyContent_txtEmailForBankAccount").value;
                var routingNumber = document.getElementById("BodyContent_txtRoutingNumber").value;
                var accountNumber = document.getElementById("BodyContent_txtAccountNumber").value;


                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var valid = 1;

                if ($.trim(namaeAcc).length == 0 || $.trim(emailAddressAcc).length == 0 || $.trim(routingNumber).length == 0 || $.trim(accountNumber).length == 0) {

                    document.getElementById("<%=lblErrorBalanced.ClientID %>").innerHTML = "All fields are required";

                    valid = 0;
                }
                else if (!filter.test(emailAddressAcc)) {
                    document.getElementById("<%=lblErrorBalanced.ClientID %>").innerHTML = "Please provide valid email address";
                    valid = 0;
                }
                //            else if (!balanced.bankAccount.validateRoutingNumber(routingNumber)) {
                //                document.getElementById("lblErrorBalanced").innerHTML = "Routing Number is not valid";
                //                valid = 0;
                //            }

                if (valid == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }

            function CreateAccountByLocation() {
                // alert('s');

                var selectedItem = $("#BodyContent_rblBankLocation").find(":checked").val();
                //                var selectedItem;
                //                for (var x = 0; x < radioButtons.length; x++) {

                //                    if (radioButtons[x].checked) {

                //                        selectedItem = radioButtons[x].value;
                //                    }

                //                }

                if (selectedItem == '') {
                    alert('Please Select Bank Location');
                }
                else if (selectedItem == 'US') {
                    loadPopupcreateBalacedAccount();
                }
                else if (selectedItem == 'UK') {
                    CreateBankAccountForStripe();
                }
                return false;
            }
            function CreateBankAccount() {
                if (!validateBankAccountEntries()) {

                    return false;
                }

                var AccType;
                if (document.getElementById("BodyContent_CheckingRadioButton").checked) {
                    AccType = 'checking';
                }
                else {
                    AccType = 'saving';
                }

                var bankAccountData = {
                    name: document.getElementById("BodyContent_txtName").value,
                    routing_number: document.getElementById("BodyContent_txtRoutingNumber").value,
                    account_number: document.getElementById("BodyContent_txtAccountNumber").value,
                    type: AccType
                };

                balanced.bankAccount.create(bankAccountData, responseCallbackHandler);

                return false;
            }



            function CreateBankAccountForStripe() {
                // alert('called');
                document.getElementById("<%= btnAuthorizeStripe.ClientID %>").click();
            }

            function ValidateNameEmailFields() {
                var firstName = document.getElementById("ctl00_BodyContent_txtFirstName").value;
                var lastName = document.getElementById("ctl00_BodyContent_txtLastName").value;
                var email = document.getElementById("ctl00_BodyContent_txtEmailAddress").value;
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var valid = 1;
                if (!filter.test(email)) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Please provide valid email address";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }
                if ($.trim(firstName).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "First Name field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if ($.trim(lastName).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Last Name field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if ($.trim(email).length == 0) {
                    document.getElementById("<%=lblMessage.ClientID %>").innerHTML = "Email field is required";
                    document.getElementById("<%=lblMessage.ClientID %>").style.color = "Red";
                    valid = 0;
                }

                if (valid == 1) {
                    var wholeName = document.getElementById("ctl00_BodyContent_txtFirstName").value + " " + document.getElementById("ctl00_BodyContent_txtLastName").value;
                    document.getElementById("BodyContent_txtName").value = wholeName;
                    document.getElementById("BodyContent_txtEmailForBankAccount").value = document.getElementById("BodyContent_txtEmailAddress").value;
                    loadPopupcreateBalacedAccount();
                    return true;
                }
                else {
                    return false;
                }
            }
            function stripeResponseHandler(status, response) {
                if (response.error) {

                    alert(response.error.message);
                } else {

                    var token = response['id'];
                    alert(token);
                }
            }

            function responseCallbackHandler(response) {
                if (response.status == 201) {

                    SetValueInHiddenForAccount(response.data)
                    document.getElementById("<%= btnCreateAccount.ClientID %>").click();
                }
                else {

                    alert("error: " + response.status);
                    return false;
                }

            }
            function SetValueInHiddenForAccount(response) {
                var balancedBankAccountURI = response['uri'];

                document.getElementById("<%=balancedBankAccountURI.ClientID %>").value = balancedBankAccountURI;
                // alert(document.getElementById('<%=balancedBankAccountURI.ClientID %>').value);
                return false;
            }
        </script>
        <script type="text/javascript">

            function fileUploaded(sender, args) {
                document.getElementById("<%= btnUploadProfilePic.ClientID %>").click();
            }
            function fileUploadedBackGround(sender, args) {
                document.getElementById("<%= btnUploadBackgroundPicture.ClientID %>").click();
            }

            function fileUploadedProofIdentification(sender, args) {
                document.getElementById("<%= ButtonProofofidentification.ClientID %>").click();
            }

            function SaveChanges() {
                var messageText = $("#BodyContent_emailHiddenField").val();
                if (messageText == "1") {
                    return false;
                }
                else {
                    document.getElementById("<%= btnSave.ClientID %>").click();
                    return true;
                }
            }


            function unloadPopupBoxPost() {
                $('#popup_box_post').fadeOut("slow");

                return false;
            }

            function loadPopupBoxPost() {
                $('#popup_box_post').fadeIn("slow");
                return false;

            }


            function unloadpopupBoxTXResidentDiv() {
                $('#popupBoxTXResidentDiv').fadeOut("slow");

                return false;
            }

            function loadpopupBoxTXResidentDiv() {
                $('#popupBoxTXResidentDiv').fadeIn("slow");
                return false;

            }

            function loadconditionTexasDiv() {
                $('#conditionTexasDiv').fadeIn("slow");
                e.preventDefault();
                return false;    

            }


            
                 

        </script>
    </telerik:RadScriptBlock>
    <div>
        <asp:button id="btnAuthorizeStripe" runat="server" style="display: none" text="Authorize" />
        <div class="popup_box_all" id="createBalacedAccountDiv">
            <table width="100%">
                <tr>
                    <td colspan="2" style="text-align: right;">
                        <asp:linkbutton id="lbtnCloseBalanced" forecolor="Red" runat="server" onclientclick="return unloadPopupcreateBalacedAccount();">X</asp:linkbutton>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <span class="LabelheadingWhiteLarger">Please fill your Account details</span><br />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:label id="lblSuccessBalanced" runat="server" forecolor="Green" font-size="12"></asp:label>
                        <asp:label id="lblErrorBalanced" runat="server" forecolor="Red" font-size="12"></asp:label>
                    </td>
                </tr>
            </table>
            <table width="100%" id="accountTable">
                <tr>
                    <td style="width: 20%;">
                        <span class="LabelheadingWhite">Name</span>
                    </td>
                    <td style="width: 80%;">
                        <asp:textbox id="txtName" readonly="true" runat="server" cssclass="textbox">
                        </asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;">
                        <span class="LabelheadingWhite">Email Address</span>
                    </td>
                    <td style="width: 80%;">
                        <asp:textbox id="txtEmailForBankAccount" readonly="true" runat="server" cssclass="textbox">
                        </asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;">
                        <span class="LabelheadingWhite">Routing Number</span>
                    </td>
                    <td style="width: 80%;">
                        <asp:textbox id="txtRoutingNumber" runat="server" cssclass="textbox">
                        </asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;">
                        <span class="LabelheadingWhite">Account Number</span>
                    </td>
                    <td style="width: 80%;">
                        <asp:textbox id="txtAccountNumber" runat="server" cssclass="textbox">
                        </asp:textbox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;">
                        <span class="LabelheadingWhite">Type</span>
                    </td>
                    <td style="width: 80%;">
                        <asp:radiobutton id="CheckingRadioButton" checked="true" text="Checking" groupname="typeh"
                            runat="server" />
                        <asp:radiobutton id="SavingRadioButton" text="Saving" groupname="typeh" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:button id="btnCreateAcc" runat="server" cssclass="post-button" text="Create Account"
                            validationgroup="submit" onclientclick="return CreateBankAccount();" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="popup_box_post" class="popup_ChangePassword">
            <table width="100%">
                <tr>
                    <td style="text-align: right; padding: 5px; float: right;">
                        <a id="popupBoxClosePost" onclick="return unloadPopupBoxPost();">
                            <img src="Images/btncross.png" alt='Close' style="cursor: pointer; width: 20px; height: 20px;" /></a>
                    </td>
                </tr>
            </table>
            <label style="font-size: large; font-weight: bold;">
                Change Password</label>
            <table width="100%" border="0" style="table-layout: fixed;">
                <tr>
                    <td style="width: 40%;">
                        <br />
                        <label>
                            Enter New Password
                        </label>
                    </td>
                    <td>
                        <br />
                        <asp:textbox id="newPasswordTextBox" runat="server" textmode="Password" tabindex="2">
                        </asp:textbox>
                        <asp:requiredfieldvalidator id="RequiredFieldValidator4" validationgroup="resetPassword"
                            runat="server" controltovalidate="newPasswordTextBox" errormessage="<br>Password is required"
                            forecolor="Red" display="Dynamic">
                        </asp:requiredfieldvalidator>
                        <asp:regularexpressionvalidator id="RegularExpressionValidator1" validationgroup="resetPassword"
                            runat="server" controltovalidate="newPasswordTextBox" errormessage="<br>Password should be minimum of 6 length"
                            forecolor="Red" display="Dynamic" validationexpression="^[a-zA-Z0-9\s]{6,}$">
                        </asp:regularexpressionvalidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            <br />
                            Enter Confirm Password
                        </label>
                    </td>
                    <td>
                        <br />
                        <asp:textbox id="confirmPasswordTextBox" runat="server" textmode="Password" tabindex="3">
                        </asp:textbox>
                        <asp:requiredfieldvalidator id="RequiredFieldValidator5" validationgroup="resetPassword"
                            runat="server" controltovalidate="confirmPasswordTextBox" errormessage="<br>Confirm Password is required"
                            forecolor="Red" display="Dynamic">
                        </asp:requiredfieldvalidator>
                        <asp:comparevalidator id="passwordsMatchCompareValidator" runat="server" validationgroup="resetPassword"
                            controltocompare="newPasswordTextBox" controltovalidate="confirmPasswordTextBox"
                            display="Dynamic" errormessage="</br>Please enter matching passwords" forecolor="Red">
                        </asp:comparevalidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                        <div>
                            <asp:button id="resetPasswordButton" cssclass="email-button" runat="server" text="Save"
                                validationgroup="resetPassword" width="80" height="35" tabindex="3" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="popupBoxTXResidentDiv" class="popup_ChangePassword">
            <table width="100%">
                <tr>
                    <td>
                        <label style="font-size: large; font-weight: bold;">
                            Texas resident</label>
                    </td>
                    <td style="text-align: right; padding: 5px; float: right;">
                        <a id="A1" onclick="return unloadpopupBoxTXResidentDiv();">
                            <img src="Images/btncross.png" alt='Close' style="cursor: pointer; width: 20px; height: 20px;" /></a>
                    </td>
                </tr>
            </table>
            <hr />
            Are you a Texas resident?

             <asp:RadioButtonList ID="texasRadioButton" runat="server" RepeatDirection="Horizontal" 
                                AutoPostBack="true" Font-Size="Medium">
                                <asp:ListItem Text="Yes" Value="1" onclick="return loadconditionTexasDiv()"></asp:ListItem>
                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>           
            <div id="conditionTexasDiv" style="display: none; margin-top: 15px;">
                Texas Term information description here
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <asp:checkbox id="termCheckbox" runat="server" text="I Agree" autopostback="True"
                    oncheckedchanged="termCheckbox_Clicked">
                </asp:checkbox>
            </div>
        </div>
        <asp:updatepanel id="userUpdatePanel" runat="server">
            <triggers>
                <asp:PostBackTrigger ControlID="btnUploadProfilePic" />
                <asp:PostBackTrigger ControlID="btnUploadBackgroundPicture" />
                <asp:PostBackTrigger ControlID="ButtonProofofidentification" />
            </triggers>
            <contenttemplate>
                <br />
                <asp:UpdatePanel ID="messageUpdatePanel" runat="server">
                    <ContentTemplate>
                        &nbsp;&nbsp;
                        <asp:HiddenField ID="emailHiddenField" runat="server"></asp:HiddenField>
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!--                  first column                       -->
                <div class="column1">
                    <div class="title top-title">
                        Edit Profile</div>
                    <div class="l-box-1">
                        <div class="twoina-row">
                            <telerik:RadTextBox ID="txtFirstName" runat="server" Width="48%" AutoPostBack="false"
                                placeholder="First Name">
                            </telerik:RadTextBox>
                            <telerik:RadTextBox ID="txtLastName" runat="server" Width="50%" AutoPostBack="false"
                                placeholder="Last Name">
                            </telerik:RadTextBox>
                        </div>
                        <div class="full-row">
                            <telerik:RadTextBox ID="txtUserName" Width="100%" runat="server" placeholder="Username">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="userNameRFV" runat="server" ValidationGroup="submit"
                                ControlToValidate="txtUserName" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <br>
                        </div>
                        <br />
                        <div class="full-row">
                            <telerik:RadTextBox ID="txtEmailAddress" runat="server" Width="100%" AutoPostBack="true"
                                placeholder="Email Address">
                            </telerik:RadTextBox>
                            <br></br>
                        </div>
                        <div class="change-password">
                            <a href="#">
                                <label onclick="return loadPopupBoxPost();">
                                    Change Password</label></a></div>
                        <%--<div class="twoina-row">
                            <input type="text" name="mainpicture" placeholder="">
                            <input type="text" name="coverpicture" placeholder="">
                        </div>--%>
                        <br />
                        <div class="update-picture">
                            <p style="margin-bottom: 5px;">
                                Upload Profile:</p>
                            <telerik:RadAsyncUpload ID="RadUpload1" runat="server" MultipleFileSelection="Automatic"
                                OnClientFilesUploaded="fileUploaded" HttpHandlerUrl="~/CustomHandler.ashx" Height="28px"
                                Width="275px" class="attach-button">
                            </telerik:RadAsyncUpload>
                            <asp:Button ID="btnUploadProfilePic" runat="server" Text="Upload Main Picture" Style="display: none;" />
                            <asp:Label ID="lblUploadProfilePic" runat="server" CssClass="LabelGreenLarge"></asp:Label>
                            <p style="margin-bottom: 5px;">
                                Upload Background:</p>
                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Automatic"
                                HttpHandlerUrl="~/CustomHandler.ashx" OnClientFilesUploaded="fileUploadedBackGround"
                                Height="28px" Width="275px" class="attach-button">
                            </telerik:RadAsyncUpload>
                            <asp:Button ID="btnUploadBackgroundPicture" runat="server" Text="Upload" Style="display: none;" />
                            <asp:Label ID="lblUploadBackgroundPicture" runat="server" CssClass="LabelGreenLarge"></asp:Label>
                            <br />
                            <p style="margin-bottom: 5px;">
                                Upload Proof of identification:</p>
                            <div>
                                <telerik:RadAsyncUpload ID="ruIDproof" runat="server" MultipleFileSelection="Automatic"
                                    OnClientFilesUploaded="fileUploadedProofIdentification" HttpHandlerUrl="~/CustomHandler.ashx"
                                    Height="28px" Width="275px" class="attach-button">
                                </telerik:RadAsyncUpload>
                                <asp:Button ID="ButtonProofofidentification" runat="server" Text="Upload Proof of identification"
                                    Style="display: none;" />
                                <asp:Label ID="LabelProofofidentification" runat="server" CssClass="LabelGreenLarge"></asp:Label>
                            </div>
                            <%-- Choose:<br />
                            <asp:RadioButtonList ID="rblChoose" runat="server" AutoPostBack="true" ForeColor="Black"
                                RepeatDirection="Horizontal" Width="50%">
                                <asp:ListItem Value="Tile" Text="Title">
                                </asp:ListItem>
                                <asp:ListItem Value="Stretch" Text="Stretch">
                                </asp:ListItem>
                            </asp:RadioButtonList>--%>
                        </div>
                    </div>
                    <div class="title">
                        Basic Information</div>
                    <div class="l-box-2">
                        <div class="box-column1">
                            Profession:<br>
                            <telerik:RadTextBox Width="100%" ID="txtJob" runat="server" AutoPostBack="false">
                            </telerik:RadTextBox>
                            Resides In:<br>
                            <telerik:RadTextBox ID="txtAddress" runat="server" Width="100%" AutoPostBack="false">
                            </telerik:RadTextBox>
                            Hometown:<br>
                            <telerik:RadTextBox Width="100%" ID="txtCity" runat="server" AutoPostBack="false">
                            </telerik:RadTextBox>                         

                             <asp:button ID="btnTexasResident" runat="server" CssClass="post-button"  OnClientClick ="return loadpopupBoxTXResidentDiv();" Text="Texas Resident?" />
                     
                        </div>
                        <div class="box-column2">
                            Birthday:<br>
                            <telerik:RadTextBox ID="txtBirthdate" runat="server" AutoPostBack="false" Width="100%">
                            </telerik:RadTextBox>
                            Skills:<br>
                            <telerik:RadTextBox ID="txtSkills" runat="server" AutoPostBack="false" Width="100%">
                            </telerik:RadTextBox>
                            Website:<br>
                            <telerik:RadTextBox ID="txtWebSite" runat="server" AutoPostBack="false" Width="100%">
                            </telerik:RadTextBox>
                        </div>
                    </div>
                </div>
                <!--                  second column                       -->
                <div class="column2">
                    <div class="title top-title">
                        Payment Information</div>
                    <div class="r-box-1" style="min-height: 100px;">
                        <div class="box-column1">
                            Bank Location:<br></br>
                            <asp:RadioButtonList ID="rblBankLocation" runat="server" RepeatDirection="Horizontal"
                                AutoPostBack="true" Font-Size="Medium">
                                <asp:ListItem Text="US" Value="US"></asp:ListItem>
                                <asp:ListItem Text="UK" Value="UK"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="box-column2">
                            <div id="balancedAccountCreateDiv" runat="server">
                                <span style="font-size: small;">Your Account has not been Configured&nbsp;</span><br />
                                <asp:LinkButton ID="lbtnCreateBalancedAccount" runat="server" Text="Create Now" Font-Size="Small"
                                    Font-Underline="true" OnClientClick="return CreateAccountByLocation();"></asp:LinkButton>
                            </div>
                            <div id="stripeAccountDetailsDiv" runat="server" visible="false">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <span class="LabelheadingNew">Stripe UserID:&nbsp;<asp:Label ID="lblStripeUserID"
                                                runat="server" Font-Size="Small"></asp:Label></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="LabelheadingNew">Date Created:&nbsp;<asp:Label ID="lblAccountCreatedDate"
                                                runat="server" Font-Size="Small"></asp:Label></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="balancedAccountDetailsDiv" runat="server" visible="false">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <span class="LabelheadingNew">Balanced CustomerID:&nbsp;<asp:Label ID="lblBalancedCustomerID"
                                                runat="server" Font-Size="Small"></asp:Label></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="LabelheadingNew">Date Created:&nbsp;<asp:Label ID="lblDateCreated" runat="server"
                                                Font-Size="Small"></asp:Label></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="title">
                        More Information</div>
                    <div class="r-box-2">
                        <div class="full-row">
                            About Me <span style="font-size: 10px;">145 characters</span>
                            <telerik:RadTextBox ID="txtAboutMe" runat="server" AutoPostBack="true" Width="100%"
                                TextMode="MultiLine">
                            </telerik:RadTextBox>
                            <br />
                            <br />
                            My Passions Are <span style="font-size: 10px;">145 characters</span>
                            <telerik:RadTextBox ID="txtPassions" runat="server" AutoPostBack="true" Width="100%"
                                TextMode="MultiLine">
                            </telerik:RadTextBox>
                            <br />
                            <br />
                            My Dream Is <span style="font-size: 10px;">145 characters</span>
                            <telerik:RadTextBox ID="txtMyDreams" runat="server" AutoPostBack="true" Width="100%"
                                TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </div>
                        <%--<div class="full-row">
                            <div class="box-column1" style="height: 22%;">
                                My CrowdBoards:<br />
                                <br />
                                <div style="background-color: #ececee; height: 125px;">
                                    <div class="DivCorner" style="background-color: #ececee; height: 125px; overflow: auto;
                                        overflow-x: hidden;">
                                        <asp:Repeater ID="CrowdBoardsCreatedByUserRepeater" runat="server" DataSourceID="sdCrowdBoardsCreatedByUser">
                                            <ItemTemplate>
                                                <div class="horizontalDirection">
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("DirectoryName", "~/CrowdBoardManagement.aspx?Name={0}") %>'>
                                                                    <asp:Image ID="boardPic" runat="server" Height="50px" Width="60px" ImageUrl='<%# isAvail(Eval("DirectoryName", "~/thumbnail/{0}.jpg")) %>' /></asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                            <div class="box-column2" style="height: 22%;">
                                Investment Set:<br />
                                <br />
                                <div style="background-color: #ececee; height: 125px;">
                                    <div class="DivCorner" style="background-color: #ececee; height: 125px; overflow: auto;
                                        overflow-x: hidden;">
                                        <asp:Repeater ID="boardsInvestedByUserRepeater" runat="server" DataSourceID="sdBoardsInvestedByUser">
                                            <ItemTemplate>
                                                <div class="horizontalDirection">
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                                    <asp:Image ID="boardPic" runat="server" Height="50px" Width="60px" ImageUrl='<%# isAvail(Eval("DirectoryName", "~/thumbnail/{0}.jpg")) %>' /></asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                    <div class="save-button-container" runat="server">
                        <input type="button" value="Save Updated Information" id="save-button" onclick=" return SaveChanges();" />
                        <asp:Button ID="btnView" runat="server" CssClass="post-button" Text="View" />                     
                    </div>
                </div>
            </contenttemplate>
        </asp:updatepanel>
    </div>
    <asp:sqldatasource id="sdBillingInformation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select userid,UserName,address,city,FirstName,LastName,Job,Birthdate,AboutMe,MyDreams,Passions,BackgroundImageStyle,WebSite,Skills,Email,BankLocation,TXResidentStatus from Users WHERE UserID=@UserID"
        updatecommand="UPDATE USERS SET UserName=@UserName, Address=@Address,City=@City,FirstName=@FirstName,LastName=@LastName,Job=@Job,Birthdate=@Birthdate,AboutMe=@AboutMe,MyDreams=@MyDreams,Passions=@MyPassions,BackgroundImageStyle=@BackgroundImageStyle,WebSite=@WebSite,Skills=@Skills,Email=@Email,BankLocation=@BankLocation WHERE UserID=@UserID">
        <selectparameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Job" Type="String" />
            <asp:Parameter Name="Birthdate" Type="String" />
            <asp:Parameter Name="AboutMe" Type="String" />
            <asp:Parameter Name="MyDreams" Type="String" />
            <asp:Parameter Name="MyPassions" Type="String" />
            <asp:Parameter Name="BackgroundImageStyle" Type="String" />
            <asp:Parameter Name="WebSite" Type="String" />
            <asp:Parameter Name="Skills" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="BankLocation" Type="String" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As UserName,UserID1,UserID2,UserID1UserName,UserID2UserName,Status,DateRequested,DateAccepted FROM vwBoardersDetail Where UserID1=@UserID OR UserID2=@UserID"
        insertcommand="INSERT INTO Boarders(UserID1,UserID2,Status,DateRequested) VALUES(@UserID1,@UserID2,@Status,@DateRequested)">
        <selectparameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </selectparameters>
        <insertparameters>
            <asp:Parameter Name="UserID1" Type="String" />
            <asp:Parameter Name="UserID2" Type="String" />
            <asp:Parameter Name="Status" Type="Boolean" />
            <asp:Parameter Name="DateRequested" Type="DateTime" />
        </insertparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdCheckRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="IF EXISTS(SELECT *  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1) ) select 1 as [status] else select 0 as [status]">
        <selectparameters>
            <asp:Parameter Name="UserID1" Type="Int32" />
            <asp:Parameter Name="UserID2" Type="Int32" />
        </selectparameters>
    </asp:sqldatasource>
    <%--<asp:SqlDataSource ID="sdCrowdBoardsCreatedByUser" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select BoardName,DirectoryName from boards where UserID=@userID order by DateActivated desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <%--<asp:SqlDataSource ID="sdBoardsInvestedByUser" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT BI.BoardID,B.BoardName,BI.DateInvested,B.DirectoryName FROM Boards B INNER JOIN BoardInvestors BI ON B.BoardID=BI.BoardID WHERE BI.AmountInvested IS NOT NULL AND BI.UserID=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:sqldatasource id="sdPossessions" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        selectcommand="SELECT P.Description,UP.PossessionID FROM UserPossessions UP INNER JOIN  Possessions P ON UP.PossessionID=P.PossessionID WHERE UP.userID=@userID">
        <selectparameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdAddPossessions" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        selectcommand="spAddPossession" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUserInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select BoardInvestedIn,crowdboards,PendingRequestCount,MessageCount from vwUserInfo where UserID=@userID">
        <selectparameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetUserId" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        selectcommand="select UserID from Users Where UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdsCheckMail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        selectcommand="Select * from [Users] WHERE email=@emailAddress and UserID<>@UserID">
        <selectparameters>
            <asp:Parameter Name="emailAddress" />
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdsCheckUserName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        selectcommand="Select * from [Users] WHERE UserName=@UserName and userid<>@UserID">
        <selectparameters>
            <asp:Parameter Name="UserName" />
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBalancedUserDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from BalancedUserRecord where UserID=@UserId">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdStripeUserDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from UserStripeAccount where UserID=@UserId">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBalancedUserAccountInsert" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        insertcommand="INSERT INTO BalancedUserRecord(UserID,UserAccountUri,UserBankAccountUri,DateCreated,CustomerID) VALUES(@UserID,@UserAccountUri,@UserBankAccountUri,GETDATE(),@CustomerID)"
        updatecommand="UPDATE BalancedUserRecord SET UserBankAccountUri=@UserBankAccountUri where UserID=@UserID">
        <insertparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="UserAccountUri" />
            <asp:Parameter Name="UserBankAccountUri" />
            <asp:Parameter Name="CustomerID" />
        </insertparameters>
        <updateparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="UserBankAccountUri" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdMemberShipUserDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select UserName,LoweredUserName,userID from aspnet_Users where UserName=@UserName"
        updatecommand="Update aspnet_Users set UserName=@UserName,LoweredUserName=@LoweredUserName where userID=@userID">
        <selectparameters>
            <asp:Parameter Name="UserName" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserName" />
            <asp:Parameter Name="LoweredUserName" />
            <asp:Parameter Name="userID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="adsTXResidentStatus" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE users SET TXResidentStatus=@TXResidentStatus where userID=@userID">
        <updateparameters>
            <asp:Parameter Name="TXResidentStatus" />          
            <asp:Parameter Name="userID" />
        </updateparameters>
    </asp:sqldatasource>
</asp:content>
