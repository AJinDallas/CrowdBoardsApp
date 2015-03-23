Public Class WhatIs
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            lbtnHome.Visible = False
            lbtnLogout.Visible = False
            lbtnLogin.Visible = True
            lbtnSignMeUp.Visible = True
            updatesDiv.Visible = False
        End If
    End Sub
    Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub
    Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
        Response.Redirect("~/Home.aspx")
    End Sub
End Class