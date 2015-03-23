Public Class SiteMaster
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        Try
            'lblMessage.Text = ""
            If Session("userName") Is Nothing Then
                lbtnHome.Visible = False
                lbtnLogout.Visible = False
                lbtnLogin.Visible = True
                lbtnSignMeUp.Visible = True

            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub
    Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
        Response.Redirect("~/Home.aspx")
    End Sub


End Class