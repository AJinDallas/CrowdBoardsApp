<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Confirm"
    MasterPageFile="~/MasterPage/Site.Master" Title="Untitled Page" CodeBehind="Confirm.aspx.vb" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>Confirm Investment</title>
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%--  <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="WebContent/Theme/styles/payment.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script type="text/javascript" src="https://js.balancedpayments.com/v1/balanced.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
    <style type="text/css">
        .popup_box_all
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 350px;
            width: 600px;
            left: 400px;
            top: 200px;
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
            height: 30px;
        }
        
        input
        {
            margin-bottom: 3px;
        }
    </style>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <asp:hiddenfield id="balancedCreditCardURI" runat="server" />
    <asp:hiddenfield id="stripeCardToken" runat="server" />
    <asp:button id="btnCreatecard" runat="server" text="Create Customer" style="display: none;" />
    <asp:button id="btnCreateCardForStripe" runat="server" text="Create Customer" style="display: none;" />
    <div class="popup_box_all" id="createBalacedAccountDiv">
        <table width="100%">
            <tr>
                <td style="text-align: center;">
                    <span style="font-size: 20px;">Please fill your Card Details</span>
                </td>
                <td style="text-align: right;">
                    <asp:linkbutton id="lbtnCloseBalanced" forecolor="Red" runat="server" onclientclick="return unloadPopupAddCardDetails();">
                        <img src="Images/btncross.png" alt="X" width="25" height="25" /></asp:linkbutton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:label id="lblSuccessBalanced" runat="server" style="color: green; font-size: 12pt;">
                    </asp:label>
                    <asp:label id="lblErrorBalanced" runat="server" style="color: red; font-size: 12pt;">
                    </asp:label>
                </td>
            </tr>
        </table>
        <table width="100%" id="cardTable" cellpadding="5" cellspacing="5">
            <tr>
                <td style="width: 20%;">
                    First Name
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtFirstNameForCard" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Last Name
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtLastNameForCard" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Email Address
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtEmailAddress" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Card Number
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtCcNumber" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Expiry Month
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtExpiryMonth" runat="server">
                    </asp:textbox>
                    (mm)
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Expiry Year
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtExpiryYear" runat="server">
                    </asp:textbox>
                    (yyyy)
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    Security Code
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtSecurityCode" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr id="eligibleForGiftAidTR" runat="server" visible="false">
                <td colspan="2">
                    <asp:checkbox id="cbEligibleForGiftAid" runat="server" text="I am a UK taxpayer and would like Crowdboarders to treat all donations I make or have made in the last four years as Gift Aid donations until further notice.<br>I confirm that I have paid or will pay an amount of Income Tax and/or Capital Gains Tax for each tax year that is at least equal to or higher than the tax claimed by all charities and CASCs from HM Revenue & Customs on my donation(s). I also understand that Council Tax and VAT do not qualify." />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:button id="btnCreateCustomer" runat="server" text="Pay" cssclass="invest-button"
                        style="width: 25%;" onclientclick="return validateCardEntries()" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            balanced.init('<%=apiMarketplace %>');
            Stripe.setPublishableKey('<%=StripePublishableKey %>');
        </script>
        <script type="text/javascript">

            function OnClientClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
            }

            function loadPopupAddCardDetails() {    // To Load the Popupbox

                $('#createBalacedAccountDiv').fadeIn("slow");
                return false;

            }
            function unloadPopupAddCardDetails() {    // TO Unload the Popupbox
                $('#createBalacedAccountDiv').fadeOut("slow");
                return false;
            }
        </script>
        <script type="text/javascript">
            function validateCardEntries() {

                var firstName = document.getElementById("BodyContent_txtFirstNameForCard").value;
                var lastName = document.getElementById("BodyContent_txtLastNameForCard").value;
                var emailAddress = document.getElementById("BodyContent_txtEmailAddress").value;
                var ccNumber = document.getElementById("BodyContent_txtCcNumber").value;
                var expiryMonth = document.getElementById("BodyContent_txtExpiryMonth").value;
                var securityCode = document.getElementById("BodyContent_txtSecurityCode").value;
                var expiryYear = document.getElementById("BodyContent_txtExpiryYear").value;
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var valid = 1;
                if ($.trim(firstName).length == 0 || $.trim(lastName).length == 0 || $.trim(emailAddress).length == 0 || $.trim(ccNumber).length == 0 || $.trim(expiryMonth).length == 0 || $.trim(securityCode).length == 0 || $.trim(expiryYear).length == 0) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "All fields are required";
                    return false;
                }
                else if (!filter.test(emailAddress)) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "Please provide valid email address";
                    return false;
                }
                else if (!balanced.card.isCardNumberValid(ccNumber)) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "Card is not valid";
                    return false;
                }
                else if (!balanced.card.isSecurityCodeValid(ccNumber, securityCode)) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "Security code is not valid";
                    return false;
                }
                else if (!balanced.card.isExpiryValid(expiryMonth, expiryYear)) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "Expiry date is not valid";
                    return false;
                }
                else {
                    var userID = '<%=Session("UserID") %>';
                    $.ajax({
                        type: "POST",
                        url: "WebService/WebService.asmx/CheckEmailExistence",
                        data: "{'emailAddress':'" + emailAddress + "','userID':'" + userID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccessCall,
                        error: OnErrorCall
                    });
                }
                return false;
            }

            function OnSuccessCall(response) {
                var messageSignUp = document.getElementById("BodyContent_lblErrorBalanced");
                var vali = 1;
                if (response.d == "2") {
                    messageSignUp.style.visibility = 'visible';
                    messageSignUp.innerHTML = "Sorry this Email is already registered";
                    vali = 0;
                }

                if (vali == 1) {
                    var bankLocation = '<%=BankLocation %>';
                    //alert(bankLocation);
                    if (bankLocation == 'UK') {
                        CreateCardForStripePayments();
                    }
                    else {
                        CreateCardForBalancedPayments();
                    }
                }
                else {

                    return false;
                }
                return false;
            }
            function OnErrorCall(response) {

                alert(response.status + " " + response.statusText);
            }
            function CreateCardForStripePayments() {

                Stripe.card.createToken({
                    number: document.getElementById("BodyContent_txtCcNumber").value,
                    cvc: document.getElementById("BodyContent_txtSecurityCode").value,
                    exp_month: document.getElementById("BodyContent_txtExpiryMonth").value,
                    exp_year: document.getElementById("BodyContent_txtExpiryYear").value
                }, stripeResponseHandler);

            }
            function CreateCardForBalancedPayments() {
                var creditCardData = {
                    card_number: document.getElementById("BodyContent_txtCcNumber").value,
                    expiration_month: document.getElementById("BodyContent_txtExpiryMonth").value,
                    expiration_year: document.getElementById("BodyContent_txtExpiryYear").value,
                    security_code: document.getElementById("BodyContent_txtSecurityCode").value
                };
                balanced.card.create(creditCardData, callbackHandler);
            }
            function stripeResponseHandler(status, response) {
                if (response.error) {
                    alert("error: " + response.error.message);
                    return false;
                } else {

                    var token = response['id'];
                    document.getElementById("<%=stripeCardToken.ClientID %>").value = token;
                    document.getElementById("<%= btnCreateCardForStripe.ClientID %>").click();
                }
            }
            function callbackHandler(response) {
                if (response.status == 201) {
                    SetValueInHidden(response.data)
                    document.getElementById("<%= btnCreatecard.ClientID %>").click();
                }
                else {
                    alert("error: " + response.status);
                    return false;
                }
            }
            function SetValueInHidden(response) {
                var cardTokenURI = response['uri'];
                document.getElementById("<%=balancedCreditCardURI.ClientID %>").value = cardTokenURI;
                return false;
            }
      
        </script>
    </telerik:RadScriptBlock>
    <div class="title">
        Invest in
        <asp:label id="boardNameLabel" runat="server"></asp:label>
        Securely
        <div style="float: right; font-size: 12px;">
            <asp:label id="messageLabel" runat="server" text="" font-size="12"></asp:label>
            <br />
            <asp:button id="btnSend" runat="server" text="Send Email" visible="false" cssclass="invest-button"
                style="width: 169px; margin-top: 20px;" />
        </div>
    </div>
    <div class="payment-details">
        <span class="level-amnt">Level Amount
            <telerik:RadTextBox ID="txtLevelAmount" runat="server" ReadOnly="true">
            </telerik:RadTextBox>
        </span><span class="fees">CrowdBoarders Fees
            <telerik:RadTextBox ID="txtFees" runat="server" ReadOnly="true">
            </telerik:RadTextBox>
        </span>
    </div>
    <div class="payment-details">
        <span class="payment-amount">You will have to pay
            <telerik:RadTextBox ID="txtStandardCharge" runat="server" ReadOnly="true">
            </telerik:RadTextBox>
        </span><span class="fees" style="text-align: left;">&nbsp;&nbsp;&nbsp;Level
            <telerik:RadTextBox ID="txtLevelName" runat="server" ReadOnly="true" Width="259px"
                Style="text-align: left;">
            </telerik:RadTextBox>
        </span>
    </div>
    <%-- <div class="pay-with-current-card">
        Pay with the Card on your account <span class="card-on-account">American Express ending
            in 0057</span>
        <div class="invest-button">
            <input type="button" value="Invest!" id="invest-button" /></div>
    </div>--%>
    <div id="billingInfoDiv" runat="server">
        <div class="pay-with-new-card">
            <div style="margin-bottom: 10px;">
                <span class="sub-heading">Billing Information</div>
            <form>
            <div class="oneina-row">
                Address</br>
                <telerik:RadTextBox ID="txtAddress" runat="server" TextMode="MultiLine" CssClass="DivCorner"
                    Font-Names="Arial" Font-Size="9pt" Width="100%" AutoPostBack="true">
                </telerik:RadTextBox></br>
            </div>
            <div class="twoina-row">
                <div class="card-number">
                    City:</br>
                    <telerik:RadTextBox ID="txtCity" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
                <div class="security">
                    State</br>
                    <telerik:RadTextBox ID="txtState" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
            </div>
            <div class="twoina-row">
                <div class="card-number">
                    Zip:</br>
                    <telerik:RadTextBox ID="txtZip" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
                <div class="security">
                    Social Security Number</br>
                    <telerik:RadTextBox ID="txtSsn" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
            </div>
            <div class="twoina-row">
                <div class="card-number">
                    First Name</br>
                    <telerik:RadTextBox ID="txtFirstName" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
                <div class="security">
                    Last Name</br>
                    <telerik:RadTextBox ID="txtLastName" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></br></div>
            </div>
            <div class="expiration-row">
                Email</br>
                <div class="year">
                    <telerik:RadTextBox ID="txtEmail" runat="server" AutoPostBack="true" Width="284px">
                    </telerik:RadTextBox></div>
                <div class="investment-button">
                    <asp:button id="btnInvest" runat="server" text="Invest !" style="font-size: 26px;
                        height: 40px; padding-left: 44px; padding-right: 44px;" cssclass="invest-button" /></div>
            </div>
            </form>
        </div>
    </div>
    <div class="balanced">
        All our payments are processed securely by<a href="http://www.balancedpayments.com"
            id="balanceurl" runat="server"><img src="WebContent/Theme/Images/balanced.jpg" id="balanceLogo"
                runat="server" />
        </a>
    </div>
    <div>
        <div id="investmentsDiv">
            <asp:hiddenfield runat="server" id="hdnBoardID" />
            <asp:hiddenfield runat="server" id="hdnLevelID" />
            <asp:hiddenfield runat="server" id="hdnAmountInvested" />
        </div>
    </div>
    <asp:sqldatasource id="sdBillingInformation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT UserName,Address,City,State,Zip,SocialSecurityNumber ,FirstName,LastName,Email FROM vUserBillingInfo  WHERE UserID=@UserID"
        updatecommand="UPDATE USERS SET Address=@Address,City=@City,State=@State,Zip=@Zip,SocialSecurityNumber=@SocialSecurityNumber,FirstName=@FirstName,LastName=@LastName,Email=@Email WHERE UserID=@UserID">
        <selectparameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="Address" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="State" />
            <asp:Parameter Name="Zip" />
            <asp:Parameter Name="SocialSecurityNumber" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Email" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestmentDetail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="sp_GetInvestmentDetails" selectcommandtype="StoredProcedure">
        <selectparameters>
         <asp:Parameter Name="LevelName" />
          <asp:Parameter Name="Name" />
           
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUserNameByUserID" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select UserName from Users where UserID=@UserID">
        <selectparameters>
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdConfirmedInvestorsDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spInvestByBalanced" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="AmountInvested" />
            <asp:Parameter Name="LevelID" />
            <asp:Parameter Name="HoldUri" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestmentByStripe" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spInvestByStripe" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="AmountInvested" />
            <asp:Parameter Name="LevelID" />
            <asp:Parameter Name="CheckoutID" />
            <asp:Parameter Name="PreApprovalID" />
             <asp:Parameter Name="EligibleForGiftAid" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdCheckInvestment" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="IF EXISTS(SELECT *  FROM BoardInvestors where UserID=@UserID and BoardID=@BoardID and DateInvested IS NOT NULL) SELECT 'IsExist' as result Else select 'NotExist' as result">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoardInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select *,(select WePayModel FROM InvestmentType WHERE Value=vwBoardInfo.InvestmentTypeID) as WePayModel FROM vwBoardInfo WHERE BoardID=@BoardID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUsersInfoChanges" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE USERS SET FirstName=@FirstName,LastName=@LastName,Email=@Email WHERE UserID=@UserID">
        <updateparameters>
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="UserID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdProcessPreApproval" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE BoardInvestors SET DateInvested=GETDATE(),DebitUri=@DebitUri WHERE HoldUri=@HoldUri">
        <updateparameters>
            <asp:Parameter Name="DebitUri" />
            <asp:Parameter Name="HoldUri" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdPreApprovalInvestments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BI.*,(select username from Users where UserID=BI.UserID) as UserName,(select LevelName from BoardLevels where LevelID=BI.LevelID) as LevelName from boardinvestors BI where BI.HoldUri IS NOT NULL AND BI.DebitUri IS NULL AND BI.BoardID=@BoardID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetStandardCharge" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT StandardCharge FROM InvestmentLevels WHERE FundAmount=@FundAmount">
        <selectparameters>
            <asp:Parameter Name="FundAmount" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBalancedInvestorDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from BalancedUserRecord WHERE UserId=@UserId">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBalancedOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from BalancedUserRecord WHERE UserId=@UserId and UserBankAccountUri is not null">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdStripeOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from UserStripeAccount WHERE UserId=@UserId and acces_token is not null">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdStripeInvestorDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from UserStripeAccount WHERE UserId=@UserId">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetOwnerEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select Email from users where UserID=@UserId">
        <selectparameters>
            <asp:Parameter Name="UserId" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBalancedUserCardInsert" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        insertcommand="INSERT INTO BalancedUserRecord(UserID,UserAccountUri,UserCardUri,DateCreated,CustomerID) VALUES(@UserID,@UserAccountUri,@UserCardUri,GETDATE(),@CustomerID)"
        updatecommand="UPDATE BalancedUserRecord SET UserCardUri=@UserCardUri where UserID=@UserID">
        <insertparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="UserAccountUri" />
            <asp:Parameter Name="UserCardUri" />
            <asp:Parameter Name="CustomerID" />
        </insertparameters>
        <updateparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="UserCardUri" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdStripeUserCardInsert" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        insertcommand="INSERT INTO UserStripeAccount(UserID,StripeCardToken,CustomerID,DateCreated,Status) VALUES(@UserID,@StripeCardToken,@CustomerID,GETDATE(),1)"
        updatecommand="UPDATE UserStripeAccount SET StripeCardToken=@StripeCardToken,CustomerID=@CustomerID where UserID=@UserID">
        <insertparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="StripeCardToken" />
            <asp:Parameter Name="CustomerID" />
        </insertparameters>
        <updateparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="StripeCardToken" />
            <asp:Parameter Name="CustomerID" />
        </updateparameters>
    </asp:sqldatasource>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="350px" Width="500px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>
</asp:content>
