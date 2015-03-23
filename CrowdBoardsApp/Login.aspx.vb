Imports System.Data
Imports System.Security.Cryptography
Partial Class Login
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Not IsPostBack Then
            Session("userName") = ""
            loginValidator.Text = ""
        End If
    End Sub
    Protected Sub btnLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLogin.Click

        If (Page.IsValid) Then
            If (tbUserName.Text.Trim() = "" Or tbPassword.Text.Trim() = "") Then
                loginValidator.Text = "UserName or Password cannot blank"
                Exit Sub
            End If
            sdsUserDataSource.SelectParameters.Item("UserID").DefaultValue = (tbUserName.Text)
            sdsUserDataSource.SelectParameters.Item("Password").DefaultValue = (tbPassword.Text)
            Dim dvLogin As DataView = CType(sdsUserDataSource.Select(DataSourceSelectArguments.Empty), DataView)
            If dvLogin.Count = 1 Then
                Session("userName") = tbUserName.Text
                Response.Redirect("Home.aspx")
            Else
                loginValidator.Text = "Enter Correct UserName or Password"
                tbUserName.Text = ""
                Exit Sub
            End If
        End If
    End Sub
End Class
