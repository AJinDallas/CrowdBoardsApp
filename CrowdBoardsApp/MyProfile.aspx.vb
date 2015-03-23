Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Net
Imports WePaySDK
Imports System.Drawing

Public Class MyProfile
    Inherits Telerik.Web.UI.RadAjaxPage
    Public apiMarketplace As String = "" & ConfigurationManager.AppSettings("ApiMarketplace")
    Public stripePublishableKey As String = "" & ConfigurationManager.AppSettings("StripePublishableKey")
    Public Property CustomerIdOfOwner() As String
        Get
            Return CStr(ViewState("_customerIdOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerIdOfOwner") = value
        End Set
    End Property
    Public Property BalancedAccountStatus() As String
        Get
            Return CStr(ViewState("_balancedAccountStatus"))
        End Get
        Set(ByVal value As String)
            ViewState("_balancedAccountStatus") = value
        End Set
    End Property
    Public Property StripeAccountStatus() As String
        Get
            Return CStr(ViewState("_stripeAccountStatus"))
        End Get
        Set(ByVal value As String)
            ViewState("_stripeAccountStatus") = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return CStr(ViewState("_userName"))
        End Get
        Set(ByVal value As String)
            ViewState("_userName") = value
        End Set
    End Property
    Public Property MemberShipUserID() As String
        Get
            Return CStr(ViewState("_memberShipUserID"))
        End Get
        Set(ByVal value As String)
            ViewState("_memberShipUserID") = value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        GlobalModule.RedirectToHttps()
        lblMessage.Text = String.Empty
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If
        If (Not Page.IsPostBack) Then
            Try

                txtFirstName.Focus()
                LoadUserInfo()


                If (Not String.IsNullOrEmpty(Request.QueryString("IsCreated"))) Then
                    If (Request.QueryString("IsCreated") = "1") Then
                        GlobalModule.SetMessage(lblMessage, True, "Account configured successfully")
                    Else
                        GlobalModule.SetMessage(lblMessage, False, "Account not configured")
                    End If
                End If
            Catch ex As Exception
                GlobalModule.SetMessage(lblMessage, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
        'If Not Request.QueryString("Name") Is Nothing Then
        '    btnClose.Visible = True
        'End If
    End Sub


    Private Sub SaveChanges()
        Try
            sdsCheckUserName.SelectParameters.Item("UserName").DefaultValue = txtUserName.Text
            sdsCheckUserName.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            Dim dv As Data.DataView = CType(sdsCheckUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    sdMemberShipUserDetails.SelectParameters.Item("UserName").DefaultValue = txtUserName.Text
                    Dim dvMember As Data.DataView = CType(sdMemberShipUserDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If Not dvMember Is Nothing Then
                        If (dvMember.Count > 0) Then
                            GlobalModule.SetMessage(lblMessage, False, "UserName already Exists")
                        End If
                    End If
                    'GlobalModule.SetMessage(lblMessage, False, "UserName already Exists")

                Else
                    If Not (Me.UserName = txtUserName.Text) Then
                        sdMemberShipUserDetails.SelectParameters.Item("UserName").DefaultValue = txtUserName.Text
                        Dim dvMember As Data.DataView = CType(sdMemberShipUserDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
                        If Not dvMember Is Nothing Then
                            If (dvMember.Count > 0) Then
                                GlobalModule.SetMessage(lblMessage, False, "UserName already Exists")
                                Exit Sub
                            End If
                        End If

                        sdMemberShipUserDetails.UpdateParameters.Item("UserName").DefaultValue = txtUserName.Text
                        sdMemberShipUserDetails.UpdateParameters.Item("LoweredUserName").DefaultValue = txtUserName.Text
                        sdMemberShipUserDetails.UpdateParameters.Item("userID").DefaultValue = Me.MemberShipUserID
                        sdMemberShipUserDetails.Update()
                        Dim renameFilePath = Server.MapPath("~/Upload/ProfilePics") & "\\" & Session("userName").ToString() & ".jpg"
                        Dim newFilePath = Server.MapPath("~/Upload/ProfilePics") & "\\" & txtUserName.Text & ".jpg"
                        Dim backGroundImagePath = Server.MapPath("~/Upload/BackgroundPics") & "\\" & Session("userName").ToString() & ".jpg"
                        Dim newBackGroundImagePath = Server.MapPath("~/Upload/BackgroundPics") & "\\" & txtUserName.Text & ".jpg"
                        If (File.Exists(renameFilePath)) Then
                            If Not (File.Exists(newFilePath)) Then
                                My.Computer.FileSystem.RenameFile(renameFilePath, txtUserName.Text & ".jpg")
                            End If
                        End If
                        If (File.Exists(backGroundImagePath)) Then
                            If Not (File.Exists(newBackGroundImagePath)) Then
                                My.Computer.FileSystem.RenameFile(backGroundImagePath, txtUserName.Text & ".jpg")
                            End If
                        End If
                    End If
                    sdBillingInformation.UpdateParameters.Item("UserName").DefaultValue = txtUserName.Text
                    sdBillingInformation.UpdateParameters.Item("Address").DefaultValue = txtAddress.Text
                    sdBillingInformation.UpdateParameters.Item("City").DefaultValue = txtCity.Text
                    sdBillingInformation.UpdateParameters.Item("MyPassions").DefaultValue = txtPassions.Text
                    sdBillingInformation.UpdateParameters.Item("FirstName").DefaultValue = txtFirstName.Text
                    sdBillingInformation.UpdateParameters.Item("LastName").DefaultValue = txtLastName.Text
                    sdBillingInformation.UpdateParameters.Item("Job").DefaultValue = txtJob.Text
                    sdBillingInformation.UpdateParameters.Item("Birthdate").DefaultValue = txtBirthdate.Text
                    sdBillingInformation.UpdateParameters.Item("AboutMe").DefaultValue = txtAboutMe.Text
                    sdBillingInformation.UpdateParameters.Item("MyDreams").DefaultValue = txtMyDreams.Text
                    sdBillingInformation.UpdateParameters.Item("BackgroundImageStyle").DefaultValue = "Stretch"
                    sdBillingInformation.UpdateParameters.Item("WebSite").DefaultValue = txtWebSite.Text
                    sdBillingInformation.UpdateParameters.Item("Skills").DefaultValue = txtSkills.Text
                    sdBillingInformation.UpdateParameters.Item("Email").DefaultValue = txtEmailAddress.Text
                    sdBillingInformation.UpdateParameters.Item("BankLocation").DefaultValue = rblBankLocation.SelectedValue
                    sdBillingInformation.Update()
                    GlobalModule.SetMessage(lblMessage, True, "Profile Updated Successfully")
                End If
            End If

            LoadUserInfo()


        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub LoadBalancedAccountInfo()
        Try
            If Not Session("UserID") Is Nothing Then
                sdBalancedUserDetails.SelectParameters.Item("UserId").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdBalancedUserDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("CustomerID"))) Then
                        lblBalancedCustomerID.Text = dv(0)("CustomerID").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("DateCreated"))) Then
                        Dim str As DateTime = Convert.ToDateTime(dv(0)("DateCreated"))
                        lblDateCreated.Text = str.ToString("MM/dd/yyyy")
                    End If
                    If (Not IsDBNull(dv(0)("UserBankAccountUri"))) Then
                        Me.BalancedAccountStatus = "Exist"
                        balancedAccountDetailsDiv.Visible = True
                        stripeAccountDetailsDiv.Visible = False
                        balancedAccountCreateDiv.Visible = False
                    Else
                        Me.BalancedAccountStatus = "IsUpdate"
                        Me.CustomerIdOfOwner = dv(0)("CustomerID").ToString()
                        balancedAccountDetailsDiv.Visible = False
                        balancedAccountCreateDiv.Visible = True
                        stripeAccountDetailsDiv.Visible = False
                    End If
                Else
                    Me.BalancedAccountStatus = "IsNew"
                    balancedAccountDetailsDiv.Visible = False
                    balancedAccountCreateDiv.Visible = True
                    stripeAccountDetailsDiv.Visible = False
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadSripeAccountInfo()
        Try
            If Not Session("UserID") Is Nothing Then
                sdStripeUserDetails.SelectParameters.Item("UserId").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdStripeUserDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("StripeUserID"))) Then
                        lblStripeUserID.Text = dv(0)("StripeUserID").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("DateCreated"))) Then
                        Dim str As DateTime = Convert.ToDateTime(dv(0)("DateCreated"))
                        lblAccountCreatedDate.Text = str.ToString("MM/dd/yyyy")
                    End If
                    If (Not IsDBNull(dv(0)("acces_token"))) Then
                        Me.StripeAccountStatus = "Exist"
                        stripeAccountDetailsDiv.Visible = True
                        balancedAccountDetailsDiv.Visible = False
                        balancedAccountCreateDiv.Visible = False
                    Else
                        Me.StripeAccountStatus = "IsUpdate"
                        stripeAccountDetailsDiv.Visible = False
                        balancedAccountCreateDiv.Visible = True
                        balancedAccountDetailsDiv.Visible = False
                    End If
                Else
                    Me.StripeAccountStatus = "IsNew"
                    stripeAccountDetailsDiv.Visible = False
                    balancedAccountCreateDiv.Visible = True
                    balancedAccountDetailsDiv.Visible = False
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnCreateAccount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateAccount.Click
        Try
            Dim userBankAccountUri As String = balancedBankAccountURI.Value

            If Not userBankAccountUri = "" Then
                If (Me.BalancedAccountStatus = "IsUpdate") Then
                    Dim r As String = BalancedPayments.AddingAccountToCustomer(Me.CustomerIdOfOwner, userBankAccountUri)
                    If r.Contains("succeeded") Then
                        sdBalancedUserAccountInsert.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
                        sdBalancedUserAccountInsert.UpdateParameters.Item("UserBankAccountUri").DefaultValue = userBankAccountUri
                        sdBalancedUserAccountInsert.Update()
                        GlobalModule.SetMessage(lblMessage, True, "Account configured successfully")
                        LoadUserInfo()
                        txtName.Text = ""
                        txtEmailForBankAccount.Text = ""
                        txtRoutingNumber.Text = ""
                        txtAccountNumber.Text = ""

                    End If
                Else
                    Dim result As String = BalancedPayments.CreateCustomer(txtName.Text, txtEmailForBankAccount.Text)
                    If result.Contains("succeeded") Then
                        Dim codes As String() = result.Split(","c)
                        If codes.Length = 3 Then
                            Dim customerUri As String = codes(1)
                            Dim customerID As String = codes(2)
                            Dim r As String = BalancedPayments.AddingAccountToCustomer(customerID, userBankAccountUri)
                            If r.Contains("succeeded") Then
                                SaveCardDetails(customerUri, userBankAccountUri, customerID)
                                GlobalModule.SetMessage(lblMessage, True, "Account configured successfully")
                                LoadUserInfo()
                                txtName.Text = ""
                                txtEmailForBankAccount.Text = ""
                                txtRoutingNumber.Text = ""
                                txtAccountNumber.Text = ""

                            End If
                        End If
                    Else
                        GlobalModule.SetMessage(lblMessage, False, "Error in Request")
                    End If
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub resetPasswordButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles resetPasswordButton.Click
        Try
            If Not (Session("userName")) Is Nothing Then
                Dim user = Membership.GetUser(Session("userName").ToString())

                Dim oldPassword As String = user.ResetPassword()
                user.ChangePassword(oldPassword, confirmPasswordTextBox.Text)
                GlobalModule.SetMessage(lblMessage, True, "Password Changed Successfully")
                FormsAuthentication.SetAuthCookie(user.UserName, False)
            End If


        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub SaveCardDetails(ByVal accountUri As String, ByVal userBankAccountUri As String, ByVal customerID As String)
        Try
            sdBalancedUserAccountInsert.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
            sdBalancedUserAccountInsert.InsertParameters.Item("UserAccountUri").DefaultValue = accountUri
            sdBalancedUserAccountInsert.InsertParameters.Item("UserBankAccountUri").DefaultValue = userBankAccountUri
            sdBalancedUserAccountInsert.InsertParameters.Item("CustomerID").DefaultValue = customerID
            Dim res As Integer = sdBalancedUserAccountInsert.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub LoadUserInfo()
        Try
            Dim dv As Data.DataView = CType(sdBillingInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then

                    If (Not IsDBNull(dv(0)("UserName"))) Then
                        txtUserName.Text = dv(0)("UserName")
                        Session("userName") = dv(0)("UserName")
                        Me.UserName = dv(0)("UserName")
                    Else
                        Me.UserName = ""
                    End If

                    If (Not IsDBNull(dv(0)("FirstName"))) Then
                        txtFirstName.Text = dv(0)("FirstName")
                    End If

                    If (Not IsDBNull(dv(0)("LastName"))) Then
                        txtLastName.Text = dv(0)("LastName")
                    End If
                    txtName.Text = txtFirstName.Text & " " & txtLastName.Text

                    If (Not IsDBNull(dv(0)("Job"))) Then
                        txtJob.Text = dv(0)("Job")
                    End If

                    If (Not IsDBNull(dv(0)("Birthdate"))) Then
                        txtBirthdate.Text = dv(0)("Birthdate")
                    End If

                    If (Not IsDBNull(dv(0)("AboutMe"))) Then
                        txtAboutMe.Text = dv(0)("AboutMe")
                    End If

                    If (Not IsDBNull(dv(0)("MyDreams"))) Then
                        txtMyDreams.Text = dv(0)("MyDreams")
                    End If

                    If (Not IsDBNull(dv(0)("Address"))) Then
                        txtAddress.Text = dv(0)("Address")
                    End If

                    If (Not IsDBNull(dv(0)("City"))) Then
                        txtCity.Text = dv(0)("City")
                    End If
                    If (Not IsDBNull(dv(0)("Passions"))) Then
                        txtPassions.Text = dv(0)("Passions")
                    End If

                    If (Not IsDBNull(dv(0)("WebSite"))) Then
                        txtWebSite.Text = dv(0)("WebSite")
                    End If
                    If (Not IsDBNull(dv(0)("Skills"))) Then
                        txtSkills.Text = dv(0)("Skills")
                    End If

                    If (Not IsDBNull(dv(0)("Email"))) Then
                        txtEmailAddress.Text = dv(0)("Email")
                        txtEmailForBankAccount.Text = dv(0)("Email")
                    End If
                    If (Not IsDBNull(dv(0)("BankLocation"))) Then
                        rblBankLocation.SelectedValue = dv(0)("BankLocation")
                        If rblBankLocation.SelectedValue = "US" Then
                            LoadBalancedAccountInfo()
                        Else
                            LoadSripeAccountInfo()
                        End If
                    End If


                    If (Not IsDBNull(dv(0)("TXResidentStatus"))) Then

                        Dim TXResidentStatus As Integer = Convert.ToInt32(dv(0)("TXResidentStatus"))
                        If (TXResidentStatus = 1) Then

                            btnTexasResident.Visible = False
                        ElseIf (TXResidentStatus = 0) Then
                            btnTexasResident.Visible = False
                        Else
                            btnTexasResident.Visible = True
                        End If

                    Else
                        btnTexasResident.Visible = True
                    End If


                    sdMemberShipUserDetails.SelectParameters.Item("UserName").DefaultValue = Me.UserName
                    Dim dvMember As Data.DataView = CType(sdMemberShipUserDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If Not dvMember Is Nothing Then
                        If (dvMember.Count > 0) Then
                            Me.MemberShipUserID = dvMember(0)("userID").ToString()
                        End If
                    End If

                End If
            End If
            Dim dv2 As DataView = CType(sdUserInfo.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv2 Is Nothing Then
                If dv2.Count > 0 Then
                    Dim PendingRequestCount As Integer
                    Dim MessageCount As Integer
                    If (Not IsDBNull(dv2(0)("PendingRequestCount"))) Then
                        PendingRequestCount = dv2(0)("PendingRequestCount")
                    End If
                    If (Not IsDBNull(dv2(0)("MessageCount"))) Then
                        MessageCount = dv2(0)("MessageCount")
                    End If
                End If
            End If


        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        SaveChanges()
        txtCity.Focus()
    End Sub
    Protected Sub txtAddress_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAddress.TextChanged


    End Sub
    Protected Sub txtCity_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCity.TextChanged
        SaveChanges()
        txtBirthdate.Focus()
    End Sub
    Protected Sub txtFirstName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFirstName.TextChanged
        SaveChanges()
        txtLastName.Focus()
    End Sub
    Protected Sub txtLastName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtLastName.TextChanged
        SaveChanges()
        txtEmailAddress.Focus()
    End Sub
    Protected Sub txtJob_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtJob.TextChanged
        SaveChanges()
        txtAddress.Focus()
    End Sub
    Protected Sub txtBirthdate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBirthdate.TextChanged
        SaveChanges()
        txtWebSite.Focus()
    End Sub
    Protected Sub txtWebSite_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtWebSite.TextChanged
        SaveChanges()
        txtSkills.Focus()
    End Sub
    Protected Sub txtSkills_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSkills.TextChanged
        SaveChanges()
        txtAboutMe.Focus()
    End Sub
    Protected Sub txtAboutMe_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAboutMe.TextChanged
        SaveChanges()
        txtPassions.Focus()
    End Sub
    Protected Sub txtMyDreams_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtMyDreams.TextChanged
        SaveChanges()
        txtFirstName.Focus()
    End Sub
    Protected Sub txtPassions_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPassions.TextChanged
        SaveChanges()
        txtMyDreams.Focus()
    End Sub

    Protected Sub txtEmailAddress_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEmailAddress.TextChanged
        If (CheckEmailExists(txtEmailAddress.Text) = "0") Then
            emailHiddenField.Value = "0"
            txtJob.Focus()
        ElseIf (CheckEmailExists(txtEmailAddress.Text) = "2") Then
            emailHiddenField.Value = "1"

            GlobalModule.SetMessage(lblMessage, False, "Email Address Already Exists")
        ElseIf (CheckEmailExists(txtEmailAddress.Text) = "1") Then
            emailHiddenField.Value = "1"

            GlobalModule.SetMessage(lblMessage, False, "Invalid Email Address")
        End If

    End Sub
    Public Function CheckEmailExists(ByVal emailAddress As String) As String

        Dim reg As String = "^((([\w]+\.[\w]+)+)|([\w]+))@(([\w]+\.)+)([A-Za-z]{1,3})$"

        If Not Regex.IsMatch(emailAddress, reg) Then
            Return "1"
        End If
        sdsCheckMail.SelectParameters.Item("emailAddress").DefaultValue = emailAddress
        sdsCheckMail.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
        Dim dv As Data.DataView = CType(sdsCheckMail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If (dv.Count > 0) Then
                Return "2"
            Else
                Return "0"
            End If
        Else
            Return ""
        End If
    End Function
    Private Sub rblBankLocation_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rblBankLocation.SelectedIndexChanged
        SaveChanges()
    End Sub
    Protected Sub btnUploadProfilePic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadProfilePic.Click
        Try
            If RadUpload1.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In RadUpload1.UploadedFiles
                    If Not (upFiles.GetExtension.ToUpper = ".JPG") Then
                        GlobalModule.SetMessage(lblUploadProfilePic, False, "Only JPG files are allowed")
                        Exit Sub
                    End If
                    upFiles.SaveAs(Server.MapPath("~/Upload/ProfilePics") & "\\" & Session("userName").ToString() & ".jpg")
                    GlobalModule.SetMessage(lblUploadProfilePic, True, Session("userName").ToString() & ".jpg Uploaded Successfully")

                    LoadUserInfo()
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblUploadProfilePic, False, "Only JPG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Uploading Profile Image")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Function ResizeImage(ByVal streamImage As String, ByVal maxWidth As Integer, ByVal maxHeight As Integer) As Bitmap
        Dim originalImage As New Bitmap(streamImage)
        Dim newWidth As Integer = originalImage.Width
        Dim newHeight As Integer = originalImage.Height

        Dim newImage As New Bitmap(originalImage, maxWidth, maxHeight)

        Dim g As Graphics = Graphics.FromImage(newImage)
        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear
        g.DrawImage(originalImage, 0, 0, newImage.Width, newImage.Height)

        originalImage.Dispose()

        Return newImage
    End Function


    Protected Sub btnUploadBackgroundPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadBackgroundPicture.Click
        Try
            If RadAsyncUpload1.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In RadAsyncUpload1.UploadedFiles
                    If Not (upFiles.GetExtension.ToUpper = ".JPG") Then
                        GlobalModule.SetMessage(lblUploadProfilePic, False, "Only JPG files are allowed")
                        Exit Sub
                    End If
                    upFiles.SaveAs(Server.MapPath("~/Upload/BackgroundPics") & "\\" & Session("userName").ToString() & ".jpg")
                    GlobalModule.SetMessage(lblUploadBackgroundPicture, True, Session("userName").ToString() & ".jpg Uploaded Successfully")
                    Dim image1 As Bitmap
                    image1 = ResizeImage(Server.MapPath("~/Upload/BackgroundPics") & "\\" & Session("userName").ToString() & ".jpg", 1481, 330)
                    image1.Save(Server.MapPath("~/Upload/BackgroundPics") & "\\" & Session("userName").ToString() & ".jpg")

                    LoadUserInfo()
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblUploadBackgroundPicture, False, "Only JPG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Uploading Background Image")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub PictureUploadMessage(ByVal LabelID As Label, ByVal FolderName As String)
        Try
            If Not Session("userName").ToString() Is Nothing Then
                Dim iPath As String = Path.Combine(Server.MapPath(FolderName), Session("userName").ToString() & ".jpg")
                If System.IO.File.Exists(iPath) Then
                    GlobalModule.SetMessage(LabelID, True, Session("userName").ToString() & ".jpg" & " uploaded")
                Else
                    GlobalModule.SetMessage(LabelID, False, " No image uploaded")
                End If
            Else
                GlobalModule.SetMessage(LabelID, False, " No image uploaded")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function CheckRequest(ByVal UserID2 As Integer) As Boolean
        Dim status As Boolean
        Try
            sdCheckRequest.SelectParameters.Item("UserID2").DefaultValue = UserID2
            sdCheckRequest.SelectParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("userID").ToString())
            Dim dv As Data.DataView = CType(sdCheckRequest.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then

                    If dv(0)("status") = 1 Then
                        status = True
                    Else
                        status = False
                    End If
                End If
            Else
                status = False
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserId.SelectParameters.Item("UserName").DefaultValue = UserName
            Dim dv As Data.DataView = CType(sdGetUserId.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    userID = dv(0)("UserID")
                End If
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function
    Protected Sub btnAuthorizeStripe_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAuthorizeStripe.Click
        Try
            Dim stripeClientID As String = "" & ConfigurationManager.AppSettings("StripeClientID")
            Response.Redirect("https://connect.stripe.com/oauth/authorize?response_type=code&client_id=" & stripeClientID & "&scope=read_write&state=ToMyProfile", False)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnView.Click
        Try
            Response.Redirect("~/Profile.aspx", False)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub ButtonProofofidentification_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonProofofidentification.Click
        Try
            If ruIDproof.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In ruIDproof.UploadedFiles
                    'Dim extention As String = upFiles.GetExtension.ToUpper
                    If Not (upFiles.GetExtension.ToUpper = ".JPG" Or upFiles.GetExtension.ToUpper = ".JPEG" Or upFiles.GetExtension.ToUpper = ".DOC" Or upFiles.GetExtension.ToUpper = ".DOCX" Or upFiles.GetExtension.ToUpper = ".PDF") Then
                        GlobalModule.SetMessage(LabelProofofidentification, False, "Only JPG or JPEG or Doc or PDF files are allowed")
                        Exit Sub
                    End If
                    upFiles.SaveAs(Server.MapPath("~/Upload/UserProofDoc") & "\\" & Session("userName").ToString() & upFiles.GetExtension)
                    GlobalModule.SetMessage(LabelProofofidentification, True, Session("userName").ToString() & upFiles.GetExtension & " Uploaded Successfully")
                    LoadUserInfo()
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblUploadProfilePic, False, "Only JPG or JPEG or Doc or PDF  files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Uploading Profile Image")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub termCheckbox_Clicked(ByVal sender As Object, ByVal e As EventArgs)
        Try
            adsTXResidentStatus.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            adsTXResidentStatus.UpdateParameters.Item("TXResidentStatus").DefaultValue = 1
            adsTXResidentStatus.Update()
            LoadUserInfo()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Uploading Profile Image")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub texasRadioButton_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles texasRadioButton.SelectedIndexChanged
        Try

            'adsTXResidentStatus.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            'adsTXResidentStatus.UpdateParameters.Item("TXResidentStatus").DefaultValue = 0
            'adsTXResidentStatus.Update()
            'LoadUserInfo()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Uploading Profile Image")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub





End Class