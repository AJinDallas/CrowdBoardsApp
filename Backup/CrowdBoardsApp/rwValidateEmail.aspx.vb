Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwValidateEmail
    Inherits Telerik.Web.UI.RadAjaxPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
            End If
            If (Not IsPostBack) Then

            End If
            lblErrorMessage.Visible = False
            lblSuccessMessage.Visible = False
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Loading Data"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSend.Click
        Try

            If (Not String.IsNullOrEmpty(Request.QueryString("vEmail"))) Then
                If (Request.QueryString("vEmail") = True) Then
                    Try
                        If (CheckEmailExistence(email.Text) = "0") Then
                            Dim sdsUserName As New SqlDataSource
                            sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
                            sdsUserName.UpdateParameters.Add("emailAddress", email.Text)
                            sdsUserName.UpdateParameters.Add("userID", Session("UserID"))
                            sdsUserName.UpdateCommand = "UPDATE [Users] SET email=@emailAddress WHERE UserID = @userID"
                            Dim result As Integer = sdsUserName.Update()
                            If (result = 1) Then
                                lblErrorMessage.Text = "Successfully updated"
                                lblErrorMessage.ForeColor = Drawing.Color.Green
                                lblErrorMessage.Visible = True
                            End If

                        ElseIf (CheckEmailExistence(email.Text) = "2") Then
                            lblErrorMessage.Text = "Email Address Already Exists"
                            lblErrorMessage.ForeColor = Drawing.Color.Red
                            lblErrorMessage.Visible = True

                        ElseIf (CheckEmailExistence(email.Text) = "1") Then
                            lblErrorMessage.ForeColor = Drawing.Color.Red
                            lblErrorMessage.Visible = True
                            lblErrorMessage.Text = "Invalid Email Address"
                        End If
                    Catch ex As Exception
                        lblErrorMessage.ForeColor = Drawing.Color.Red
                        lblErrorMessage.Visible = True
                        lblErrorMessage.Text = "Error in Processing Request"
                        GlobalModule.ErrorLogFile(ex)
                    End Try
                Else
                    sdUserDetails.SelectParameters.Item("Email").DefaultValue = email.Text
                    sdUserDetails.SelectParameters.Item("UserName").DefaultValue = Session("userName")
                    Dim dv As System.Data.DataView = CType(sdUserDetails.Select(DataSourceSelectArguments.Empty), System.Data.DataView)
                    If Not (dv) Is Nothing Then
                        If (dv.Count > 0) Then
                            Dim fromUser As String = "" & Session("userName")
                            Dim fromEmail As String = "" & email.Text
                            Dim subject As String = ""
                            subject = "Request for Email Validation!"
                            Dim body As String = "Name: " & fromUser & "<br>Email: " & fromEmail & "<br><br>Thanks"

                            Dim adminEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("adminEmail")
                            GlobalModule.SendEmail(adminEmail, subject, body, True)
                            lblSuccessMessage.ForeColor = Drawing.Color.Green
                            lblSuccessMessage.Visible = True
                            lblSuccessMessage.Text = "Thank you for your Request.  You will be contacted shortly."
                        Else
                            lblErrorMessage.ForeColor = Drawing.Color.Red
                            lblErrorMessage.Visible = True
                            lblErrorMessage.Text = "Please enter a Registered email address"
                        End If
                    Else
                        lblErrorMessage.ForeColor = Drawing.Color.Red
                        lblErrorMessage.Visible = True
                        lblErrorMessage.Text = "Please enter a Registered email address"
                    End If
                End If
            End If
        Catch ex As Exception
            lblErrorMessage.ForeColor = Drawing.Color.Red
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Processing Request"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        RadAjaxManager1.ResponseScripts.Add(" Ok();")
    End Sub

    Public Function CheckEmailExistence(ByVal emailAddress As String) As String

        Dim sdsUserName As New SqlDataSource
        sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
        sdsUserName.SelectParameters.Add("emailAddress", emailAddress)
        sdsUserName.SelectParameters.Add("userID", Session("UserID"))
        sdsUserName.SelectCommand = "Select * from [Users] WHERE email=@emailAddress and UserID<>@userID"
        Dim dv As Data.DataView = CType(sdsUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
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

End Class