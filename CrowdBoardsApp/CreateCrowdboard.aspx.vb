Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.Threading
Imports ASPSnippets.FaceBookAPI
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Net
Imports OAuth.Net.Common
Imports OAuth.Net.Components
Imports OAuth.Net.Consumer
Imports OAuth
Imports OAuthYahoo
Imports System.Text
Imports System.Xml
Imports System.Collections
Imports System.Collections.Generic
Imports System.Net.Mail
Imports System.Text.RegularExpressions
Imports LinkedInLibrary

Public Class CreateCrowdboard
    Inherits Telerik.Web.UI.RadAjaxPage
    Public index As Integer = 0
    Public Property BoardID() As Int32
        Get
            Return CInt(ViewState("_boardID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property

    Public Property LevelID() As Int32
        Get
            Return CInt(ViewState("_levelID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_levelID") = value
        End Set
    End Property
    Public Property editLevelID() As Int32
        Get
            Return CInt(ViewState("_editLevelID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_editLevelID") = value
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
            Return CStr(IIf(Not ViewState("_directoryName") Is Nothing, ViewState("_directoryName"), ""))
        End Get
        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property
    Public Property BoardName() As String

        Get
            Return CStr(ViewState("_BoardName"))
        End Get

        Set(ByVal value As String)
            ViewState("_BoardName") = value
        End Set
    End Property
    Public Property AreaName() As String
        Get
            Return Convert.ToString(ViewState("_areaName"))
        End Get

        Set(ByVal value As String)
            ViewState("_areaName") = value
        End Set
    End Property
    Public Property EnglishName() As String

        Get
            Return CStr(ViewState("_englishName"))
        End Get

        Set(ByVal value As String)
            ViewState("_englishName") = value
        End Set
    End Property
    Public Property dtBoardLevels() As DataTable
        Get
            Return CType(ViewState("_dtBoardLevels"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("_dtBoardLevels") = value
        End Set
    End Property
    Public Property DistrictName() As String

        Get
            Return Convert.ToString(IIf(Not ViewState("_districtName") Is Nothing, ViewState("_districtName"), ""))
        End Get

        Set(ByVal value As String)
            ViewState("_districtName") = value
        End Set
    End Property

    Public Property BankLocation() As String

        Get
            Return CStr(ViewState("_bankLocation"))
        End Get

        Set(ByVal value As String)
            ViewState("_bankLocation") = value
        End Set
    End Property



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()

        RadWindow1.VisibleOnPageLoad = False
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If

        If (Not Page.IsPostBack) Then
            Me.BoardPicUrl = "~/Images/blankBoardImage.png"
            SetBankLocation()
            invTypeDataList.DataBind()
            If Me.EnglishName Is Nothing Then
                Me.EnglishName = " "
            End If
            If Request.QueryString("Name") IsNot Nothing Then
                Me.BoardID = getBoardId()
                LoadBoardDescriptionInfo()
                index = 2
                hdnIndex.Text = index
            Else
                index = 0
                hdnIndex.Text = index
            End If
            Session("searchKeyWord") = "%"
            InitializeDataTable()
        End If
        lblMessageStep1.Text = ""
        lblMessageStep2.Text = ""
        lblMessageStep3.Text = ""
        lblMessageStep1.Font.Size = 12
        lblMessageStep2.Font.Size = 12
        lblMessageStep3.Font.Size = 12
        lblMessageStep4.Font.Size = 12
        messageLabel.Font.Size = 12
    End Sub

    Protected Sub ClearOwnerTypeCss()
        Try
            Session("ownerType") = Nothing

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub districtDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles districtDataList.ItemDataBound
        Try

            Dim hdnDistrictID As HiddenField = e.Item.FindControl("hdnDistrictID")
            Dim areaDataList As DataList = CType(e.Item.FindControl("areaDataList"), DataList)
            sdAreas.SelectParameters.Item("districtID").DefaultValue = hdnDistrictID.Value
            Dim dvArea As Data.DataView = CType(sdAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)
            areaDataList.DataSource = dvArea
            areaDataList.DataBind()
            areaDataList.RepeatColumns = 2
            areaDataList.RepeatLayout = RepeatLayout.Table

            Dim hdnDistrictName As HiddenField = CType(e.Item.FindControl("hdnDistrictName"), HiddenField)
            Dim districtNameLinkButton As LinkButton = CType(e.Item.FindControl("DistrictNameLinkButton"), LinkButton)
            districtNameLinkButton.Attributes.Add("onclick", "return loadPopupBoxArea(" + hdnDistrictID.Value + ",'" + hdnDistrictName.Value + "');")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub


    Protected Sub invTypeDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles invTypeDataList.ItemCommand
        Try
            If (e.CommandName.ToString() = "SetInvestmentType") Then
                Session("BoardType") = CInt(e.CommandArgument.ToString())
                Dim hdnEnglishName As HiddenField = e.Item.FindControl("hdnEnglishName")
                Me.EnglishName = hdnEnglishName.Value
                If Me.EnglishName.ToLower() = "donation" Then
                    taxIDTable.Visible = True
                    If Me.BankLocation = "UK" Then
                        lblFederalTaxID.Text = "Charity Gift Registry ID"
                        txtFederalTaxID.Attributes.Add("placeholder", "Charity Gift Registry ID")
                    Else
                        lblFederalTaxID.Text = "Federal Tax ID"
                        txtFederalTaxID.Attributes.Add("placeholder", "Federal Tax ID")
                    End If
                Else
                    taxIDTable.Visible = False
                    txtFederalTaxID.Text = ""
                    txtFederalTaxID.Attributes.Add("placeholder", "")
                End If
                index = 2
                hdnIndex.Text = index
            End If
            invTypeDataList.DataBind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep1, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Function checkType() As Boolean
        Dim result As Boolean = True
        Try
            If Session("BoardType") Is Nothing Then
                GlobalModule.SetMessage(lblMessageStep1, False, "Please Select type of CrowdBoard")
                index = 1
                hdnIndex.Text = index
                result = False
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Sub SaveBoardDetailsForNextStep()
        Try
            If Not checkType() Then
                Exit Sub
            ElseIf hdnSelectedArea.Value = "" Then
                GlobalModule.SetMessage(lblMessageStep2, False, "Please Select District and Area")
                Exit Sub
            Else
                SaveChanges()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadBoardDescriptionInfo()
        Try
            sdBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("BoardName"))) Then
                    txtBoardName.Text = dv(0)("BoardName")
                    lblCrowdBoardName.Text = dv(0)("BoardName").ToString()
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    txtDescription.Text = dv(0)("Description")
                    lblDescription.Text = dv(0)("Description").ToString()
                End If
                If (Not IsDBNull(dv(0)("TotalOffer"))) Then
                    txtSeeking.Text = dv(0)("TotalOffer")
                End If
                If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                    hdnDirectoryName.Value = dv(0)("DirectoryName")
                    Me.DirectoryName = dv(0)("DirectoryName").ToString()
                End If

                If (Not IsDBNull(dv(0)("InvType"))) Then
                    lblBoardType.Text = dv(0)("InvType").ToString()


                    If lblBoardType.Text.ToLower() = "donation" Then
                        taxIDTable.Visible = True
                        If Me.BankLocation = "UK" Then
                            lblFederalTaxID.Text = "Charity Gift Registry ID"
                            txtFederalTaxID.Attributes.Add("placeholder", "Charity Gift Registry ID")
                        Else
                            lblFederalTaxID.Text = "Federal Tax ID"
                            txtFederalTaxID.Attributes.Add("placeholder", "Federal Tax ID")
                        End If
                        If (Not IsDBNull(dv(0)("FederalTaxID"))) Then
                            txtFederalTaxID.Text = dv(0)("FederalTaxID").ToString()
                        End If
                    Else
                        taxIDTable.Visible = False
                        txtFederalTaxID.Text = ""
                        txtFederalTaxID.Attributes.Add("placeholder", "")
                    End If

                End If

                If (Not IsDBNull(dv(0)("Location"))) Then
                    lblLocation.Text = dv(0)("Location").ToString()
                End If
                If (Not IsDBNull(dv(0)("city"))) Then
                    txtCity.Text = dv(0)("city").ToString()
                End If
                If (Not IsDBNull(dv(0)("Country"))) Then
                    txtCounty.Text = dv(0)("Country").ToString()
                End If
                If (Not IsDBNull(dv(0)("TotalOfferText"))) Then
                    lblSeeking.Text = dv(0)("TotalOfferText")
                    maxLeft.Text = dv(0)("TotalOfferText")
                End If

                If (Not IsDBNull(dv(0)("areaID"))) Then
                    districtLabel.Text = dv(0)("District") + " District"
                    areaLabel.Text = "Your have Selected the " + dv(0)("areaName") + "  Area in the "
                Else
                    districtLabel.Text = ""
                    areaLabel.Text = ""
                End If

            End If
            imgProfile.ImageUrl = Me.BoardPicUrl
            imgBoardProfile.ImageUrl = Me.BoardPicUrl
            rieBackgroundPic.ImageUrl = Me.BoardPicUrl
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub SaveChanges()
        Try
            If CheckBoardName(txtBoardName.Text) Then
                If Me.BoardName = txtBoardName.Text Then
                    SaveBoardDetails()
                    LoadBoardDescriptionInfo()
                    index = 3
                    hdnIndex.Text = index
                Else
                    If (hdnSelectedArea.Value <> "" And hdnSelectedDistrict.Value <> "") Then

                        SelectedAres.Text = hdnSelectedArea.Value
                        selectedDistrict.Text = hdnSelectedDistrict.Value
                        districtLabel.Text = hdnSelectedDistrict.Value + " District"
                        areaLabel.Text = "Your have Selected the " + hdnSelectedArea.Value + "  Area in the "
                    End If
                    GlobalModule.SetMessage(lblMessageStep2, False, "BoardName already exists")
                    Exit Sub
                End If
            Else
                If Me.BoardID = 0 Then
                    sdCreateNewBoardDataSource.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    Dim dv As Data.DataView = CType(sdCreateNewBoardDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If dv.Count > 0 Then
                        Me.BoardID = dv(0)("boardID")
                    End If
                End If
                Me.BoardName = txtBoardName.Text
                SaveBoardDetails()
                LoadBoardDescriptionInfo()
                index = 3
                hdnIndex.Text = index
            End If


        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep2, False, "Error in Update")
        End Try
    End Sub
    Protected Sub SaveBoardDetails()
        Try
            Dim directoryName As String
            directoryName = txtBoardName.Text.Trim.ToLower.Replace(" ", "-")
            sdBoard.UpdateParameters.Item("DirectoryName").DefaultValue = directoryName
            sdBoard.UpdateParameters.Item("BoardName").DefaultValue = txtBoardName.Text
            sdBoard.UpdateParameters.Item("Description").DefaultValue = txtDescription.Text
            sdBoard.UpdateParameters.Item("city").DefaultValue = txtCity.Text
            sdBoard.UpdateParameters.Item("InvType").DefaultValue = Session("BoardType")
            sdBoard.UpdateParameters.Item("country").DefaultValue = txtCounty.Text
            sdBoard.UpdateParameters.Item("AreaID").DefaultValue = getAreaID()
            'sdBoard.UpdateParameters.Item("Tags").DefaultValue = "" ''txtTags.Text
            sdBoard.UpdateParameters.Item("Status").DefaultValue = 0
            sdBoard.UpdateParameters.Item("TotalOffer").DefaultValue = txtSeeking.Text
            sdBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
            If (Session("BoardType").ToString() = "1") Then
                sdBoard.UpdateParameters.Item("EquityID").DefaultValue = EquityTypesDropDownList.SelectedValue
            Else
                sdBoard.UpdateParameters.Item("EquityID").DefaultValue = ""
            End If

            sdBoard.Update()
            If (Me.EnglishName.ToLower() = "donation") Then
                SaveTaxID()
            End If
            LoadBoardDescriptionInfo()
            GlobalModule.SetMessage(lblMessageStep2, True, "Updated Successfully")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub SaveTaxID()
        Try
            sdInvestmentType.UpdateParameters.Item("FederalTaxID").DefaultValue = txtFederalTaxID.Text
            sdInvestmentType.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdInvestmentType.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function CheckBoardName(ByVal boardName As String) As Boolean
        Dim isExist As Boolean = False
        Try
            sdCheckBoardName.SelectParameters("BoardName").DefaultValue = boardName
            Dim dvIsExits As Data.DataView = CType(sdCheckBoardName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dvIsExits) Is Nothing Then
                If (dvIsExits.Count > 0) Then
                    isExist = True
                Else
                    isExist = False
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isExist
    End Function
    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs)
        Try
            rieBackgroundPic.ResetChanges()
            rieBackgroundPic.ImageUrl = e.Argument
            GlobalModule.SetMessage(lblMessageStep2, True, "Successfully Uploaded")
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep2, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnProfilePicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProfilePicture.Click
        Try
            If Not checkType() Then
                Exit Sub
            End If
            If rauProfilePicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauProfilePicture.UploadedFiles

                    Dim image As System.Drawing.Image
                    image = Drawing.Image.FromStream(upFiles.InputStream)

                    'If (image.Height <> 350) And (image.Width <> 350) Then
                    '    GlobalModule.SetMessage(lblMessageStep2, False, "Please Upload Image of Size 350 x 350 pixels")
                    '    index = 2
                    '    hdnIndex.Text = index
                    '    image.Dispose()
                    '    Exit Sub
                    'End If


                    Dim tempPath As String = Server.MapPath("~/thumbnail/temp/")
                    Dim target As New DirectoryInfo(tempPath)

                    If Not Directory.Exists(target.FullName) Then
                        Directory.CreateDirectory(target.FullName)
                    Else
                        EmptyTemp(tempPath)
                    End If

                    image.Save(tempPath & upFiles.GetName())
                    Dim image1 As Bitmap
                    image1 = ResizeImage(tempPath & upFiles.GetName(), 350, 350)
                    image1.Save(tempPath & upFiles.GetName())

                    Me.BoardPicUrl = "~/thumbnail/temp/" & upFiles.GetName()

                    LoadBoardDescriptionInfo()
                    GlobalModule.SetMessage(lblMessageStep2, True, "Successfully Uploaded")
                    index = 2
                    hdnIndex.Text = index
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "key", "SetImageUrl()", True)
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMessageStep2, False, "Only JPG,GIF,PNG files are allowed")
                LoadBoardDescriptionInfo()
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep2, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Private Function ResizeImage(ByVal streamImage As String, ByVal maxWidth As Integer, ByVal maxHeight As Integer) As Bitmap
        Dim originalImage As New Bitmap(streamImage)
        Dim newWidth As Integer = originalImage.Width
        Dim newHeight As Integer = originalImage.Height

        Dim newImage As New Bitmap(originalImage, maxWidth, maxHeight)

        Dim g As Graphics = Graphics.FromImage(newImage)
        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear
        g.DrawImage(originalImage, 0, 0, newImage.Width, newImage.Height)

        originalImage.Dispose()

        Return newImage
    End Function


    Protected Sub rieBackgroundPic_OnImageSaving(ByVal sender As Object, ByVal args As Telerik.Web.UI.ImageEditorSavingEventArgs)
        Try
            'If (args.Image.Height <> 350) Or (args.Image.Width <> 350) Then

            '    '  GlobalModule.SetMessage(lblMessageStep2, False, "Please Upload Image of Size 350 x 350 pixels")
            '    GlobalModule.SetMessage(lblMessageStep2, False, "")
            '    args.Argument = "Please Upload Image of Size 350 x 350 pixels"
            '    args.Cancel = True
            '    rieBackgroundPic.Dispose()
            '    Exit Sub
            'Else
            Dim FileName As String = Path.GetFileName(args.FileName)
            GlobalModule.SetMessage(lblMessageStep2, True, "")
            args.Argument = "Uploaded Image Saved"

            Me.BoardPicUrl = "~/thumbnail/temp/" & FileName

            LoadBoardDescriptionInfo()
            'End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub btnGetStarted_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGetStarted.Click
        index = 1
        hdnIndex.Text = index
    End Sub
    Protected Sub gotoStep3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles gotoStep3.Click
        Try

            If (CheckEmailExists() = False) Then
                RadWindow1.Height = 400
                RadWindow1.Width = 600
                RadWindow1.NavigateUrl = "~/rwValidateEmail.aspx?vEmail=" & True
                RadWindow1.VisibleOnPageLoad = True
            Else
                SaveBoardDetailsForNextStep()
            End If



        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Private Function getBoardId() As Integer
        Dim boardId As Integer = 0
        Try
            sdGetBoardIdDataSource.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                boardId = dv(0)("BoardID")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return boardId
    End Function

    Private Function getAreaID() As Integer
        Dim areaid As Integer = 0
        Try
            sdGetAreaID.SelectParameters.Item("AreaName").DefaultValue = hdnSelectedArea.Value.Replace("amp;", "")
            Dim dv As Data.DataView = CType(sdGetAreaID.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                areaid = dv(0)("areaID")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return areaid
    End Function
    Protected Sub ClearAll()
        txtBoardName.Text = ""
        txtDescription.Text = ""
        txtCity.Text = ""
        txtSeeking.Text = ""
        txtCounty.Text = ""
    End Sub
    Private Sub InitializeDataTable()
        Dim dt As New DataTable
        dt.Columns.Add("LevelID", GetType(String))
        dt.Columns.Add("LevelName", GetType(String))
        dt.Columns.Add("Description", GetType(String))
        dt.Columns.Add("LevelAmount", GetType(String))
        dt.Columns.Add("NumOffered", GetType(String))
        GridViewLevel.DataSource = dt
        GridViewLevel.DataBind()
        Me.dtBoardLevels = dt.Copy()
        levelNumberLabel.Text = "1"
    End Sub
    Protected Sub AddLevel()
        Try
            Dim row As DataRow = Me.dtBoardLevels.NewRow()
            Me.LevelID = Me.LevelID + 1
            row("LevelID") = Me.LevelID
            row("LevelName") = txtLevelName.Text
            row("Description") = txtLevelDescription.Text
            row("LevelAmount") = cbInvestmentLevels.SelectedValue
            row("NumOffered") = txtMaximumOffered.Text
            Me.dtBoardLevels.Rows.Add(row)
            levelNumberLabel.Text = Me.dtBoardLevels.Rows.Count().ToString() + 1
            maxlevel.Text = Me.dtBoardLevels.Rows.Count().ToString()
            txtLevelName.Text = ""
            txtLevelDescription.Text = ""
            cbInvestmentLevels.SelectedIndex = 0
            txtMaximumOffered.Text = ""
            GlobalModule.SetMessage(lblMessageStep3, True, "Level Added Successfully.")
            Me.ViewState.Add("current", dtBoardLevels)

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub UpdateLevel(ByVal LevelID As String)
        Try
            Dim Rows As DataRow() = Me.dtBoardLevels.Select("LevelID='" + LevelID + "'")
            If (Rows.Count > 0) Then
                Me.dtBoardLevels.Rows(0)("LevelName") = txtLevelName.Text
                Me.dtBoardLevels.Rows(0)("Description") = txtLevelDescription.Text
                Me.dtBoardLevels.Rows(0)("LevelAmount") = cbInvestmentLevels.SelectedValue
                Me.dtBoardLevels.Rows(0)("NumOffered") = txtMaximumOffered.Text
                Me.dtBoardLevels.AcceptChanges()
                levelNumberLabel.Text = Me.dtBoardLevels.Rows.Count().ToString() + 1
                addLevelButton.Text = "Add Level"
                txtLevelName.Text = ""
                txtLevelDescription.Text = ""
                cbInvestmentLevels.SelectedIndex = 0
                txtMaximumOffered.Text = ""
                GlobalModule.SetMessage(lblMessageStep3, True, "Level Added Successfully.")
                Me.ViewState.Add("current", dtBoardLevels)
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub DeleteLevel(ByVal LevelID As String)
        Try
            Dim Rows As DataRow() = Me.dtBoardLevels.Select("LevelID='" + LevelID + "'")
            If (Rows.Count > 0) Then
                Me.dtBoardLevels.Rows(0).Delete()
                Me.dtBoardLevels.AcceptChanges()
                addLevelButton.Text = "Add Level"
                levelNumberLabel.Text = Me.dtBoardLevels.Rows.Count().ToString() + 1
                maxlevel.Text = Me.dtBoardLevels.Rows.Count().ToString()
                txtLevelName.Text = ""
                txtLevelDescription.Text = ""
                cbInvestmentLevels.SelectedIndex = 0
                txtMaximumOffered.Text = ""
                GlobalModule.SetMessage(lblMessageStep3, True, "Level deleted Successfully.")
                Me.ViewState.Add("current", dtBoardLevels)
                Dim dt As DataTable
                dt = CType(ViewState("current"), DataTable)
                GridViewLevel.DataSource = dt
                GridViewLevel.DataBind()
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub cbInvestmentLevels_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles cbInvestmentLevels.SelectedIndexChanged
        Try
            If Not (txtSeeking.Text = "") Then
                If Not (cbInvestmentLevels.SelectedValue = 0) Then
                    If (Convert.ToDouble(e.Value) > Convert.ToDouble(txtSeeking.Text)) Then
                        Dim levelMessage As String = String.Empty
                        If Me.BankLocation = "US" Then
                            levelMessage = "Your Investment Level Amount  $"
                        Else
                            levelMessage = "Your Investment Level Amount  £"
                        End If
                        GlobalModule.SetMessage(lblMessageStep3, False, levelMessage + cbInvestmentLevels.SelectedValue + " must be less than the total seeking")
                    Else
                        Dim maxOfferd As Int64 = (Convert.ToInt64(txtSeeking.Text)) / Convert.ToInt64(e.Value)
                        txtMaximumOffered.Text = maxOfferd.ToString()
                    End If
                Else
                    GlobalModule.SetMessage(lblMessageStep3, False, "Please select level amount")
                End If
            Else
                index = 0
                hdnIndex.Text = index
                GlobalModule.SetMessage(lblMessageStep0, False, "Please Create Board First")
                Exit Sub
            End If
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub addLevelButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addLevelButton.Click
        Try

            If (CheckNumericValue(cbInvestmentLevels.SelectedValue) = 1) Then
                If Not (txtSeeking.Text = "") Then
                    Dim maxoffred As Int64 = (Convert.ToInt64(txtSeeking.Text)) / Convert.ToInt64(cbInvestmentLevels.SelectedValue)
                    If (Convert.ToInt64(txtMaximumOffered.Text) > maxoffred) Then
                        GlobalModule.SetMessage(lblMessageStep3, False, "Please enter value in Quantity Offered between 1 and " & maxoffred.ToString())
                        Exit Sub
                    Else
                        If addLevelButton.Text = "Add Level" Then
                            AddLevel()
                        ElseIf addLevelButton.Text = "Update Level" Then
                            UpdateLevel(Me.editLevelID.ToString())
                        End If

                        LoadBoardDescriptionInfo()
                        Dim dt As DataTable
                        dt = CType(ViewState("current"), DataTable)
                        GridViewLevel.DataSource = dt
                        GridViewLevel.DataBind()
                    End If
                Else
                    index = 0
                    hdnIndex.Text = index
                    GlobalModule.SetMessage(lblMessageStep0, False, "Please Create Board First")
                End If
            Else
                GlobalModule.SetMessage(lblMessageStep3, False, "Unable to add Investment Level Amount")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub gotoStep4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles gotoStep4.Click
        Try
            index = 4
            hdnIndex.Text = index
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub btnSendLive_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendLive.Click
        Try
            MoveProfilePic()
            SaveToDraftOrSendLive(4, "Home")
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep4, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnFinalSaveToDraft_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinalSaveToDraft.Click
        Try
            MoveProfilePic()
            SaveToDraftOrSendLive(0, "Home")

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep4, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SaveBoardLevels()
        Dim resutl As Integer
        Try
            If Me.dtBoardLevels.Rows.Count > 0 Then
                sdBoardLevels.DeleteParameters.Item("BoardID").DefaultValue = Me.BoardID
                Dim res As Integer = sdBoardLevels.Delete()
                For Each row As DataRow In Me.dtBoardLevels.Rows
                    If Not (row("LevelName") = "") Then
                        sdBoardLevels.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                        sdBoardLevels.InsertParameters.Item("LevelName").DefaultValue = row("LevelName")
                        sdBoardLevels.InsertParameters.Item("Description").DefaultValue = row("Description")
                        sdBoardLevels.InsertParameters.Item("NumOffered").DefaultValue = row("NumOffered")
                        If (CheckNumericValue(row("LevelAmount")) = 1) Then
                            sdBoardLevels.InsertParameters.Item("LevelAmount").DefaultValue = Convert.ToDouble(row("LevelAmount"))
                        Else
                            sdBoardLevels.InsertParameters.Item("LevelAmount").DefaultValue = 0
                        End If
                        resutl = sdBoardLevels.Insert()
                    End If
                Next
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SaveToDraftOrSendLive(ByVal status As Integer, ByVal redirectTo As String)
        Try
            Dim res As Integer
            If Me.BoardID = 0 Then
                index = 0
                hdnIndex.Text = index
                GlobalModule.SetMessage(lblMessageStep0, False, "Please Create Board First")
            ElseIf (Me.dtBoardLevels.Rows.Count = 0) Then
                index = 3
                hdnIndex.Text = index
                GlobalModule.SetMessage(lblMessageStep3, False, "Please Add Board Levels")
            Else
                SaveBoardLevels()
                Dim isConfigurred As Boolean
                If Me.BankLocation = "US" Then
                    isConfigurred = IsBalancedAccountConfigured()
                Else
                    isConfigurred = IsStripeAccountConfigured()
                End If
                If (isConfigurred) Then
                    If status = 4 Then
                        sdActivateBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
                        res = sdActivateBoard.Update()
                    Else
                        sdSaveStatus.UpdateParameters.Item("Status").DefaultValue = status
                        sdSaveStatus.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
                        res = sdSaveStatus.Update()
                    End If
                Else
                    sdSaveStatus.UpdateParameters.Item("Status").DefaultValue = 0
                    sdSaveStatus.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
                    res = sdSaveStatus.Update()
                End If

                If res = 1 And Me.BoardID <> 0 Then
                    SendBoardCreationEmail()
                    'If redirectTo = "Home" Then
                    '    Response.Redirect("~/Home.aspx", False)
                    'Else
                    '    Response.Redirect("~/BoardDetails.aspx?Name=" & Me.DirectoryName, False)
                    'End If
                    Response.Redirect("~/CrowdboardCommand.aspx", False)
                Else
                    GlobalModule.SetMessage(lblMessageStep4, True, "Error in Request")
                End If
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Function GetDistrictManagerEmail() As String
        Dim email As String = ""
        Try
            sdGetDistrictManagerEmail.SelectParameters.Item("AreaID").DefaultValue = Me.getAreaID
            Dim dv As Data.DataView = CType(sdGetDistrictManagerEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                email = dv(0)("Email")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return email
    End Function

    Protected Sub SendBoardCreationEmail()
        Try
            Try
                Dim managerEmail As String = GetDistrictManagerEmail()
                Dim sp As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                Dim infoEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("infoEmail")
                Dim toAddress As String
                Dim strBody As String
                Dim strSubject As String = "New CrowdBoard Created"
                If managerEmail = "" Then
                    toAddress = infoEmail
                Else
                    toAddress = infoEmail & "," & managerEmail
                End If

                Dim userLink As String = "<a style='color:#99CCFF;' href='" + sp + "/Profile.aspx?User=" + Session("UserName").ToString() + "'>@" + Session("UserName").ToString() + "</a>" & " has just created "
                Dim boardLink As String = "<a style='color:#99CCFF;' href='" + sp + "/" + Me.DirectoryName + "'>" + "@" + Me.BoardName + "@</a>"

                strBody = userLink & boardLink
                GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
            Catch ex As Exception
                Throw ex
            End Try
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Function IsBalancedAccountConfigured() As Boolean
        Dim result As Boolean = False
        Try
            sdBalancedOwnerDetails.SelectParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
            Dim dv As Data.DataView = CType(sdBalancedOwnerDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    result = True
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Private Function IsStripeAccountConfigured() As Boolean
        Dim result As Boolean = False
        Try
            sdStripeOwnerDetails.SelectParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
            Dim dv As Data.DataView = CType(sdStripeOwnerDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    result = True
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function

    Protected Sub MoveProfilePic()
        Dim fileExtention As String = String.Empty
        Try
            If (Me.BoardPicUrl <> "") Then
                Dim sourcePath As String = Server.MapPath(Me.BoardPicUrl)
                Dim tempPath As String = Server.MapPath("~/thumbnail/temp/")
                Dim dir As DirectoryInfo = New DirectoryInfo(tempPath)
                Dim files As FileInfo() = dir.GetFiles()
                If files.Length > 0 Then
                    For Each File In files
                        fileExtention = File.Extension
                    Next
                    Dim destinationPath As String = Server.MapPath("~/thumbnail/" & hdnDirectoryName.Value & fileExtention)
                    My.Computer.FileSystem.MoveFile(sourcePath, destinationPath, True)
                    EmptyTemp(tempPath)
                End If
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub EmptyTemp(ByVal tempPath As String)
        Try
            Dim filePaths As String() = Directory.GetFiles(tempPath)
            For Each filePath As String In filePaths
                File.Delete(filePath)
            Next
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub SetBankLocation()

        Try
            sdGetBankLocation.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            Dim dv As Data.DataView = CType(sdGetBankLocation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = dv(0)("BankLocation").ToString()
                    Me.BankLocation = dv(0)("BankLocation").ToString()
                Else
                    sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = "US"
                    Me.BankLocation = "US"
                End If
            Else
                sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = "US"
                Me.BankLocation = "US"
            End If
            If Me.BankLocation = "US" Then
                lblAmtType.Text = "$"
                txtSeeking.Attributes.Add("placeholder", "100")
            Else
                lblAmtType.Text = "£"
                txtSeeking.Attributes.Add("placeholder", "100")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Function CheckNumericValue(ByVal value As String) As Integer
        Dim restul As Integer = 0
        Try
            If IsNumeric(value) Then
                restul = 1
            ElseIf (value = "") Then
                restul = 0
            Else
                restul = 0
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return restul
    End Function

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function


    Protected Sub btnFinalAddExtras_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinalAddExtras.Click
        Try
            If (Me.BoardID = 0 Or Me.DirectoryName = "") Then
                GlobalModule.SetMessage(lblMessageStep0, False, "Please create board first")
                index = 0
                hdnIndex.Text = index
            Else
                MoveProfilePic()
                SaveToDraftOrSendLive(0, "BoardDetails")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep4, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub addInExtraLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addInExtraLinkButton.Click
        Try
            If (Me.BoardID = 0 Or Me.DirectoryName = "") Then
                GlobalModule.SetMessage(lblMessageStep0, False, "Please create board first")
                index = 0
                hdnIndex.Text = index
            Else
                MoveProfilePic()
                SaveToDraftOrSendLive(0, "BoardDetails")

            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep4, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub GridViewLevel_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles GridViewLevel.ItemCommand
        Try
            Dim editLevelInded As Integer = e.Item.ItemIndex + 1
            levelNumberLabel.Text = editLevelInded.ToString()
            If (e.CommandName = "Iedit") Then
                addLevelButton.Text = "Update Level"
                Me.editLevelID = e.CommandArgument.ToString()
                Dim hdnLevelName As HiddenField = CType(e.Item.FindControl("hdnLevelName"), HiddenField)
                Dim hdnDescription As HiddenField = CType(e.Item.FindControl("hdnDescription"), HiddenField)
                Dim hdnLevelAmount As HiddenField = CType(e.Item.FindControl("hdnLevelAmount"), HiddenField)
                Dim hdnMaximumOffered As HiddenField = CType(e.Item.FindControl("hdnMaximumOffered"), HiddenField)
                txtLevelName.Text = hdnLevelName.Value
                txtLevelDescription.Text = hdnDescription.Value
                cbInvestmentLevels.SelectedValue = hdnLevelAmount.Value
                txtMaximumOffered.Text = hdnMaximumOffered.Value
            ElseIf (e.CommandName = "Idelete") Then
                Me.editLevelID = e.CommandArgument.ToString()
                DeleteLevel(Me.editLevelID.ToString())
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Public Function CheckEmailExists() As Boolean
        Dim result As Boolean = False
        sdIsValidEmail.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
        Dim dv As Data.DataView = CType(sdIsValidEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not dv Is Nothing Then
            If (dv.Count > 0) Then
                If (dv(0)("EmailVerified").ToString() = "Check" Or dv(0)("EmailVerified").ToString() = "N/A") Then
                    If (Not IsDBNull(dv(0)("Email"))) Then
                        result = True
                    Else
                        result = False
                    End If
                Else
                    result = False
                End If
            End If
        End If
        Return result

    End Function


End Class