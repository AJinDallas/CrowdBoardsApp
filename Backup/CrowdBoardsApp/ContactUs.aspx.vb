
Public Class ContactUs
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        lblMessage.Text = ""

        If (Not Page.IsPostBack) Then
            Try
                If Not (Session("userID")) Is Nothing Then
                    ' LoadUserDetails()
                End If
            Catch ex As Exception
                GlobalModule.SetMessage(lblMessage, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Try
            SaveContactInfo()
            SendUserInformation()
            GlobalModule.SetMessage(lblMessage, True, "Information sent successfully")
            ResetForm()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub LoadUserDetails()
        Try
            sdUserInformation.SelectParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
            Dim dv As Data.DataView = CType(sdUserInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("Email"))) Then
                        txtEmail.Text = dv(0)("Email").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("FirstName"))) Then
                        txtFirstName.Text = dv(0)("FirstName").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("LastName"))) Then
                        txtLastName.Text = dv(0)("LastName").ToString()
                    End If
                End If
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SendUserInformation()
        Try
            Dim subject As String = "Contact Us Question"
            Dim body As String = ""
            body = "First Name: " & txtFirstName.Text & "<br>Last Name: " & txtLastName.Text & "<br>Email Address: " & txtEmail.Text & "<br>Question: " & txtQuestion.Text & "<br><br>Thanks"
            Dim infoEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("infoEmail")
            GlobalModule.SendEmail(infoEmail, subject, body, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub SaveContactInfo()
        Try
            sdContactUs.InsertParameters.Item("FirstName").DefaultValue = txtFirstName.Text
            sdContactUs.InsertParameters.Item("LastName").DefaultValue = txtLastName.Text
            sdContactUs.InsertParameters.Item("Email").DefaultValue = txtEmail.Text
            sdContactUs.InsertParameters.Item("QuestionText").DefaultValue = txtQuestion.Text
            sdContactUs.Insert()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub ResetForm()
        Try
            txtFirstName.Text = ""
            txtLastName.Text = ""
            txtEmail.Text = ""
            txtQuestion.Text = ""

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class