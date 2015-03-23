Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.IO
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports System.Net
Imports System.Web.Services
Imports Telerik.Charting
Imports Telerik.Charting.Styles

Public Class Board
    Inherits Telerik.Web.UI.RadAjaxPage
    Public url As String = ""
    Public YoutubeVideoUrl As String = ""
    Public commentCount As Integer = 0
    Public recommeendCount As Integer = 0
    Public watchCount As Integer = 0
    Dim globalModule As New GlobalModule
    Public Property sqlCommandComment() As String
        Get
            Return CStr(ViewState("_sqlCommandComment"))
        End Get
        Set(ByVal value As String)
            ViewState("_sqlCommandComment") = value
        End Set
    End Property
    Public Property sqlCommandRecommend() As String
        Get
            Return CStr(ViewState("_sqlCommandRecommend"))
        End Get
        Set(ByVal value As String)
            ViewState("_sqlCommandRecommend") = value
        End Set
    End Property
    Public Property sqlCommandWatch() As String
        Get
            Return CStr(ViewState("_sqlCommandWatch"))
        End Get
        Set(ByVal value As String)
            ViewState("_sqlCommandWatch") = value
        End Set
    End Property
    Public Property BoardID() As Int32

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property AmountRemaining() As Double

        Get
            Return CDbl(ViewState("_amountRemaining"))
        End Get

        Set(ByVal value As Double)
            ViewState("_amountRemaining") = value
        End Set
    End Property
    Public Property AmountTotalOffer() As Double

        Get
            Return CDbl(ViewState("_amountTotalOffer"))
        End Get

        Set(ByVal value As Double)
            ViewState("_amountTotalOffer") = value
        End Set
    End Property
    Public Property fromSearchPage() As Int32

        Get
            Return CInt(ViewState("_fromSearchPage"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_fromSearchPage") = value
        End Set
    End Property

    Public Property ownerUserID() As String

        Get
            Return CStr(ViewState("_ownerUserID"))
        End Get

        Set(ByVal value As String)
            ViewState("_ownerUserID") = value
        End Set
    End Property

    Public Property directoryName() As String

        Get
            Return CStr(ViewState("_directoryName"))
        End Get

        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property
    Public Property YoutubeUrl() As String

        Get
            Return CStr(ViewState("_youtubeUrl"))
        End Get

        Set(ByVal value As String)
            ViewState("_youtubeUrl") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        globalModule.RedirectToHttps()
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        TwitterConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("consumerKey")
        TwitterConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("consumerSecret")
        messageLabel.Text = ""
        'If Session("userName") Is Nothing Then
        '    If Not Request.QueryString("returnUrl") Is Nothing Then
        '        Response.Redirect("~/Default.aspx?returnUrl=" & Request.QueryString("returnUrl"))
        '    Else
        '        Response.Redirect("~/Default.aspx")
        '    End If
        'End If
        If (Not Page.IsPostBack) Then
            If TwitterConnect.IsAuthorized Then
                If Not (Session("tweetMessage")) Is Nothing Then
                    Dim twitter As New TwitterConnect()
                    twitter.Tweet(Session("tweetMessage"))
                    'SaveBoostEntry()
                    Session("tweetMessage") = Nothing
                End If
            End If
            If TwitterConnect.IsDenied Then
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "key", "alert('User has denied access.')", True)
            End If
            Try
                If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                    Me.directoryName = Request.QueryString("Name")
                    hdnBoardName.value = Me.directoryName
                Else
                    If Not (Page.RouteData.Values("Name") = Nothing) Then
                        Me.directoryName = Page.RouteData.Values("Name").ToString()
                        checkDirectoryName(Me.directoryName)
                    Else
                        checkDirectoryName("")
                        Exit Sub
                    End If
                  
                End If
                If Request.QueryString("fromSearch") = "1" Then
                    Me.fromSearchPage = 1
                End If

                LoadBoardDescriptionInfo()
                LoadBoardInfo()
                ViewBoardRecord()
                LoadChart()
                CheckWatching()
                CheckRecommend()
                HideShowIfLoggedIn()
                'lbtnMoreInfo.Attributes.Add("style", "color:#ececee")
            Catch ex As Exception
                globalModule.SetMessage(messageLabel, False, "Error in Loading Data")
                globalModule.ErrorLogFile(ex)
            End Try

        End If
        RadWindow1.VisibleOnPageLoad = False

    End Sub
    Protected Sub checkDirectoryName(ByVal directoryName As String)
        Try
            Dim directoryNameCheck As String = "SELECT COUNT(*) AS Count FROM Boards WHERE DirectoryName='" + directoryName + "'"
            Dim myconnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ConnectionString.ToString())
            Using myconnection
                Dim ds As New DataSet()
                Dim da As SqlDataAdapter
                da = New SqlDataAdapter(directoryNameCheck, myconnection)
                da.SelectCommand.CommandType = CommandType.Text
                da.Fill(ds, "Results")
                If Not (ds) Is Nothing Then
                    Dim dt As DataTable = ds.Tables("Results")
                    If Not (dt) Is Nothing Then
                        If (dt.Rows.Count > 0) Then
                            If (Convert.ToInt32(dt.Rows(0)("Count") = 0)) Then
                                Response.RedirectPermanent("~/404.html", False)
                            End If
                        End If
                    End If
                End If
            End Using

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub HideShowIfLoggedIn()
        Try
            If Not (Session("UserID")) Is Nothing Then
                'lbtnHome.Visible = True
                'lbtnLogout.Visible = True
                'lbtnSignup.Visible = False
            Else
                'lbtnHome.Visible = False
                'lbtnLogout.Visible = False
                'lbtnSignup.Visible = True
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub CheckWatching()
        Try
            If Not (Session("UserID")) Is Nothing Then
                sdWatching.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdWatching.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv2 As Data.DataView = CType(sdWatching.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If dv2.Count > 0 Then
                    If dv2(0)("result") = "IsExist" Then
                        btnWatch.Visible = False
                        btnStopWatching.Visible = True
                        divImageWatch.Visible = False
                        divImageStopWatch.Visible = True
                    Else
                        btnStopWatching.Visible = False
                        divImageWatch.Visible = True
                        divImageStopWatch.Visible = False
                        btnWatch.Visible = True
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub CheckRecommend()
        Try
            If Not (Session("UserID")) Is Nothing Then
                sdCheckRecommend.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdCheckRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv2 As Data.DataView = CType(sdCheckRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If dv2.Count > 0 Then
                    If dv2(0)("result") = "IsExist" Then
                        lbtnRecommend.Text = "Recommended"
                    Else
                        lbtnRecommend.Text = "Recommend"
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub ViewBoardRecord()
        Try
            If Not (Session("UserID")) Is Nothing Then
                sdViewBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdViewBoard.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                Dim dv As DataView = CType(sdViewBoard.Select(DataSourceSelectArguments.Empty), DataView)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub boardLevelsRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles boardLevelsRepeater.ItemCommand
        Try
            If (e.CommandName.ToString() = "IInvest") Then

                Dim uID As Integer = 0
                If Not (Request.QueryString("from")) Is Nothing Then
                    uID = Request.QueryString("from")
                End If
                If (Session("UserID")) Is Nothing Then
                    If Not (uID = 0) Then
                        Response.Redirect("~/InvestSignup.aspx?bordName=" & Me.directoryName & "&from=" & uID, False)
                        Exit Sub
                    Else
                        Response.Redirect("~/InvestSignup.aspx?bordName=" & Me.directoryName, False)
                        Exit Sub
                    End If

                Else
                    Dim levelName As String = e.CommandArgument.ToString()
                    Response.Redirect("~/Confirm.aspx?Name=" & Me.directoryName & "&LevelName=" & HttpContext.Current.Server.UrlEncode(levelName), False)
                    Exit Sub
                End If

                'If (Session("UserID")) Is Nothing Then
                '    Response.Redirect("~/InvestSignup.aspx?name=" & Me.directoryName, False)
                '    Exit Sub
                'Else
                '    Dim levelName As String = e.CommandArgument.ToString()
                '    Response.Redirect("~/Confirm.aspx?Name=" & Me.directoryName & "&LevelName=" & HttpContext.Current.Server.UrlEncode(levelName), False)
                '    Exit Sub
                'End If


            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub LoadChart()
        Try
            Dim maxValue As Double = 0
            sdAmountrRaisedGraph.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As DataView = CType(sdAmountrRaisedGraph.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    maxValue = Me.AmountTotalOffer
                    RadChart1.PlotArea.YAxis.MaxValue = maxValue
                    RadChart1.PlotArea.YAxis.Step = maxValue / 10

                    RadChart1.PlotArea.XAxis.LayoutMode = Telerik.Charting.Styles.ChartAxisLayoutMode.Inside
                    RadChart1.PlotArea.XAxis.Appearance.ValueFormat = Telerik.Charting.Styles.ChartValueFormat.ShortDate
                    RadChart1.PlotArea.XAxis.Appearance.CustomFormat = "dd MMM yyyy"
                    RadChart1.PlotArea.XAxis.AddRange(DateTime.Now.AddDays(-90).ToOADate(), DateTime.Now.ToOADate(), 10)

                    RadChart1.PlotArea.XAxis.Appearance.LabelAppearance.RotationAngle = 315

                    RadChart1.DataSource = dv
                    RadChart1.DataBind()
                    RadChart1.PlotArea.XAxis(1).TextBlock.Visible = False
                    RadChart1.PlotArea.XAxis(2).TextBlock.Visible = False
                    RadChart1.PlotArea.XAxis(4).TextBlock.Visible = False
                    RadChart1.PlotArea.XAxis(5).TextBlock.Visible = False
                    RadChart1.PlotArea.XAxis(7).TextBlock.Visible = False
                    RadChart1.PlotArea.XAxis(8).TextBlock.Visible = False
                End If
            End If
            sdLevelReachedGraph.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dvLevelReached As DataView = CType(sdLevelReachedGraph.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dvLevelReached Is Nothing Then
                If dvLevelReached.Count > 0 Then
                    If (Not IsDBNull(dvLevelReached(0)("TotalOffer"))) Then
                        maxValue = dvLevelReached(0)("TotalOffer")
                    End If
                    RadChart2.PlotArea.YAxis.MaxValue = maxValue
                    RadChart2.PlotArea.YAxis.Step = maxValue / 10
                    RadChart2.DataSource = dvLevelReached
                    RadChart2.DataBind()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub RadChart2_ItemDataBound(ByVal sender As Object, ByVal e As ChartItemDataBoundEventArgs) Handles RadChart2.ItemDataBound
        Try

            If (e.SeriesItem.YValue <= (Me.AmountTotalOffer - Me.AmountRemaining)) Then
                e.SeriesItem.Appearance.Border.Color = Color.Cyan
                e.SeriesItem.Appearance.FillStyle.MainColor = Color.Cyan
            Else
                e.SeriesItem.Appearance.Border.Color = Color.Gray
                e.SeriesItem.Appearance.FillStyle.MainColor = Color.Gray
            End If

        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub ResetCss()
        Try
            'lbtnMoreInfo.Attributes.Add("style", "color:#99CCFF")
            'lbtnMediaLinks.Attributes.Add("style", "color:#99CCFF")
            'lbtnBoardersIn.Attributes.Add("style", "color:#99CCFF")
            'lbtnFilesUploaded.Attributes.Add("style", "color:#99CCFF")
            'lbtnPerformanceCharts.Attributes.Add("style", "color:#99CCFF")
            'lbtnCrowdBoardTeam.Attributes.Add("style", "color:#99CCFF")
            'lbtnInvest.Attributes.Add("style", "color:#99CCFF")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Protected Sub lbtnMoreInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMoreInfo.Click
    '    RadMultiPage1.SelectedIndex = 0
    '    ResetCss()
    '    lbtnMoreInfo.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnMediaLinks_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMediaLinks.Click
    '    RadMultiPage1.SelectedIndex = 1
    '    ResetCss()
    '    lbtnMediaLinks.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnFilesUploaded_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnFilesUploaded.Click
    '    RadMultiPage1.SelectedIndex = 2
    '    ResetCss()
    '    lbtnFilesUploaded.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnPerformanceCharts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnPerformanceCharts.Click
    '    RadMultiPage1.SelectedIndex = 3
    '    ResetCss()
    '    lbtnPerformanceCharts.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnCrowdBoardTeam_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnCrowdBoardTeam.Click
    '    RadMultiPage1.SelectedIndex = 4
    '    ResetCss()
    '    lbtnCrowdBoardTeam.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnBoardersIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBoardersIn.Click
    '    RadMultiPage1.SelectedIndex = 5
    '    ResetCss()
    '    lbtnBoardersIn.Attributes.Add("style", "color:#ececee")
    'End Sub
    'Protected Sub lbtnInvest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnInvest.Click
    '    RadMultiPage1.SelectedIndex = 6
    '    ResetCss()
    '    lbtnInvest.Attributes.Add("style", "color:#ececee")
    'End Sub

    Private Sub LoadGrids()
        Try
            Dim dvWCR As DataView = CType(sdsWCR.Select(DataSourceSelectArguments.Empty), DataView)
            If Not dvWCR Is Nothing Then
                If dvWCR.Count > 0 Then
                    WCRDataList.DataSource = dvWCR
                    WCRDataList.DataBind()

                End If
            End If

        Catch ex As Exception
            Throw ex
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
    Private Sub LoadBoardDescriptionInfo()
        Try
            If (Not String.IsNullOrEmpty(Me.directoryName)) Then
                sdBoard.SelectParameters.Item("Name").DefaultValue = Me.directoryName
                Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("BoardID"))) Then
                        Me.BoardID = dv(0)("BoardID")
                        boardIDHiddenField.Value = Me.BoardID
                    End If
                    If Not (Session("UserID")) Is Nothing Then
                        If (checkIfAdmin() = False) Then
                            If (dv(0)("Status") <> 1) And (dv(0)("UserID") <> Session("UserID")) Then
                                hdnGoback.Value = Request.UrlReferrer.ToString()
                                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:GoBack();", True)
                            End If
                        End If
                    End If
                End If
                SetBackgroundCoverProfilePic()
                SetCBTeamMediaLinkFilesUploadVisibility()
                sdBoardLevels.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdRecentActivityOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdRecentCommentsOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdAllBoardersList.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdsRecommended.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdsWatchedOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID

                sdsBoardInvested.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdsWCR.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                Dim dv1 As Data.DataView = CType(sdAllBoardersList.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If Not dv1 Is Nothing Then
                    lblBoardersIn.Text = dv1.Count
                Else
                    lblBoardersIn.Text = "0"
                End If

                LoadGrids()

                Dim dvInvested As DataView = CType(sdsBoardInvested.Select(DataSourceSelectArguments.Empty), DataView)
                boardInvestedDataList.DataSource = dvInvested
                boardInvestedDataList.DataBind()

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub SetBackgroundCoverProfilePic()
        Try
            Dim GM As New GlobalModule
            Dim pathBoardPic As String = GM.GetImageURL(Me.directoryName & ".jpg", 150, 150, "thumbnail", "thumbs") '"Upload/BoardCoverPics/" & Request.QueryString("Name") & ".jpg"
            imgOwnedBy.Src = isAvail("~/thumbnail/" & Me.directoryName & ".jpg")

            If Not isAvail("~/Upload/BoardBackgroundPics/" & Me.directoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathBackgoundImage As String = "Upload/BoardBackgroundPics/" & Me.directoryName & ".jpg"
                ' mainDiv.Attributes.Add("style", "background-image:url(" & pathBackgoundImage & "); background-repeat:no-repeat; overflow: hidden; background-size: 100% 100%; height:1000px; width:100%;")
            Else

                ' mainDiv.Attributes.Add("style", "background-image:url(Images/defaultBackground.jpg); background-repeat:no-repeat; overflow: hidden; background-size: 100% 100%; height:1000px;  width:100%;")
                '   mainDiv.Attributes.Add("style", "background-image:url(Images/defaultBackground.jpg); background-repeat:no-repeat; overflow: hidden; background-size: 100% 80%; height:100%; width:100%;")
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & Me.directoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & Me.directoryName & ".jpg"
                coverPicDiv.ImageUrl = pathCoverPic
                coverPicDiv.Attributes.Add("style", "min-height: 200px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.ImageUrl = "WebContent/Theme/images/profilebanner.jpeg"
                coverPicDiv.Attributes.Add("style", "min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
                ' coverPicDiv.Attributes.Add("style", "background-color:#fbfbfb;min-height: 200px; width: 100%;")
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    'Protected Sub rgBoardComments_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rgBoardComments.NeedDataSource
    '    Try
    '        Try
    '            sdBoardComments.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
    '            Dim dv As Data.DataView = CType(sdBoardComments.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '            rgBoardComments.DataSource = dv
    '        Catch ex As Exception
    '            Throw ex
    '        End Try
    '    Catch ex As Exception
    '        GlobalModule.SetMessage(messageLabel, False, "Error in Loading Comments")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub

    Protected Sub NextBoard(ByVal dview As DataView)
        Try
            Dim dv As Data.DataView = dview
            If dv.Count > 0 Then
                Dim counter As Integer = 0
                For Each rowView As DataRowView In dv
                    Dim row As DataRow = rowView.Row
                    If dv(counter)("BoardID") = Me.BoardID Then
                        If counter < dv.Count - 1 Then
                            Me.BoardID = dv(counter + 1)("BoardID")
                            Me.directoryName = dv(counter + 1)("DirectoryName")
                            boardIDHiddenField.Value = Me.BoardID
                            LoadBoardDetails()
                            Exit For
                        End If
                    End If
                    counter = counter + 1
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub PreviousBoard(ByVal dview As DataView)
        Try
            Dim dv As Data.DataView = dview
            If dv.Count > 0 Then
                Dim counter As Integer = 0
                For Each rowView As DataRowView In dv
                    Dim row As DataRow = rowView.Row
                    If dv(counter)("BoardID") = Me.BoardID Then
                        If Not counter = 0 Then
                            Me.BoardID = dv(counter - 1)("BoardID")
                            Me.directoryName = dv(counter - 1)("DirectoryName")
                            boardIDHiddenField.Value = Me.BoardID
                            LoadBoardDetails()
                            Exit For
                        End If
                    End If
                    counter = counter + 1
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnNextBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNextBoard.Click
        Try
            Dim dv As Data.DataView
            If Me.fromSearchPage = 1 Then
                dv = CType(sdBoardsList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Else
                If (areaHyperLink.Text <> "") Then
                    sdBoardsByArea.SelectParameters.Item("AreaName").DefaultValue = areaHyperLink.Text.Trim()
                    dv = CType(sdBoardsByArea.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Else
                    dv = CType(sdBoardsList.Select(DataSourceSelectArguments.Empty), Data.DataView)
                End If
            End If
            If Not dv Is Nothing Then
                NextBoard(dv)
            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Loading data")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnPreviousBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPreviousBoard.Click
        Try
            Dim dv As Data.DataView
            If Me.fromSearchPage = 1 Then
                dv = CType(sdBoardsList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Else
                If (areaHyperLink.Text <> "") Then
                    sdBoardsByArea.SelectParameters.Item("AreaName").DefaultValue = areaHyperLink.Text.Trim()
                    dv = CType(sdBoardsByArea.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Else
                    dv = CType(sdBoardsList.Select(DataSourceSelectArguments.Empty), Data.DataView)
                End If
            End If
            If Not dv Is Nothing Then
                PreviousBoard(dv)
            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Loading data")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SetCBTeamMediaLinkFilesUploadVisibility()
        Try
            sdCrowdBoardTeam.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            ' sdCrowdBoardTeam.SelectParameters.Item("MemberID").DefaultValue = Convert.ToInt64(Session("userID"))
            Dim dv1 As Data.DataView = CType(sdCrowdBoardTeam.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv1 Is Nothing Then
                If (dv1.Count = 0) Then
                    crowdBoardTeamDiv.Attributes.Add("Style", "display:none;")
                    crowdBoardTeamLinkTr.Attributes.Add("Style", "display:none;")
                Else
                    crowdBoardTeamDiv.Attributes.Add("Style", "display:block;width: 100%; min-height: 400px;")
                    crowdBoardTeamLinkTr.Attributes.Add("Style", "display:block;")
                End If
            Else
                crowdBoardTeamDiv.Attributes.Add("Style", "display:none;")
                crowdBoardTeamLinkTr.Attributes.Add("Style", "display:none;")
            End If
            sdFilesUploaded.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv2 As Data.DataView = CType(sdFilesUploaded.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv2 Is Nothing Then
                If (dv2.Count = 0) Then
                    fileDiv.Attributes.Add("Style", "display:none;")
                    filesUploadedTr.Attributes.Add("Style", "display:none;")
                Else
                    fileDiv.Attributes.Add("Style", "display:block;width: 100%; min-height: 290px;")
                    filesUploadedTr.Attributes.Add("Style", "display:block;")
                End If
            Else
                fileDiv.Attributes.Add("Style", "display:none;")
                fileDiv.Attributes.Add("Style", "display:none;")
            End If

            sdBoardMediaLinks.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv3 As Data.DataView = CType(sdBoardMediaLinks.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv3 Is Nothing Then
                If (dv3.Count = 0) Then
                    mediaLinksDiv.Attributes.Add("Style", "display:none;")
                    mediaLinksTr.Attributes.Add("Style", "display:none;")
                Else
                    'mediaLinksDiv.Attributes.Add("Style", "display:block;width: 100%; min-height: 400px;")
                    mediaLinksTr.Attributes.Add("Style", "display:block;")
                End If
            Else
                mediaLinksDiv.Attributes.Add("Style", "display:none;")
                mediaLinksDiv.Attributes.Add("Style", "display:none;")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardDetails()
        Try
            SetBackgroundCoverProfilePic()
            sdBoardLevels.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdRecentActivityOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdAllBoardersList.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdRecentCommentsOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdsRecommended.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdsWatchedOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdsBoardInvested.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdAllBoardersList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                lblBoardersIn.Text = dv.Count
            Else
                lblBoardersIn.Text = "0"
            End If
            SetCBTeamMediaLinkFilesUploadVisibility()
            LoadBoardInfo()
            ViewBoardRecord()
            LoadChart()
            CheckWatching()
            CheckRecommend()
            LoadGrids()


            Dim dvInvested As DataView = CType(sdsBoardInvested.Select(DataSourceSelectArguments.Empty), DataView)
            boardInvestedDataList.DataSource = dvInvested
            boardInvestedDataList.DataBind()
            'commentsDataList.DataSource = GetCustomersData(1, Me.BoardID)
            'commentsDataList.DataBind()
            'recommendedDataList.DataSource = GetBowarRecommendData(1, Me.BoardID)
            'recommendedDataList.DataBind()
            'rgBoardComments.Rebind()
            ''recentActivityOnBoardRepeater.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
    '    Session.Abandon()
    '    Response.Redirect("~/Default.aspx")
    'End Sub

    'Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
    '    Response.Redirect("~/Home.aspx")
    'End Sub

    'Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
    '    Response.Redirect("~/Search.aspx", False)
    'End Sub
    Protected Sub lbtnRecommend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnRecommend.Click
        Try

            If (Session("userID")) IsNot Nothing Then
                If (lbtnRecommend.Text = "Recommend") Then
                    RecommendBoard()
                ElseIf (lbtnRecommend.Text = "Recommended") Then
                    UnrecommendBoard()
                End If
                LoadGrids()
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub RecommendBoard()
        Try
            sdRecommend.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdRecommend.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            Dim dv2 As Data.DataView = CType(sdRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv2.Count > 0 Then
                If dv2(0)(0) = "0" Then
                    globalModule.SetMessage(messageLabel, False, "You have already recommended this Board")
                Else
                    globalModule.SetMessage(messageLabel, True, "Crowdboard recommended succesfully")
                    lbtnRecommend.Text = "Recommended"

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub UnrecommendBoard()
        Try
            sdRecommend.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdRecommend.UpdateParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            sdRecommend.Update()
            lbtnRecommend.Text = "Recommend"
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardInfo()
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv1 As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv1.Count > 0) Then
                If (Not IsDBNull(dv1(0)("Boardname"))) Then
                    boardNameLabel.Text = "Name: " + dv1(0)("Boardname").ToString()
                    hdnBoardName.Value = dv1(0)("Boardname").ToString()
                End If
                If (Not IsDBNull(dv1(0)("OwnerName"))) Then
                    boardOwnerHyperLink.Text = dv1(0)("OwnerName").ToString()
                    boardOwnerHyperLink.NavigateUrl = "Profile.aspx?User=" + dv1(0)("OwnerName").ToString()
                End If

                Dim city As String = IIf(IsDBNull(dv1(0)("city")), "", dv1(0)("city"))
                Dim state As String = IIf(IsDBNull(dv1(0)("state")), "", dv1(0)("state"))
                Dim country As String = IIf(IsDBNull(dv1(0)("country")), "", dv1(0)("country"))

                If (Not IsDBNull(dv1(0)("Watches"))) Then
                    lblWatches.Text = dv1(0)("Watches")
                    lblWatchesBottom.Text = dv1(0)("Watches")
                Else
                    lblWatches.Text = "0"
                    lblWatchesBottom.Text = "0"
                End If

                If (Not IsDBNull(dv1(0)("Comments"))) Then

                    lblCommentsBottom.Text = dv1(0)("Comments")
                Else

                    lblCommentsBottom.Text = "0"
                End If

                If (Not IsDBNull(dv1(0)("RecommendCount"))) Then

                    lblRecommendsCount.Text = dv1(0)("RecommendCount")
                Else

                    lblRecommendsCount.Text = "0"
                End If

                If (Not IsDBNull(dv1(0)("PricedFrom"))) Then
                    lblPricedFrom.Text = dv1(0)("PricedFrom")
                End If

                If (Not IsDBNull(dv1(0)("Seeking"))) Then
                    lblSeeking.Text = globalModule.GetAmountAccordingToLocation(dv1(0)("Seeking").ToString(), dv1(0)("BankLocation").ToString())
                End If

                Dim largeChange As Integer
                If (Not IsDBNull(dv1(0)("seekingAmount"))) Then
                    ThermometerSlider.MaximumValue = Convert.ToDecimal(dv1(0)("seekingAmount"))
                    largeChange = Convert.ToInt32(dv1(0)("seekingAmount")) / 5
                    ThermometerSlider.LargeChange = largeChange
                    Me.AmountTotalOffer = Convert.ToDecimal(dv1(0)("seekingAmount"))
                Else
                    ThermometerSlider.MaximumValue = 5000
                    largeChange = 5000 / 5
                    ThermometerSlider.LargeChange = largeChange
                End If
                If (Not IsDBNull(dv1(0)("RaisedTotal"))) Then
                    ThermometerSlider.Value = Convert.ToInt64(dv1(0)("RaisedTotal"))
                Else
                    ThermometerSlider.Value = 0
                End If
                If (Not IsDBNull(dv1(0)("Amountleft"))) Then
                    lblAmountLeft.Text = globalModule.GetAmountAccordingToLocation(dv1(0)("Amountleft").ToString(), dv1(0)("BankLocation").ToString())
                    '  lblAmountLeft.Text = IIf(dv1(0)("Amountleft") = 0, "$0", FormatCurrency(Convert.ToDouble(dv1(0)("Amountleft")), 0, 0, 0))
                    Me.AmountRemaining = dv1(0)("Amountleft")
                End If
                If (Not IsDBNull(dv1(0)("BoardLevel"))) Then
                    lblBoardLevel.Text = IIf(dv1(0)("BoardLevel") = "Not Calculated", "1", dv1(0)("BoardLevel"))
                End If
                If (Not IsDBNull(dv1(0)("District"))) Then
                    '//lblDistrict.Text = dv1(0)("District")
                    hyperlinkDistrict.Text = dv1(0)("District")
                    hyperlinkDistrict.NavigateUrl = "~/Search.aspx?District=" & dv1(0)("District").ToString()
                    'districtHeadingHyperlink.Text = dv1(0)("District")
                    'districtHeadingHyperlink.NavigateUrl = "~/Search.aspx?District=" & dv1(0)("District").ToString()

                End If
                If (Not IsDBNull(dv1(0)("MoreInfo"))) Then
                    moreInfoLabel.Text = dv1(0)("MoreInfo")
                End If
                'If (Not IsDBNull(dv1(0)("question1"))) Then
                '    question1Label.Text = dv1(0)("question1")
                'End If
                'If (Not IsDBNull(dv1(0)("answer1"))) Then
                '    answer1Label.Text = dv1(0)("answer1")
                'End If
                'If (Not IsDBNull(dv1(0)("question3"))) Then
                '    question3Label.Text = dv1(0)("question3")
                'End If
                'If (Not IsDBNull(dv1(0)("answer3"))) Then
                '    answer3Label.Text = dv1(0)("answer3")
                'End If
                'If (Not IsDBNull(dv1(0)("question2"))) Then
                '    question2Label.Text = dv1(0)("question2")
                'End If
                'If (Not IsDBNull(dv1(0)("answer2"))) Then
                '    answer2Label.Text = dv1(0)("answer2")
                'End If
                'If (Not IsDBNull(dv1(0)("question4"))) Then
                '    question4Label.Text = dv1(0)("question4")
                'End If
                'If (Not IsDBNull(dv1(0)("answer4"))) Then
                '    answer4Label.Text = dv1(0)("answer4")
                'End If
                If (Not IsDBNull(dv1(0)("AreaName"))) Then
                    areaHyperLink.Text = dv1(0)("AreaName")
                    areaHyperLink.NavigateUrl = "~/Search.aspx?Area=" & dv1(0)("AreaName").ToString()
                    ' areaHeadingHyperLink.Text = dv1(0)("AreaName")
                    ' areaHeadingHyperLink.NavigateUrl = "~/Search.aspx?Area=" & dv1(0)("AreaName").ToString()
                End If
                If (Not IsDBNull(dv1(0)("InvType"))) Then
                    lblCrowdBoardType.Text = dv1(0)("InvType")
                    ' lblBoardType.Text = dv1(0)("InvType")
                    If (Not IsDBNull(dv1(0)("InvTypeDescription"))) Then
                        lblCrowdBoardType.ToolTip = dv1(0)("InvTypeDescription")
                        ' lblBoardType.ToolTip = dv1(0)("InvTypeDescription")
                    End If
                End If
                If (Not IsDBNull(dv1(0)("Description"))) Then
                    lblDescription.Text = dv1(0)("Description")
                End If
                If (Not IsDBNull(dv1(0)("YoutubeVideoUrl"))) Then
                    If (Not dv1(0)("YoutubeVideoUrl") = "") Then
                        Me.YoutubeUrl = dv1(0)("YoutubeVideoUrl").ToString()

                        'ibtnPlay.Visible = True
                        playDiv.Visible = True
                        Dim youtubeVideoUrl As String = Me.YoutubeUrl
                        RadMediaPlayer1.Sources.Clear()
                        RadMediaPlayer1.StartTime = 0
                        RadMediaPlayer1.Muted = False
                        RadMediaPlayer1.AutoPlay = False
                        RadMediaPlayer1.Title = Me.directoryName

                        RadMediaPlayer1.Source = youtubeVideoUrl
                    Else
                        Me.YoutubeUrl = "http://www.youtube.com/v/sFqbhsvXE7M"
                        'ibtnPlay.Visible = False
                        playDiv.Visible = False
                    End If
                Else
                    Me.YoutubeUrl = "http://www.youtube.com/v/sFqbhsvXE7M"
                    ' ibtnPlay.Visible = False
                    playDiv.Visible = False
                End If

            End If
            sdUpdates.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdUpdates.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("CommentCount"))) Then
                    'lblUpdates.Text = "(" & dv(0)("CommentCount") & ")"
                End If
            End If
            'commentsDataList.DataSource = GetCustomersData(1, Me.BoardID)
            'commentsDataList.DataBind()
            'recommendedDataList.DataSource = GetBowarRecommendData(1, Me.BoardID)
            'recommendedDataList.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    'Protected Sub lbAddComment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbAddComment.Click
    '    commentDiv.Visible = True
    '    lbAddComment.Visible = False
    'End Sub

    'Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
    '    txtComment.Text = ""
    '    lbAddComment.Visible = True
    '    commentDiv.Visible = False
    'End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Try
            If Not Session("userID") Is Nothing Then
                If CheckBoarderStatus() = 1 Then
                    If (Not String.IsNullOrEmpty(Me.directoryName)) Then
                        Try
                            If txtComment.Text.Trim() <> "" Then
                                sdBoardComments.InsertParameters.Item("Text").DefaultValue = txtComment.Text
                                sdBoardComments.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
                                sdBoardComments.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                                sdBoardComments.Insert()
                                txtComment.Text = ""
                                LoadBoardInfo()
                                LoadGrids()

                                ''  recentActivityOnBoardRepeater.DataBind()
                                globalModule.SetMessage(messageLabel, True, "Comment Added Successfully")
                                SendEmailToUser()
                                'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "openRadWindow('" & hdnDirectoryName.Value & "');", True)
                            Else
                                globalModule.SetMessage(messageLabel, False, "Please Enter Comment")
                            End If
                        Catch ex As Exception
                            globalModule.SetMessage(messageLabel, False, "Error in Posting Comment")
                            globalModule.ErrorLogFile(ex)
                        End Try
                    Else
                        Response.Redirect("~/Default.aspx", False)
                    End If
                Else
                    RadWindow1.NavigateUrl = "~/rwValidateEmail.aspx"
                    RadWindow1.VisibleOnPageLoad = True
                End If
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendEmailToUser()
        Try
            sdUserInfo.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv3 As Data.DataView = CType(sdUserInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv3.Count > 0 Then
                If (Not IsDBNull(dv3(0)("Email"))) Then
                    If (Not dv3(0)("Email") = "") Then
                        Dim receiverEmail As String = dv3(0)("Email")
                        Dim strSubject As String = "You have received a comment"
                        Dim toAddress As String = receiverEmail.Trim
                        Dim strBody As String = "A CrowdBoarder has commented on your CrowdBoard, see what they said:<a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
                        globalModule.SendEmail(toAddress, strSubject, strBody, True)
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnStopWatching_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnStopWatching.Click
        Try
            sdWatching.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdWatching.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            sdWatching.Update()
            globalModule.SetMessage(messageLabel, True, "You are no longer watching this board")
            btnStopWatching.Visible = False
            btnWatch.Visible = True
            divImageWatch.Visible = True
            divImageStopWatch.Visible = False
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnWatch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWatch.Click
        Try
            If (Session("userID")) IsNot Nothing Then

                If CheckIsOwner() = 1 Then
                    globalModule.SetMessage(messageLabel, False, "You cannot watch your own Board")
                Else
                    sdWatchers.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                    sdWatchers.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                    Dim dv2 As Data.DataView = CType(sdWatchers.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If dv2.Count > 0 Then
                        If dv2(0)(0) = "0" Then
                            globalModule.SetMessage(messageLabel, False, "You are Already Watching this Board")
                        Else
                            btnStopWatching.Visible = True
                            btnWatch.Visible = False
                            divImageWatch.Visible = False
                            divImageStopWatch.Visible = True
                            globalModule.SetMessage(messageLabel, True, "Board put on Watch Successfully")
                        End If
                    End If
                End If
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function CheckBoarderStatus() As Integer
        Dim isBoarder As Integer = 0
        Try
            Dim username As String = Session("userName")
            Dim userRolesList() As String = Roles.GetRolesForUser(username)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    If (item = "Boarder") Then
                        isBoarder = 1
                        Exit For
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isBoarder
    End Function
    Public Function CheckIsOwner() As Integer
        Dim isOwner As Integer = 0
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If dv(0)("UserID") = Session("userID") Then
                    isOwner = 1
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isOwner
    End Function

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Protected Sub filesUploadedDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles filesUploadedDataList.ItemCommand
        Try
            Dim lbtnFileShow As New LinkButton()
            lbtnFileShow = CType(e.Item.FindControl("lbtnFileShow"), LinkButton)
            DownloadFiles(lbtnFileShow.Text)
        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub DownloadFiles(ByVal fileName As String)
        Try
            Session("ExportPOPath") = Nothing
            Session("fileName") = Nothing
            Dim rootPath = "~/Upload/BoardDirectory/" & Me.directoryName & "/" & fileName
            Session("ExportPOPath") = Server.MapPath(rootPath)
            Session("fileName") = fileName
            Response.Redirect("~/ExportText.aspx", False)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnFacebookShare_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFacebookShare.Click
        Try
            If txtBoostContent.Text <> "" Then

                Dim callbackUrl As String
                Dim url As String
                If Request.QueryString("fromSearch") = "1" Then
                    callbackUrl = "" & ConfigurationManager.AppSettings("site") & "/" & Me.directoryName & "?fromSearch=1"
                    url = "~/" & Me.directoryName & "?fromSearch=1"
                Else
                    callbackUrl = "" & ConfigurationManager.AppSettings("site") & "/" & Me.directoryName
                    url = "~/" & Me.directoryName
                End If
                Dim content As String = "" & "<a href='" & callbackUrl & "'>" & txtBoostContent.Text & "</a>"
                Session("IsFbShare") = url & "," & txtBoostContent.Text & "," & callbackUrl & ",FromBoard=" & Me.directoryName
                FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))
            Else
                globalModule.SetMessage(messageLabel, False, "Please enter boost content")
            End If

        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnTwitterShare_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTwitterShare.Click
        Try
            If txtBoostContent.Text <> "" Then
                If Not TwitterConnect.IsAuthorized Then
                    Dim twitter As New TwitterConnect()
                    Dim callbackUrl As String
                    If Request.QueryString("fromSearch") = "1" Then
                        callbackUrl = "" & ConfigurationManager.AppSettings("site") & "/Board.aspx?Name=" & Me.directoryName & "&fromSearch=1"
                    Else
                        callbackUrl = "" & ConfigurationManager.AppSettings("site") & "/" & Me.directoryName
                    End If
                    Dim content As String = "" & "<a href='" & HttpContext.Current.Server.UrlEncode(callbackUrl) & "'>" & txtBoostContent.Text & "</a>"
                    Session("tweetMessage") = content
                    twitter.Authorize(callbackUrl)
                End If
            Else
                globalModule.SetMessage(messageLabel, False, "Please enter boost content")
            End If

        Catch ex As Exception
            globalModule.SetMessage(messageLabel, False, "Error in Request")
            globalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Shared Function GetCommentsData(ByVal pageIndex As Integer, ByVal boardID As Integer) As DataSet
        Dim query As String = "[P_LoadCommentsOnBoard]"
        Dim cmd As SqlCommand = New SqlCommand(query)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex)
        cmd.Parameters.AddWithValue("@PageSize", 10)
        cmd.Parameters.AddWithValue("@BoardID", boardID)
        cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output
        Return GetData(cmd)
    End Function

    Private Shared Function GetData(ByVal cmd As SqlCommand) As DataSet
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(strConnString)
        Dim sda As SqlDataAdapter = New SqlDataAdapter
        cmd.Connection = con
        sda.SelectCommand = cmd
        Dim ds As DataSet = New DataSet
        sda.Fill(ds, "Comments")
        Dim dt As DataTable = New DataTable("PageCount")
        dt.Columns.Add("PageCount")
        dt.Rows.Add()
        dt.Rows(0)(0) = cmd.Parameters("@PageCount").Value
        ds.Tables.Add(dt)
        con.Close()
        Return ds
    End Function
    <WebMethod()> _
    Public Shared Function GetComments(ByVal pageIndex As Integer, ByVal boardID As Integer) As String
        Return GetCommentsData(pageIndex, boardID).GetXml
    End Function

    Public Shared Function GetBowarRecommendData(ByVal pageIndex As Integer, ByVal boardID As Integer) As DataSet
        Dim query As String = "[P_LoadRecommandOnBoard]"
        Dim cmd As SqlCommand = New SqlCommand(query)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex)
        cmd.Parameters.AddWithValue("@PageSize", 10)
        cmd.Parameters.AddWithValue("@BoardID", boardID)
        cmd.Parameters.Add("@pageCountRecommend", SqlDbType.Int, 4).Direction = ParameterDirection.Output
        Return GetBoardRecommend(cmd)
    End Function

    Private Shared Function GetBoardRecommend(ByVal cmd As SqlCommand) As DataSet
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(strConnString)
        Dim sda As SqlDataAdapter = New SqlDataAdapter
        cmd.Connection = con
        sda.SelectCommand = cmd
        Dim ds As DataSet = New DataSet
        sda.Fill(ds, "Recommends")
        Dim dt As DataTable = New DataTable("pageCountRecommend")
        dt.Columns.Add("pageCountRecommend")
        dt.Rows.Add()
        dt.Rows(0)(0) = cmd.Parameters("@pageCountRecommend").Value
        ds.Tables.Add(dt)
        Return ds
    End Function
    <WebMethod()> _
    Public Shared Function GetRecommendOnBoard(ByVal pageIndex As Integer, ByVal boardID As Integer) As String
        Return GetBowarRecommendData(pageIndex, boardID).GetXml
    End Function
    Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest

        'If hdnScrollType.Value = "comments" Then
        '    rgComments.PageSize += 10
        '    sdRecentCommentsOnBoard.SelectCommand = Me.sqlCommandComment
        '    rgComments.DataSourceID = sdRecentCommentsOnBoard.ID
        '    rgComments.Rebind()
        'ElseIf hdnScrollType.Value = "recommends" Then

        '    rgRecommend.PageSize += 10
        '    sdsRecommended.SelectCommand = Me.sqlCommandRecommend
        '    rgRecommend.DataSourceID = sdsRecommended.ID
        '    rgRecommend.Rebind()
        'ElseIf hdnScrollType.Value = "watches" Then

        '    rgWatches.PageSize += 10
        '    sdsWatchedOnBoard.SelectCommand = Me.sqlCommandWatch
        '    rgWatches.DataSourceID = sdsWatchedOnBoard.ID
        '    rgWatches.Rebind()
        'End If
    End Sub

    'Protected Sub ibtnPlay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnPlay.Click
    '    Try
    '        Dim youtubeVideoUrl As String = Me.YoutubeUrl
    '        RadMediaPlayer1.Sources.Clear()
    '        RadMediaPlayer1.StartTime = 0
    '        RadMediaPlayer1.Muted = False
    '        RadMediaPlayer1.AutoPlay = False
    '        RadMediaPlayer1.Title = Me.directoryName

    '        RadMediaPlayer1.Source = youtubeVideoUrl
    '        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxVideo();", True)
    '    Catch ex As Exception
    '        Throw ex
    '        globalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub
    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function

End Class