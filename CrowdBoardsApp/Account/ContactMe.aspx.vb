Imports System.Net
Imports System.Net.Mail
Imports System.IO
Public Class ContactMe
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblMessage.Visible = False
    End Sub

    Protected Sub submitButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles submitButton.Click
        Dim fromUser As String = "" & Name.Text
        Dim fromEmail As String = "" & email.Text
        Dim subject As String = ""
        If fromEmail <> "" Then
            subject = "New person for the interest list!"
        Else
            Response.Redirect("~/Account/ContactMe.aspx")
        End If
        Dim body As String = "Name: " & fromUser & "<br>Email: " & fromEmail & "<br><br>Thanks"
        Try
            SaveContactInfo()
            Dim adminEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("adminEmail")
            GlobalModule.SendEmail(adminEmail, subject, body, True)
            lblMessage.ForeColor = Drawing.Color.Green
            lblMessage.Visible = True
            lblMessage.Text = "Thank you for your interest.  You will be contacted shortly."
        Catch ex As Exception
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Visible = True
            lblMessage.Text = "Error in Processing Request"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub SaveContactInfo()
        Try
            sdContactUs.InsertParameters.Item("FirstName").DefaultValue = Name.Text
            sdContactUs.InsertParameters.Item("LastName").DefaultValue = ""
            sdContactUs.InsertParameters.Item("Email").DefaultValue = email.Text
            sdContactUs.InsertParameters.Item("QuestionText").DefaultValue = ""
            sdContactUs.Insert()
        Catch ex As Exception
            lblMessage.Text = "Error in Processing Request"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class