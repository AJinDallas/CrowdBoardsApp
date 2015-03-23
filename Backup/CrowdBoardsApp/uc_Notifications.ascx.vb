Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports System.Web.Script.Serialization
Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports WePaySDK
Public Class uc_Notifications
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
        '    Response.Redirect("~/Default.aspx", False)
        'End If
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub
    Private Sub LoadData()
        Try
            sdNotifications.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdNotifications.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn")
            sdRecentActivityOnBoards.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdRecentActivityOnBoards.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn")
            Dim dv3 As DataView = CType(sdNotifications.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv4 As DataView = CType(sdRecentActivityOnBoards.Select(DataSourceSelectArguments.Empty), DataView)
            If (dv3 Is Nothing) Or (dv4 Is Nothing) Then
                Exit Sub
            End If
            If dv3.Count > 0 Then
                notificationsRepeater.DataSource = dv3
                notificationsRepeater.DataBind()
            End If

            If dv4.Count > 0 Then
                recentActivityOnBoardsRepeater.DataSource = dv4
                recentActivityOnBoardsRepeater.DataBind()
            End If
            lblUpdates.Text = "(" & dv3.Count + dv4.Count & ")"
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class