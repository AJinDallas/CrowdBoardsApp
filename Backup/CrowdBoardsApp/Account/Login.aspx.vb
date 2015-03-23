Imports ASPSnippets.FaceBookAPI
Imports System.Web.Script.Serialization
Imports System.Web.UI.WebControls
Imports System.IO
Partial Class Account_Login
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not Page.IsPostBack) Then
            Session.Abandon()
        End If


        RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
        If (LoginUser.DestinationPageUrl.Contains("confirm.aspx")) Then
            LoginUser.DestinationPageUrl = HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
        Else
            LoginUser.DestinationPageUrl = "~/Home.aspx"
        End If
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
    End Sub

    Protected Sub LoginUser_LoggingIn(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles LoginUser.LoggingIn
        Session("userName") = LoginUser.UserName.ToString()
        Dim UserName As String = LoginUser.UserName.ToString()
        Session("UserID") = GetUserID(UserName)
    End Sub
    Protected Sub signInFacebook_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles signInFacebook.Click
        FaceBookConnect.Authorize("user_photos,email", System.Configuration.ConfigurationManager.AppSettings("returnURL")) 'Request.Url.AbsoluteUri.Split("?"c)(0))
    End Sub
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = UserName
            Dim dv As Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
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