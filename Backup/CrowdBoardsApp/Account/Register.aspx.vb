Imports ASPSnippets.FaceBookAPI
Imports System.Web.Script.Serialization
Imports System.Web.Security
Partial Class Account_Register
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If "" & System.Configuration.ConfigurationManager.AppSettings("allowRegistration") = "0" Then
            Response.Redirect("~/Account/ContactMe.aspx")
        End If
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString("ReturnUrl")
        lblErrorMessage.Visible = False
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        Dim redirectUrl1 As String = "" & System.Configuration.ConfigurationManager.AppSettings("returnURL")
    End Sub

    Protected Sub RegisterUser_CreatedUser(ByVal sender As Object, ByVal e As EventArgs) Handles RegisterUser.CreatedUser
        'FormsAuthentication.SetAuthCookie(RegisterUser.UserName, False)

        'Dim continueUrl As String = RegisterUser.ContinueDestinationPageUrl
        'If String.IsNullOrEmpty(continueUrl) Then
        '    continueUrl = "~/Default.aspx"
        'End If

        'Response.Redirect(continueUrl)
        ' Get the UserId of the just-added user 

            Dim newUser As MembershipUser = Membership.GetUser(RegisterUser.UserName)

            Dim newUserId As Guid = DirectCast(newUser.ProviderUserKey, Guid)

            'Get Profile Data Entered by user in CUW control

            Dim FirstName As String = DirectCast(RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("FirstNameTextBox"), TextBox).Text
            Dim LastName As String = DirectCast(RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("LastNameTextBox"), TextBox).Text
            UpdateUserProfile(newUser.UserName, FirstName, LastName)
            Roles.AddUserToRole(newUser.UserName, "Boarder")
            Response.Redirect("~/Account/Login.aspx")
    End Sub

    Private Sub UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String)

        Try
            sdUsers.InsertParameters.Item("UserName").DefaultValue = UserName
            sdUsers.InsertParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.InsertParameters.Item("LastName").DefaultValue = LastName
            sdUsers.Insert()
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in User Creation"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub signInFacebook_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles signInFacebook.Click

        Dim redirectUrl As String = "" & System.Configuration.ConfigurationManager.AppSettings("returnURL")
        FaceBookConnect.Authorize("user_photos,email", redirectUrl) 'Request.Url.AbsoluteUri.Split("?"c)(0))


    End Sub
End Class
