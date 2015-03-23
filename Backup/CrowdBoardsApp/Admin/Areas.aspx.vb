Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class Areas
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
    Protected Sub rgAreas_InsertCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgAreas.InsertCommand
        Try
            Dim editedItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = editedItem.EditManager
            If Not CType(editMan.GetColumnEditor("AreaName"), GridTextBoxColumnEditor).Text = "" Then
                If Not DirectCast(editMan.GetColumnEditor("districtID"), GridDropDownColumnEditor).SelectedIndex = 0 Then
                    sdAreas.InsertParameters.Item("AreaName").DefaultValue = CType(editMan.GetColumnEditor("AreaName"), GridTextBoxColumnEditor).Text
                    sdAreas.InsertParameters.Item("districtID").DefaultValue = DirectCast(editMan.GetColumnEditor("districtID"), GridDropDownColumnEditor).SelectedValue
                    sdAreas.Insert()
                    GlobalModule.SetMessage(lblErrorMessage, True, "Area Added Successfully")

                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Please Select District first")
                End If
            Else
                GlobalModule.SetMessage(lblErrorMessage, False, "Area is Blank")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Creating Area")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub rgAreas_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgAreas.UpdateCommand
        Try
            Dim edititem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = edititem.EditManager
            sdAreas.UpdateParameters.Item("AreaName").DefaultValue = CType(editMan.GetColumnEditor("AreaName"), GridTextBoxColumnEditor).Text
            sdAreas.UpdateParameters.Item("areaID").DefaultValue = Convert.ToInt32(edititem.OwnerTableView.DataKeyValues(edititem.ItemIndex)("areaID"))
            sdAreas.UpdateParameters.Item("districtID").DefaultValue = DirectCast(editMan.GetColumnEditor("districtID"), GridDropDownColumnEditor).SelectedValue
            sdAreas.Update()
            GlobalModule.SetMessage(lblErrorMessage, True, "Area  Updated Successfully")
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub rgAreas_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgAreas.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                sdAreas.DeleteParameters.Item("areaID").DefaultValue = Convert.ToInt32(item.OwnerTableView.DataKeyValues(item.ItemIndex)("areaID"))
                sdAreas.Delete()
                Dim hfareaID As HiddenField = e.Item.FindControl("hfareaID")
                DeleteLogo(hfareaID.Value, "AreasPics")
                lblErrorMessage.Visible = True
                lblErrorMessage.Text = "Area Deleted Successfully"
                lblErrorMessage.ForeColor = Drawing.Color.Green
            End If
            If (e.CommandName = "upload") Then
                Dim ruLogo As RadAsyncUpload = e.Item.FindControl("RadAsyncUpload1")
                If ruLogo.UploadedFiles.Count > 0 Then
                    For Each upFiles As UploadedFile In ruLogo.UploadedFiles
                        If Not (upFiles.GetExtension.ToUpper = ".JPG") Then
                            GlobalModule.SetMessage(lblErrorMessage, False, "Only .jpg files are allowed")
                            Exit Sub
                        End If
                        Dim hfareaID As HiddenField = e.Item.FindControl("hfareaID")
                        upFiles.SaveAs(Server.MapPath("~/Upload/AreasPics") & "\\" & hfareaID.Value + upFiles.GetExtension)
                        GlobalModule.SetMessage(lblErrorMessage, True, "Logo Uploaded")
                        Exit Sub
                    Next
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Please Select file")
                End If
            End If
            If (e.CommandName = "MoveUp") Then
                Dim districtID As HiddenField = e.Item.FindControl("districtIDHiddenField")
                sdAreaSortOrder.SelectParameters.Item("Id").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdAreaSortOrder.SelectParameters.Item("action").DefaultValue = "MoveUp"
                sdAreaSortOrder.SelectParameters.Item("districtID").DefaultValue = districtID.Value
                Dim dv As Data.DataView = CType(sdAreaSortOrder.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim isSuccess As String
                isSuccess = dv(0)(0).ToString()
                rgAreas.Rebind()
            End If
            If (e.CommandName = "MoveDown") Then
                Dim districtID As HiddenField = e.Item.FindControl("districtIDHiddenField")
                sdAreaSortOrder.SelectParameters.Item("Id").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdAreaSortOrder.SelectParameters.Item("action").DefaultValue = "MoveDown"
                sdAreaSortOrder.SelectParameters.Item("districtID").DefaultValue = districtID.Value
                Dim dv As Data.DataView = CType(sdAreaSortOrder.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim isSuccess As String
                isSuccess = dv(0)(0).ToString()
                rgAreas.Rebind()
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Operation")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub rgAreas_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgAreas.ItemDataBound
        Try
            If TypeOf e.Item Is GridDataItem Then
                Dim RadAsyncUpload1 As New RadAsyncUpload()
                RadAsyncUpload1 = DirectCast(e.Item.FindControl("RadAsyncUpload1"), RadAsyncUpload)
                Dim btnUpload As New Button()
                btnUpload = DirectCast(e.Item.FindControl("btnUpload"), Button)
                RadAsyncUpload1.Attributes.Add("OnClick", "UploadButtonClick('" + btnUpload.ClientID + "');")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Area DataBound")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub DeleteLogo(ByVal ID As String, ByVal Folder As String)
        Try
            Dim strPath As String = Server.MapPath("~/Upload/" & Folder & "\\" & ID & ".jpg")
            System.IO.File.Delete(strPath)
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deleting File")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class