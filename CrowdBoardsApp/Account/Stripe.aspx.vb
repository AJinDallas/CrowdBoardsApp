Imports System.Net
Imports System.IO
Imports Newtonsoft.Json.Linq
Imports Stripe

Public Class StripeCallback
    Inherits System.Web.UI.Page
    Public Shared stripeApiKey As String = "" & ConfigurationManager.AppSettings("StripeApiKey")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If (Not Page.IsPostBack) Then
            Try
                If (Not String.IsNullOrEmpty(Request.QueryString("code"))) Then
                    Dim code As String = Request.QueryString("code")
                    CreateStripeCustomer(code)
                Else
                    If (Request.QueryString("state") = "ToMyProfile") Then
                        Response.Redirect("~/MyProfile.aspx?IsCreated=0", False)
                    Else
                        Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0", False)
                    End If
                End If
            Catch ex As Exception
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
    End Sub
    Public Sub CreateStripeCustomer(ByVal code As String)

        Try
            Dim stripeService = New StripeOAuthTokenService(stripeApiKey)
            Dim stripeTokenOptions = New StripeOAuthTokenCreateOptions()
            stripeTokenOptions.Code = code
            stripeTokenOptions.GrantType = "authorization_code"
            Dim res = stripeService.Create(stripeTokenOptions)

            If Not res Is Nothing Then
                CreateUserStripeAccount(res.StripeUserId, res.AccessToken, res.PublishableKey, res.RefreshToken)
            Else
                If (Request.QueryString("state") = "ToMyProfile") Then
                    Response.Redirect("~/MyProfile.aspx?IsCreated=0", False)
                Else
                    Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0", False)
                End If
            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            If (Request.QueryString("state") = "ToMyProfile") Then
                Response.Redirect("~/MyProfile.aspx?IsCreated=0", False)
            Else
                Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0", False)
            End If
        End Try

    End Sub
    Private Sub CreateUserStripeAccount(ByVal StripeUserID As String, ByVal acces_token As String, ByVal Publishable_key As String, ByVal refresh_token As String)
        Try
            Dim result As Integer
            Dim strRedirect As String = String.Empty
            If (Session("userID")) Is Nothing Then
                If Not (Session("userName")) Is Nothing Then
                    sdGetUserID.SelectParameters.Item("UserName").DefaultValue = Session("UserName")
                    Dim dv As Data.DataView = CType(sdGetUserID.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If (dv.Count > 0) Then
                        Session("userID") = dv(0)("UserID")
                    End If
                Else
                    Response.Redirect("~/Default.aspx", False)
                    Exit Sub
                End If
          
            End If
            If (IsStripeAccountExist()) Then
                sdUserStripeAccount.UpdateParameters.Item("UserID").DefaultValue = Session("userID")
                sdUserStripeAccount.UpdateParameters.Item("StripeUserID").DefaultValue = StripeUserID
                sdUserStripeAccount.UpdateParameters.Item("acces_token").DefaultValue = acces_token
                sdUserStripeAccount.UpdateParameters.Item("Publishable_key").DefaultValue = Publishable_key
                sdUserStripeAccount.UpdateParameters.Item("refresh_token").DefaultValue = refresh_token
                result = sdUserStripeAccount.Update()
            Else
                sdUserStripeAccount.InsertParameters.Item("UserID").DefaultValue = Session("userID")
                sdUserStripeAccount.InsertParameters.Item("StripeUserID").DefaultValue = StripeUserID
                sdUserStripeAccount.InsertParameters.Item("acces_token").DefaultValue = acces_token
                sdUserStripeAccount.InsertParameters.Item("Publishable_key").DefaultValue = Publishable_key
                sdUserStripeAccount.InsertParameters.Item("refresh_token").DefaultValue = refresh_token
                result = sdUserStripeAccount.Insert()
            End If


            If result = 1 Then
                If (Request.QueryString("state") = "ToMyProfile") Then
                    strRedirect = "~/MyProfile.aspx?IsCreated=1"
                Else
                    strRedirect = "~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=1"
                End If
            Else
                If (Request.QueryString("state") = "ToMyProfile") Then
                    strRedirect = "~/MyProfile.aspx?IsCreated=0"
                Else
                    strRedirect = "~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0"
                End If
            End If
            Response.Redirect(strRedirect, False)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            If (Request.QueryString("state") = "ToMyProfile") Then
                Response.Redirect("~/MyProfile.aspx?IsCreated=0", False)
            Else
                Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0", False)
            End If
        End Try
    End Sub
    Private Function IsStripeAccountExist() As Boolean
        Dim res As Boolean = False
        Try
            sdUserStripeAccount.SelectParameters.Item("UserID").DefaultValue = Session("userID")
            Dim dv As Data.DataView = CType(sdUserStripeAccount.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                res = True
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            If (Request.QueryString("state") = "ToMyProfile") Then
                Response.Redirect("~/MyProfile.aspx?IsCreated=0", False)
            Else
                Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("state") & "&IsCreated=0", False)
            End If
        End Try
        Return res
    End Function
End Class