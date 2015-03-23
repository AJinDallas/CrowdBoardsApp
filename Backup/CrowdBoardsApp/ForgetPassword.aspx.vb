Imports System.Web.Security
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.Script.Serialization
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Public Class ForgetPassword
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property newPassword() As String
        Get
            Return Convert.ToString(ViewState("_newPassword"))
        End Get

        Set(ByVal value As String)
            ViewState("_newPassword") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If (Request.QueryString("uuid") Is Nothing) And (Request.QueryString("Id") Is Nothing) Then
            RadAjaxManager1.ResponseScripts.Add(" Ok();")
        End If
        lblMessage.Text = ""
    End Sub

    Protected Sub LoginButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginButton.Click
        Try
            Me.newPassword = txtConfirmPassword.Text
            ChangePassword()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub ChangePassword()
        Try
            Dim uuid As String = Request.QueryString("uuid")
            Dim userID As String = Request.QueryString("Id")
            sdGetUserInfo.SelectParameters.Item("uuid").DefaultValue = Request.QueryString("uuid")
            sdGetUserInfo.SelectParameters.Item("UserID").DefaultValue = Request.QueryString("Id")
            Dim dv As Data.DataView = CType(sdGetUserInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                sdGetUserInfo.UpdateParameters.Item("UserID").DefaultValue = dv(0)("UserID")
                sdGetUserInfo.Update()
                Dim result As Integer = sdGetUserInfo.Update()
                If result = 1 Then
                    If Not dv(0)("UserName") Is Nothing Then
                        Dim user = Membership.GetUser(dv(0)("UserName").ToString())
                        Dim newPassword As String = Me.newPassword
                        Dim oldPassword As String = user.ResetPassword()
                        'If Not user Is Nothing Then
                        '    If user.IsLockedOut Then
                        '        user.UnlockUser()
                        '    End If
                        'End If
                        user.ChangePassword(oldPassword, newPassword)
                        If (Not IsDBNull(dv(0)("DateLastLoggedIn"))) Then
                            Session("DateLastLoggedIn") = dv(0)("DateLastLoggedIn")
                        Else
                            Session("DateLastLoggedIn") = System.DateTime.Now
                        End If
                        Session("userName") = user.UserName
                        Session("UserID") = dv(0)("UserID")
                        FormsAuthentication.SetAuthCookie(user.UserName, False)
                        UpdateLastLogin(user.UserName)
                        RadAjaxManager1.ResponseScripts.Add(" Ok();")
                    End If
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in request, Please contact to Administrator.")
                End If
            Else
                GlobalModule.SetMessage(lblMessage, False, "Password reset token expired, please request again")
            End If
        Catch ex As Exception
            Throw ex
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
End Class