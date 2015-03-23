Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class Posts
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If checkIfAdmin() = False Then
            Response.Redirect("~/Home.aspx")
        End If
        lblErrorMessage.Text = ""
    End Sub
    Private Function checkIfAdmin() As Boolean
        Try
            Dim roles() As String = System.Web.Security.Roles.GetRolesForUser(Session("userName").ToString())
            For Each Item As String In roles
                If Item = "Admin" Then
                    Return True
                End If
            Next
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return False
    End Function
    Protected Sub allPostsRadGrid_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles allPostsRadGrid.ItemCommand
        Try
            If (e.CommandName = "DeletePost") Then
                Dim postID = Convert.ToInt32(e.CommandArgument.ToString())
                sdsUserPosts.DeleteParameters.Item("PostID").DefaultValue = postID
                Dim result = sdsUserPosts.Delete()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "Post Deleted Successfully")
                    allPostsRadGrid.Rebind()
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deleting Post")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deleting")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub allPostsRadGrid_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles allPostsRadGrid.UpdateCommand
        Try
            Dim edititem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = edititem.EditManager
            sdsUserPosts.UpdateParameters.Item("Text").DefaultValue = CType(editMan.GetColumnEditor("Text"), GridTextBoxColumnEditor).Text
            sdsUserPosts.UpdateParameters.Item("PostID").DefaultValue = Convert.ToInt32(edititem.OwnerTableView.DataKeyValues(edititem.ItemIndex)("PostID"))
            Dim result = sdsUserPosts.Update()

            If result = 1 Then
                GlobalModule.SetMessage(lblErrorMessage, True, "Post Updated Successfully")
            Else
                GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            End If
            allPostsRadGrid.Rebind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub commentsRadGrid_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles commentsRadGrid.UpdateCommand
        Try
            Dim edititem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = edititem.EditManager
            sdsComments.UpdateParameters.Item("Comment").DefaultValue = CType(editMan.GetColumnEditor("Comment"), GridTextBoxColumnEditor).Text
            sdsComments.UpdateParameters.Item("ReplyID").DefaultValue = Convert.ToInt32(edititem.OwnerTableView.DataKeyValues(edititem.ItemIndex)("ReplyID"))
            Dim result = sdsComments.Update()

            If result = 1 Then
                GlobalModule.SetMessage(lblErrorMessage, True, "Comment Updated Successfully")
            Else
                GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            End If
            commentsRadGrid.Rebind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub commentsRadGrid_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles commentsRadGrid.ItemCommand
        Try
            If (e.CommandName = "DeleteComment") Then
                Dim replyID = Convert.ToInt32(e.CommandArgument.ToString())
                sdsComments.DeleteParameters.Item("ReplyID").DefaultValue = replyID
                Dim result = sdsComments.Delete()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "Comment Deleted Successfully")
                    commentsRadGrid.Rebind()
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deleting Comment")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deleting")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class