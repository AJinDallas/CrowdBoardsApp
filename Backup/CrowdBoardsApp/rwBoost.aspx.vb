Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Imports ASPSnippets.FaceBookAPI

Public Class rwBoost
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Public returnUrl As String
    Public fbCall As New FaceBookConnect
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        returnUrl = "" & System.Configuration.ConfigurationManager.AppSettings("returnURL")
        Try
            If Session("userName") Is Nothing Then
                RadAjaxManager1.ResponseScripts.Add(" Ok();")
            ElseIf (String.IsNullOrEmpty(Request.QueryString("PostID"))) Then
                RadAjaxManager1.ResponseScripts.Add(" Ok();")
            End If
           
            If (Not IsPostBack) Then
                hdnPostId.Value = Request.QueryString("PostID").ToString()
            End If
            lblErrorMessage.Visible = False
            lblSuccessMessage.Visible = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Loading Data")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub btnShare_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShare.Click
        Try
            If Not Session("userID") Is Nothing Then
                If (Not String.IsNullOrEmpty(Request.QueryString("PostID"))) Then
                    share()
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnFacebookShare_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFacebookShare.Click
        Try
            Session("IsFbShare") = Request.QueryString("PostID").ToString()
            RadAjaxManager1.ResponseScripts.Add(" Ok();")
            FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))

        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        RadAjaxManager1.ResponseScripts.Add(" Ok();")
    End Sub
    Protected Sub share()
        Try

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class