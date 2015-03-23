Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class Users
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

    Protected Sub grAllUsers_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles grAllUsers.ItemCommand
        Try
            If (e.CommandName = "deactivateUsers") Then
                sdUsersStatus.UpdateParameters("UserID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdUsersStatus.UpdateParameters("status").DefaultValue = False
                Dim result = sdUsersStatus.Update()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "Deactivated Successfully")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deactivated")

                End If

            ElseIf (e.CommandName = "activateUsers") Then
                sdUsersStatus.UpdateParameters("UserID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdUsersStatus.UpdateParameters("status").DefaultValue = True
                Dim result = sdUsersStatus.Update()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "Activated Successfully")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in Activated")

                End If

            ElseIf (e.CommandName = "unlockUsers") Then
                sdUsersAccountStatus.UpdateParameters("memberID").DefaultValue = e.CommandArgument.ToString()

                Dim result = sdUsersAccountStatus.Update()
                If (result = 1) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "User's account unlocked Successfully")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in unlocked Account")

                End If

            ElseIf (e.CommandName = "deleteUser") Then
                sdUsersDelete.SelectParameters.Item("userID").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                Dim dv1 As Data.DataView = CType(sdUsersDelete.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim resutl As String = String.Empty
                If Not dv1 Is Nothing Then
                    If dv1.Count > 0 Then
                        If (Not IsDBNull(dv1(0)("result"))) Then
                            resutl = dv1(0)("result")
                        End If
                    End If
                End If

                If (resutl = String.Empty) Then
                    GlobalModule.SetMessage(lblErrorMessage, True, "User's account unlocked Successfully")

                ElseIf (resutl = "EXISTS") Then

                    GlobalModule.SetMessage(lblErrorMessage, False, "Cannot delete user because one or more boards of this user has investments available")
                ElseIf (resutl = "Error") Then

                    GlobalModule.SetMessage(lblErrorMessage, False, "Error in user deleting ")
                Else
                    GlobalModule.SetMessage(lblErrorMessage, True, "User deleted")

                End If
            End If


            grAllUsers.Rebind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub




    Protected Sub grAllUsers_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles grAllUsers.ItemDataBound

        'Check the formatting condition
        Try
            'Is it a GridDataItem
            If (TypeOf (e.Item) Is GridDataItem) Then
                'Get the instance of the right type
                Dim dataBoundItem As GridDataItem = e.Item

                Dim activeBtn As LinkButton = DirectCast(e.Item.FindControl("btnActivateUser"), LinkButton)
                Dim deActiveBtn As LinkButton = DirectCast(e.Item.FindControl("btnUserStatus"), LinkButton)
                If (deActiveBtn.Visible) Then
                    activeBtn.Visible = False
                Else
                    activeBtn.Visible = True
                End If
            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub



End Class