Imports System.Web.UI.WebControls
Partial Class publicMaster
    Inherits System.Web.UI.MasterPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim currentURL As String = System.Web.HttpContext.Current.Request.Url.AbsolutePath
        Dim currentPage As String = System.IO.Path.GetFileName(currentURL)
        SetSelected(currentPage)
    End Sub
    Protected Sub btnManageRoles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnManageRoles.Click
        Response.Redirect("~/Admin/AssignRole.aspx")
    End Sub
    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx", False)
    End Sub
    Private Sub SetSelected(ByVal page As String)
        If (page.Contains("Users.aspx")) Then
            lbtnUsers.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("Boards.aspx")) Then
            lbtnBoards.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("Posts.aspx")) Then
            lbtnPosts.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("Districts.aspx")) Then
            lbtnDistricts.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("Areas.aspx")) Then
            lbtnAreas.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("InvestmentTypes.aspx")) Then
            lbtnInvestmentTypes.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("AllImages.aspx")) Then
            lbtnImages.Attributes.Add("style", "color:#99CCFF;")
        ElseIf (page.Contains("IntrestList.aspx")) Then
            lbtnIntrest.Attributes.Add("style", "color:#99CCFF;")
        End If
    End Sub
End Class

