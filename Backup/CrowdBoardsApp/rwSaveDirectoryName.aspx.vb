Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Partial Class rwSaveDirectory
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        
    End Sub

    Private Sub SaveChanges()
        Try
            sdBoard.UpdateParameters.Item("DirectoryName").DefaultValue = txtDirectoryName.Text.Trim()
            sdBoard.UpdateParameters.Item("BoardId").DefaultValue = Session("boardID").ToString()
            sdBoard.Update()
            RadAjaxManager1.ResponseScripts.Add(" Ok();")
        Catch ex As Exception
            lblErrorMessageForm.Text = "Error in Update"
            GlobalModule.ErrorLogFile(ex)
            Exit Sub
        End Try
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        SaveChanges()
    End Sub
End Class