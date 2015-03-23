Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class Districts
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
    Protected Sub rgDistricts_InsertCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgDistricts.InsertCommand
        Try
            Dim editedItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = editedItem.EditManager
            sdDistricts.InsertParameters.Item("DistrictName").DefaultValue = CType(editMan.GetColumnEditor("DistrictName"), GridTextBoxColumnEditor).Text
            If (CType(editMan.GetColumnEditor("Description"), GridTextBoxColumnEditor).Text = "") Then
                sdDistricts.InsertParameters.Item("Description").DefaultValue = "#"
            Else
                sdDistricts.InsertParameters.Item("Description").DefaultValue = CType(editMan.GetColumnEditor("Description"), GridTextBoxColumnEditor).Text
            End If
            If (CType(editMan.GetColumnEditor("Quotation"), GridTextBoxColumnEditor).Text = "") Then
                sdDistricts.InsertParameters.Item("Quotation").DefaultValue = "#"
            Else
                sdDistricts.InsertParameters.Item("Quotation").DefaultValue = CType(editMan.GetColumnEditor("Quotation"), GridTextBoxColumnEditor).Text
            End If
            Dim ddlUserList As RadDropDownList = CType(e.Item.FindControl("ddlUserList"), RadDropDownList)
            sdDistricts.InsertParameters.Item("Manager").DefaultValue = ddlUserList.SelectedValue

            sdDistricts.Insert()
            GlobalModule.SetMessage(lblErrorMessage, True, "District Added Successfully")
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Creating District")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub rgDistricts_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgDistricts.UpdateCommand
        Try
            Dim edititem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = edititem.EditManager
            sdDistricts.UpdateParameters.Item("DistrictName").DefaultValue = CType(editMan.GetColumnEditor("DistrictName"), GridTextBoxColumnEditor).Text
            sdDistricts.UpdateParameters.Item("Description").DefaultValue = CType(editMan.GetColumnEditor("Description"), GridTextBoxColumnEditor).Text
            sdDistricts.UpdateParameters.Item("Quotation").DefaultValue = CType(editMan.GetColumnEditor("Quotation"), GridTextBoxColumnEditor).Text
            sdDistricts.UpdateParameters.Item("DistrictID").DefaultValue = Convert.ToInt32(edititem.OwnerTableView.DataKeyValues(edititem.ItemIndex)("DistrictID"))
            Dim ddlUserList As RadDropDownList = CType(e.Item.FindControl("ddlUserList"), RadDropDownList)
            sdDistricts.UpdateParameters.Item("Manager").DefaultValue = ddlUserList.SelectedValue
            sdDistricts.Update()
            GlobalModule.SetMessage(lblErrorMessage, True, "District Updated Successfully")
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub rgDistricts_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgDistricts.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
                sdDistricts.DeleteParameters.Item("DistrictID").DefaultValue = Convert.ToInt32(item.OwnerTableView.DataKeyValues(item.ItemIndex)("DistrictID"))
                sdDistricts.Delete()

                Dim hfDistrictID As HiddenField = e.Item.FindControl("hfDistrictID")
                DeleteLogo(hfDistrictID.Value, "DistrictPics")

                lblErrorMessage.Visible = True
                lblErrorMessage.Text = "District Deleted Successfully"
                lblErrorMessage.ForeColor = Drawing.Color.Green
            End If
            If (e.CommandName = "upload") Then
                Dim ruLogo As RadAsyncUpload = e.Item.FindControl("rAsyncUploadDistric")
                If ruLogo.UploadedFiles.Count > 0 Then

                    For Each upFiles As UploadedFile In ruLogo.UploadedFiles
                        If Not (upFiles.GetExtension.ToUpper = ".JPG") Then
                            GlobalModule.SetMessage(lblErrorMessage, False, "Only .jpg files are allowed")
                            Exit Sub
                        End If
                        Dim hfDistrictID As HiddenField = e.Item.FindControl("hfDistrictID")
                        upFiles.SaveAs(Server.MapPath("~/Upload/DistrictPics") & "\\" & hfDistrictID.Value + upFiles.GetExtension)
                        GlobalModule.SetMessage(lblErrorMessage, True, "Logo Uploaded")
                        Exit Sub
                    Next
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Please Select file")

                End If
            End If
            If (e.CommandName = "MoveUp") Then
                ' Dim areaID As HiddenField = e.Item.FindControl("areaIDHiddenField")
                sdDistrictsSortOrder.SelectParameters.Item("Id").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdDistrictsSortOrder.SelectParameters.Item("action").DefaultValue = "MoveUp"
                ' sdDistrictsSortOrder.SelectParameters.Item("areaID").DefaultValue = areaID.Value
                Dim dv As Data.DataView = CType(sdDistrictsSortOrder.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim isSuccess As String
                isSuccess = dv(0)(0).ToString()
                rgDistricts.Rebind()
            End If
            If (e.CommandName = "MoveDown") Then
                'Dim areaID As HiddenField = e.Item.FindControl("areaIDHiddenField")
                sdDistrictsSortOrder.SelectParameters.Item("Id").DefaultValue = Convert.ToInt32(e.CommandArgument.ToString())
                sdDistrictsSortOrder.SelectParameters.Item("action").DefaultValue = "MoveDown"
                'sdDistrictsSortOrder.SelectParameters.Item("areaID").DefaultValue = areaID.Value
                Dim dv As Data.DataView = CType(sdDistrictsSortOrder.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim isSuccess As String
                isSuccess = dv(0)(0).ToString()
                rgDistricts.Rebind()
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Deletion")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub rgDistricts_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgDistricts.ItemDataBound
        Try
            If TypeOf e.Item Is GridDataItem Then
                Dim RadAsyncUpload1 As New RadAsyncUpload()
                RadAsyncUpload1 = DirectCast(e.Item.FindControl("rAsyncUploadDistric"), RadAsyncUpload)
                Dim btnUpload As New Button()
                btnUpload = DirectCast(e.Item.FindControl("btnDistrictUpload"), Button)
                RadAsyncUpload1.Attributes.Add("OnClick", "DistrictUploadButtonClick('" + btnUpload.ClientID + "');")
            End If
            If TypeOf e.Item Is GridEditableItem And e.Item.IsInEditMode Then
                Dim item As GridEditableItem = DirectCast(e.Item, GridEditableItem)
                Dim ddl As RadDropDownList = DirectCast(item.FindControl("ddlUserList"), RadDropDownList)
                ddl.SelectedValue = DirectCast(DataBinder.Eval(e.Item.DataItem, "Manager").ToString(), String)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in District DataBound")
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