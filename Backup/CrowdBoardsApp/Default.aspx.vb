Imports ASPSnippets.FaceBookAPI
Imports System.Data
Imports ASPSnippets.TwitterAPI
Imports System.Web.Security
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.Script.Serialization
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Xml
Imports oAuthExample


Public Class _Default
    Inherits Telerik.Web.UI.RadAjaxPage
    Private _oauth As New oAuthLinkedIn()

    Public Property directoryName() As String

        Get
            Return CStr(ViewState("_directoryName"))
        End Get

        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property
    Public Property userID() As Integer

        Get
            Return CInt(ViewState("_userID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_userID") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtLogInUserName.Focus()
        GlobalModule.RedirectToHttps()

        Dim allowAccess As String = "" & System.Configuration.ConfigurationManager.AppSettings("AllowPublicAccess")
        If (allowAccess = "0") Then
            If Not (Request.QueryString("key") = "hbbh77554") Then
                Response.Redirect("~/email.html", False)
            End If
        End If




        'Dim allowAccess As String = "" & System.Configuration.ConfigurationManager.AppSettings("AllowPublicAccess")
        'If (allowAccess = "0") Then
        '    If Not (Request.QueryString("key") = "hbbh77554") Then
        '        Response.Redirect("~/index.html", False)

        '    End If
        'End If

        messageLable.Text = String.Empty
        lblMessageSignUp.Text = String.Empty
        Dim oauth_token As String = Request.QueryString("oauth_token")
        Dim oauth_verifier As String = Request.QueryString("oauth_verifier")
        If oauth_token IsNot Nothing AndAlso oauth_verifier IsNot Nothing Then
            Application("oauth_token") = oauth_token
            Application("oauth_verifier") = oauth_verifier
        End If
        messageLable.Visible = False
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        TwitterConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("consumerKey")
        TwitterConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("consumerSecret")
        RadWindow1.VisibleOnPageLoad = False
        If (Not Page.IsPostBack) Then

            If Not (Request.QueryString("bordName") = Nothing) Then
                Me.directoryName = Me.Request.QueryString("bordName").ToString()
            Else
                Me.directoryName = ""
            End If
            If Not (Request.QueryString("from")) Is Nothing Then
                Me.userID = Request.QueryString("from")
            End If

            ForgetPasswordCheck()
            FacebookRegister()
            resetTextBoxes()
        End If

    End Sub


    Protected Sub ForgetPasswordCheck()
        Try
            If (Not Request.QueryString("uuid") Is Nothing) And (Not Request.QueryString("Id") Is Nothing) Then
                RadWindow1.NavigateUrl = "~/ForgetPassword.aspx?uuid=" & Request.QueryString("uuid") & "&id=" & Request.QueryString("Id")
                RadWindow1.Height = 300
                RadWindow1.Width = 650
                RadWindow1.VisibleOnPageLoad = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub FacebookRegister()
        Try
            If (Not Request.QueryString("FacebookId") Is Nothing) Then
                RadWindow1.NavigateUrl = "~/rwFacebookUser.aspx?FacebookId=" & Request.QueryString("FacebookId") & "&FirstName=" & Request.QueryString("FirstName") & "&LastName=" & Request.QueryString("LastName") & "&Email=" & Request.QueryString("Email")
                RadWindow1.Height = 300
                RadWindow1.Width = 700
                RadWindow1.VisibleOnPageLoad = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoginButtonHidden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginButtonHidden.Click
        Try
            If Membership.ValidateUser(txtLogInUserName.Text, txtlogInPassword.Text) Then
                sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = txtLogInUserName.Text
                Dim dv As System.Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
                If dv.Count > 0 Then
                    If dv(0)("Status") = True Then
                        Session("userName") = txtLogInUserName.Text

                        If (Not IsDBNull(dv(0)("DateLastLoggedIn"))) Then
                            Session("DateLastLoggedIn") = dv(0)("DateLastLoggedIn")
                        Else
                            Session("DateLastLoggedIn") = System.DateTime.Now
                        End If

                        Dim UserName As String = txtLogInUserName.Text
                        Session("UserID") = GetUserID(UserName)

                        FormsAuthentication.SetAuthCookie(txtLogInUserName.Text, False)

                        UpdateLastLogin(UserName)
                        If Not Request.QueryString("returnUrl") Is Nothing Then
                            Response.Redirect(Request.QueryString("ReturnUrl"), False)
                        Else
                            Response.Redirect("~/Home.aspx", False)
                        End If

                    Else
                        GlobalModule.SetMessage(messageLable, False, "Please Contact Administrator to activate your account")
                    End If
                Else
                    GlobalModule.SetMessage(messageLable, False, "Invalid User")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLable, False, "Error in User Login")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub signInFacebook_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles signInFacebook.Click
        Try
            Session("returnURL") = Me.directoryName
            Session("uID") = Me.userID
            FaceBookConnect.Authorize("user_photos,email", System.Configuration.ConfigurationManager.AppSettings("returnURL")) 'Request.Url.AbsoluteUri.Split("?"c)(0))
        Catch ex As Exception
            GlobalModule.SetMessage(messageLable, False, "Error in Sign In with Facebook")
            'GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub signInTwitter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles signInTwitter.Click
        Try
            Session("returnURL") = Me.directoryName
            Session("uID") = Me.userID
            If Not TwitterConnect.IsAuthorized Then
                Dim twitter As New TwitterConnect()
                'twitter.Authorize("https://crowdboarders.com/Account/TwitterRegister.aspx")
                twitter.Authorize(System.Configuration.ConfigurationManager.AppSettings("twitterCallbackUrl"))
            End If
            'Dim oAuth = New oAuthTwitter()
            ''Redirect the user to Twitter for authorization.
            ''Using oauth_callback for local testing.

            '' R_ use the dynamic url director
            '' Call back URL to direct the user to the page
            'oAuth.CallBackUrl = ConfigurationManager.AppSettings("twitterCallbackUrl")
            'Response.Redirect(oAuth.AuthorizationLinkGet(), False)
        Catch ex As Exception
            GlobalModule.SetMessage(messageLable, False, "Error in Sign In with Twitter")
            'GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnSignup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSignup.Click
        Try
            If Not Page.IsValid = False Then
                Dim newUser As MembershipUser
                newUser = Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text)
                If newUser Is Nothing Then
                    Dim membershipCreateStatus As MembershipCreateStatus
                    If (membershipCreateStatus = membershipCreateStatus.InvalidPassword) Then
                        GlobalModule.SetMessage(lblMessageSignUp, True, "Password must be a minimum of 7 characters with at least one non-alphanumeric character")
                        Exit Sub
                    ElseIf (membershipCreateStatus = membershipCreateStatus.InvalidUserName) Then
                        GlobalModule.SetMessage(lblMessageSignUp, True, "Please Enter Valid User Name")

                        Exit Sub
                    ElseIf (membershipCreateStatus = membershipCreateStatus.InvalidEmail) Then
                        GlobalModule.SetMessage(lblMessageSignUp, True, "Please Enter Valid Email")
                        Exit Sub
                    Else
                        GlobalModule.SetMessage(lblMessageSignUp, True, "Please Enter Correct Information")
                        Exit Sub
                    End If
                End If

                newUser = Membership.GetUser(txtUserName.Text)
                Dim uuID As String = Guid.NewGuid().ToString()
                Dim userID As Integer = UpdateUserProfile(txtUserName.Text, txtFirstName.Text, txtLastName.Text, txtEmail.Text, uuID)
                If userID = 0 Then
                    GlobalModule.SetMessage(lblMessageSignUp, False, "Error in SignUp.Please try again !")
                Else
                    Try
                        SendValidationEmail(txtUserName.Text, txtFirstName.Text, txtLastName.Text, txtEmail.Text, uuID, userID)
                        SendMailToAdmin(txtUserName.Text, txtFirstName.Text, txtLastName.Text, txtEmail.Text)
                    Catch ex1 As Exception
                        GlobalModule.SetMessage(lblMessageSignUp, True, "SignUp Successful. Error in sending verification mail")
                        Exit Sub
                    End Try
                    GlobalModule.SetMessage(lblMessageSignUp, True, "Please check your email for confirmation (including spam/junk email folders)")
                    resetTextBoxes()
                End If
            Else
                GlobalModule.SetMessage(lblMessageSignUp, False, "Error in SignUp.Please try again !")
            End If
        Catch reg As MembershipCreateUserException
            If reg.Message.Contains("password") Then
                GlobalModule.SetMessage(lblMessageSignUp, True, "Password must be a minumum of 7 characters and contain at least one non-alphanumeric character")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSignUp, False, "Error in SignUp.Please try again !")
            'GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendMailToAdmin(ByVal userName As String, ByVal firstName As String, ByVal lastName As String, ByVal Email As String)
        Try
            Dim strSubject As String
            Dim strbody As String
            Dim UserFromName As String = ""
            If Not (Request.QueryString("from")) Is Nothing Then
                'urlTextLabel.innerHTML = '<%= ConfigurationManager.AppSettings("site").ToString() %>/Default.aspx?from=' + userID;
                sdGetUserIdDataSource2.SelectParameters.Item("UserID").DefaultValue = Request.QueryString("from")
                Dim dv1 As System.Data.DataView = CType(sdGetUserIdDataSource2.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
                If (dv1.Count > 0) Then
                    If (Not IsDBNull(dv1(0)("UserName"))) Then
                        UserFromName = dv1(0)("UserName")
                    End If
                End If
               
                strSubject = "New User Registered"
                strbody = "<span style='font-size:11.0pt;font-family:Calibri,sans-serif;color:#1f497d'> New User Registered referred by <a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Profile.aspx?User=" & UserFromName & "'>" & UserFromName & "</a>"


            Else
                strSubject = "New User Registered"
            End If
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody2 As String = strbody & "</span><br><br>User Name: " & userName & " <br>First Name: " & firstName & " <br>Last Name: " & lastName & " <br>email: " & Email & "</span>"
            GlobalModule.SendEmail(toAddress, strSubject, strBody2, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub resetTextBoxes()
        lblUserNameX.Attributes.Add("style", "visibility:hidden;")
        lblFirstNameX.Attributes.Add("style", "visibility:hidden;")
        lblLastNameX.Attributes.Add("style", "visibility:hidden;")
        lblEmailX.Attributes.Add("style", "visibility:hidden;")
        lblPasswordX.Attributes.Add("style", "visibility:hidden;")
        lblConfirmPasswordX.Attributes.Add("style", "visibility:hidden;")
        txtUserName.Text = ""
        txtFirstName.Text = ""
        txtLastName.Text = ""
        txtEmail.Text = ""
        txtPassword.Text = ""
        txtConfirmPassword.Text = ""
        ' txtUserName.Focus()
    End Sub
    Protected Sub lbtnSingup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSingup.Click

    End Sub

    Private Sub SendValidationEmail(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal email As String, ByVal uuid As String, ByVal UserID As Integer)
        Try
            Dim strSubject As String = "crowdboarders - Activate Account"
            Dim toAddress As String = email
            Dim strBody As String = "Please click the link below to Activate Your Account<br><br>"
            Dim verificationLink As String = "<a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Account/Verification.aspx?UserID=" & UserID & "&uuid=" & uuid & "'>Please click here to Verify your Account</a>"
            strBody = strBody & verificationLink
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal email As String, ByVal uuid As String) As Integer
        Dim userdID As Integer = 0
        Try
            sdUsers.SelectParameters.Item("UserName").DefaultValue = UserName
            sdUsers.SelectParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.SelectParameters.Item("LastName").DefaultValue = LastName
            sdUsers.SelectParameters.Item("Email").DefaultValue = email
            sdUsers.SelectParameters.Item("uuid").DefaultValue = uuid
            Dim uID As Integer = 0
            If Not (Request.QueryString("from")) Is Nothing Then
                uID = Request.QueryString("uID")
            End If

            If Not (Request.QueryString("bordName")) Is Nothing Then
                sdUsers.SelectParameters.Item("ReferalURL").DefaultValue = "NA"
                sdUsers.SelectParameters.Item("ReferalValue").DefaultValue = Me.directoryName
                sdUsers.SelectParameters.Item("ReferalUserID").DefaultValue = Me.userID

            Else
                sdUsers.SelectParameters.Item("ReferalURL").DefaultValue = "NA"
                sdUsers.SelectParameters.Item("ReferalValue").DefaultValue = "NA"
                sdUsers.SelectParameters.Item("ReferalUserID").DefaultValue = Me.userID
            End If

            Dim dv1 As Data.DataView = CType(sdUsers.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv1 Is Nothing Then
                If dv1.Count > 0 Then
                    If (Not IsDBNull(dv1(0)("UserID"))) Then
                        userdID = dv1(0)("UserID")
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userdID
    End Function
    Private Sub UpdateLastLogin(ByVal UserName As String)
        Try
            sdUpdateLastlogin.UpdateParameters.Item("UserName").DefaultValue = UserName
            sdUpdateLastlogin.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = UserName
            Dim dv As System.Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
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

    Protected Sub signInLinkedIn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles signInLinkedIn.Click
        Try
            Session("returnURL") = Me.directoryName
            Session("uID") = Me.userID
            Dim authLink As String = _oauth.AuthorizationLinkGet()
            Application("reuqestToken") = _oauth.Token
            Application("reuqestTokenSecret") = _oauth.TokenSecret
            Application("oauthLink") = authLink
            Session("Session_OToken") = _oauth.Token
            Session("Session_OTokenSecret") = _oauth.TokenSecret
            Response.Redirect(authLink, False)
        Catch ex As Exception
            GlobalModule.SetMessage(messageLable, False, "Error in Sign In with LinkedIn")
            'GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class