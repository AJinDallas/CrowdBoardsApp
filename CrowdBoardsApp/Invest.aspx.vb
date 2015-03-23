
Partial Class Invest
    Inherits Telerik.Web.UI.RadAjaxPage
    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Response.Redirect("~/Board.aspx?Name=" + Request.QueryString("Name"))
    End Sub
    
End Class
