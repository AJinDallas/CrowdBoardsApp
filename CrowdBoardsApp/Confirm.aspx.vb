Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports WePaySDK
Imports Stripe

Partial Class Confirm
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Public paypalEmail As String
    Public customKeys As String
    Public itemName As String
    Public amount As String
    Public acces_token As String
    Public accountID As String
    Public successUrl As String = ConfigurationManager.AppSettings("successUrl").ToString()
    Public cancelUrl As String = ConfigurationManager.AppSettings("cancelUrl").ToString()
    Public apiMarketplace As String = "" & ConfigurationManager.AppSettings("ApiMarketplace")
    Public stripePublishableKey As String = "" & ConfigurationManager.AppSettings("StripePublishableKey")
    Public Shared stripeApiKey As String = "" & ConfigurationManager.AppSettings("StripeApiKey")
    Public Property ownerID() As Integer
        Get
            Return CInt(ViewState("_ownerID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_ownerID") = value
        End Set
    End Property
    Public Property amountRemaining() As Double
        Get
            Return CDbl(ViewState("_amountRemaining"))
        End Get
        Set(ByVal value As Double)
            ViewState("_amountRemaining") = value
        End Set
    End Property
    Public Property wePayModelType() As String
        Get
            Return CStr(ViewState("_wePayModelType"))
        End Get
        Set(ByVal value As String)
            ViewState("_wePayModelType") = value
        End Set
    End Property
    Public Property EmailBody() As String
        Get
            Return CStr(ViewState("_emailBody"))
        End Get
        Set(ByVal value As String)
            ViewState("_emailBody") = value
        End Set
    End Property
    Public Property InvestmentType() As String
        Get
            Return CStr(ViewState("_investmentType"))
        End Get
        Set(ByVal value As String)
            ViewState("_investmentType") = value
        End Set
    End Property
    Public Property InvestorName() As String
        Get
            Return CStr(ViewState("_investorName"))
        End Get
        Set(ByVal value As String)
            ViewState("_investorName") = value
        End Set
    End Property
    Public Property BoardOwnerUserName() As String
        Get
            Return CStr(ViewState("_ownerUserName"))
        End Get
        Set(ByVal value As String)
            ViewState("_ownerUserName") = value
        End Set
    End Property
    Public Property CustomerIdOfOwner() As String
        Get
            Return CStr(ViewState("_customerIdOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerIdOfOwner") = value
        End Set
    End Property
    Public Property CustomerIdOfInvestor() As String
        Get
            Return CStr(ViewState("_customerIdOfInvestor"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerIdOfInvestor") = value
        End Set
    End Property
    Public Property CustomerUriOfInvestor() As String
        Get
            Return CStr(ViewState("_customerUriOfInvestor"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerUriOfInvestor") = value
        End Set
    End Property
    Public Property BankLocation() As String
        Get
            Return CStr(ViewState("_bankLocation"))
        End Get
        Set(ByVal value As String)
            ViewState("_bankLocation") = value
        End Set
    End Property
    Public Property AccessTokenOfOwner() As String
        Get
            Return CStr(ViewState("_accessTokenOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_accessTokenOfOwner") = value
        End Set
    End Property
    Public Property PublishableKeyOfOwner() As String
        Get
            Return CStr(ViewState("_publishableKeyOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_publishableKeyOfOwner") = value
        End Set
    End Property
    Public Property StripeCustomerIDOfInvestor() As String
        Get
            Return CStr(ViewState("_stripeCustomerIDOfInvestor"))
        End Get
        Set(ByVal value As String)
            ViewState("_stripeCustomerIDOfInvestor") = value
        End Set
    End Property
    Public Property StripeAccountMode() As String
        Get
            Return CStr(ViewState("_stripeAccountMode"))
        End Get
        Set(ByVal value As String)
            ViewState("_stripeAccountMode") = value
        End Set
    End Property
    Protected Sub SetOwnerUserName()
        Try
            sdUserNameByUserID.SelectParameters.Item("UserID").DefaultValue = Me.ownerID
            Dim dv As Data.DataView = CType(sdUserNameByUserID.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("UserName"))) Then
                        Me.BoardOwnerUserName = dv(0)("UserName").ToString()
                        'userName = dv(0)("UserName").ToString()
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        messageLabel.Text = String.Empty
        If (Not Page.IsPostBack) Then
            If Session("userName") Is Nothing Then
                If (Request.QueryString.Count > 0) Then
                    Dim returnURL As String = "~/confirm.aspx?Name=" & Request.QueryString("Name") & "&LevelName=" & Request.QueryString("LevelName")
                    Response.Redirect("~/Default.aspx?returnURL=" & HttpUtility.UrlEncode(returnURL))
                End If
            Else
                If (Request.QueryString.Count > 0) Then
                    Try
                        LoadUserBillingInfo()
                        LoadInvestmentDetail()
                        SetOwnerUserName()
                        EmailBodyCreation()
                        CheckInvestment()
                        'CheckIfFullyFunded()
                    Catch ex As Exception
                        GlobalModule.SetMessage(messageLabel, False, "Error in Loading Data")
                        GlobalModule.ErrorLogFile(ex)
                    End Try

                Else
                    Response.Redirect("~/Search.aspx")
                End If

            End If
        End If
        RadWindow1.VisibleOnPageLoad = False
    End Sub

    Private Sub LoadUserBillingInfo()
        Try
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                Dim dv As Data.DataView = CType(sdBillingInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then


                    boardNameLabel.Text = Request.QueryString("Name").ToString()
                    If (Not IsDBNull(dv(0)("Address"))) Then
                        txtAddress.Text = dv(0)("Address")
                    End If

                    If (Not IsDBNull(dv(0)("City"))) Then
                        txtCity.Text = dv(0)("City")
                    End If

                    If (Not IsDBNull(dv(0)("State"))) Then

                        txtState.Text = dv(0)("State")
                    End If
                    If (Not IsDBNull(dv(0)("Zip"))) Then
                        txtZip.Text = dv(0)("Zip")
                    End If
                    If (Not IsDBNull(dv(0)("SocialSecurityNumber"))) Then
                        txtSsn.Text = dv(0)("SocialSecurityNumber")
                    End If
                    If (Not IsDBNull(dv(0)("FirstName"))) Then
                        txtFirstName.Text = dv(0)("FirstName")
                        txtFirstNameForCard.Text = dv(0)("FirstName")
                    End If
                    If (Not IsDBNull(dv(0)("LastName"))) Then
                        txtLastName.Text = dv(0)("LastName")
                        txtLastNameForCard.Text = dv(0)("LastName")
                    End If

                    If (Not IsDBNull(dv(0)("Email"))) Then
                        txtEmail.Text = dv(0)("Email")
                        txtEmailAddress.Text = dv(0)("Email")
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadInvestmentDetail()
        Try
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                sdInvestmentDetail.SelectParameters.Item("LevelName").DefaultValue = Request.QueryString("LevelName")
                sdInvestmentDetail.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
                Dim dv As Data.DataView = CType(sdInvestmentDetail.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then

                    If (Not IsDBNull(dv(0)("ItemName"))) Then
                        txtLevelName.Text = dv(0)("ItemName")
                        itemName = dv(0)("ItemName")
                    End If

                    If (Not IsDBNull(dv(0)("PaypalEmail"))) Then
                        paypalEmail = dv(0)("PaypalEmail")
                    End If
                    If (Not IsDBNull(dv(0)("LevelAmount"))) Then
                        ' txtLevelAmount.Text = GM.GetAmountAccordingToLocation(dv(0)("LevelAmount").ToString(), dv(0)("BankLocation").ToString())
                        txtLevelAmount.Text = GM.GetAmountAccordingToLocationForAPICall(dv(0)("LevelAmount").ToString(), dv(0)("BankLocation").ToString())

                        amount = dv(0)("LevelAmount")
                        hdnAmountInvested.Value = dv(0)("LevelAmount")
                    End If

                    If (Not IsDBNull(dv(0)("BoardID"))) Then
                        hdnBoardID.Value = dv(0)("BoardID")
                    End If

                    If (Not IsDBNull(dv(0)("LevelID"))) Then
                        hdnLevelID.Value = dv(0)("LevelID")
                    End If
                    If (Not IsDBNull(dv(0)("ownerID"))) Then
                        Me.ownerID = dv(0)("ownerID")
                    End If
                    If (Not IsDBNull(dv(0)("InvestmentType"))) Then
                        Me.InvestmentType = dv(0)("InvestmentType")
                    End If
                    If (Not IsDBNull(dv(0)("BankLocation"))) Then
                        Me.BankLocation = dv(0)("BankLocation")
                    End If
                    If (Not IsDBNull(dv(0)("StardardCharge"))) Then
                        txtStandardCharge.Text = GM.GetAmountAccordingToLocationForAPICall(dv(0)("StardardCharge").ToString(), dv(0)("BankLocation").ToString())
                    End If
                    If (Not IsDBNull(dv(0)("Fees"))) Then
                        txtFees.Text = GM.GetAmountAccordingToLocationForAPICall(dv(0)("Fees").ToString(), dv(0)("BankLocation").ToString())
                    End If
                    If (Me.BankLocation = "UK") Then
                        balanceurl.HRef = "https://stripe.com/"
                        balanceLogo.Src = "WebContent/theme/Images/stripe-logo.png"
                    Else
                        balanceurl.HRef = "http://www.balancedpayments.com"
                        balanceLogo.Src = "WebContent/theme/Images/balanced.jpg"
                    End If
                    customKeys = Session("UserID").ToString() & "," & dv(0)("BoardID").ToString & "," & dv(0)("LevelID").ToString() & "," & dv(0)("LevelAmount").ToString() & "," & Request.QueryString("Name") & "," & Request.QueryString("LevelName") & "," & Me.ownerID.ToString()
                    Session("InvestmentDetails") = customKeys

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub SendEmailToOwner()
        Try
            Dim strSubject As String = "You Have a New Investor!"
            Dim toAddress As String = GetOwnerEmailAddress()
            Dim strBody As String = "A CrowdBoarder has invested in your CrowdBoard! Login to see how much <a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
            If (toAddress <> "") Then
                GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function GetOwnerEmailAddress() As String
        Dim res As String = ""
        Try
            Dim dv As DataView
            sdGetOwnerEmail.SelectParameters.Item("UserId").DefaultValue = Me.ownerID
            dv = CType(sdGetOwnerEmail.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("Email"))) Then
                        res = dv(0)("Email")
                    End If
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
        Return res
    End Function
    Protected Sub EmailBodyCreation()
        Try
            Me.EmailBody = ""
            Me.EmailBody = "Board Name: " & Request.QueryString("Name") & " " & "(" & hdnBoardID.Value & ")" & "<br>"
            Me.EmailBody = Me.EmailBody & "Investment Level : " + Request.QueryString("LevelName") + " " + "(" & hdnLevelID.Value & ")" & "<br>"
            Me.EmailBody = Me.EmailBody & "Investor : " & Session("UserName").ToString() & " " & "(" & (Session("UserID").ToString()) & ")" & "<br>"
            Me.EmailBody = Me.EmailBody & "Board Owner : " & Me.BoardOwnerUserName.ToString() & " " & "(" & Me.ownerID.ToString() & ")" & "<br>"
            Me.EmailBody = Me.EmailBody & "Level Amount: " & txtLevelAmount.Text & "<br>"
            Me.EmailBody = Me.EmailBody & "Fees: " & txtFees.Text & "<br>"
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSend.Click
        Try
            RadWindow1.NavigateUrl = "~/rwValidateEmail.aspx"
            RadWindow1.VisibleOnPageLoad = True
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Processing Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub SendMailToAdmin()
        Try
            Dim strSubject As String = "Investment Details"
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody As String = "Below are the details of Investment:-<br>" & Me.EmailBody
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub SaveChanges()
        Try
            sdBillingInformation.UpdateParameters.Item("Address").DefaultValue = txtAddress.Text
            sdBillingInformation.UpdateParameters.Item("City").DefaultValue = txtCity.Text
            sdBillingInformation.UpdateParameters.Item("State").DefaultValue = txtState.Text
            sdBillingInformation.UpdateParameters.Item("Zip").DefaultValue = txtZip.Text
            sdBillingInformation.UpdateParameters.Item("SocialSecuritynumber").DefaultValue = txtSsn.Text
            sdBillingInformation.UpdateParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
            sdBillingInformation.UpdateParameters.Item("FirstName").DefaultValue = txtFirstName.Text
            sdBillingInformation.UpdateParameters.Item("LastName").DefaultValue = txtLastName.Text
            sdBillingInformation.UpdateParameters.Item("Email").DefaultValue = txtEmail.Text
            sdBillingInformation.Update()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub txtAddress_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAddress.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtCity_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCity.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtState_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtState.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtZip_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtZip.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtSsn_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSsn.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtFirstName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFirstName.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtLastName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtLastName.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtEmail_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEmail.TextChanged
        SaveChanges()
    End Sub
    Private Sub CheckInvestment()
        Try
            If CheckBoarderStatus() = 1 Then
                If CheckIsOwner() = 1 Then
                    GlobalModule.SetMessage(messageLabel, False, "You cannot Invest in your own Board")
                    btnInvest.Visible = False
                Else
                    sdCheckInvestment.SelectParameters.Item("BoardID").DefaultValue = hdnBoardID.Value
                    sdCheckInvestment.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                    Dim dv As Data.DataView = CType(sdCheckInvestment.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If dv.Count > 0 Then
                        If dv(0)("result") = "IsExist" Then
                            GlobalModule.SetMessage(messageLabel, False, "You have Already Invested In this Board")
                            btnInvest.Visible = False
                        Else
                            Dim str As String = String.Empty
                            If (Me.BankLocation = "US") Then
                                str = txtLevelAmount.Text.Replace("$", "")
                            Else
                                str = txtLevelAmount.Text.Replace("£", "")
                            End If
                            If (Convert.ToDouble(str) > Me.amountRemaining) Then
                                GlobalModule.SetMessage(messageLabel, False, "Not much investment left in this board")
                                btnInvest.Visible = False
                            End If
                        End If
                    End If
                End If
            Else
                ' GlobalModule.SetMessage(messageLabel, False, "Your Email Address has not been Validated.Please click Send button to Resend the Email Address")
                ' btnSend.Visible = True
                GlobalModule.SetMessage(messageLabel, False, "   You do not have permission to invest, Please contact administrator !!")
                btnInvest.Visible = False
                btnSend.Visible = False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function CheckBoarderStatus() As Integer
        Dim isBoarder As Integer = 0
        Try
            Dim username As String = Session("userName")
            Dim userRolesList() As String = Roles.GetRolesForUser(username)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    If (item = "Boarder") Then
                        isBoarder = 1
                        Exit For
                    ElseIf (item = "Admin") Then
                        isBoarder = 1
                        Exit For
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isBoarder
    End Function
    Public Function CheckIsOwner() As Integer
        Dim isOwner As Integer = 0
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = hdnBoardID.Value
            Dim dv As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If dv(0)("UserID") = Session("userID") Then
                    isOwner = 1
                Else
                    isOwner = 0
                End If
                Me.amountRemaining = Convert.ToDouble(dv(0)("AmountRemaining"))
                If (Not IsDBNull(dv(0)("WePayModel"))) Then
                    Me.wePayModelType = dv(0)("WePayModel").ToString()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isOwner
    End Function
    Protected Sub SetAmountRemaining()
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = hdnBoardID.Value
            Dim dv As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("AmountRemaining"))) Then
                    Me.amountRemaining = Convert.ToDouble(dv(0)("AmountRemaining"))
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Protected Function GetStandardCharge(ByVal fundAmount As String) As String
        Dim standardCharge As String = String.Empty
        Try
            sdGetStandardCharge.SelectParameters.Item("FundAmount").DefaultValue = fundAmount
            Dim dv As Data.DataView = CType(sdGetStandardCharge.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("StandardCharge"))) Then
                        standardCharge = dv(0)("StandardCharge").ToString()
                    End If
                End If
            End If
        Catch ex As Exception

        End Try
        Return standardCharge
    End Function
    Protected Sub btnInvest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInvest.Click
        Try
            If Me.BankLocation <> "" Then
                If (Me.BankLocation = "US") Then
                    BalancedInvetmentMethod()
                Else
                    StripeInvetmentMethod()
                End If
            Else
                GlobalModule.SetMessage(messageLabel, False, "Investment not available this time")
            End If


        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Processing Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub StripeInvetmentMethod()
        Try
            Dim standardCharge As String = txtStandardCharge.Text.Replace("£", "")
            Dim fullName As String = txtFirstNameForCard.Text.Trim() + txtLastNameForCard.Text.Trim()
            If standardCharge <> "" Then
                Me.AccessTokenOfOwner = GetOwnerAccessToken(Me.ownerID)
                Me.StripeCustomerIDOfInvestor = GetStripeCustomerIdOfInvestor(Session("UserID"))
                If Me.AccessTokenOfOwner = "error" Then
                    GlobalModule.SetMessage(messageLabel, False, "Investment not available this time")
                ElseIf Me.AccessTokenOfOwner = "not found" Then
                    GlobalModule.SetMessage(messageLabel, False, "Investment not available this time")
                Else
                    If Me.StripeCustomerIDOfInvestor = "error" Then
                        GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                    ElseIf Me.StripeCustomerIDOfInvestor = "not found" Then
                        Me.StripeAccountMode = "IsNew"
                        If fullName = "" Or txtEmailAddress.Text.Trim() = "" Then
                            GlobalModule.SetMessage(messageLabel, False, "Please update First Name,Last Name and valid email in your profile first")
                        Else
                            If (Me.InvestmentType.ToLower = "donation") Then
                                eligibleForGiftAidTR.Visible = True
                            Else
                                eligibleForGiftAidTR.Visible = False
                            End If

                            Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:loadPopupAddCardDetails();", True)
                        End If

                    Else
                        If Me.StripeCustomerIDOfInvestor = "" Then
                            Me.StripeAccountMode = "IsUpdate"
                            If fullName = "" Or txtEmailAddress.Text.Trim() = "" Then
                                GlobalModule.SetMessage(messageLabel, False, "Please update First Name,Last Name and valid email in your profile first")
                            Else
                                If (Me.InvestmentType.ToLower = "donation") Then
                                    eligibleForGiftAidTR.Visible = True
                                Else
                                    eligibleForGiftAidTR.Visible = False
                                End If
                                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:loadPopupAddCardDetails();", True)
                            End If
                        Else
                            CreateStripeCharge()
                        End If
                    End If
                End If

            Else
                GlobalModule.SetMessage(messageLabel, False, "No investment available")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub BalancedInvetmentMethod()
        Try
            Dim standardCharge As String = txtStandardCharge.Text.Replace("$", "")
            Dim fullName As String = txtFirstNameForCard.Text.Trim() + txtLastNameForCard.Text.Trim()
            If standardCharge <> "" Then
                Dim strDebitAmount As String = txtStandardCharge.Text.Replace("$", "").Replace(".", "")
                Dim strCreditAmount As String = txtLevelAmount.Text.Replace("$", "").Replace(".", "")
                Dim strFeesAmount As String = txtFees.Text.Replace("$", "").Replace(".", "")

                Me.CustomerIdOfOwner = GetOwnerCustomerID(Me.ownerID)
                Me.CustomerIdOfInvestor = GetInvestorCustomerID(Convert.ToInt64(Session("userID")))
                If Me.CustomerIdOfOwner = "error" Then
                    GlobalModule.SetMessage(messageLabel, False, "Investment not available this time")
                ElseIf Me.CustomerIdOfOwner = "not found" Then
                    GlobalModule.SetMessage(messageLabel, False, "Investment not available this time")
                Else
                    If Me.CustomerIdOfInvestor = "error" Then
                        GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                    ElseIf Me.CustomerIdOfInvestor = "not found" Then
                        Me.CustomerUriOfInvestor = "IsNew"
                        If fullName = "" Or txtEmailAddress.Text.Trim() = "" Then
                            GlobalModule.SetMessage(messageLabel, False, "Please update First Name,Last Name and valid email in your profile first")
                        Else
                            Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:loadPopupAddCardDetails();", True)
                        End If

                    Else
                        If Me.CustomerUriOfInvestor = "" Then
                            Me.CustomerUriOfInvestor = "IsUpdate"
                            If fullName = "" Or txtEmailAddress.Text.Trim() = "" Then
                                GlobalModule.SetMessage(messageLabel, False, "Please update First Name,Last Name and valid email in your profile first")
                            Else
                                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:loadPopupAddCardDetails();", True)
                            End If
                        Else
                            If Me.wePayModelType = "PreApproval" Then
                                CreateHoldForCard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Hold for Investment in " & txtLevelName.Text)
                            ElseIf Me.wePayModelType = "DirectCheckout" Then
                                InvestInBoard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Investment in " & txtLevelName.Text)
                            End If
                            SendMailToAdmin()
                        End If

                    End If
                End If
            Else
                GlobalModule.SetMessage(messageLabel, False, "No investment available")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub CreateHoldForCard(ByVal customerIdOfInvestor As String, ByVal customerIdOfOwner As String, ByVal appears_on_statement_as As String, ByVal debitAmount As String, ByVal creditAmount As String, ByVal merchantCreditAmount As String, ByVal description As String)
        Try
            EmailBodyCreation()
            Dim holdResult As String = BalancedPayments.CreateHoldForCard(debitAmount, Me.CustomerUriOfInvestor, description)
            If holdResult.Contains("succeeded") Then
                Me.EmailBody = Me.EmailBody & "Hold Status: succeeded <br>"
                Dim holdData() As String = holdResult.Split(",")
                AddInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, holdData(1).ToString())
            ElseIf holdResult.Contains("failed") Then
                Me.EmailBody = Me.EmailBody & "Hold Status: failed <br>"
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            Else
                Me.EmailBody = Me.EmailBody & "Hold Status: Error Occured <br>"
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub CaptureHold(ByVal holdUri As String, ByVal strAmount As String, ByVal appears_on_statement_as As String, ByVal description As String, ByVal creditAmount As String, ByVal merchantCreditAmount As String)
        Try
            Dim holdCaptureResult As String = BalancedPayments.CaptureHoldForCard(appears_on_statement_as, strAmount, description, holdUri)
            If holdCaptureResult.Contains("succeeded") Then
                Dim holdCaptureData() As String = holdCaptureResult.Split(",")
                Dim creditRes As String = BalancedPayments.CreateNewCreditForCustomer(CustomerIdOfOwner, creditAmount)
                If creditRes.Contains("paid") Or creditRes.Contains("pending") Then
                    Dim merchantCreditRes As String = BalancedPayments.CreateNewCreditForMarketPlace(merchantCreditAmount)
                    SaveInvestment(holdCaptureData(1).ToString(), holdUri)

                ElseIf creditRes.Contains("error") Then
                    GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                Else
                    GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                End If
            ElseIf holdCaptureResult.Contains("error") Then
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            Else
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub SaveInvestment(ByVal debitUri As String, ByVal holdUri As String)
        Try
            sdProcessPreApproval.UpdateParameters.Item("DebitUri").DefaultValue = debitUri
            sdProcessPreApproval.UpdateParameters.Item("HoldUri").DefaultValue = holdUri
            sdProcessPreApproval.Update()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub CheckIfFullyFunded()
        Try
            If Me.amountRemaining = 0.0 Then
                sdPreApprovalInvestments.SelectParameters.Item("BoardID").DefaultValue = hdnBoardID.Value
                Dim dv As Data.DataView = CType(sdPreApprovalInvestments.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If Not dv Is Nothing Then
                    If dv.Count > 0 Then
                        For Each dr As DataRowView In dv
                            Dim holdUri As String = dr("HoldUri").ToString()
                            Dim userName As String = dr("UserName").ToString()
                            Dim levelName As String = dr("LevelName").ToString()
                            Dim creditAmount As String = dr("AmountInvested").ToString()
                            creditAmount = creditAmount.Replace(".", "")
                            Dim standardCharge As String = GetStandardCharge(dr("AmountInvested").ToString())
                            standardCharge = standardCharge.Replace(".", "")
                            Dim merchantAmount As Double = Convert.ToDouble(standardCharge) - Convert.ToDouble(creditAmount)
                            Dim merchantAmountStr As String = merchantAmount.ToString()
                            merchantAmountStr = merchantAmountStr.Replace(".", "")
                            CaptureHold(holdUri, standardCharge, userName, "Investment in " & levelName, creditAmount, merchantAmountStr)
                        Next
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub InvestInBoard(ByVal customerIdOfInvestor As String, ByVal customerIdOfOwner As String, ByVal appears_on_statement_as As String, ByVal debitAmount As String, ByVal creditAmount As String, ByVal merchantCreditAmount As String, ByVal description As String)
        Try
            EmailBodyCreation()
            Dim mailAppendContain = ""
            Dim debitResult As String = BalancedPayments.CreateNewDebit(customerIdOfInvestor, appears_on_statement_as, debitAmount, description)
            If debitResult.Contains("succeeded") Then
                Me.EmailBody = Me.EmailBody & "Debit Status: succeeded <br>"
                Dim creditRes As String = BalancedPayments.CreateNewCreditForCustomer(customerIdOfOwner, creditAmount)
                If creditRes.Contains("paid") Or creditRes.Contains("pending") Then
                    If creditRes.Contains("paid") Then
                        Me.EmailBody = Me.EmailBody & "Credit Status: paid <br>"
                    ElseIf creditRes.Contains("pending") Then
                        Me.EmailBody = Me.EmailBody & "Credit Status: pending <br>"
                    Else
                        Me.EmailBody = Me.EmailBody & "Credit Status: error occured <br>"
                    End If
                    Dim merchantCreditRes As String = BalancedPayments.CreateNewCreditForMarketPlace(merchantCreditAmount)
                    If merchantCreditRes.Contains("paid") Then
                        Me.EmailBody = Me.EmailBody & "Merchant Credit Status: paid <br>"
                    ElseIf merchantCreditRes.Contains("pending") Then
                        Me.EmailBody = Me.EmailBody & "Merchant Credit Status: pending <br>"
                    Else
                        Me.EmailBody = Me.EmailBody & "Merchant Credit Status: error occured <br>"
                    End If
                    AddInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, "")

                ElseIf creditRes.Contains("error") Then
                    GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                Else
                    GlobalModule.SetMessage(messageLabel, False, "Error in Request")
                End If
            ElseIf debitResult.Contains("error") Then
                Me.EmailBody = Me.EmailBody & "Debit Status: Error Occured <br>"
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            Else
                Me.EmailBody = Me.EmailBody & "Debit Status: Error Occured <br>"
                GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub AddInvestment(ByVal userId As String, ByVal boardID As String, ByVal levelID As String, ByVal levelAmount As String, ByVal holdUri As String)

        Try
            sdConfirmedInvestorsDataSource.SelectParameters.Item("BoardID").DefaultValue = boardID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("UserID").DefaultValue = userId
            sdConfirmedInvestorsDataSource.SelectParameters.Item("AmountInvested").DefaultValue = levelAmount
            sdConfirmedInvestorsDataSource.SelectParameters.Item("LevelID").DefaultValue = levelID
            If (holdUri = "") Then
                sdConfirmedInvestorsDataSource.SelectParameters.Item("HoldUri").DefaultValue = "Direct"
            Else
                sdConfirmedInvestorsDataSource.SelectParameters.Item("HoldUri").DefaultValue = holdUri
            End If

            Dim dv1 As Data.DataView = CType(sdConfirmedInvestorsDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv1 Is Nothing Then
                If dv1.Count > 0 Then
                    billingInfoDiv.Visible = False

                    GlobalModule.SetMessage(messageLabel, True, "Congratulations! You have successfully invested")
                    Me.EmailBody = Me.EmailBody & "Investment saving Status: saved successfully <br>"
                    SendEmailToOwner()
                Else
                    GlobalModule.SetMessage(messageLabel, False, "Error in saving investment deatils")
                    Me.EmailBody = Me.EmailBody & "Investment saving Status: error in saving details <br>"
                End If
            Else
                GlobalModule.SetMessage(messageLabel, False, "Error in saving investment deatils")
                Me.EmailBody = Me.EmailBody & "Investment saving Status: error in saving details <br>"
            End If
            btnInvest.Visible = False
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub AddStripeInvestment(ByVal userId As String, ByVal boardID As String, ByVal levelID As String, ByVal levelAmount As String, ByVal checkOutID As String, ByVal preApprovalID As String)

        Try
            sdInvestmentByStripe.SelectParameters.Item("BoardID").DefaultValue = boardID
            sdInvestmentByStripe.SelectParameters.Item("UserID").DefaultValue = userId
            sdInvestmentByStripe.SelectParameters.Item("AmountInvested").DefaultValue = levelAmount
            sdInvestmentByStripe.SelectParameters.Item("LevelID").DefaultValue = levelID
            If (Me.InvestmentType.ToLower = "donation") Then
                If (cbEligibleForGiftAid.Checked) Then
                    sdInvestmentByStripe.SelectParameters.Item("EligibleForGiftAid").DefaultValue = 1
                Else
                    sdInvestmentByStripe.SelectParameters.Item("EligibleForGiftAid").DefaultValue = 0
                End If
            Else
                sdInvestmentByStripe.SelectParameters.Item("EligibleForGiftAid").DefaultValue = 2
            End If
            If (checkOutID = "") Then
                sdInvestmentByStripe.SelectParameters.Item("CheckoutID").DefaultValue = "Preapproval"
            Else
                sdInvestmentByStripe.SelectParameters.Item("CheckoutID").DefaultValue = checkOutID
            End If
            If (preApprovalID = "") Then
                sdInvestmentByStripe.SelectParameters.Item("PreApprovalID").DefaultValue = "Direct"
            Else
                sdInvestmentByStripe.SelectParameters.Item("PreApprovalID").DefaultValue = preApprovalID
            End If


            Dim dv1 As Data.DataView = CType(sdInvestmentByStripe.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv1 Is Nothing Then
                If dv1.Count > 0 Then
                    billingInfoDiv.Visible = False

                    GlobalModule.SetMessage(messageLabel, True, "Congratulations! You have successfully invested")
                    Me.EmailBody = Me.EmailBody & "Investment saving Status: saved successfully <br>"
                    SendEmailToOwner()
                Else
                    GlobalModule.SetMessage(messageLabel, False, "Error in saving investment deatils")
                    Me.EmailBody = Me.EmailBody & "Investment saving Status: error in saving details <br>"
                End If
            Else
                GlobalModule.SetMessage(messageLabel, False, "Error in saving investment deatils")
                Me.EmailBody = Me.EmailBody & "Investment saving Status: error in saving details <br>"
            End If
            btnInvest.Visible = False
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Function GetInvestorCustomerID(ByVal userId As Integer) As String
        Try
            Dim res As String = ""
            Dim dv As DataView

            sdBalancedInvestorDetails.SelectParameters.Item("UserId").DefaultValue = userId
            dv = CType(sdBalancedInvestorDetails.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("CustomerID"))) Then
                        res = dv(0)("CustomerID")
                    End If
                    If (Not IsDBNull(dv(0)("UserCardUri"))) Then
                        Me.CustomerUriOfInvestor = dv(0)("UserCardUri").ToString()
                    Else
                        Me.CustomerUriOfInvestor = ""
                    End If
                Else
                    res = "not found"
                    Me.CustomerUriOfInvestor = ""
                End If
            Else
                res = "error"
            End If
            Return res
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Protected Function GetStripeCustomerIdOfInvestor(ByVal userId As Integer) As String
        Try
            Dim res As String = ""
            Dim dv As DataView

            sdStripeInvestorDetails.SelectParameters.Item("UserId").DefaultValue = userId
            dv = CType(sdStripeInvestorDetails.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("CustomerID"))) Then
                        res = dv(0)("CustomerID")
                    Else
                        res = ""
                    End If
                Else
                    res = "not found"
                End If
            Else
                res = "error"
            End If
            Return res
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Protected Function GetOwnerCustomerID(ByVal userId As Integer) As String
        Try
            Dim res As String = ""
            Dim dv As DataView
            sdBalancedOwnerDetails.SelectParameters.Item("UserId").DefaultValue = userId
            dv = CType(sdBalancedOwnerDetails.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("CustomerID"))) Then
                        res = dv(0)("CustomerID")
                    End If
                Else
                    res = "not found"
                End If
            Else
                res = "error"
            End If
            Return res
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Protected Function GetOwnerAccessToken(ByVal userId As Integer) As String
        Try
            Dim res As String = ""
            Dim dv As DataView
            sdStripeOwnerDetails.SelectParameters.Item("UserId").DefaultValue = userId
            dv = CType(sdStripeOwnerDetails.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("acces_token"))) Then
                        res = dv(0)("acces_token")
                    End If
                    If (Not IsDBNull(dv(0)("Publishable_key"))) Then
                        Me.PublishableKeyOfOwner = dv(0)("Publishable_key")
                    End If
                Else
                    res = "not found"
                End If
            Else
                res = "error"
            End If
            Return res
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Sub SaveCardChanges()
        Try
            sdUsersInfoChanges.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            sdUsersInfoChanges.UpdateParameters.Item("FirstName").DefaultValue = txtFirstNameForCard.Text.Trim()
            sdUsersInfoChanges.UpdateParameters.Item("LastName").DefaultValue = txtLastNameForCard.Text.Trim()
            sdUsersInfoChanges.UpdateParameters.Item("Email").DefaultValue = txtEmailAddress.Text.Trim()
            sdUsersInfoChanges.Update()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCreatecard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreatecard.Click
        Try
            SaveCardChanges()
            Dim strDebitAmount As String = txtStandardCharge.Text.Replace("$", "").Replace(".", "")
            Dim strCreditAmount As String = txtLevelAmount.Text.Replace("$", "").Replace(".", "")
            Dim strFeesAmount As String = txtFees.Text.Replace("$", "").Replace(".", "")
            Dim cardUri As String = balancedCreditCardURI.Value
            Dim fullName As String = txtFirstNameForCard.Text.Trim() + txtLastNameForCard.Text.Trim()
            If Not cardUri = "" Then
                If Me.CustomerUriOfInvestor = "IsNew" Then
                    Dim result As String = BalancedPayments.CreateCustomer(fullName, txtEmailAddress.Text)
                    If result.Contains("succeeded") Then
                        Dim codes As String() = result.Split(","c)
                        If codes.Length = 3 Then
                            Dim customerUri As String = codes(1)
                            Dim customerID As String = codes(2)
                            Dim r As String = BalancedPayments.AddingCardToCustomer(customerID, cardUri)
                            If r.Contains("succeeded") Then
                                SaveCardDetails(customerUri, cardUri, customerID)
                                If Me.wePayModelType = "PreApproval" Then
                                    CreateHoldForCard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Hold for Investment in " & txtLevelName.Text)
                                ElseIf Me.wePayModelType = "DirectCheckout" Then
                                    InvestInBoard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Investment in " & txtLevelName.Text)
                                End If

                                SendMailToAdmin()
                            End If
                        End If
                    Else
                        GlobalModule.SetMessage(messageLabel, False, "error in request")
                    End If
                Else
                    Dim r As String = BalancedPayments.AddingCardToCustomer(Me.CustomerIdOfInvestor, cardUri)
                    If r.Contains("succeeded") Then
                        sdBalancedUserCardInsert.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
                        sdBalancedUserCardInsert.UpdateParameters.Item("UserCardUri").DefaultValue = cardUri
                        sdBalancedUserCardInsert.Update()
                        If Me.wePayModelType = "PreApproval" Then
                            CreateHoldForCard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Hold for Investment in " & txtLevelName.Text)
                        ElseIf Me.wePayModelType = "DirectCheckout" Then
                            InvestInBoard(Me.CustomerIdOfInvestor, Me.CustomerIdOfOwner, Session("UserName").ToString(), strDebitAmount, strCreditAmount, strFeesAmount, "Investment in " & txtLevelName.Text)
                        End If
                        SendMailToAdmin()
                    End If
                End If

            End If

        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SaveCardDetails(ByVal accountUri As String, ByVal cardUri As String, ByVal customerID As String)
        Try
            sdBalancedUserCardInsert.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
            sdBalancedUserCardInsert.InsertParameters.Item("UserAccountUri").DefaultValue = accountUri
            sdBalancedUserCardInsert.InsertParameters.Item("UserCardUri").DefaultValue = cardUri
            sdBalancedUserCardInsert.InsertParameters.Item("CustomerID").DefaultValue = customerID
            Dim res As Integer = sdBalancedUserCardInsert.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub SaveStripeCardDetails(ByVal StripeCardToken As String, ByVal customerID As String)
        Try
            sdStripeUserCardInsert.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
            sdStripeUserCardInsert.InsertParameters.Item("StripeCardToken").DefaultValue = StripeCardToken
            sdStripeUserCardInsert.InsertParameters.Item("CustomerID").DefaultValue = customerID
            Dim res As Integer = sdStripeUserCardInsert.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub UpdateStripeCardDetails(ByVal StripeCardToken As String, ByVal customerID As String)
        Try
            sdStripeUserCardInsert.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            sdStripeUserCardInsert.UpdateParameters.Item("StripeCardToken").DefaultValue = StripeCardToken
            sdStripeUserCardInsert.UpdateParameters.Item("CustomerID").DefaultValue = customerID
            Dim res As Integer = sdStripeUserCardInsert.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnCreateCardForStripe_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateCardForStripe.Click
        Try
            EmailBodyCreation()
            SaveCardChanges()
            Dim debitAmount As Decimal = Convert.ToDecimal(txtStandardCharge.Text.Replace("£", ""))
            Dim debitAmountStr As String = debitAmount.ToString("0.00").Replace(".", "")
            Dim levelAmount As Decimal = Convert.ToDecimal(txtLevelAmount.Text.Replace("£", ""))
            Dim applicationFee As Decimal = debitAmount - levelAmount - (debitAmount * 0.029) - 0.15
            Dim applicationFeeStr As String = applicationFee.ToString("0.00").Replace(".", "")

            Dim cardToken As String = stripeCardToken.Value
            Dim fullName As String = txtFirstNameForCard.Text.Trim() + txtLastNameForCard.Text.Trim()
            Me.EmailBody = Me.EmailBody & "Card Token Create Status: Success <br>"
            If Not cardToken = "" Then
                Dim stripeService = New StripeCustomerService(stripeApiKey)
                Dim stripeCutomerOptions = New StripeCustomerCreateOptions()
                stripeCutomerOptions.TokenId = cardToken
                stripeCutomerOptions.CardName = fullName
                stripeCutomerOptions.Email = txtEmailAddress.Text
                Dim res = stripeService.Create(stripeCutomerOptions)
                If Not res Is Nothing Then
                    Me.EmailBody = Me.EmailBody & "Customer Create Status: Success <br>"
                    If Me.StripeAccountMode = "IsNew" Then
                        SaveStripeCardDetails(cardToken, res.Id)
                    Else
                        UpdateStripeCardDetails(cardToken, res.Id)
                    End If

                    Dim stripeTokenService = New StripeTokenService(Me.AccessTokenOfOwner)
                    Dim stripeTokenCreateOptions = New StripeTokenCreateOptions()
                    stripeTokenCreateOptions.CustomerId = res.Id
                    Dim tokenResult = stripeTokenService.Create(stripeTokenCreateOptions)
                    If Not tokenResult Is Nothing Then

                        Me.EmailBody = Me.EmailBody & "Charge token Create Status: Success <br>"
                        Dim stripeChargeService = New StripeChargeService(Me.AccessTokenOfOwner)

                        Dim stripeChargeOptions = New StripeChargeCreateOptions()
                        stripeChargeOptions.TokenId = tokenResult.Id
                        stripeChargeOptions.Amount = Convert.ToInt16(debitAmountStr)
                        stripeChargeOptions.ApplicationFee = Convert.ToInt16(applicationFeeStr)
                        stripeChargeOptions.Currency = "gbp"
                        stripeChargeOptions.Description = "Investment in " & txtLevelName.Text
                        If Me.wePayModelType = "PreApproval" Then
                            stripeChargeOptions.Capture = False
                        ElseIf Me.wePayModelType = "DirectCheckout" Then
                            stripeChargeOptions.Capture = True
                        End If
                        Dim res1 = stripeChargeService.Create(stripeChargeOptions)
                        If Not res1 Is Nothing Then
                            If stripeChargeOptions.Capture Then
                                AddStripeInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, res1.Id, "")
                            Else
                                AddStripeInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, "", res1.Id)
                            End If
                            Me.EmailBody = Me.EmailBody & "Charge Create Status: Success <br>"
                        Else
                            Me.EmailBody = Me.EmailBody & "Charge Create Status: Failed <br>"
                            GlobalModule.SetMessage(messageLabel, False, "Error in investment")
                        End If
                    Else
                        Me.EmailBody = Me.EmailBody & "Charge token Create Status: Failed <br>"
                        Me.EmailBody = Me.EmailBody & "Charge Create Status: Not done <br>"
                        GlobalModule.SetMessage(messageLabel, False, "error in request")
                    End If
                Else
                    Me.EmailBody = Me.EmailBody & "Customer Create Status: Failed <br>"
                    Me.EmailBody = Me.EmailBody & "Charge Create Status: Not done <br>"
                    GlobalModule.SetMessage(messageLabel, False, "error in request")
                End If
            Else
                Me.EmailBody = Me.EmailBody & "Card Create Status: Failed <br>"
                Me.EmailBody = Me.EmailBody & "Customer Create Status: Failed <br>"
                Me.EmailBody = Me.EmailBody & "Charge Create Status: Not done <br>"
                GlobalModule.SetMessage(messageLabel, False, "error in request")
            End If
            SendMailToAdmin()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub CreateStripeCharge()
        Try
            EmailBodyCreation()
            Dim debitAmount As Decimal = Convert.ToDecimal(txtStandardCharge.Text.Replace("£", ""))
            Dim debitAmountStr As String = debitAmount.ToString("0.00").Replace(".", "")
            Dim levelAmount As Decimal = Convert.ToDecimal(txtLevelAmount.Text.Replace("£", ""))
            Dim applicationFee As Decimal = debitAmount - levelAmount - (debitAmount * 0.029) - 0.15
            Dim applicationFeeStr As String = applicationFee.ToString("0.00").Replace(".", "")


            Dim fullName As String = txtFirstNameForCard.Text.Trim() + txtLastNameForCard.Text.Trim()

            Dim stripeTokenService = New StripeTokenService(Me.AccessTokenOfOwner)
            Dim stripeTokenCreateOptions = New StripeTokenCreateOptions()
            stripeTokenCreateOptions.CustomerId = Me.StripeCustomerIDOfInvestor
            Dim tokenResult = stripeTokenService.Create(stripeTokenCreateOptions)

            If Not tokenResult Is Nothing Then
                Me.EmailBody = Me.EmailBody & "Charge token Create Status: Success <br>"

                Dim stripeChargeService = New StripeChargeService(Me.AccessTokenOfOwner)
                'Dim stripeChargeService = New StripeChargeService(stripeApiKey)
                Dim stripeChargeOptions = New StripeChargeCreateOptions()

                stripeChargeOptions.TokenId = tokenResult.Id
                stripeChargeOptions.Amount = debitAmountStr
                stripeChargeOptions.ApplicationFee = applicationFeeStr
                stripeChargeOptions.Currency = "gbp"
                stripeChargeOptions.Description = "Investment in " & txtLevelName.Text

                If Me.wePayModelType = "PreApproval" Then
                    stripeChargeOptions.Capture = False
                ElseIf Me.wePayModelType = "DirectCheckout" Then
                    stripeChargeOptions.Capture = True
                End If
                Dim res1 = stripeChargeService.Create(stripeChargeOptions)
                If Not res1 Is Nothing Then
                    If stripeChargeOptions.Capture Then
                        AddStripeInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, res1.Id, "")
                    Else
                        AddStripeInvestment(Session("UserID").ToString(), hdnBoardID.Value, hdnLevelID.Value, hdnAmountInvested.Value, "", res1.Id)
                    End If
                    Me.EmailBody = Me.EmailBody & "Charge Create Status: Success <br>"
                Else
                    Me.EmailBody = Me.EmailBody & "Charge Create Status: Failed <br>"
                    GlobalModule.SetMessage(messageLabel, False, "Error in investment")
                End If
            Else
                Me.EmailBody = Me.EmailBody & "Charge token Create Status: Failed <br>"
                GlobalModule.SetMessage(messageLabel, False, "Error in investment")
            End If

            SendMailToAdmin()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class
