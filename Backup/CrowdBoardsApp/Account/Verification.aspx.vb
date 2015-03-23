Public Class Verification
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        lblMessage.Text = ""
        ValidateUser()

    End Sub
    Protected Sub ValidateUser()
        Try
            If (Not Request.QueryString("UserID") Is Nothing) Then
                sdGetUserInfo.SelectParameters.Item("UserID").DefaultValue = Request.QueryString("UserID")
                Dim dv As Data.DataView = CType(sdGetUserInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If dv.Count > 0 Then
                    If (dv(0)("Status")) Then
                        GlobalModule.SetMessage(lblMessage, True, "This Email address is already verified")
                        ' Dim url As String = ConfigurationManager.AppSettings("site").ToString() & "/Default.aspx"
                        'Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:GoToLogin('" & url & "');", True)
                        hlLogin.Visible = True
                    Else
                        Dim uuid As String = IIf(IsDBNull(dv(0)("uuid")), "", dv(0)("uuid"))
                        If uuid = Request.QueryString("uuid") Then
                            sdGetUserInfo.UpdateParameters.Item("UserID").DefaultValue = dv(0)("UserID")
                            Dim result As Integer = sdGetUserInfo.Update()
                            If result = 1 Then
                                Roles.AddUserToRole(dv(0)("UserName"), "Boarder")
                                Dim boradName As String = Request.QueryString("name")
                                If Not (boradName) Is Nothing Then
                                    If Not (boradName = "") Then
                                        Response.Redirect("~/InvestSignup.aspx?name=" + boradName & "&message=verified", False)
                                    Else
                                        GlobalModule.SetMessage(lblMessage, True, "Your account has been verified successfully.Please click the link below to Login")
                                        hlLogin.Visible = True
                                    End If
                                Else
                                    GlobalModule.SetMessage(lblMessage, True, "Your account has been verified successfully.Please click the link below to Login")
                                    hlLogin.Visible = True
                                End If
                            Else
                                GlobalModule.SetMessage(lblMessage, False, "Error in request, Please try again.")
                            End If
                        Else
                            GlobalModule.SetMessage(lblMessage, False, "Your Request has been expired.")
                        End If

                    End If
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Your Request has been expired.")
                End If
            Else
                GlobalModule.SetMessage(lblMessage, False, "Invalid request")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in User Validation")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class