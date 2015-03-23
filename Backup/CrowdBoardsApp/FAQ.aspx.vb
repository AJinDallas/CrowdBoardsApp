Public Class FAQ
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        Try
            
        Catch ex As Exception

        End Try
    End Sub
    
End Class