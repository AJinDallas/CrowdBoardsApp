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
Imports LinkedInLibrary
Public Class LinkedInRegister
    Inherits Telerik.Web.UI.RadAjaxPage
    Private _oauth As New oAuthLinkedIn()
    Dim accessToken As String = ""
    Dim accessTokenSecret As String = ""
    Dim gettoken As String = Nothing
    Dim getotokensecret As String = Nothing
    Dim getverifier As String = Nothing
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        RegisterLinkedInUser()

    End Sub

    Protected Sub RegisterLinkedInUser()
        If (Not Session("Session_OToken") Is Nothing) And (Not Request.QueryString("oauth_verifier") Is Nothing) And (Not Session("Session_OTokenSecret") Is Nothing) Then
            Try
                gettoken = Session("Session_OToken").ToString()
                getotokensecret = Session("Session_OTokenSecret").ToString()
                getverifier = Request.QueryString("oauth_verifier")

                'Get Access Token
                _oauth.Token = gettoken
                _oauth.TokenSecret = getotokensecret
                _oauth.Verifier = getverifier

                _oauth.AccessTokenGet(gettoken)
                accessToken = _oauth.Token
                accessTokenSecret = _oauth.TokenSecret

                _oauth.Token = accessToken
                _oauth.TokenSecret = accessTokenSecret
                _oauth.Verifier = getverifier

                'Display profile
                Dim response As String = _oauth.APIWebRequest("GET", "https://api.linkedin.com/v1/people/~", Nothing)
                'txtApiResponse.Text = response;
                If Not response Is Nothing Then
                    Dim xml As New XmlDocument()
                    xml.LoadXml(response)
                    ' suppose that myXmlString contains "<Names>...</Names>"
                    Dim xnList As XmlNodeList = xml.SelectNodes("/person")
                    Dim xnUrlList As XmlNodeList = xml.SelectNodes("/person/site-standard-profile-request")
                    For Each xn As XmlNode In xnList
                        Dim firstName As String = xn("first-name").InnerText
                        Dim lastName As String = xn("last-name").InnerText
                        Dim url As String = xnUrlList(0).InnerText
                        Dim i As Integer = url.IndexOf("?")
                        Dim result As String = url.Substring(i + 1)
                        Dim list As New ArrayList()
                        list.AddRange(result.Split(New Char() {"&"c}))
                        If (list.Count > 0) Then
                            Dim idStr As String = list(0).ToString()
                            Dim idList As New ArrayList()
                            idList.AddRange(idStr.Split(New Char() {"="c}))
                            If (idList.Count > 0) Then
                                Dim id As String = idList(1).ToString()
                                If id <> "" Then
                                    RegisterUser(id, firstName, lastName)
                                End If
                            End If
                        End If
                    Next
                End If
            Catch ex As Exception
                lblMessage.Text = "Error in User Login.Please Contact Administrator"
                lblMessage.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If

    End Sub
    Protected Sub RegisterUser(ByVal id As String, ByVal firstName As String, ByVal lastName As String)
        Try
            sdUsers.SelectParameters.Item("LinkedInUserID").DefaultValue = id
            Dim dv As DataView = CType(sdUsers.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("status"))) Then
                    If dv(0)("status").ToString() = "NotExist" Then
                        Membership.CreateUser(firstName & "_" & lastName & "_" & id, firstName & lastName & id & "123")
                        Dim newUser As MembershipUser = Membership.GetUser(firstName & "_" & lastName & "_" & id)
                        UpdateUserProfile(firstName & "_" & lastName & "_" & id, firstName, lastName, id)
                        Roles.AddUserToRole(newUser.UserName, "Boarder")
                        Session("DateLastLoggedIn") = System.DateTime.Now
                        Session("userName") = firstName & "_" & lastName & "_" & id
                        Session("userID") = GetUserID(firstName & "_" & lastName & "_" & id)
                        SendMailToAdmin(firstName, lastName)
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
                        ' Response.Redirect("~/Home.aspx", False)
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
    Private Sub SendMailToAdmin(ByVal FirstName As String, ByVal LastName As String)
        Try
            Dim strSubject As String = "New User Registered through  LinkedIn"
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody As String = "New user has been registered through LinkedIn<br><br>First Name: " & FirstName & "<br>Last Name: " & LastName
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal id As String)
        Try
            sdUsers.InsertParameters.Item("UserName").DefaultValue = UserName
            sdUsers.InsertParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.InsertParameters.Item("LastName").DefaultValue = LastName
            sdUsers.InsertParameters.Item("LinkedInUserID").DefaultValue = id
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