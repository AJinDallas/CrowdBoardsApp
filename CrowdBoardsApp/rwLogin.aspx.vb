Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwLogin
    Inherits Telerik.Web.UI.RadAjaxPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
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
    Protected Sub LoginButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginButton.Click
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
                        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "Ok('" & Request.QueryString("page") & "');", True)
                        'RadAjaxManager1.ResponseScripts.Add("Ok();")
                    Else
                        GlobalModule.SetMessage(lblErrorMessage, False, "Please Contact Administrator to activate your account")
                    End If
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Invalid User")
                End If
            Else
                GlobalModule.SetMessage(lblErrorMessage, False, "Invalid UserName / Password")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in User Login")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
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
End Class