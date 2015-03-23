Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwAssignRole
    Inherits Telerik.Web.UI.RadAjaxPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try


            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
            End If
            If (Not IsPostBack) Then
                BindRolesCheckboxList()
                AssignedUserRoles()
            End If
            lblErrorMessage.Visible = False
            lblSuccessMessage.Visible = False
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Loading Data"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnAssignRole_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAssignRole.Click
        Try
            AssignRoleToUser()
            RadAjaxManager1.ResponseScripts.Add(" Ok();")
        Catch ex As Exception
            lblErrorMessage.Visible = True
            lblErrorMessage.Text = "Error in Assigning Roles"
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        RadAjaxManager1.ResponseScripts.Add(" Ok();")
    End Sub
    Protected Sub AssignRoleToUser()
        Try
            Dim username As String = Request.QueryString("User")
            Dim userRolesList() As String = Roles.GetRolesForUser(username)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    Roles.RemoveUserFromRole(username, item)
                Next
                For Each item As ListItem In cblRoles.Items
                    If item.Selected = True Then
                        Dim roleName As String = item.Text
                        Roles.AddUserToRole(username, roleName)
                    End If
                Next
            Else
                For Each item As ListItem In cblRoles.Items
                    If item.Selected = True Then
                        Dim roleName As String = item.Text
                        Roles.AddUserToRole(username, roleName)
                    End If
                Next
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub AssignedUserRoles()
        Try
            Dim username As String = Request.QueryString("User")
            Dim userRolesList() As String = Roles.GetRolesForUser(username)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    For Each listItem As ListItem In cblRoles.Items
                        If (item = listItem.Text) Then
                            listItem.Selected = True
                        End If
                    Next
                Next

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub BindRolesCheckboxList()
        Try
            Dim dv As Data.DataView = CType(sdRoles.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                cblRoles.DataSource = dv
                cblRoles.DataTextField = "RoleName"
                cblRoles.DataValueField = "RoleID"
                cblRoles.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class