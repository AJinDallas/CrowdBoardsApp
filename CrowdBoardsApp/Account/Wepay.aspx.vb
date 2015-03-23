Imports WePaySDK
Public Class Wepay
    Inherits System.Web.UI.Page
    Dim userID As String = String.Empty
    Dim boardID As String = String.Empty
    Dim levelID As String = String.Empty
    Dim levelAmount As String = String.Empty
    Dim boardName As String = String.Empty
    Dim levelName As String = String.Empty
    Dim ownerID As String = String.Empty
    Dim acces_token As String = String.Empty
    Dim accountID As String = String.Empty
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If (Not Page.IsPostBack) Then
            If (Not String.IsNullOrEmpty(Request.QueryString("checkout_id"))) Then
                GetCheckoutStatus(Request.QueryString("checkout_id"))
            ElseIf (Not String.IsNullOrEmpty(Request.QueryString("preapproval_id"))) Then
                GetPreapprovalStatus(Request.QueryString("preapproval_id"))
            ElseIf (Not String.IsNullOrEmpty(Request.QueryString("code"))) Then
                ' Dim code As String = Request.QueryString("code")
                ' OAuth(code)
            End If
        End If
    End Sub

    Private Sub GetCheckoutStatus(ByVal checkoutId As String)
        Try

            Dim iid As Long = 0
            Dim valid As Boolean = Int64.TryParse(checkoutId, iid)
            If Not valid Then

            End If

            Dim cheskOut As New Checkout

            Dim resp = cheskOut.GetStatus(iid)
            GetInvestmentDetails()
            GetUserWePayAccountDetails()
            If resp.[Error] IsNot Nothing Then
                ' Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=0", False)
            Else

            End If
            If acces_token = "" Or accountID = "" Then
                Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=0", False)
            Else
                AddInvestment(userID, boardID, levelID, levelAmount, boardName, levelName, checkoutId, "-1")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub GetPreapprovalStatus(ByVal preapprovalId As String)
        Try
            GetInvestmentDetails()
            GetUserWePayAccountDetails()
            Dim iid As Long = 0
            Dim valid As Boolean = Int64.TryParse(preapprovalId, iid)
            If Not valid Then

            End If

            If acces_token = "" Or accountID = "" Then
                Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=0", False)
            Else
                Dim req = New PreapprovalRequest()
                req.accessToken = acces_token
                req.preapproval_id = iid
                Dim preapproval As New Preapproval
                Dim resp = preapproval.GetStatus(req)

                AddInvestment(userID, boardID, levelID, levelAmount, boardName, levelName, "-1", preapprovalId)
            End If
            
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub GetInvestmentDetails()
        Try
            If Session("InvestmentDetails") IsNot Nothing Then
                Dim strCustom As String = Session("InvestmentDetails").ToString()
                Dim list As New ArrayList()
                list.AddRange(strCustom.Split(New Char() {","c}))
                If (list.Count > 0) Then
                    userID = list(0).ToString()
                    boardID = list(1).ToString()
                    levelID = list(2).ToString()
                    levelAmount = list(3).ToString()
                    boardName = list(4).ToString()
                    levelName = list(5).ToString()
                    ownerID = list(6).ToString()
                End If
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub AddInvestment(ByVal userId As String, ByVal boardID As String, ByVal levelID As String, ByVal levelAmount As String, ByVal boardName As String, ByVal levelName As String, ByVal checkoutID As String, ByVal preApprovalId As String)

        Try
            sdConfirmedInvestorsDataSource.SelectParameters.Item("BoardID").DefaultValue = boardID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("UserID").DefaultValue = userId
            sdConfirmedInvestorsDataSource.SelectParameters.Item("AmountInvested").DefaultValue = levelAmount
            sdConfirmedInvestorsDataSource.SelectParameters.Item("LevelID").DefaultValue = levelID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("CheckoutID").DefaultValue = checkoutID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("PreApprovalID").DefaultValue = preApprovalId
            Dim dv1 As Data.DataView = CType(sdConfirmedInvestorsDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv1 Is Nothing Then
                If dv1.Count > 0 Then
                    Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=1", False)
                End If
            Else
                Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=0", False)
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Public Sub OAuth(ByVal code As String)
        Try
            Dim clientID As String = "" & System.Configuration.ConfigurationManager.AppSettings("WepayClientId")
            Dim wepayClientSecret As String = "" & System.Configuration.ConfigurationManager.AppSettings("WepayClientSecret")
            Dim redirectUri As String = "" & System.Configuration.ConfigurationManager.AppSettings("redirect_uri")
            Dim req = New TokenRequest()
            req.client_id = clientID
            req.client_secret = wepayClientSecret
            req.code = code
            req.redirect_uri = redirectUri
            Dim oauth As New WePaySDK.OAuth
            Dim resp = oauth.Authorize(req)
            If resp.[Error] IsNot Nothing Then

            End If

            Dim accRequest = New AccountCreateRequest()
            accRequest.accessToken = resp.access_token
            accRequest.name = Session("userName").ToString()
            accRequest.description = "New Account for CrowdBoarders"
            accRequest.reference_id = Session("userID").ToString()

            Dim accResponse = New Account().Post(accRequest)
            Dim wePayUserid As String = resp.user_id
            Dim acces_token As String = resp.access_token
            Dim accountId As String = accResponse.account_id
            Dim account_uri As String = accResponse.account_uri
            CreateUserWePayAccount(wePayUserid, acces_token, accountId, account_uri)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub CreateUserWePayAccount(ByVal wePayUserid As String, ByVal acces_token As String, ByVal accountId As String, ByVal account_uri As String)
        Try
            sdUserWePayAccount.InsertParameters.Item("UserID").DefaultValue = Session("userID")
            sdUserWePayAccount.InsertParameters.Item("WePayUserID").DefaultValue = wePayUserid
            sdUserWePayAccount.InsertParameters.Item("acces_token").DefaultValue = acces_token
            sdUserWePayAccount.InsertParameters.Item("AccountID").DefaultValue = accountId
            sdUserWePayAccount.InsertParameters.Item("AccountUri").DefaultValue = account_uri
            Dim result As Integer = sdUserWePayAccount.Insert()
            If result = 1 Then
                Response.Redirect("~/MyProfile.aspx", False)
            Else

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub GetUserWePayAccountDetails()
        Try
            sdUserWePayAccountDetails.SelectParameters.Item("UserID").DefaultValue = ownerID
            Dim dv As Data.DataView = CType(sdUserWePayAccountDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("acces_token"))) Then
                    acces_token = dv(0)("acces_token").ToString()
                End If
                If (Not IsDBNull(dv(0)("AccountID"))) Then
                    accountID = dv(0)("AccountID").ToString()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class