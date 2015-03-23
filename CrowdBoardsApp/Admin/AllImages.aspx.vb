Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class AllImages
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property dtAllImages() As DataTable
        Get
            Return CType(ViewState("_dtAllImages"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("_dtAllImages") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If checkIfAdmin() = False Then
            Response.Redirect("~/Home.aspx")
        End If
        lblErrorMessage.Text = ""
        If (Not Page.IsPostBack) Then
            Try
                InitializeDataTable()
                LoadAllImages()
                Dim us As Integer = GetUserIdByDirectoryName("christian's-cb")
            Catch ex As Exception
                GlobalModule.SetMessage(lblErrorMessage, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
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
    Protected Sub InitializeDataTable()
        Try
            Dim dt As New DataTable
            dt.Columns.Add("FileName", GetType(String))
            dt.Columns.Add("ImageUrl", GetType(String))
            dt.Columns.Add("UserID", GetType(Integer))
            dt.Columns.Add("UserName", GetType(String))
            dt.Columns.Add("DateUploaded", GetType(Date))
            dt.Columns.Add("ImageType", GetType(String))
            dt.Columns.Add("DirectoryName", GetType(String))
            Me.dtAllImages = dt.Copy()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub AddRow(ByVal directoryName As String, ByVal fileName As String, ByVal imageUrl As String, ByVal UserID As Integer, ByVal UserName As String, ByVal dateUploaded As Date, ByVal imageType As String)
        Try
            Dim dr As DataRow = Me.dtAllImages.NewRow
            dr("DirectoryName") = directoryName
            dr("FileName") = fileName
            dr("ImageUrl") = imageUrl
            dr("UserID") = UserID
            dr("UserName") = UserName
            dr("DateUploaded") = dateUploaded
            dr("ImageType") = imageType
            Me.dtAllImages.Rows.Add(dr)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadAllImages()
        Try
            Dim dv As Data.DataView = CType(sdAllImages.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                For Each rowView As DataRowView In dv
                    Dim row As DataRow = rowView.Row
                    Dim url As String = String.Empty
                    If (IsGraphicsFile(row("AttachedFileName").ToString())) Then
                        If (row("ImageType") = "User Post") Then
                            url = "~/Upload/UserPostsFiles/" & row("AttachedFileName")
                        ElseIf (row("ImageType") = "Message") Then
                            url = "~/Upload/MessageFiles/" & row("AttachedFileName")
                        ElseIf (row("ImageType") = "Board Files") Then
                            url = "~/Upload/BoardDirectory/" & row("DirectoryName") & "/" & row("AttachedFileName")
                        End If
                        AddRow(row("DirectoryName"), row("AttachedFileName"), url, row("UserID"), row("UserName"), row("DatePosted"), row("ImageType"))
                    End If
                Next
            End If
            AddImagesToDataTable("~/Upload/BoardBackgroundPics", "Board")
            AddImagesToDataTable("~/Upload/BoardCoverPics", "Board")
            AddImagesToDataTable("~/thumbnail", "Board")
            AddImagesToDataTable("~/Upload/ProfilePics", "User")
            AddImagesToDataTable("~/Upload/BackgroundPics", "User")
            Dim dataView As New DataView
            dataView = Me.dtAllImages.DefaultView
            dataView.Sort = "DateUploaded desc"
            allImagesGrid.DataSource = dataView
            allImagesGrid.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function IsGraphicsFile(ByVal Filename As String) As Boolean
        Filename = Filename.ToLower()
        If InStr(Filename, ".jpg") Or InStr(Filename, ".jpeg") Or _
           InStr(Filename, ".gif") Or InStr(Filename, ".bmp") Or InStr(Filename, ".png") Then
            Return True
        Else
            Return False
        End If
    End Function
    Private Sub AddImagesToDataTable(ByVal directoryName As String, ByVal directoryType As String)
        Try
            Dim type As String = GetFolderType(directoryName, directoryType)
            Dim directory As New IO.DirectoryInfo(Server.MapPath(directoryName))
            Dim allFiles As IO.FileInfo() = directory.GetFiles()
            Dim file As IO.FileInfo
            For Each file In allFiles
                If file.Exists Then
                    If (IsGraphicsFile(file.Name)) Then
                        If Not (file.Name.Contains("noimage")) Then
                            Dim userI As Integer
                            Dim userN As String
                            If directoryType = "User" Then
                                userI = GetUserIdByUserName(file.Name.Replace(file.Extension, ""))
                                userN = file.Name.Replace(file.Extension, "")
                            Else
                                userI = GetUserIdByDirectoryName(file.Name.Replace(file.Extension, ""))
                                userN = GetUserNameByDirectoryName(file.Name.Replace(file.Extension, ""))
                            End If
                            If (userI <> 0 And userN <> "") Then
                                AddRow("", file.Name, directoryName & "/" & file.Name, userI, userN, file.CreationTime, type)
                            End If
                        End If
                    End If
                End If
            Next
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Function GetUserIdByDirectoryName(ByVal directoryName As String) As Integer
        Dim userID As Integer = 0
        Try
            sdGetUserDetailsByDirectoryName.SelectParameters.Item("DirectoryName").DefaultValue = directoryName
            Dim dv As Data.DataView = CType(sdGetUserDetailsByDirectoryName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("UserID"))) Then
                        userID = dv(0)("UserID").ToString()
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function
    Protected Function GetUserNameByDirectoryName(ByVal directoryName As String) As String
        Dim userName As String = String.Empty
        Try
            sdGetUserDetailsByDirectoryName.SelectParameters.Item("DirectoryName").DefaultValue = Replace(directoryName, "'", "''")
            Dim dv As Data.DataView = CType(sdGetUserDetailsByDirectoryName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("UserName"))) Then
                        userName = dv(0)("UserName").ToString()
                    End If
                End If
            End If
          
        Catch ex As Exception
            Throw ex
        End Try
        Return userName
    End Function
    Protected Function GetUserIdByUserName(ByVal userName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserIDByUserName.SelectParameters.Item("UserName").DefaultValue = userName
            Dim dv As Data.DataView = CType(sdGetUserIDByUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("UserID"))) Then
                        userID = dv(0)("UserID").ToString()
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function

    Protected Function GetFolderType(ByVal directoryName As String, ByVal directoryType As String) As String
        Dim type As String = String.Empty
        Try
            If (directoryName.Contains("BoardBackgroundPics") And directoryType = "Board") Then
                type = "Board Background Image"
            ElseIf (directoryName.Contains("BoardCoverPics") And directoryType = "Board") Then
                type = "Board Cover Image"
            ElseIf (directoryName.Contains("thumbnail") And directoryType = "Board") Then
                type = "Board Profile Image"
            ElseIf (directoryName.Contains("ProfilePics") And directoryType = "User") Then
                type = "User Profile Image"
            ElseIf (directoryName.Contains("BackgroundPics") And directoryType = "User") Then
                type = "User Background Image"
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return type
    End Function
    Protected Sub allImagesGrid_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles allImagesGrid.ItemCommand
        Try

            If (e.CommandName = "DeleteImage") Then
                Dim fileName As String = e.CommandArgument.ToString()
                Dim hdnImageType As HiddenField = CType(e.Item.FindControl("hdnImageType"), HiddenField)
                Dim hdnDirectoryName As HiddenField = CType(e.Item.FindControl("hdnDirectoryName"), HiddenField)
                Dim hdnUserID As HiddenField = CType(e.Item.FindControl("hdnUserID"), HiddenField)
                DeleteImage(hdnImageType.Value, fileName, hdnDirectoryName.Value, hdnUserID.Value)
                Me.dtAllImages.Rows.Clear()
                InitializeDataTable()
                LoadAllImages()
                GlobalModule.SetMessage(lblErrorMessage, True, "Image deleted")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblErrorMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub DeleteImage(ByVal type As String, ByVal fileName As String, ByVal directoryName As String, ByVal userID As String)
        Try
            Dim folder As String = String.Empty
            If (type = "Message") Then
                folder = "~/Upload/MessageFiles/"
                UpdateMessageRecord(userID, fileName)
            ElseIf (type = "User Post") Then
                folder = "~/Upload/UserPostsFiles/"
                UpdateUserPostRecord(userID, fileName)
            ElseIf (type = "Board Files") Then
                folder = "~/Upload/BoardDirectory/" & directoryName & "/"
                sdAllImages.DeleteParameters.Item("FileName").DefaultValue = fileName
                sdAllImages.Delete()
            ElseIf (type = "Board Background Image") Then
                folder = "~/Upload/BoardBackgroundPics/"
            ElseIf (type = "Board Cover Image") Then
                folder = "~/Upload/BoardCoverPics/"
            ElseIf (type = "Board Profile Image") Then
                folder = "~/thumbnail/"
            ElseIf (type = "User Profile Image") Then
                folder = "~/Upload/ProfilePics/"
            ElseIf (type = "User Background Image") Then
                folder = "~/Upload/BackgroundPics/"
            End If
            Dim dirInfo As New DirectoryInfo(Server.MapPath(folder))
            If dirInfo.Exists Then
                If File.Exists(folder & fileName) Then
                    File.Delete(Server.MapPath(folder & fileName))
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub UpdateMessageRecord(ByVal userID As String, ByVal fileName As String)
        Try
            sdAllImages.UpdateParameters.Item("UserID").DefaultValue = userID
            sdAllImages.UpdateParameters.Item("FileName").DefaultValue = fileName
            sdAllImages.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub UpdateUserPostRecord(ByVal userID As String, ByVal fileName As String)
        Try
            sdGetUserDetailsByDirectoryName.UpdateParameters.Item("UserID").DefaultValue = userID
            sdGetUserDetailsByDirectoryName.UpdateParameters.Item("FileName").DefaultValue = fileName
            sdGetUserDetailsByDirectoryName.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub allImagesGrid_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles allImagesGrid.NeedDataSource

        Dim dataView As New DataView
        dataView = Me.dtAllImages.DefaultView
        dataView.Sort = "DateUploaded desc"
        allImagesGrid.DataSource = dataView
    End Sub
End Class