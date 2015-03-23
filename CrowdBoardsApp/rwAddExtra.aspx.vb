Imports Telerik.Web.UI
Imports System.IO

Public Class rwAddExtra
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property BoardID() As Int32
        Get
            Return CInt(ViewState("_boardID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property MediaLinkId() As String
        Get
            Return CStr(ViewState("_mediaLinkId"))
        End Get
        Set(ByVal value As String)
            ViewState("_mediaLinkId") = value
        End Set
    End Property
    Public Property BoardPicUrl() As String
        Get
            Return CStr(ViewState("_boardPicUrl"))
        End Get
        Set(ByVal value As String)
            ViewState("_boardPicUrl") = value
        End Set
    End Property
    Public Property DirectoryName() As String
        Get
            Return CStr(ViewState("_directoryName"))
        End Get
        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property
    Public Property BackgroundUrl() As String
        Get
            Return CStr(ViewState("_backgroundUrl"))
        End Get
        Set(ByVal value As String)
            ViewState("_backgroundUrl") = value
        End Set
    End Property
    Public Property CoverUrl() As String
        Get
            Return CStr(ViewState("_coverUrl"))
        End Get
        Set(ByVal value As String)
            ViewState("_coverUrl") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                Me.BoardID = Convert.ToInt32(Request.QueryString("BoardId"))
                Me.DirectoryName = Request.QueryString("directoryName")
                Me.BoardPicUrl = Request.QueryString("url")
                LoadBoardPic()
                SetBackgroundCoverProfilePic()
                RadMultiPage1.SelectedIndex = 0
                ResetCss()
                lbtnDesign.Attributes.Add("style", "color:#99CCFF")
                LoadBoardDescriptionInfo()
                LoadBoardFiles()
                LoadBoardMediaLinks()
                removeTools()
                Dim filePath As String
                filePath = CreateDirectory()
                reCreatePage.Content = ReadFile(filePath + "\Index.html")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Public Sub removeTools()
        Try
            reCreatePage.EnsureToolsFileLoaded()
            reCreatePage.FindTool("FindAndReplace").Visible = False
            reCreatePage.FindTool("Print").Visible = False
            reCreatePage.FindTool("FlashManager").Visible = False
            reCreatePage.FindTool("MediaManager").Visible = False
            reCreatePage.FindTool("Superscript").Visible = False
            reCreatePage.FindTool("Subscript").Visible = False
            reCreatePage.FindTool("XhtmlValidator").Visible = False
            reCreatePage.FindTool("ApplyClass").Visible = False
            reCreatePage.FindTool("FormatStripper").Visible = False
            reCreatePage.FindTool("InsertSymbol").Visible = False
            reCreatePage.FindTool("InsertTable").Visible = False
            reCreatePage.FindTool("InsertFormElement").Visible = False
            reCreatePage.FindTool("InsertSnippet").Visible = False
            reCreatePage.FindTool("ConvertToLower").Visible = False
            reCreatePage.FindTool("ConvertToUpper").Visible = False
            reCreatePage.FindTool("Zoom").Visible = False
            reCreatePage.FindTool("ModuleManager").Visible = False
            reCreatePage.FindTool("ToggleScreenMode").Visible = False
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try
            sdBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("YoutubeVideoUrl"))) Then
                    txtYoutubeVideoUrl.Text = dv(0)("YoutubeVideoUrl")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub ResetCss()
        Try
            lbtnDesign.Attributes.Add("style", "color:#FFFFFF")
            lbtnMoreInfo.Attributes.Add("style", "color:#FFFFFF")
            lbtnMediaLinks.Attributes.Add("style", "color:#FFFFFF")
            lbtnUploadFiles.Attributes.Add("style", "color:#FFFFFF")
            lbtnCrowdBoardTeam.Attributes.Add("style", "color:#FFFFFF")
            lbtnPreview.Attributes.Add("style", "color:#FFFFFF")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardPic()
        Try
            If Not Me.BoardPicUrl = "" Then
                imgProfile.ImageUrl = Me.BoardPicUrl
            Else
                imgProfile.ImageUrl = "~/Images/blankBoardImage.png"
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub lbtnDesign_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnDesign.Click
        RadMultiPage1.SelectedIndex = 0
        ResetCss()
        lbtnDesign.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = True
        LoadBoardPic()
    End Sub
    Protected Sub lbtnMoreInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMoreInfo.Click
        RadMultiPage1.SelectedIndex = 1
        ResetCss()
        lbtnMoreInfo.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = False
    End Sub
    Protected Sub lbtnMediaLinks_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMediaLinks.Click
        RadMultiPage1.SelectedIndex = 2
        ResetCss()
        lbtnMediaLinks.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = False
    End Sub
    Protected Sub lbtnUploadFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnUploadFiles.Click
        RadMultiPage1.SelectedIndex = 3
        ResetCss()
        lbtnUploadFiles.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = False
    End Sub
    Protected Sub lbtnCrowdBoardTeam_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnCrowdBoardTeam.Click
        RadMultiPage1.SelectedIndex = 4
        ResetCss()
        lbtnCrowdBoardTeam.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = False
    End Sub
    Protected Sub lbtnPreview_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnPreview.Click
        RadMultiPage1.SelectedIndex = 5
        ResetCss()
        lbtnPreview.Attributes.Add("style", "color:#99CCFF")
        boardImageDiv.Visible = False
    End Sub

    Protected Sub btnBackgroungPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBackgroungPicture.Click
        Try
            If rauBackgroundPicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauBackgroundPicture.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardBackgroundPics") & "\\" & Me.DirectoryName & ".jpg", True)
                    SetBackgroundCoverProfilePic()
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMessageDesign, False, "Only JPG,GIF,PNG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCoverPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCoverPicture.Click
        Try
            If rauCoverPicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauCoverPicture.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardCoverPics") & "\\" & Me.DirectoryName & ".jpg", True)
                    SetBackgroundCoverProfilePic()
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMessageDesign, False, "Only JPG,GIF,PNG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SetBackgroundCoverProfilePic()
        Try
            If Not isAvail("~/Upload/BoardBackgroundPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathBackgroundImage As String = "Upload/BoardBackgroundPics/" & Me.DirectoryName & ".jpg"
                backgroundDiv.Attributes.Add("style", "background-image:url(" & pathBackgroundImage & "); background-repeat:no-repeat; overflow: hidden; background-size: 100% 100%;width: 95%; height: 400px;border-color: #99CCFF;border-style: solid; border-width: 1;")
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");width: 100%; height: 30%; border-bottom-color: #99CCFF; border-bottom-style: solid;border-bottom-width: thin;")
            End If
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
    Protected Sub btnAddToCrowdboardDesign_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddToCrowdboardDesign.Click
        Try
            AddYoutubeVideoUrl()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub AddYoutubeVideoUrl()
        Try
            sdUpdateUrlDataSource.UpdateParameters.Item("YoutubeVideoUrl").DefaultValue = txtYoutubeVideoUrl.Text
            sdUpdateUrlDataSource.UpdateParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            sdUpdateUrlDataSource.Update()
            LoadBoardPic()
            SetBackgroundCoverProfilePic()
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardFiles()
        Try
            sdBoardFiles.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdBoardFiles.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                rgBoardFiles.DataSource = dv
                rgBoardFiles.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnBoardFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBoardFiles.Click
        Try
            If rauBoardFiles.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauBoardFiles.UploadedFiles

                    Dim imagePath As String = "Upload/BoardDirectory/" & Me.DirectoryName & "/" & upFiles.GetName()
                    If Not Directory.Exists(System.IO.Path.Combine(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName))) Then
                        Directory.CreateDirectory(System.IO.Path.Combine(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName)))
                    End If
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName) & "\\" & upFiles.GetName(), True)
                    SaveBoardFile(upFiles.GetName(), imagePath)
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Please select file")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SaveBoardFile(ByVal fileName As String, ByVal filePath As String)
        Try
            sdBoardFiles.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdBoardFiles.InsertParameters.Item("FileName").DefaultValue = fileName
            sdBoardFiles.InsertParameters.Item("FilePath").DefaultValue = filePath
            sdBoardFiles.Insert()
            LoadBoardFiles()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub rgBoardFiles_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardFiles.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim id As String = e.CommandArgument.ToString()
                Dim hdnFileName = TryCast(e.Item.FindControl("hdnFileName"), HiddenField)
                sdBoardFiles.DeleteParameters.Item("ID").DefaultValue = id
                Dim res As Integer = sdBoardFiles.Delete()
                If (res = 1) Then
                    DeleteBoardFile(hdnFileName.Value)
                    LoadBoardFiles()
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
   
    Private Sub DeleteBoardFile(ByVal fileName As String)
        Try
            Dim objFileInfo As System.IO.FileInfo
            Response.Clear()
            Dim rootPath = "~/Upload/BoardDirectory/" & Me.DirectoryName & "/" & fileName
            If Not System.IO.File.Exists(Server.MapPath(rootPath)) Then Exit Sub
            objFileInfo = New System.IO.FileInfo(Server.MapPath(rootPath))
            objFileInfo.Delete()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub rgBoardMediaLinks_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardMediaLinks.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim id As String = e.CommandArgument.ToString()
                sdBoardMediaLinks.DeleteParameters.Item("ID").DefaultValue = id
                Dim res As Integer = sdBoardMediaLinks.Delete()
                If (res = 1) Then
                    LoadBoardMediaLinks()
                Else
                    GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
                End If
            ElseIf (e.CommandName = "IEdit") Then
                btnAddMediaLink.Text = "UPDATE"
                Me.MediaLinkId = e.CommandArgument.ToString()
                Dim hdnName As HiddenField = CType(e.Item.FindControl("hdnName"), HiddenField)
                Dim hdnUrl As HiddenField = CType(e.Item.FindControl("hdnUrl"), HiddenField)
                txtMediaLinkName.Text = hdnName.Value
                txtMediaLinkUrl.Text = hdnUrl.Value
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub LoadBoardMediaLinks()
        Try
            sdBoardMediaLinks.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdBoardMediaLinks.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                rgBoardMediaLinks.DataSource = dv
                rgBoardMediaLinks.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnAddMediaLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddMediaLink.Click
        Try
            If (btnAddMediaLink.Text = "ADD") Then
                AddMediaLink()
            ElseIf (btnAddMediaLink.Text = "UPDATE") Then
                UpdateMediaLink(Me.MediaLinkId)
            End If
            LoadBoardMediaLinks()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub AddMediaLink()
        Try
            sdBoardMediaLinks.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdBoardMediaLinks.InsertParameters.Item("Name").DefaultValue = txtMediaLinkName.Text
            sdBoardMediaLinks.InsertParameters.Item("Url").DefaultValue = txtMediaLinkUrl.Text
            sdBoardMediaLinks.Insert()
            txtMediaLinkName.Text = ""
            txtMediaLinkUrl.Text = ""
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub UpdateMediaLink(ByVal id As String)
        Try
            sdBoardMediaLinks.UpdateParameters.Item("ID").DefaultValue = id
            sdBoardMediaLinks.UpdateParameters.Item("Name").DefaultValue = txtMediaLinkName.Text
            sdBoardMediaLinks.UpdateParameters.Item("Url").DefaultValue = txtMediaLinkUrl.Text
            Dim res As Integer = sdBoardMediaLinks.Update()
            If (res = 1) Then
                txtMediaLinkName.Text = ""
                txtMediaLinkUrl.Text = ""
                btnAddMediaLink.Text = "ADD"
                Me.MediaLinkId = ""
            End If
           
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnSendrRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendrRequest.Click
        Try
            Dim boarder As String = cbAllBoardersList.SelectedValue
            Dim requestStatus As Integer = CheckRequest(boarder)
            If (requestStatus = 0) Then
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, False, "Request is already pending")
            ElseIf (requestStatus = 1) Then
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Boarder has already accepted your request")
            ElseIf requestStatus = 2 Then
                sdCrowdBoardTeam.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdCrowdBoardTeam.UpdateParameters.Item("MemberID").DefaultValue = boarder
                sdCrowdBoardTeam.UpdateParameters.Item("RequestTitle").DefaultValue = txtRequestTitle.Text
                sdCrowdBoardTeam.UpdateParameters.Item("Description").DefaultValue = txtRequestDescription.Text
                sdCrowdBoardTeam.Update()
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Request sent successfully")
            ElseIf (requestStatus = 3) Then
                sdCrowdBoardTeam.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdCrowdBoardTeam.InsertParameters.Item("MemberID").DefaultValue = boarder
                sdCrowdBoardTeam.InsertParameters.Item("RequestTitle").DefaultValue = txtRequestTitle.Text
                sdCrowdBoardTeam.InsertParameters.Item("Description").DefaultValue = txtRequestDescription.Text
                sdCrowdBoardTeam.Insert()
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Request sent successfully")
            End If
            cbAllBoardersList.SelectedValue = 0
            txtRequestTitle.Text = ""
            txtRequestDescription.Text = ""
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageCrowdboardTeam, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Function CheckRequest(ByVal memberID As String) As Integer
        Dim status As Integer
        Try
            sdCrowdBoardTeam.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
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
    Protected Sub btnSaveMoreInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveMoreInfo.Click
        Try
            If Not Me.DirectoryName = "" Then
                Dim filePath As String
                filePath = CreateDirectory()
                Using externalFile As New StreamWriter(filePath + "\Index.html", False)
                    externalFile.Write(reCreatePage.Content)
                    externalFile.Flush()
                    externalFile.Close()
                End Using
                Dim directoryName As String = Me.DirectoryName
                sdUpdateCreatePageUrl.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdUpdateCreatePageUrl.UpdateParameters.Item("Url").DefaultValue = directoryName & "/" & "Index.html"
                sdUpdateCreatePageUrl.Update()
                LoadBoardDescriptionInfo()
                GlobalModule.SetMessage(lblMessageMoreInfo, True, "Data Saved Successfully")
            Else
                GlobalModule.SetMessage(lblMessageMoreInfo, False, "Please create board First")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMoreInfo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Function CreateDirectory() As String
        Dim mainDirectoryPath As String
        mainDirectoryPath = ""
        Dim filePath As String
        filePath = ""
        Try
            mainDirectoryPath = "~/Upload/BoardDirectory/" & Me.DirectoryName
            filePath = HttpContext.Current.Server.MapPath(mainDirectoryPath)
            If Not Directory.Exists(filePath) Then
                Dim info As DirectoryInfo = Directory.CreateDirectory(filePath)
                If Not File.Exists(filePath + "\" + "Index.html") Then
                    Using stramWrite As New System.IO.StreamWriter(filePath + "\" + "Index.html", False)
                        stramWrite.Close()
                    End Using
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return filePath
    End Function
    Protected Function ReadFile(ByVal path As String) As String
        Dim content As String = ""
        Try
            Using sr As New System.IO.StreamReader(path)
                content = sr.ReadToEnd()
                sr.Close()
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return content
    End Function
End Class