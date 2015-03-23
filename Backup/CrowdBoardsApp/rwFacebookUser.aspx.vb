Imports ASPSnippets.FaceBookAPI
Imports System.Web.Script.Serialization
Imports System.Web.Security
Imports Telerik

Public Class rwFacebookUser
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblMessage.Text = ""
    End Sub
    Protected Sub LoginButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginButton.Click
        Try

            RegisterFacebookUser()

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub RegisterFacebookUser()
        Try
            Dim FacebookId As String = Request.QueryString("FacebookId")
            Dim FirstName As String = IIf(Request.QueryString("FirstName") = "", "", Request.QueryString("FirstName"))
            Dim LastName As String = IIf(Request.QueryString("LastName") = "", "", Request.QueryString("LastName"))
            Dim Email As String = IIf(Request.QueryString("Email") = "", "", Request.QueryString("Email"))
            If Not String.IsNullOrEmpty(FacebookId) Then
                If txtUserName.Text <> "" Then
                    Dim user = Membership.GetUser(txtUserName.Text)
                    If (user Is Nothing) Then
                        Membership.CreateUser(txtUserName.Text, txtUserName.Text & "123")
                        Dim newUser As MembershipUser = Membership.GetUser(txtUserName.Text)
                        UpdateUserProfile(txtUserName.Text, FirstName, LastName, FacebookId)
                        Roles.AddUserToRole(newUser.UserName, "Boarder")
                        Session("DateLastLoggedIn") = System.DateTime.Now
                        Session("userName") = txtUserName.Text
                        Session("userID") = GetUserID(txtUserName.Text)
                        SendMailToAdmin(FirstName, LastName, Email)
                        If Not (Session("returnURL")) Is Nothing Then
                            If Not (Session("returnURL") = "") Then
                                Dim returnURL As String = System.Configuration.ConfigurationManager.AppSettings("site")
                                directoryName.Value = returnURL + "/" + Session("returnURL").ToString()
                            Else
                                directoryName.Value = ""
                            End If
                        Else
                            directoryName.Value = ""
                        End If
                        RadAjaxManager1.ResponseScripts.Add(" Ok();")
                    Else
                        GlobalModule.SetMessage(lblMessage, False, "Sorry This Username is Already Taken!")
                    End If
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Please Enter UserName")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal id As String)
        Try
            sdUsers.InsertParameters.Item("UserName").DefaultValue = UserName
            sdUsers.InsertParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.InsertParameters.Item("LastName").DefaultValue = LastName
            sdUsers.InsertParameters.Item("FacebookUserID").DefaultValue = id
            sdUsers.Insert()
        Catch ex As Exception
            Throw ex
        End Try
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

    Private Sub SendMailToAdmin(ByVal FirstName As String, ByVal LastName As String, ByVal email As String)
        Try
            Dim strSubject As String = "New User Registered through  Facebook"
            Dim toAddress As String = ConfigurationManager.AppSettings("adminEmail").ToString()
            Dim strBody As String = "New user has been registered through Facebook<br><br>First Name: " & FirstName & "<br>Last Name: " & LastName & "<br>Email: " & email
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class