Imports Telerik.Web.UI

Public Class IntrestList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If checkIfAdmin() = False Then
            Response.Redirect("~/Home.aspx")
        End If
        lblErrorMessage.Text = ""
    End Sub


    Private Function checkIfAdmin() As Boolean
        Try
            Dim roles() As String = System.Web.Security.Roles.GetRolesForUser(Session("userName").ToString())
            For Each Item As String In roles
                If Item = "Admin" Then
                    Return True
                End If
            Next
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return False
    End Function



    Protected Sub resetButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles resetButton.Click
        Try
           
          
            subjectTextBox.Text = ""
            messageBodyTextbox.Text = ""
            subjectTextBox.Focus()
           
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub sendMailButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles sendMailButton.Click
        Try
            Dim isSelected = False
            For Each item As GridDataItem In grIntrestList.SelectedItems
                Dim emailAddress As String = item("Email").Text
                If Not (emailAddress = "") Then
                    isSelected = True
                    GlobalModule.SendEmail(emailAddress, subjectTextBox.Text, messageBodyTextbox.Text, False)

                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Please select User")
                End If
            Next
            If (isSelected = False) Then
                GlobalModule.SetMessage(lblErrorMessage, False, "Please select User")
            Else
                subjectTextBox.Text = ""
                messageBodyTextbox.Text = ""
                GlobalModule.SetMessage(lblErrorMessage, True, "Mail sent Successfully")
               
            End If
           
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

End Class