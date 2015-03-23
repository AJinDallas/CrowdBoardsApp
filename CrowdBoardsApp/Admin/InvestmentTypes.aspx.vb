Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class InvestmentTypes
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
    Protected Sub rgInvestmentTypes_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgInvestmentTypes.UpdateCommand
        Try
            Dim edititem As GridEditableItem = TryCast(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = edititem.EditManager
            sdInvestmentTypes.UpdateParameters.Item("EnglishName").DefaultValue = CType(editMan.GetColumnEditor("EnglishName"), GridTextBoxColumnEditor).Text
            sdInvestmentTypes.UpdateParameters.Item("EnglishDescription").DefaultValue = CType(editMan.GetColumnEditor("EnglishDescription"), GridTextBoxColumnEditor).Text
            sdInvestmentTypes.UpdateParameters.Item("ShortEnglishDesc").DefaultValue = CType(editMan.GetColumnEditor("ShortEnglishDesc"), GridTextBoxColumnEditor).Text
            sdInvestmentTypes.UpdateParameters.Item("Value").DefaultValue = Convert.ToInt32(edititem.OwnerTableView.DataKeyValues(edititem.ItemIndex)("Value"))
            Dim ddlModel As RadDropDownList = CType(e.Item.FindControl("ddlModel"), RadDropDownList)
            Dim strModel As String = ddlModel.SelectedValue
            If strModel = "--Select Model--" Then
                sdInvestmentTypes.UpdateParameters.Item("WePayModel").DefaultValue = ""
            Else
                sdInvestmentTypes.UpdateParameters.Item("WePayModel").DefaultValue = strModel
            End If
            sdInvestmentTypes.Update()
            GlobalModule.SetMessage(lblErrorMessage, True, "Investment Type  Updated Successfully")
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Update")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub rgInvestmentTypes_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rgInvestmentTypes.ItemDataBound
        Try
            If TypeOf e.Item Is GridEditableItem And e.Item.IsInEditMode Then
                Dim item As GridEditableItem = DirectCast(e.Item, GridEditableItem)
                Dim ddl As RadDropDownList = DirectCast(item.FindControl("ddlModel"), RadDropDownList)
                ddl.SelectedValue = DirectCast(DataBinder.Eval(e.Item.DataItem, "WePayModel").ToString(), String)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Protected Sub rgInvestmentTypes_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgInvestmentTypes.ItemCommand
        Try

            If (e.CommandName = "upload") Then
                Dim ruImage As RadUpload = e.Item.FindControl("ruImage")
                If ruImage.UploadedFiles.Count > 0 Then
                    For Each upFiles As UploadedFile In ruImage.UploadedFiles
                        Dim hfValue As HiddenField = e.Item.FindControl("hfValue")
                        upFiles.SaveAs(Server.MapPath("~/Upload/InvestmentTypePics") & "\\" & hfValue.Value + upFiles.GetExtension)
                        GlobalModule.SetMessage(lblErrorMessage, True, "Image Uploaded")
                        Exit Sub
                    Next
                Else
                    GlobalModule.SetMessage(lblErrorMessage, False, "Please Select file")
                End If
            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
End Class