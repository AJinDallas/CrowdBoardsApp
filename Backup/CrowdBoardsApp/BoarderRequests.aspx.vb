Imports System.Web.Script.Serialization
Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Public Class BoarderRequests
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If (Not Page.IsPostBack) Then
            lnkbtnConnect.Attributes.Add("style", "text-decoration:underline")
        End If

        lblMessage.Text = ""
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
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendEmailToUser(ByVal email As String)
        Try
            Dim strSubject As String = "A CrowdBoarder has added you!"
            Dim toAddress As String = email
            Dim strBody As String = "A fellow CrowdBoarder has added you to their Boarders Lineup, login to see who: <a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
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
    'Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
    '    Session.Abandon()
    '    Response.Redirect("~/Default.aspx")
    'End Sub
    'Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
    '    Dim searchBoards = searchBoardsTextBox.Text
    '    Response.Redirect("~/Search.aspx?searchValue=" & searchBoards)
    'End Sub
    'Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
    '    Response.Redirect("~/Home.aspx")
    'End Sub
    Public Function GetnvestorCount(ByVal count As String) As String
        Dim result As String = String.Empty
        Try
            result = result & "Investors: " & count
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String
        Dim result As String = String.Empty
        Try
            result = GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, FilePath, thumbsFilePath)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return result
    End Function
    Protected Sub crowdBoardTeamRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles crowdBoardTeamRepeater.ItemCommand
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
            crowdBoardTeamRepeater.DataBind()
            crowdBoardInvitationsRepeater.DataBind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub crowdBoardTeamRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles crowdBoardTeamRepeater.ItemDataBound
        Try

            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicDiv"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub



    Protected Sub crowdBoardInvitationsRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles crowdBoardInvitationsRepeater.ItemDataBound
        Try

            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName1"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicDiv1"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub


    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function

    Protected Sub lnkbtnConnect_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnConnect.Click
        lnkbtnConnect.Attributes.Add("style", "text-decoration:underline")
        lnkbtnInvitations.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdTeam.Attributes.Add("style", "text-decoration:none")
        MultiViewBoarder.ActiveViewIndex = 0
    End Sub

    Protected Sub lnkbtnInvitations_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnInvitations.Click
        lnkbtnConnect.Attributes.Add("style", "text-decoration:none")
        lnkbtnInvitations.Attributes.Add("style", "text-decoration:underline")
        lnkbtnCrowdTeam.Attributes.Add("style", "text-decoration:none")
        MultiViewBoarder.ActiveViewIndex = 1
    End Sub

    Protected Sub lnkbtnCrowdTeam_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnCrowdTeam.Click
        lnkbtnConnect.Attributes.Add("style", "text-decoration:none")
        lnkbtnInvitations.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdTeam.Attributes.Add("style", "text-decoration:underline")
        MultiViewBoarder.ActiveViewIndex = 2
    End Sub
End Class