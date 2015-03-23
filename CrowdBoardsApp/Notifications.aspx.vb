Public Class Notifications
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageRecent.Text = ""
        If (Not Page.IsPostBack) Then
            LoadData()
        End If
    End Sub
    'Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
    '    Dim searchBoards = searchBoardsTextBox.Text
    '    Response.Redirect("~/Search.aspx?searchValue=" & searchBoards)
    'End Sub
    Private Sub LoadData()
        Try
            sdNotifications.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdNotifications.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn")
            sdRecentActivityOnBoards.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdRecentActivityOnBoards.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn")
            sdNotificationsAll.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdBoardActivitiesAll.SelectParameters.Item("userID").DefaultValue = Session("userID")
            Dim dv3 As DataView = CType(sdNotifications.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv4 As DataView = CType(sdRecentActivityOnBoards.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv1 As DataView = CType(sdNotificationsAll.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv2 As DataView = CType(sdBoardActivitiesAll.Select(DataSourceSelectArguments.Empty), DataView)
            If (dv3 Is Nothing) And (dv4 Is Nothing) Then
                Exit Sub
            End If
            If Not (dv3 Is Nothing) Then
                If dv3.Count > 0 Then
                    notificationsRepeater.DataSource = dv3
                    notificationsRepeater.DataBind()
                End If
            End If

            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    recentActivityOnBoardsRepeater.DataSource = dv4
                    recentActivityOnBoardsRepeater.DataBind()
                End If
            End If
            If (dv3.Count + dv4.Count = 0) Then
                lblMessageRecent.Text = "No recent notifications"
            End If
            If Not (dv1 Is Nothing) Then
                If dv1.Count > 0 Then
                    notificationsDataListFull.DataSource = dv1
                    notificationsDataListFull.DataBind()
                End If
            End If
            If Not (dv2 Is Nothing) Then
                If dv2.Count > 0 Then
                    activityOnBoardsDataList.DataSource = dv2
                    activityOnBoardsDataList.DataBind()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Public Function CheckNull(ByVal activityDate As Object) As String
        If IsDBNull(activityDate) Then
            Return ""
        Else
            Return (Convert.ToDateTime(activityDate).ToString("MM/dd/yyyy"))
        End If

    End Function
    'Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
    '    Response.Redirect("~/Home.aspx")
    'End Sub
    'Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
    '    Session.Abandon()
    '    Response.Redirect("~/Default.aspx")
    'End Sub
End Class