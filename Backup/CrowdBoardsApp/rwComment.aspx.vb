Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwComment
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
            End If
            If (Not IsPostBack) Then

            End If
            lblErrorMessage.Visible = False
            lblSuccessMessage.Visible = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Loading Data")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Try
            If Not Session("userID") Is Nothing Then
                If (Not String.IsNullOrEmpty(Request.QueryString("PostID"))) Then
                    AddComment()
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Posting Comment")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        RadAjaxManager1.ResponseScripts.Add(" Ok();")
    End Sub
    Protected Sub AddComment()
        Try
            If txtComment.Text.Trim() <> "" Then
                sdPostReplies.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
                sdPostReplies.InsertParameters.Item("PostID").DefaultValue = Request.QueryString("PostID")
                sdPostReplies.InsertParameters.Item("Comment").DefaultValue = txtComment.Text
                sdPostReplies.Insert()
                txtComment.Text = ""
                GlobalModule.SetMessage(lblSuccessMessage, True, "Comment added Successfully")
            Else
                GlobalModule.SetMessage(lblErrorMessage, False, "Please Enter Comment")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class