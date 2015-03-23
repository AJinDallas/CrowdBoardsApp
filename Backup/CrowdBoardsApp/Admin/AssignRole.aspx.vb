Public Class AssignRole
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If checkIfAdmin() = False Then
            Response.Redirect("~/Home.aspx")
        End If
    End Sub
    Sub grAllUsers_ItemCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles grAllUsers.ItemCommand
        Try
            If (e.CommandName = "IAssignRole") Then
                Dim UserName As String = Convert.ToString(e.CommandArgument)
                RadWindow1.NavigateUrl = "~/Admin/rwAssignRole.aspx?User=" & UserName
                RadWindow1.VisibleOnPageLoad = True
                ' Opend a pop up
                ' Assign Role(UserID, 0)
            End If
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Processing"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub grAllUsers_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles grAllUsers.ItemDataBound
        Try
            If (e.Item.ItemType = Telerik.Web.UI.GridItemType.Item Or e.Item.ItemType = Telerik.Web.UI.GridItemType.AlternatingItem) Then
                Dim lblRoles As Label = TryCast(e.Item.FindControl("lblRoles"), Label)
                Dim hdnUserID As HiddenField = TryCast(e.Item.FindControl("hdnUserID"), HiddenField)
                Dim userRolesList() As String = Roles.GetRolesForUser(hdnUserID.Value)
                If userRolesList.Length > 0 Then
                    lblRoles.Text = [String].Join(",", userRolesList.ToArray())
                End If
            End If
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Loading Data"
            GlobalModule.ErrorLogFile(ex)
        End Try
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
            Throw ex
        End Try
        Return False
    End Function
End Class