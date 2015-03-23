Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SetActiveLink()
        If Not Page.IsPostBack Then
            lblMessage.Text = ""
            If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
                lbtlogout.Visible = False
                ' Response.Redirect("~/Default.aspx", False)
                Exit Sub
            Else
                lbtlogout.Visible = True
                isAdminli.Visible = checkIfAdmin()
                Session("cssNews") = ""
                Session("cssSearch") = ""
                Session("cssHome") = ""
                LoadData()
                LoadNotificationData()
                LoadPendingRequestData()
            End If
        End If
    End Sub
    Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
        Dim searchBoards = searchBoardsTextBox.Value
        Response.Redirect("~/SiteSearch.aspx?searchValue=" & searchBoards)
    End Sub
    Protected Sub lbtlogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtlogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub


    Private Function checkIfAdmin() As Boolean
        Try
            If (Session("userName")) Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
                Exit Function
            End If
            Dim roles() As String = System.Web.Security.Roles.GetRolesForUser(Session("userName").ToString())
            If Not (roles) Is Nothing Then
                If (roles.Length > 0) Then
                    For Each Item As String In roles
                        If Item = "Admin" Then
                            Return True
                        End If
                    Next
                End If
            End If
        Catch ex As Exception
            Throw ex

        End Try
        Return False
    End Function
    Private Sub LoadData()
        Try

            Dim dv4 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)

            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("MessageCount"))) Then
                        lblUpdates.Text = "(" & dv4(0)("MessageCount").ToString() & ")"
                    Else
                        lblUpdates.Text = "(" + "0" + ")"
                    End If

                End If
            Else
                lblUpdates.Text = "(" + "0" + ")"
            End If


        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function


    Private Sub LoadNotificationData()
        Try
            sdNotifications.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdNotifications.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn") '"06/07/2013"
            sdRecentActivityOnBoards.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdRecentActivityOnBoards.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn") '"06/07/2013"  
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
            countNotification.Text = "(" & dv3.Count + dv4.Count & ")"
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub boardersRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles boardersRepeater.ItemCommand
        Try
            If (e.CommandName = "IAccept") Then
                Dim requesterEmailID As HiddenField = CType(e.Item.FindControl("requesterEmailID"), HiddenField)
                Dim userID1 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdPendingRequests.UpdateParameters.Item("userID1").DefaultValue = userID1
                Dim result As Integer = sdPendingRequests.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request accepted")
                    If (requesterEmailID.Value <> "") Then
                        SendEmailToUser(requesterEmailID.Value)
                    End If

                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in accepting  Request")
                End If
            ElseIf (e.CommandName = "IDecline") Then
                Dim userID1 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdRejectRequest.UpdateParameters.Item("userID1").DefaultValue = userID1
                Dim result As Integer = sdRejectRequest.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request declined")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in rejecting  Request")
                End If

            End If
            boardersRepeater.DataBind()
            LoadData()
            LoadPendingRequestData()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendEmailToUser(ByVal email As String)
        Try
            Dim strSubject As String = "A CrowdBoarder has added you!"
            Dim toAddress As String = email
            Dim strBody As String = "A fellow CrowdBoarder has added you to their Boarders Lineup, login to see who: <a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + ">" + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub crowdBoardInvitationsRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles crowdBoardInvitationsRepeater.ItemCommand
        Try
            If (e.CommandName = "IAccept") Then
                Dim BoardID As Int32 = Convert.ToInt32(e.CommandArgument())
                sdsCrowdBoardInvites.UpdateParameters.Item("BoardID").DefaultValue = BoardID
                Dim result As Integer = sdsCrowdBoardInvites.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request accepted")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in accepting  Request")
                End If
            ElseIf (e.CommandName = "IDecline") Then
                Dim BoardID As Int32 = Convert.ToInt32(e.CommandArgument())
                sdRejectCrowdboardTeamRequest.UpdateParameters.Item("BoardID").DefaultValue = BoardID
                Dim result As Integer = sdRejectCrowdboardTeamRequest.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request declined")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in rejecting  Request")
                End If

            End If
            crowdBoardInvitationsRepeater.DataBind()
            LoadData()
            LoadPendingRequestData()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Private Sub LoadPendingRequestData()
        Try
            Dim dv4 As DataView = CType(sdRejectRequest.Select(DataSourceSelectArguments.Empty), DataView)
            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("RequestCount"))) Then
                        requestsCountLabel.Text = "(" & dv4(0)("RequestCount").ToString() & ")"
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub liCrowdNews_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liCrowdNews.Click
        Session("cssNews") = "focus"
        Session("cssSearch") = ""
        Session("cssHome") = ""
        DirectCast(FindControl("liCrowdNews"), LinkButton).Attributes.Add("class", "focus")
        Response.Redirect("CrowdNews.aspx")
    End Sub

    Protected Sub liSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liSearch.Click
        Session("cssSearch") = "focus"
        Session("cssNews") = ""
        Session("cssHome") = ""
        DirectCast(FindControl("liSearch"), LinkButton).Attributes.Add("class", "focus")
        Response.Redirect("Search.aspx")
    End Sub

    Protected Sub liHome_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liHome.Click
        Session("cssHome") = "focus"
        Session("cssNews") = ""
        Session("cssSearch") = ""
        DirectCast(FindControl("liHome"), LinkButton).Attributes.Add("class", "focus")
        Response.Redirect("Home.aspx")
    End Sub

    Private Sub SetActiveLink()
        Try
            If Not (Session("cssHome") = "") Then
                DirectCast(FindControl("liHome"), LinkButton).Attributes.Add("class", "focus")
            ElseIf Not (Session("cssSearch") = "") Then
                DirectCast(FindControl("liSearch"), LinkButton).Attributes.Add("class", "focus")
            ElseIf Not (Session("cssNews") = "") Then
                DirectCast(FindControl("liCrowdNews"), LinkButton).Attributes.Add("class", "focus")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class