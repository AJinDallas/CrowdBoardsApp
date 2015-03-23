Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class Boards
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
    Private Sub SendEmailToOwner(ByVal email As String)
        Try
            Dim strSubject As String = "Your CrowdBoard is Approved!"
            Dim toAddress As String = email
            Dim strBody As String = "Congratulations your CrowdBoard has been approved and is now Live, check it out:<a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
            If (toAddress <> "") Then
                GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub grAllBoard_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles grAllBoard.ItemCommand
        Try
            If e.CommandName = RadGrid.ExportToExcelCommandName Then
                grAllBoard.MasterTableView.GetColumn("Action").Visible = False
                grAllBoard.MasterTableView.GetColumn("DeleteBoard").Visible = False
            End If

            If (e.CommandName = "aproveBoards") Then
                Dim hdnOwnerEmail As HiddenField = CType(e.Item.FindControl("hdnOwnerEmail"), HiddenField)
                sdBoardStatus.UpdateParameters("BoardID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdBoardStatus.UpdateParameters("status").DefaultValue = 1
                Dim result = sdBoardStatus.Update()
                If (result = 1) Then
                    If (hdnOwnerEmail.Value <> "") Then
                        SendEmailToOwner(hdnOwnerEmail.Value)
                    End If
                    GlobalModule.SetMessage(lblErrorMessage, True, "Board Approved Successfully")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Activated")
                End If
            ElseIf (e.CommandName = "deactivateBoards") Then
                sdBoardStatus.UpdateParameters("BoardID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdBoardStatus.UpdateParameters("status").DefaultValue = 3
                Dim result = sdBoardStatus.Update()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "Deactivated Successfully")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deactivated")
                End If
            ElseIf (e.CommandName = "DeleteBoard") Then
                sdBoardDelete.SelectParameters.Item("BoardID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                Dim dvResult As Data.DataView = CType(sdBoardDelete.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If Not (dvResult) Is Nothing Then
                    If (dvResult.Count > 0) Then
                        If (Not IsDBNull(dvResult(0)("RESUTL"))) Then
                            GlobalModule.SetMessage(lblErrorMessage, True, "Board Deleted")

                        Else
                            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Borad Deleting")
                        End If
                    End If

                End If
            End If
            grAllBoard.Rebind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class