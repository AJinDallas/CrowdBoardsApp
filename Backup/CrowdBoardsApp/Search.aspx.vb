Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI

Public Class Search
    Inherits Telerik.Web.UI.RadAjaxPage

    Dim GM As New GlobalModule
    Public Property DistrictName() As String

        Get
            Return Convert.ToString(ViewState("_districtName"))
        End Get

        Set(ByVal value As String)
            ViewState("_districtName") = value
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
    Public Property showResult() As String
        Get
            Return Convert.ToString(ViewState("_showResult"))
        End Get

        Set(ByVal value As String)
            ViewState("_showResult") = value
        End Set
    End Property
    Public Property LoadType() As Integer
        Get
            Return CInt(ViewState("_loadType"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_loadType") = value
        End Set
    End Property
    Public Property districtsDataTable() As DataTable

        Get
            Return CType(ViewState("_districtsDataTable"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("_districtsDataTable") = value
        End Set
    End Property

    Public Property boardDataTable() As DataTable

        Get
            Return CType(ViewState("_boardDataTable"), DataTable)
        End Get

        Set(ByVal value As DataTable)
            ViewState("_boardDataTable") = value
        End Set
    End Property

    Public Property userDataTable() As DataTable

        Get
            Return CType(ViewState("_userDataTable"), DataTable)
        End Get

        Set(ByVal value As DataTable)
            ViewState("_userDataTable") = value
        End Set
    End Property
    Public Property areasDataTable() As DataTable

        Get
            Return CType(ViewState("_areasDataTable"), DataTable)
        End Get

        Set(ByVal value As DataTable)
            ViewState("_areasDataTable") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        RadWindow1.VisibleOnPageLoad = False
        If Session("userName") Is Nothing Then
            addDistrictRemoveButton.Visible = False
        Else
            addDistrictRemoveButton.Visible = True
        End If
        lblMessageSearch.Text = ""
        lblMessage.Text = ""

        If (Not Page.IsPostBack) Then
            Try

                LoadInitialData()
                LoadDataByQueryString()
                LoadFinalData()

            Catch ex As Exception
                GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
    End Sub
    Private Sub LoadDataByQueryString()
        Try
            If Not Request.QueryString("District") Is Nothing Then
                If Request.QueryString("District") = "" Then
                    Session("District") = "%"
                Else
                    Session("District") = Request.QueryString("District").ToString()
                    areasRepeaterDiv.Attributes.Add("style", "display:block;")
                    filterDiv.Attributes.Add("style", "display:none;")
                    LoadBoardsRepeater()
                End If
                showAllLinkButton.Visible = True
            ElseIf Not Request.QueryString("Area") Is Nothing Then
                If Request.QueryString("Area") = "" Then
                    Session("Area") = "%"
                Else
                    Session("Area") = Request.QueryString("Area").ToString()
                    Session("District") = GetDistrictName()
                    Me.AreaName = Session("Area")
                    areaRepeater.DataBind()
                    filterDiv.Attributes.Add("style", "display:none;")
                    ShowSpecificDistrictAndArea()
                    LoadBoardByArea(Me.AreaName)
                End If
                showAllLinkButton.Visible = True
            ElseIf Not Request.QueryString("searchValue") Is Nothing Then
                If Request.QueryString("searchValue") = "" Then
                    Session("searchValue") = "%"
                Else
                    Session("searchValue") = Request.QueryString("searchValue").ToString()
                    areasRepeaterDiv.Attributes.Add("style", "display:none;")
                    filterDiv.Attributes.Add("style", "display:block;")
                    LoadBoardsRepeaterBySearchValue()
                End If
            ElseIf Not Request.QueryString("FromHome") Is Nothing Then
                Session("District") = "%"
                Session("areaID") = 1
                LoadLatestBoards()
                lbtnLatestBoards.Attributes.Add("style", "color:black;")
            Else
                Session("District") = "%"
                Session("areaID") = 1
                Session("searchValue") = "%"
                LoadBoardsRepeaterBySearchValue()

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub LoadInitialData()
        Try
            LoadBoardUsers()
            Session("districtID") = 0
            Session("Area") = "%"
            SetParameters()
            areaRepeater.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub LoadFinalData()
        Try

            If (Me.DistrictName = "") Then
                If Not Request.QueryString("District") Is Nothing Then
                    Me.DistrictName = Request.QueryString("District").ToString()
                End If
            End If
            districtDataList.DataBind()

            If Me.DistrictName Is Nothing Then
                Me.DistrictName = " "
            End If
            If Me.AreaName Is Nothing Then
                Me.AreaName = " "
            End If

            Dim dv As Data.DataView = CType(sdUpdates.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("CommentCount"))) Then
                    ' lblUpdates.Text = "(" & dv(0)("CommentCount") & ")"
                End If
            End If
            If Session("userName") Is Nothing Then
                'lbtnHome.Visible = False
                'lbtnLogout.Visible = False
                'lbtnLogin.Visible = True
                'lbtnSignMeUp.Visible = True
                'updatesDiv.Visible = False
                If Request.QueryString("District") Is Nothing Then
                    wordOnStreetDiv.Attributes.Add("style", "display:none;")
                    inCrowdLatestDiv.Attributes.Add("style", "display:none;")
                End If
            End If
            ShowSpecificDistrict()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function GetDistrictName() As String
        Dim result As String = String.Empty
        Try
            sdGetDistrictName.SelectParameters.Item("AreaName").DefaultValue = Session("Area").ToString()
            Dim dv As Data.DataView = CType(sdGetDistrictName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If Not (IsDBNull(dv(0)("DistrictName"))) Then
                    result = dv(0)("DistrictName").ToString()
                End If
                If Not (IsDBNull(dv(0)("DistrictID"))) Then
                    Session("districtID") = dv(0)("DistrictID").ToString()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Public Function GetnvestorCount(ByVal count As String) As String
        Dim result As String = String.Empty
        Try
            result = result & "Investors: " & count
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String
        Dim result As String = String.Empty
        Try
            result = GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, FilePath, thumbsFilePath)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return result
    End Function
    'Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
    '    Session.Abandon()
    '    Response.Redirect("~/Default.aspx")
    'End Sub
    'Protected Sub lbtnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogin.Click
    '    Response.Redirect("~/Default.aspx")
    'End Sub
    'Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
    '    Response.Redirect("~/Home.aspx")
    'End Sub

    'Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
    '    Try
    '        ResetArea()
    '        Session("searchValue") = searchTextBox.Text
    '        Me.DistrictName = ""
    '        Me.AreaName = ""
    '        Session("Area") = ""
    '        Me.showResult = ""
    '        LoadBoardsRepeaterBySearchValue()
    '        areaRepeater.DataBind()
    '        districtDataList.DataBind()
    '        areasRepeaterDiv.Attributes.Add("style", "display:none;")
    '        filterDiv.Attributes.Add("style", "display:block;")
    '    Catch ex As Exception
    '        GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub
    Protected Sub boardsRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles boardsRepeater.ItemCommand
        Try
            If (e.CommandName.ToString() = "ToBoard") Then
                Dim directoryName As String = e.CommandArgument.ToString()
                If Not Session("UserName") Is Nothing Then

                    Response.Redirect("~/" & directoryName & "?fromSearch=1", False)
                Else
                    If (Me.LoadType = 1) Then
                        LoadBoardByArea(Me.AreaName)
                    Else
                        LoadBoardsRepeater()
                    End If

                    RadWindow1.NavigateUrl = "~/rwLogin.aspx?page=" & directoryName
                    RadWindow1.VisibleOnPageLoad = True

                    'Response.Redirect("~/Default.aspx", False)
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub boardsRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles boardsRepeater.ItemDataBound
        Try
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicDiv"), HtmlGenericControl)
            Dim largeChange As Integer
            If Not (hdnMaxValue.Value = "") Then
                thermometerSlider.MaximumValue = Convert.ToDecimal(hdnMaxValue.Value)
                largeChange = Convert.ToInt32(hdnMaxValue.Value) / 5
                thermometerSlider.LargeChange = largeChange
            Else
                thermometerSlider.MaximumValue = 5000
                largeChange = 5000 / 5
                thermometerSlider.LargeChange = largeChange
            End If
            If Not (hdnValue.Value = "") Then
                thermometerSlider.Value = Convert.ToDouble(hdnValue.Value)
            Else
                thermometerSlider.Value = 0
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub LoadDistrictDescription()
        Try
            lblDistrictDescription.Text = ""
            lblDistrictQuotation.Text = ""
            Dim dv As Data.DataView = CType(sdDistrictDesc.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If Not (IsDBNull(dv(0)("Description"))) Then
                    lblDistrictDescription.Text = dv(0)("Description").ToString()
                End If
                If Not (IsDBNull(dv(0)("Quotation"))) Then
                    lblDistrictQuotation.Text = dv(0)("Quotation").ToString()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub districtDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles districtDataList.ItemCommand
        Try
            If (e.CommandName.ToString() = "ShowBoards") Then
                areaTitleDiv.Visible = True
                Dim hdnUserCount As HiddenField = e.Item.FindControl("hdnUserCount")
                Dim districtNameLinkButton As LinkButton = e.Item.FindControl("DistrictNameLinkButton")
                Me.showResult = ""
                Dim hdnDistrictName As HiddenField = e.Item.FindControl("hdnDistrictName")
                Session("District") = hdnDistrictName.Value
                districtNameLabel.Text = "Welcome to the " & hdnDistrictName.Value & " District!"
                lblPopulationCount.Text = hdnUserCount.Value
                '  lblDistrictName.Text = hdnDistrictName.Value
                'lblDistrictCount.Text = hdnUserCount.Value
                Session("districtID") = CInt(e.CommandArgument.ToString())
                Me.DistrictName = hdnDistrictName.Value
                '
                welcomeDistrictDiv.Visible = True
                welcomeAreaDiv.Visible = False
                Me.AreaName = ""
                If (Session("Area")) Is Nothing Then
                    Session("Area") = ""
                End If

                Me.ViewState("CurrentPage") = Nothing
                Dim hdnIsExists As HiddenField = e.Item.FindControl("hdnIsExists")
                SetDistrictAddRemoveText(hdnIsExists.Value)
                Session("hdnIsExists") = hdnIsExists.Value
                Me.LoadType = 0
                LoadBoardsRepeater()
                LoadDistrictDescription()
            End If
            districtDataList.DataBind()
            Dim hdnRowID As HiddenField = e.Item.FindControl("hdnDistrictRowNumber")
            areaRepeater.DataBind()
            If (Me.showResult <> "") Then
                LoadBoardByArea(Me.AreaName)
            Else
                LoadBoardsRepeater()
            End If
            If Not Session("userName") Is Nothing Then
                wordOnStreetDiv.Attributes.Add("style", "display:block;")
                inCrowdLatestDiv.Attributes.Add("style", "display:none;")
                txtPostOnDistrict.Text = "@" & Me.DistrictName & "District"
                ' districtSpecificPostTextBox.Text = "@" & Me.DistrictName & "District"
            End If
            areasRepeaterDiv.Attributes.Add("style", "display:block;")
            filterDiv.Attributes.Add("style", "display:none;")
            showAllLinkButton.Visible = True

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub areaRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles areaRepeater.ItemCommand
        Try
            'ResetArea()
            If (e.CommandName.ToString() = "ShowBoards") Then
                Session("areaID") = CInt(e.CommandArgument.ToString())
                Dim hdnRowID As HiddenField = e.Item.FindControl("hdnRowNumber")
                Dim hdnAreaName As HiddenField = e.Item.FindControl("hdnAreaName")
                Me.AreaName = hdnAreaName.Value
                lblAreaNameWelcome.Text = "Welcome to the " & Me.AreaName & " Area!"
                welcomeDistrictDiv.Visible = False
                welcomeAreaDiv.Visible = True
                Session("Area") = Me.AreaName
                Me.showResult = "Show"
                Me.ViewState("CurrentPage") = Nothing
                Dim hdnIsExists As HiddenField = e.Item.FindControl("hdnIsExists")
                SetAreaAddRemoveText(hdnIsExists.Value)
                Me.LoadType = 1
                LoadBoardByArea(hdnAreaName.Value)
                ' LoadBoardByArea(Me.AreaName)


            End If
            areaRepeater.DataBind()
            If Not Session("userName") Is Nothing Then
                wordOnStreetDiv.Attributes.Add("style", "display:none;")
                inCrowdLatestDiv.Attributes.Add("style", "display:block;")
                txtInCrowdLatestPost.Text = "@" & Me.AreaName & "incrowd"
                areaSpecificPostTextBox.Text = "@" & Me.AreaName & "incrowd"
                wordOntheStreetRepeater.DataBind()
                inCrowdLatestRepeater.DataBind()
                ' districtSpecificNewsDataList.DataBind()
                areaSpecificNewsDataList.DataBind()
                areaSpecificNewsDataListPost.DataBind()
            End If
            showAllLinkButton.Visible = True
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Private Sub ResetArea()
        Try
            Me.AreaName = ""
            Session("Area") = Nothing
            Me.DistrictName = ""
            Session("areaID") = Nothing
            Session("District") = Nothing
            Session("searchValue") = Nothing
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardsRepeater()
        Try
            pagingDiv.Visible = False
            sdBoards.SelectParameters.Item("District").DefaultValue = Session("District").ToString()
            Dim dv As Data.DataView = CType(sdBoards.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim pagedDataSource As New PagedDataSource()

            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 12
            pagedDataSource.CurrentPageIndex = CurrentPage
            lblShowPangeNumber.Text = "Showing Page: " & (CurrentPage + 1).ToString() & " of " & pagedDataSource.PageCount.ToString()
            If Not (dv) Is Nothing Then

                If (dv.Count = 0) Then
                    createNewboardDiv.Visible = True
                Else
                    createNewboardDiv.Visible = False
                End If

                If (dv.Count = 0 Or dv.Count <= 12) Then

                    pagingDiv.Visible = False
                Else
                    pagingDiv.Visible = True
                End If
                btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
                btnNext.Enabled = Not pagedDataSource.IsLastPage
                boardsRepeater.DataSource = pagedDataSource
                boardsRepeater.DataBind()
                Me.DistrictName = Session("District").ToString()
                If Not Session("userName") Is Nothing Then
                    If Not (Session("District").ToString() = "%") Then
                        wordOnStreetDiv.Attributes.Add("style", "display:block;")
                        inCrowdLatestDiv.Attributes.Add("style", "display:none;")
                        txtPostOnDistrict.Text = "@" & Session("District").ToString() & "District"
                    End If
                End If
            Else
                createNewboardDiv.Visible = True
                pagingDiv.Visible = False
                GlobalModule.SetMessage(lblMessageSearch, False, "Enter Text to Search for and Click Search")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardsRepeaterBySearchValue()
        Try
            pagingDiv.Visible = False
            sdSearchValue.SelectParameters.Item("searchValue").DefaultValue = Session("searchValue").ToString()
            Dim dv As Data.DataView = CType(sdSearchValue.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 12
            pagedDataSource.CurrentPageIndex = CurrentPage
            lblShowPangeNumber.Text = "Showing Page: " & (CurrentPage + 1).ToString() & " of " & pagedDataSource.PageCount.ToString()
            If Not (dv) Is Nothing Then
                If (dv.Count = 0) Then
                    createNewboardDiv.Visible = True
                Else
                    createNewboardDiv.Visible = False
                End If

                If (dv.Count = 0 Or dv.Count <= 12) Then
                    pagingDiv.Visible = False
                Else
                    pagingDiv.Visible = True
                End If
                btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
                btnNext.Enabled = Not pagedDataSource.IsLastPage
                boardsRepeater.DataSource = pagedDataSource
                boardsRepeater.DataBind()
            Else
                createNewboardDiv.Visible = True
                pagingDiv.Visible = False
                GlobalModule.SetMessage(lblMessageSearch, False, "Enter Text to Search for and Click Search")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadLatestBoards()
        Try
            pagingDiv.Visible = False
            Dim dv As Data.DataView = CType(sdAllBoards.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 12
            pagedDataSource.CurrentPageIndex = CurrentPage
            lblShowPangeNumber.Text = "Showing Page: " & (CurrentPage + 1).ToString() & " of " & pagedDataSource.PageCount.ToString()
            If Not (dv) Is Nothing Then
                If (dv.Count = 0) Then
                    createNewboardDiv.Visible = True
                Else
                    createNewboardDiv.Visible = False
                End If

                If (dv.Count = 0 Or dv.Count <= 12) Then
                    pagingDiv.Visible = False
                Else
                    pagingDiv.Visible = True
                End If
                btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
                btnNext.Enabled = Not pagedDataSource.IsLastPage
                boardsRepeater.DataSource = pagedDataSource
                boardsRepeater.DataBind()
            Else
                createNewboardDiv.Visible = True
                pagingDiv.Visible = False
                GlobalModule.SetMessage(lblMessageSearch, False, "Enter Text to Search for and Click Search")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardByArea(ByVal areaName As String)
        Try
            pagingDiv.Visible = False
            sdsLoadBordByArea.SelectParameters.Item("Area").DefaultValue = areaName
            Dim dvLoadBordByArea As Data.DataView = CType(sdsLoadBordByArea.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dvLoadBordByArea) Is Nothing Then

                If (dvLoadBordByArea.Count = 0) Then
                    createNewboardDiv.Visible = True
                Else
                    createNewboardDiv.Visible = False
                End If

                If dvLoadBordByArea.Count > 0 Then
                    If Not (IsDBNull(dvLoadBordByArea(0)("areaCount"))) Then
                        areaPopulationLabel.Text = dvLoadBordByArea(0)("areaCount").ToString()
                    Else
                        areaPopulationLabel.Text = "0"
                    End If
                Else
                    areaPopulationLabel.Text = "0"
                End If
            Else
                areaPopulationLabel.Text = "0"
            End If

            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dvLoadBordByArea
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 12
            pagedDataSource.CurrentPageIndex = CurrentPage

            lblShowPangeNumber.Text = "Showing Page: " & (CurrentPage + 1).ToString() & " of " & pagedDataSource.PageCount.ToString()
            If Not (dvLoadBordByArea) Is Nothing Then
                If (dvLoadBordByArea.Count = 0 Or dvLoadBordByArea.Count <= 12) Then
                    pagingDiv.Visible = False
                Else
                    pagingDiv.Visible = True
                End If
            Else
                createNewboardDiv.Visible = True
                pagingDiv.Visible = False
            End If
            btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
            btnNext.Enabled = Not pagedDataSource.IsLastPage
            boardsRepeater.DataSource = pagedDataSource
            boardsRepeater.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Property CurrentPage() As Integer
        Get
            Dim pageNumber As Object = Me.ViewState("CurrentPage")
            If pageNumber Is Nothing Then

                Return 0
            Else
                Return CInt(pageNumber)
            End If
        End Get
        Set(ByVal value As Integer)
            Me.ViewState("CurrentPage") = value
        End Set
    End Property
    Protected Sub btnPrevious_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPrevious.Click
        Try
            CurrentPage -= 1
            If (Me.showResult <> "") Then
                LoadBoardByArea(Me.AreaName)
            Else
                If Not Session("District") Is Nothing Then
                    LoadBoardsRepeater()
                Else
                    LoadBoardsRepeaterBySearchValue()
                End If
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Try
            CurrentPage += 1
            If (Me.showResult <> "") Then
                LoadBoardByArea(Me.AreaName)
            Else
                If Not Session("District") Is Nothing Then
                    LoadBoardsRepeater()
                Else
                    LoadBoardsRepeaterBySearchValue()
                End If
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try

    End Sub
    Protected Sub SetParameters()
        Try
            If Not Session("UserID") Is Nothing Then
                sdDistricts.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                sdUserDistricts.InsertParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                sdUserDistricts.DeleteParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                sdAreas.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            Else
                sdDistricts.SelectParameters.Item("UserID").DefaultValue = 0
                sdAreas.SelectParameters.Item("UserID").DefaultValue = 0
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function GetDivAreaImageURL() As String
        Return "Images/IMG_TV.png"
    End Function

    Private Sub SetDistrictAddRemoveText(ByVal isExists As String)
        If (isExists = 0) Then
            addDistrictRemoveButton.Text = "Add to My Districts"
            postOnDistrictDiv.Visible = False
        Else
            postOnDistrictDiv.Visible = True
            addDistrictRemoveButton.Text = "Added to My Districts"
        End If
    End Sub
    Protected Sub addDistrictRemoveButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addDistrictRemoveButton.Click
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx")
                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:GoToLogin();", True)
            ElseIf (addDistrictRemoveButton.Text = "Add to My Districts") Then
                sdUserDistricts.InsertParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                sdUserDistricts.InsertParameters.Item("DistrictID").DefaultValue = Convert.ToInt32(Session("districtID"))
                sdUserDistricts.Insert()
                SetDistrictAddRemoveText(1)
            ElseIf (addDistrictRemoveButton.Text = "Added to My Districts") Then
                sdUserDistricts.DeleteParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                sdUserDistricts.DeleteParameters.Item("DistrictID").DefaultValue = Convert.ToInt32(Session("districtID"))
                sdUserDistricts.Delete()
                SetDistrictAddRemoveText(0)
            End If
            areaRepeater.DataBind()
            If (Me.showResult <> "") Then
                LoadBoardByArea(Me.AreaName)
            Else
                LoadBoardsRepeater()
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub ShowSpecificDistrict()
        Try
            For Each districList As DataListItem In districtDataList.Items
                Dim link As LinkButton = DirectCast(districList.FindControl("DistrictNameLinkButton"), LinkButton)
                If Not Request.QueryString("District") Is Nothing Then
                    If (link.Text = Request.QueryString("District").ToString()) Then
                        Me.showResult = ""
                        Dim hdnDistrictName As HiddenField = districList.FindControl("hdnDistrictName")
                        Dim hdnUserCount As HiddenField = districList.FindControl("hdnUserCount")
                        Session("District") = hdnDistrictName.Value
                        Me.DistrictName = hdnDistrictName.Value

                        districtNameLabel.Text = "Welcome to the " & hdnDistrictName.Value & " District! (Population  :" & hdnUserCount.Value & ")"
                        Dim hdndistrictID As HiddenField = districList.FindControl("hdndistrictID")
                        Session("districtID") = hdndistrictID.Value
                        Me.DistrictName = hdnDistrictName.Value
                        Me.ViewState("CurrentPage") = Nothing
                        Dim hdnIsExists As HiddenField = districList.FindControl("hdnIsExists")
                        SetDistrictAddRemoveText(hdnIsExists.Value)
                        LoadBoardsRepeater()
                        LoadDistrictDescription()
                    End If
                End If
            Next
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub ShowSpecificDistrictAndArea()
        Try
            For Each districList As DataListItem In districtDataList.Items
                Dim link As LinkButton = DirectCast(districList.FindControl("DistrictNameLinkButton"), LinkButton)
                If Not Session("District") Is Nothing Then
                    If (link.Text = Session("District").ToString()) Then
                        Me.showResult = ""
                        Dim hdnDistrictName As HiddenField = districList.FindControl("hdnDistrictName")
                        Dim hdnUserCount As HiddenField = districList.FindControl("hdnUserCount")
                        Session("District") = hdnDistrictName.Value
                        Me.DistrictName = hdnDistrictName.Value

                        districtNameLabel.Text = "Welcome to the " & hdnDistrictName.Value & " District! (Population  :" & hdnUserCount.Value & ")"
                        Dim hdndistrictID As HiddenField = districList.FindControl("hdndistrictID")
                        Session("districtID") = hdndistrictID.Value
                        Me.DistrictName = hdnDistrictName.Value
                        Me.ViewState("CurrentPage") = Nothing
                        Dim hdnIsExists As HiddenField = districList.FindControl("hdnIsExists")
                        SetDistrictAddRemoveText(hdnIsExists.Value)
                        LoadDistrictDescription()
                    End If
                End If
            Next
            For Each areaRepeaterItem As RepeaterItem In areaRepeater.Items
                Dim link As HiddenField = DirectCast(areaRepeaterItem.FindControl("hdnAreaName"), HiddenField)
                If Not Session("Area") Is Nothing Then
                    If (link.Value = Session("Area").ToString()) Then
                        Dim hdnIsExists As HiddenField = areaRepeaterItem.FindControl("hdnIsExists")
                        SetAreaAddRemoveText(hdnIsExists.Value)
                    End If
                End If
            Next
            If Not Session("userName") Is Nothing Then
                wordOnStreetDiv.Attributes.Add("style", "display:none;")
                inCrowdLatestDiv.Attributes.Add("style", "display:block;")
                txtInCrowdLatestPost.Text = "@" & Me.AreaName & "incrowd"
                areaSpecificPostTextBox.Text = "@" & Me.AreaName & "incrowd"
            End If
            areasRepeaterDiv.Attributes.Add("style", "display:block;")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub incrowdLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles incrowdLinkButton.Click
        Try
            radMultiPageMiddle.SelectedIndex = 0
            setCss()
            incrowdLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub

    Protected Sub viewIncrowdLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles viewIncrowdLinkButton.Click
        Try
            radMultiPageMiddle.SelectedIndex = 1
            setCss()
            viewIncrowdLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub incrowdPostLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles incrowdPostLinkButton.Click
        Try
            setCss()
            incrowdPostLinkButton.Attributes.Add("style", "text-decoration:underline")
            radMultiPageMiddle.SelectedIndex = 2

            If (joinAreaLinkButton.Text = "Join") Then
                areaPostDiv.Visible = False
            Else
                areaPostDiv.Visible = True
            End If
            If Not Session("userName") Is Nothing Then
                Dim GM As New GlobalModule
                Dim path As String = GM.GetImageURL(Session("userName") & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")
                userProfileImage.Src = path
                userNameLabel.Text = Session("userName").ToString()
            End If


        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub setCss()
        incrowdPostLinkButton.Attributes.Add("style", "text-decoration:none")
        viewIncrowdLinkButton.Attributes.Add("style", "text-decoration:none")
        incrowdLinkButton.Attributes.Add("style", "text-decoration:none")
    End Sub

    Protected Sub btnViewFullWordOnStreetNews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewFullWordOnStreetNews.Click
        Try
            Response.Redirect("~/Wordonthestreet.aspx", False)
            'radMultiPage1.SelectedIndex = 1
            'LoadBoardsRepeater()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
        End Try
    End Sub
    Protected Sub btnViewFullInCrowdLatest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewFullInCrowdLatest.Click
        Try

            radMultiPage1.SelectedIndex = 1
            LoadBoardByArea(Me.AreaName)
            incrowdLinkButton.Attributes.Add("style", "text-decoration:underline")
            backFromAllAreaNews.Text = "Back to " & Me.AreaName & " Area"
            selectedAreaNameLable.Text = Me.AreaName & " Incrowd "
            incrowdLinkButton.Attributes.Add("class", "focus")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
        End Try
    End Sub
    Protected Sub areaPopulationLabel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles areaPopulationLabel.Click
        Try
            radMultiPage1.SelectedIndex = 1
            LoadBoardByArea(Me.AreaName)
            'incrowdLinkButton.Attributes.Add("style", "text-decoration:underline")
            backFromAllAreaNews.Text = "Back to " & Me.AreaName & " Area"
            selectedAreaNameLable.Text = Me.AreaName & " Incrowd "
            viewIncrowdLinkButton.Attributes.Add("class", "focus")
            radMultiPageMiddle.SelectedIndex = 1
            setCss()
            viewIncrowdLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub backFromAllAreaNews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles backFromAllAreaNews.Click
        Try
            radMultiPage1.SelectedIndex = 0
            Me.AreaName = Session("Area").ToString()
            LoadBoardByArea(Me.AreaName)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
        End Try
    End Sub
    'Protected Sub backFromAllDistrictNews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles backFromAllDistrictNews.Click
    '    Try
    '        radMultiPage1.SelectedIndex = 0
    '        LoadBoardsRepeater()
    '    Catch ex As Exception
    '        GlobalModule.ErrorLogFile(ex)
    '        GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
    '    End Try
    'End Sub
    Private Sub SetAreaAddRemoveText(ByVal isExists As String)
        If (isExists = 0) Then
            joinAreaLinkButton.Text = "Join"
            btnJoinIncrowdArea.Text = "Join Incrowd"
            postOnAreaDiv.Visible = False
        Else
            postOnAreaDiv.Visible = True
            joinAreaLinkButton.Text = "Incrowd Member"
            btnJoinIncrowdArea.Text = "Incrowd Member"
        End If

        If (joinAreaLinkButton.Text = "Join") Then
            areaPostDiv.Visible = False
        Else
            areaPostDiv.Visible = True
        End If

    End Sub
    Protected Sub joinAreaLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles joinAreaLinkButton.Click
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx")
            ElseIf (joinAreaLinkButton.Text = "Join") Then
                sdUserAreas.InsertParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                sdUserAreas.InsertParameters.Item("AreaID").DefaultValue = Session("areaID").ToString()
                sdUserAreas.Insert()
                SetAreaAddRemoveText(1)
            ElseIf (joinAreaLinkButton.Text = "Incrowd Member") Then
                sdUserAreas.DeleteParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                sdUserAreas.DeleteParameters.Item("AreaID").DefaultValue = Session("areaID").ToString()
                sdUserAreas.Delete()
                SetAreaAddRemoveText(0)
            End If
            viewInCrowdDataList.DataBind()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
        End Try
    End Sub
    Protected Sub btnJoinIncrowdArea_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnJoinIncrowdArea.Click
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx")
            ElseIf (btnJoinIncrowdArea.Text = "Join Incrowd") Then
                sdUserAreas.InsertParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                sdUserAreas.InsertParameters.Item("AreaID").DefaultValue = Session("areaID").ToString()
                sdUserAreas.Insert()
                SetAreaAddRemoveText(1)
            ElseIf (btnJoinIncrowdArea.Text = "Incrowd Member") Then
                sdUserAreas.DeleteParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                sdUserAreas.DeleteParameters.Item("AreaID").DefaultValue = Session("areaID").ToString()
                sdUserAreas.Delete()
                SetAreaAddRemoveText(0)
            End If
            viewInCrowdDataList.DataBind()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub SubmitPost(ByVal postText As String)
        Try
            If postText <> "" Then

                sdPosts.SelectParameters.Item("Text").DefaultValue = CheckBoarName(postText)
                sdPosts.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If dv.Count > 0 Then
                    SaveAttachment(Convert.ToInt32(dv(0)("PostID")))
                    GlobalModule.SetMessage(lblMessage, True, "Post added succesfully")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Post not added")
                End If
            Else
                GlobalModule.SetMessage(lblMessage, False, "Post is blank")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub SaveAttachment(ByVal ID As Integer)

        Try
            Dim path As String = System.IO.Path.Combine(Server.MapPath("~/Upload/UserPostsFiles/Temp"))
            Dim FileDirectory As New DirectoryInfo(path)
            Dim myLocalFileInfo As FileInfo()
            myLocalFileInfo = FileDirectory.GetFiles()
            If myLocalFileInfo.Length > 0 Then
                Dim fileName As String = ID.ToString() & "_" + myLocalFileInfo(0).ToString()
                Dim physicalPath As String = System.IO.Path.Combine(Server.MapPath("~/Upload/UserPostsFiles/"), fileName)
                myLocalFileInfo(0).MoveTo(physicalPath)
                sdPosts.UpdateParameters.Item("PostID").DefaultValue = ID
                sdPosts.UpdateParameters.Item("AttachedFileName").DefaultValue = fileName
                sdPosts.Update()
            End If
        Catch ex As Exception
            Throw ex

        End Try
    End Sub

    Protected Sub btnPostOnDitrict_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPostOnDitrict.Click
        Try
            SubmitPost(txtPostOnDistrict.Text)
            txtPostOnDistrict.Text = "@" & Session("District").ToString() & "District"
            wordOntheStreetRepeater.DataBind()
            inCrowdLatestRepeater.DataBind()
            ' districtSpecificNewsDataList.DataBind()
            areaSpecificNewsDataList.DataBind()
            areaSpecificNewsDataListPost.DataBind()
            LoadBoardsRepeater()
            LoadDistrictDescription()
            txtPostOnDistrict.Text = ""
            txtPostOnDistrict.Focus()

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub btnInCrowdLatestPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInCrowdLatestPost.Click
        Try
            SubmitPost(txtInCrowdLatestPost.Text)
            txtInCrowdLatestPost.Text = "@" & Me.AreaName & "incrowd"
            wordOntheStreetRepeater.DataBind()
            inCrowdLatestRepeater.DataBind()
            '  districtSpecificNewsDataList.DataBind()
            areaSpecificNewsDataList.DataBind()
            areaSpecificNewsDataListPost.DataBind()
            LoadBoardByArea(Me.AreaName)
            LoadDistrictDescription()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    'Protected Sub addDistrictSpecificPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addDistrictSpecificPost.Click
    '    Try
    '        ' SubmitPost(districtSpecificPostTextBox.Text)
    '        ' districtSpecificPostTextBox.Text = "@" & Session("District").ToString() & "District"
    '        wordOntheStreetRepeater.DataBind()
    '        inCrowdLatestRepeater.DataBind()
    '        ' districtSpecificNewsDataList.DataBind()
    '        areaSpecificNewsDataList.DataBind()
    '        areaSpecificNewsDataListPost.DataBind()
    '        LoadBoardsRepeater()
    '        LoadDistrictDescription()
    '    Catch ex As Exception
    '        GlobalModule.ErrorLogFile(ex)
    '        GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
    '    End Try
    'End Sub
    Protected Sub addAreaSpecificPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addAreaSpecificPost.Click
        Try
            SubmitPost(areaSpecificPostTextBox.Text)
            areaSpecificPostTextBox.Text = "@" & Me.AreaName & "incrowd"
            wordOntheStreetRepeater.DataBind()
            inCrowdLatestRepeater.DataBind()
            ' districtSpecificNewsDataList.DataBind()
            areaSpecificNewsDataList.DataBind()
            areaSpecificNewsDataListPost.DataBind()
            LoadBoardByArea(Me.AreaName)
            LoadDistrictDescription()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnMostRaised_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMostRaised.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("MostRaised", "")
            SetCssActive(lbtnMostRaised)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnMostActive_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMostActive.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("MostActive", "")
            SetCssActive(lbtnMostActive)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLatestBoards_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLatestBoards.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LatestBoards", "")
            SetCssActive(lbtnLatestBoards)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub

    Private Sub SetCssActive(ByVal activeLink As LinkButton)

        lbtnMostActive.Attributes.Add("style", "color:#ececee;")
        lbtnMostRaised.Attributes.Add("style", "color:#ececee;")
        lbtnMostWatched.Attributes.Add("style", "color:#ececee;")
        lbtnLatestBoards.Attributes.Add("style", "color:#ececee;")
        lbtnLevel9Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel8Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel7Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel6Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel5Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel4Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel3Plus.Attributes.Add("style", "color:#ececee;")
        lbtnLevel2Plus.Attributes.Add("style", "color:#ececee;")
        activeLink.Attributes.Add("style", "color:#494949;")

    End Sub
    Protected Sub showAllLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles showAllLinkButton.Click
        Try

            showAllLinkButton.Visible = False
            Response.Redirect("~/Search.aspx", False)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel2Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel2Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'2','3','4','5','6','7','8','9','10'")
            SetCssActive(lbtnLevel2Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel3Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel3Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'3','4','5','6','7','8','9','10'")
            SetCssActive(lbtnLevel3Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel4Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel4Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'4','5','6','7','8','9','10'")
            SetCssActive(lbtnLevel4Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel5Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel5Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'5','6','7','8','9','10'")
            SetCssActive(lbtnLevel5Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel6Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel6Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'6','7','8','9','10'")
            SetCssActive(lbtnLevel6Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel7Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel7Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'7','8','9','10'")
            SetCssActive(lbtnLevel7Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel8Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel8Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'8','9','10'")
            SetCssActive(lbtnLevel8Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub
    Protected Sub lbtnLevel9Plus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevel9Plus.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("LevelPlus", "'9','10'")
            SetCssActive(lbtnLevel9Plus)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub

    Protected Sub lbtnMostWatched_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMostWatched.Click
        Try
            Me.ViewState("CurrentPage") = Nothing
            LoadBoardsFiltered("MostWatched", "")
            SetCssActive(lbtnMostWatched)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub

    Protected Sub LoadBoardsFiltered(ByVal type As String, ByVal Levels As String)
        Try
            pagingDiv.Visible = False

            Dim dv As New Data.DataView
            If (type = "LevelPlus") Then
                sdLoadBoardsByLevel.SelectParameters.Item("Levels").DefaultValue = Levels
                dv = CType(sdLoadBoardsByLevel.Select(DataSourceSelectArguments.Empty), Data.DataView)
            ElseIf (type = "MostRaised") Then
                dv = CType(sdLoadBoardsMostRaised.Select(DataSourceSelectArguments.Empty), Data.DataView)
            ElseIf (type = "MostWatched") Then
                dv = CType(sdLoadBoardsMostWatched.Select(DataSourceSelectArguments.Empty), Data.DataView)
            ElseIf (type = "MostActive") Then
                dv = CType(sdLoadBoardsMostActive.Select(DataSourceSelectArguments.Empty), Data.DataView)
            ElseIf (type = "LatestBoards") Then
                dv = CType(sdAllBoards.Select(DataSourceSelectArguments.Empty), Data.DataView)
            End If
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 12
            pagedDataSource.CurrentPageIndex = CurrentPage

            lblShowPangeNumber.Text = "Showing Page: " & (CurrentPage + 1).ToString() & " of " & pagedDataSource.PageCount.ToString()
            If Not (dv) Is Nothing Then
                If (dv.Count = 0 Or dv.Count <= 12) Then
                    pagingDiv.Visible = False
                Else
                    pagingDiv.Visible = True
                End If
            Else
                pagingDiv.Visible = False
            End If
            btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
            btnNext.Enabled = Not pagedDataSource.IsLastPage
            boardsRepeater.DataSource = pagedDataSource
            boardsRepeater.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Public Function CheckBoarName(ByVal postMessage As String) As String
        Try
            If (postMessage.Contains("@")) Then


                Dim boards As String() = postMessage.Split("@")
                For Each brd As String In boards
                    If postMessage.Contains("@" + brd.Trim() + "@") AndAlso brd.Trim() <> "" Then
                        postMessage = postMessage.Replace("@" + brd.Trim() + "@", "$" + brd.Trim() + "$")
                    End If
                Next

                Dim split As String() = Regex.Split(postMessage, " ")
                For Each part As String In split
                    If (part.Contains("@")) Then
                        Dim userNameValue = part
                        part = part.Replace("@", "")
                        Dim strQuery As String = "UserName ='" & part.ToString() & "'"
                        Dim dr As DataRow()
                        dr = Me.userDataTable.Select(strQuery)
                        If dr.Length <> 0 Then
                            Dim sp As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                            Dim urlString As String = "<a style='color:#99CCFF;' href='" + sp + "/Profile.aspx?User=" + dr(0)("UserName").ToString() + "'>" + userNameValue + "</a>"
                            postMessage = postMessage.Replace(userNameValue.ToString(), urlString)
                        End If
                    End If
                Next
                Dim words As String() = postMessage.Split("$")
                If Not (words) Is Nothing Then
                    If (words.Length <> 0) Then
                        For i As Integer = 0 To words.Length - 1
                            If postMessage.Contains("$" + words(i).ToString().Trim() + "$") AndAlso words(i).ToString().Trim() <> "" Then
                                Dim strQuery As String = "BoardName ='" & words(i).ToString() & "'"
                                Dim dr As DataRow()
                                dr = Me.boardDataTable.Select(strQuery)
                                If dr.Length <> 0 Then
                                    Dim s As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                                    Dim urlString As String = "<a style='color:#99CCFF;' href='" + s + "/" + dr(0)("DirectoryName").ToString() + "'>" + "@" + words(i).ToString() + "@</a>"
                                    postMessage = postMessage.Replace("$" + words(i).ToString() + "$", urlString)
                                End If
                            End If
                        Next
                    End If
                End If
            End If
            If (postMessage.Contains("incrowd")) Then
                For Each dr As DataRow In Me.areasDataTable.Rows
                    Dim areaName As String = dr("AreaName").ToString()
                    If (postMessage.Contains(areaName)) Then
                        Dim strAr As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                        Dim urlArStr As String = "<a style='color:#48a88d;' href='" + strAr + "/Search.aspx?Area=" + areaName + "'>" + "@" + areaName + "incrowd</a>"
                        postMessage = postMessage.Replace("@" + areaName + "incrowd", urlArStr)
                    End If
                Next
            End If
            If (postMessage.Contains("District") Or postMessage.Contains("district")) Then
                For Each dr As DataRow In Me.districtsDataTable.Rows
                    Dim districtName As String = dr("DistrictName").ToString()
                    If (postMessage.Contains(districtName)) Then
                        Dim strAr As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                        Dim urlArStr As String = "<a style='color:#99CCFF;' href='" + strAr + "/Search.aspx?District=" + districtName + "'>" + "@" + districtName + "District</a>"
                        postMessage = postMessage.Replace("@" + districtName + "District", urlArStr)
                    End If
                Next
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        If (postMessage.Contains("$")) Then
            postMessage = postMessage.Replace("$", "@")
        End If

        Return postMessage
    End Function
    Private Sub LoadBoardUsers()
        Try

            Dim userDataView As DataView = CType(sdCheckuserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Me.userDataTable = userDataView.ToTable

            Dim dataViewAllBoards As DataView = CType(sdCheckBoardName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Me.boardDataTable = dataViewAllBoards.ToTable

            Dim dataViewArea As DataView = CType(sdAllAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Me.areasDataTable = dataViewArea.ToTable
            Dim dataViewDistricts As DataView = CType(sdsDistricts.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Me.districtsDataTable = dataViewDistricts.ToTable
        Catch ex As Exception

        End Try
    End Sub
    Private Sub WaitForLoading()
        Try

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function

    Protected Sub wordOntheStreetRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles wordOntheStreetRepeater.ItemCommand
        Try
            Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
            Dim lblComment As Label = CType(e.Item.FindControl("lblComment"), Label)
            If (e.CommandName = "IComment") Then
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleCommentFull"), RadTextBox)
                AddComment(txtSingleComment, postID)
                BindAllNews()
                ' BindNews()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
            ElseIf (e.CommandName = "IRecommend") Then
                Dim lbtnRecommendsNewsAll As LinkButton = CType(e.Item.FindControl("lbtnRecommendsNewsAllFull"), LinkButton)
                If (lbtnRecommendsNewsAll.Text = "Recommend") Then
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = True
                Else
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = False
                End If
                sdIRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                sdIRecommend.SelectParameters.Item("PostID").DefaultValue = postID
                Dim dv As Data.DataView = CType(sdIRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
                BindAllNews()
                ' BindNews()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
            ElseIf (e.CommandName = "IBoostOnFacebook") Then
                Session("IsFbShare") = postID.ToString()
                Session("PagePrompt") = "Search.aspx"
                FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))
            ElseIf (e.CommandName = "IBoostOnTwitter") Then
                If Not TwitterConnect.IsAuthorized Then
                    Dim twitter As New TwitterConnect()
                    Session("IsTwitterShare") = postID.ToString()
                    Session("tweetMessage") = lblComment.Text
                    twitter.Authorize(Request.Url.AbsoluteUri.Split("?"c)(0))
                End If
            End If

        Catch ex As Exception
            '  GlobalModule.SetMessage(messageLabel, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub AddComment(ByVal txtComment As RadTextBox, ByVal postID As String)
        Try
            If txtComment.Text.Trim() <> "" Then
                Dim comment As String = CheckBoarName(txtComment.Text)
                sdCommentOnPost.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
                sdCommentOnPost.InsertParameters.Item("PostID").DefaultValue = postID
                sdCommentOnPost.InsertParameters.Item("Comment").DefaultValue = comment
                sdCommentOnPost.Insert()
                txtComment.Text = ""
            End If
        Catch ex As Exception
            Throw ex

        End Try
    End Sub

    Protected Sub BindAllNews()
        Try
            wordOntheStreetRepeater.DataBind()
            'Dim dv As Data.DataView = CType(sdCrowdNewsFull.Select(DataSourceSelectArguments.Empty), Data.DataView)
            'crowdNewsAllDataListFull.DataSource = dv
            'crowdNewsAllDataListFull.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub wordOntheStreetRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles wordOntheStreetRepeater.ItemDataBound
        Try

            Dim hdnPostID = TryCast(e.Item.FindControl("hdnPostIDFull"), HiddenField)

            Dim singlePostRepliesDataListFull As DataList = TryCast(e.Item.FindControl("singlePostRepliesDataListFull"), DataList)

            sdPostReplies.SelectParameters.Item("PostID").DefaultValue = hdnPostID.Value
            Dim dv As Data.DataView = CType(sdPostReplies.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then

                singlePostRepliesDataListFull.DataSource = dv
                singlePostRepliesDataListFull.DataBind()
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub fileAttachButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles fileAttachButton.Click
        Try
            If fileAttachRadAsyncUpload.UploadedFiles.Count > 0 Then

                If Not Directory.Exists(System.IO.Path.Combine(Server.MapPath("~/Upload/UserPostsFiles/Temp"))) Then
                    Directory.CreateDirectory(System.IO.Path.Combine(Server.MapPath("~/Upload/UserPostsFiles/Temp")))
                Else
                    Dim path As String = System.IO.Path.Combine(Server.MapPath("~/Upload/UserPostsFiles/Temp"))
                    Dim FileDirectory As New DirectoryInfo(path)
                    Dim myLocalFileInfo As FileInfo()
                    myLocalFileInfo = FileDirectory.GetFiles()
                    For Each file In myLocalFileInfo
                        file.Delete()
                    Next
                End If
                For Each upFiles As UploadedFile In fileAttachRadAsyncUpload.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/Upload/UserPostsFiles/Temp") & "\\" & upFiles.GetName())
                Next
                GlobalModule.SetMessage(lblMessage, True, "File attached successfully")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub areaSpecificNewsDataListPost_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles areaSpecificNewsDataListPost.ItemCommand
        Try
            Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
            Dim lblComment As Label = CType(e.Item.FindControl("lblCommentFull"), Label)
            If (e.CommandName = "IComment") Then
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleComment"), RadTextBox)
                AddComment(txtSingleComment, postID)
                areaSpecificNewsDataListPost.DataBind()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadAreaPopupBoxPostAllFull(" & postID.ToString() & ");", True)
                Exit Sub
            ElseIf (e.CommandName = "IRecommend") Then
                Dim lbtnRecommendsNewsAll As LinkButton = CType(e.Item.FindControl("lbtnRecommendsPost1"), LinkButton)
                If (lbtnRecommendsNewsAll.Text = "Recommend") Then
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = True
                Else
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = False
                End If
                sdIRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                sdIRecommend.SelectParameters.Item("PostID").DefaultValue = postID
                Dim dv As Data.DataView = CType(sdIRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
                areaSpecificNewsDataListPost.DataBind()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadAreaPopupBoxBoostAllFull(" & postID.ToString() & ");", True)
                Exit Sub
            ElseIf (e.CommandName = "IBoostOnFacebook") Then
                Session("IsFbShare") = postID.ToString()
                Session("PagePrompt") = "Search.aspx"
                FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))
                Exit Sub
            ElseIf (e.CommandName = "IBoostOnTwitter") Then
                If Not TwitterConnect.IsAuthorized Then
                    Dim twitter As New TwitterConnect()
                    Session("IsTwitterShare") = postID.ToString()
                    Session("tweetMessage") = lblComment.Text
                    twitter.Authorize(Request.Url.AbsoluteUri.Split("?"c)(0))
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub areaSpecificNewsDataListPost_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles areaSpecificNewsDataListPost.ItemDataBound
        Try

            Dim hdnPostID = TryCast(e.Item.FindControl("hdnAreaPostID"), HiddenField)
            Dim recommendImg = TryCast(e.Item.FindControl("recommendImg"), Image)
            Dim lbtnRecommendsNewsAllFull = TryCast(e.Item.FindControl("lbtnRecommendsNewsAllFull"), LinkButton)
            Dim singlePostRepliesDataList As DataList = TryCast(e.Item.FindControl("singlePostRepliesDataList"), DataList)

            recommendImg.Attributes("onclick") = String.Format("ClickRecommend(" & lbtnRecommendsNewsAllFull.ClientID & ");")

            sdPostReplies.SelectParameters.Item("PostID").DefaultValue = hdnPostID.Value
            Dim dv As Data.DataView = CType(sdPostReplies.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then

                singlePostRepliesDataList.DataSource = dv
                singlePostRepliesDataList.DataBind()
            End If


        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

End Class