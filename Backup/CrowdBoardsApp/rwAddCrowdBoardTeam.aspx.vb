Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik

Public Class rwAddCrowdBoardTeam
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            Session("searchKeyWord") = "%"
        End If
    End Sub

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Protected Sub btnSendrRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendrRequest.Click
        Try
            If nonFriendDatalist.Items.Count > 0 Then
                For Each dli As DataListItem In nonFriendDatalist.Items
                    If dli.ItemType = ListItemType.Item OrElse dli.ItemType = ListItemType.AlternatingItem Then
                        Dim cbuser As CheckBox = TryCast(dli.FindControl("cbuser"), CheckBox)
                        Dim hdnMemberID As HiddenField = TryCast(dli.FindControl("hdnMemberID"), HiddenField)
                        If cbuser.Checked Then
                            Dim requestStatus As Integer = CheckRequest(hdnMemberID.Value)
                            If (requestStatus = 3) Then
                                sdCrowdBoardTeam.InsertParameters.Item("BoardID").DefaultValue = Request.QueryString("BoardID")
                                sdCrowdBoardTeam.InsertParameters.Item("MemberID").DefaultValue = hdnMemberID.Value
                                sdCrowdBoardTeam.Insert()
                            ElseIf requestStatus = 2 Then
                                sdCrowdBoardTeam.UpdateParameters.Item("BoardID").DefaultValue = Request.QueryString("BoardID")
                                sdCrowdBoardTeam.UpdateParameters.Item("MemberID").DefaultValue = hdnMemberID.Value
                                sdCrowdBoardTeam.Update()
                            End If
                            GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                        End If
                    End If
                Next
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnSearchBoarder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchBoarder.Click
        Try
            If txtSearchBoarders.Text = "" Then
                Session("searchKeyWord") = "%"
            Else
                Session("searchKeyWord") = txtSearchBoarders.Text
            End If
            nonFriendDatalist.DataBind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Function CheckRequest(ByVal memberID As Integer) As Integer
        Dim status As Integer
        Try
            sdCrowdBoardTeam.SelectParameters.Item("BoardID").DefaultValue = Request.QueryString("BoardID")
            sdCrowdBoardTeam.SelectParameters.Item("MemberID").DefaultValue = memberID
            Dim dv As Data.DataView = CType(sdCrowdBoardTeam.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                status = dv(0)("status")
            Else
                status = 3
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
End Class