Public Class rwWrongPassword
    Inherits Telerik.Web.UI.RadAjaxPage
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
        Try
            If (Not Page.IsPostBack) Then
                resetTextBoxes()
                If Request.QueryString("page") IsNot Nothing Then
                    If (Request.QueryString("page").Length >= 1) Then
                        Me.Page.Title = "Login"
                    End If
                Else
                    Me.Page.Title = "Wrong Password"
                End If
            End If

            lblEmailMessage.Text = String.Empty
            messageLable.Text = String.Empty
            lblMessageSignUp.Text = String.Empty
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub imgSendEmail_Click(ByVal sender As Object, ByVal e As EventArgs) Handles imgSendEmail.Click
        Try
            SendRequestEmail()
        Catch ex As Exception
            GlobalModule.SetMessage(lblEmailMessage, False, "Error in Sending Email")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub SendRequestEmail()
        Try
            If txtEmailSend.Text <> "" Then
                Dim emailCheck = Membership.GetUserNameByEmail(txtEmailSend.Text)
                If Not emailCheck Is Nothing Then
                    Dim userID As Integer = GetUserID(emailCheck)
                    If userID <> 0 Then
                        Dim uuID As String = Guid.NewGuid().ToString()
                        Dim result As Integer = UpdateUserProfile(userID.ToString(), txtEmailSend.Text, uuID)
                        If result = 1 Then
                            Dim strSubject As String = "Password Request"
                            Dim toAddress As String = txtEmailSend.Text
                            Dim strBody As String = "Please click the link below to Reset Your Password<br><br>"
                            Dim verificationLink As String = "<a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Default.aspx?uuid=" & uuID & "&Id=" & userID & "'>Please click here to Reset your Password</a>"
                            strBody = strBody & verificationLink
                            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
                            GlobalModule.SetMessage(lblEmailMessage, True, "Please Check your Email to Reset your Password (including spam/junk email folders)")
                        End If
                    End If
                Else
                    GlobalModule.SetMessage(lblEmailMessage, False, "Email Address not Registered")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function UpdateUserProfile(ByVal userID As String, ByVal email As String, ByVal uuid As String) As Integer
        Dim result As Integer = 0
        Try
            sdUpdateUserByEmailID.UpdateParameters.Item("UserID").DefaultValue = userID
            sdUpdateUserByEmailID.UpdateParameters.Item("uuid").DefaultValue = uuid
            result = sdUpdateUserByEmailID.Update()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Sub LoginButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginButton.Click
        Try
            If Membership.ValidateUser(txtLogInUserName.Text, txtlogInPassword.Text) Then
                sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = txtLogInUserName.Text
                Dim dv As System.Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
                If dv.Count > 0 Then
                    If dv(0)("Status") = True Then
                        Session("userName") = txtLogInUserName.Text
                        Dim UserName As String = txtLogInUserName.Text
                        Session("UserID") = GetUserID(UserName)
                        FormsAuthentication.SetAuthCookie(txtLogInUserName.Text, False)
                        UpdateLastLogin(UserName)
                        If Request.QueryString("dirName") IsNot Nothing Then
                            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "ToBoardPage('" & Request.QueryString("dirName") & "');", True)
                        Else
                            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "Ok('" & Request.QueryString("page") & "');", True)
                        End If

                        'RadAjaxManager1.ResponseScripts.Add(" Ok();")
                    Else
                        GlobalModule.SetMessage(messageLable, False, "Please Contact Administrator to activate your account")
                    End If
                Else
                    GlobalModule.SetMessage(messageLable, False, "Invalid User")
                End If
            Else
                GlobalModule.SetMessage(messageLable, False, "Invalid UserName / Password")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLable, False, "Error in User Login")
            GlobalModule.ErrorLogFile(ex)
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
    Private Sub UpdateLastLogin(ByVal UserName As String)
        Try
            sdUpdateLastlogin.UpdateParameters.Item("UserName").DefaultValue = UserName
            sdUpdateLastlogin.Update()
        Catch ex As Exception
            Throw ex
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
                        GlobalModule.SetMessage(lblMessageSignUp, True, "Password must be a minumum of 7 characters with at least one non-alphanumeric character")
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
                Dim userID As Integer = CreateUserProfile(txtUserName.Text, txtFirstName.Text, txtLastName.Text, txtEmail.Text, uuID)
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
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendMailToAdmin(ByVal userName As String, ByVal firstName As String, ByVal lastName As String, ByVal Email As String)
        Try
            Dim strSubject As String = "New User Registered"
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody As String = "New user has been registered <br><br>User Name: " & userName & " <br>First Name: " & firstName & " <br>Last Name: " & lastName & " <br>email: " & Email
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
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
    Private Function CreateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal email As String, ByVal uuid As String) As Integer
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
        txtUserName.Focus()
    End Sub
End Class