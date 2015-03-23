Public Class uc_PendingRequests
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If
        lblMessage.Text = ""
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub
    Private Sub LoadData()
        Try
            Dim dv4 As DataView = CType(sdRejectRequest.Select(DataSourceSelectArguments.Empty), DataView)
            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("RequestCount"))) Then
                        lblUpdates.Text = "(" & dv4(0)("RequestCount").ToString() & ")"
                    End If
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
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class