Imports System
Imports System.Text.RegularExpressions
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Script.Serialization
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Xml
Imports TwitterLibrary
Imports Newtonsoft.Json.Linq
Imports oAuthExample
Imports ASPSnippets.TwitterAPI

Public Class TwitterRegister
    Inherits System.Web.UI.Page
    Private url As String = ""
    Private xml As String = ""
    Public name As String = ""
    Public twitterId As String = ""
    Public username As String = ""
    Public profileImage As String = ""
    Public followersCount As String = ""
    Public noOfTweets As String = ""
    Public recentTweet As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        GetUserDetailsFromTwitter()
    End Sub
    Private Sub GetUserDetailsFromTwitter()
        Try
            'If Request("oauth_token") IsNot Nothing And Request("oauth_verifier") IsNot Nothing Then

            '    Dim oAuth = New oAuthTwitter()
            '    'Get the access token and secret.
            '    oAuth.AccessTokenGet(Request("oauth_token"), Request("oauth_verifier"))
            '    If oAuth.TokenSecret.Length > 0 Then
            '        url = "https://api.twitter.com/1.1/account/verify_credentials.json"
            '        xml = oAuth.oAuthWebRequest(oAuthTwitter.Method.[GET], url, [String].Empty)
            '        Dim o As JObject = JObject.Parse(xml)
            '        twitterId = Convert.ToString(o("id"))
            '        name = Convert.ToString(o("name"))
            '        username = Convert.ToString(o("screen_name"))
            '        RegisterUser(twitterId, name, username)
            '    End If
            'End If
            If TwitterConnect.IsAuthorized Then
                Dim twitter As New TwitterConnect()
                Dim dt As DataTable = twitter.FetchProfile()
                If dt.Rows.Count > 0 Then
                    twitterId = dt.Rows(0)("Id").ToString()
                    name = dt.Rows(0)("name").ToString()
                    username = dt.Rows(0)("screen_name").ToString()
                    RegisterUser(twitterId, name, username)
                Else
                    Response.Redirect("~/Default.aspx", False)
                End If
            End If
        Catch ex As Exception
            lblMessage.Text = "Error in User Login.Please Contact Administrator"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub RegisterUser(ByVal twitterId As String, ByVal name As String, ByVal username As String)
        Try
            sdUsers.SelectParameters.Item("TwitterUserID").DefaultValue = twitterId
            Dim dv As DataView = CType(sdUsers.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("status"))) Then
                    If dv(0)("status").ToString() = "NotExist" Then
                        Membership.CreateUser(username & twitterId, username & twitterId & "123")
                        Dim newUser As MembershipUser = Membership.GetUser(username & twitterId)
                        UpdateUserProfile(username & twitterId, name, name, twitterId)
                        Roles.AddUserToRole(newUser.UserName, "Boarder")
                        Session("DateLastLoggedIn") = System.DateTime.Now
                        Session("userName") = username & twitterId
                        Session("userID") = GetUserID(username & twitterId)
                        SendMailToAdmin(username & twitterId)
                        '  Response.Redirect("~/Home.aspx", False)

                        If Not (Session("returnURL")) Is Nothing Then
                            If Not (Session("returnURL") = "") Then
                                Dim returnURL As String = System.Configuration.ConfigurationManager.AppSettings("site")
                                Response.Redirect(returnURL + "/" + Session("returnURL").ToString() & "#investDiv", False)
                            Else
                                Response.Redirect("~/Home.aspx", False)
                            End If

                        Else
                            Response.Redirect("~/Home.aspx", False)
                        End If
                    Else
                        If dv(0)("userStatus") = True Then
                            sdUsers.UpdateParameters.Item("UserName").DefaultValue = dv(0)("UserName")
                            sdUsers.Update()
                            If (Not IsDBNull(dv(0)("DateLastLoggedIn"))) Then
                                Session("DateLastLoggedIn") = dv(0)("DateLastLoggedIn")
                            Else
                                Session("DateLastLoggedIn") = System.DateTime.Now
                            End If

                            Session("userName") = dv(0)("UserName")
                            Session("UserID") = dv(0)("status")

                            If Not (Session("returnURL")) Is Nothing Then
                                If Not (Session("returnURL") = "") Then
                                    Dim returnURL As String = System.Configuration.ConfigurationManager.AppSettings("site")
                                    Response.Redirect(returnURL + "/" + Session("returnURL").ToString() & "#investDiv", False)
                                Else
                                    Response.Redirect("~/Home.aspx", False)
                                End If

                            Else
                                Response.Redirect("~/Home.aspx", False)
                            End If
                            'Response.Redirect("~/Home.aspx", False)
                        Else
                            lblMessage.Text = "Your Account has been Deactivated.Please contact Administrator to Reactivate your Account"
                            lblMessage.ForeColor = Drawing.Color.Red
                        End If
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub SendMailToAdmin(ByVal userName As String)
        Try
            Dim strSubject As String = "New User Registered through  Twitter"
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody As String = "New user has been registered through Twitter<br><br>User Name: " & userName
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal twitterId As String)
        Try
            sdUsers.InsertParameters.Item("UserName").DefaultValue = UserName
            sdUsers.InsertParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.InsertParameters.Item("LastName").DefaultValue = LastName
            sdUsers.InsertParameters.Item("TwitterUserID").DefaultValue = twitterId

            Dim ReferalURL As String = ""
            Dim ReferalValue As String = ""
            Dim ReferalUserID As Integer = 0
            If Not (Session("returnURL")) Is Nothing Then
                ReferalValue = Session("returnURL")
            End If
            If Not (Session("uID")) Is Nothing Then

                ReferalUserID = Session("uID")
            End If
            sdUsers.InsertParameters.Item("ReferalValue").DefaultValue = ReferalValue
            sdUsers.InsertParameters.Item("ReferalUserID").DefaultValue = ReferalUserID

            sdUsers.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = UserName
            Dim dv As Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    userID = dv(0)("UserID")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function
End Class