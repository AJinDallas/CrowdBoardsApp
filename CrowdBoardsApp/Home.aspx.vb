Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.IO
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports System.Net
Imports System.Web.Services

Partial Class Home
    Inherits Telerik.Web.UI.RadAjaxPage

    Public Property boardDataTable() As DataTable

        Get
            Return CType(ViewState("_boardDataTable"), DataTable)
        End Get

        Set(ByVal value As DataTable)
            ViewState("_boardDataTable") = value
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

    Public Property districtsDataTable() As DataTable

        Get
            Return CType(ViewState("_districtsDataTable"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("_districtsDataTable") = value
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
    Public Property DistrictName() As String

        Get
            Return Convert.ToString(IIf(Not ViewState("_districtName") Is Nothing, ViewState("_districtName"), ""))
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        TwitterConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("consumerKey")
        TwitterConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("consumerSecret")
        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If
        messageLabel.Text = String.Empty
        If Not Page.IsPostBack Then
            LoadBoardUsers()

            If TwitterConnect.IsAuthorized Then
                If Not (Session("tweetMessage")) Is Nothing Then
                    Dim twitter As New TwitterConnect()
                    twitter.Tweet(Session("tweetMessage").ToString())
                    SaveBoostEntry()
                End If
            End If
            If TwitterConnect.IsDenied Then
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "key", "alert('User has denied access.')", True)
            End If
            Try
                isAdminli.Visible = checkIfAdmin()
                LoadData()
                BindNews()
                LoadMessageCount()
                LoadNotificationData()
                LoadPendingRequestData()
                Session("searchKeyWord") = "%"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "unloadPopupBoxVideo();", True)
            Catch ex As Exception
                GlobalModule.SetMessage(messageLabel, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)

            End Try
        End If
        RadWindow1.VisibleOnPageLoad = False

        CheckCountOfPhoto()

    End Sub


    Private Function checkIfAdmin() As Boolean
        Try
            If (Session("userName")) Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
                Exit Function
            End If
            Dim roles() As String = System.Web.Security.Roles.GetRolesForUser(Session("userName").ToString())
            If Not (roles) Is Nothing Then
                If (roles.Length > 0) Then
                    For Each Item As String In roles
                        If Item = "Admin" Then
                            Return True
                        End If
                    Next
                End If
            End If
        Catch ex As Exception
            Throw ex

        End Try
        Return False
    End Function
    Protected Sub districtDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles districtDataList.ItemDataBound
        Try

            Dim hdnDistrictID As HiddenField = e.Item.FindControl("hdnDistrictID")
            Dim areaDataList As DataList = CType(e.Item.FindControl("areaDataList"), DataList)
            sdAreas.SelectParameters.Item("districtID").DefaultValue = hdnDistrictID.Value
            Dim dvArea As Data.DataView = CType(sdAreas.Select(DataSourceSelectArguments.Empty), Data.DataView)
            areaDataList.DataSource = dvArea
            areaDataList.DataBind()
            areaDataList.RepeatColumns = 5
            areaDataList.RepeatLayout = RepeatLayout.Table

            Dim hdnDistrictName As HiddenField = CType(e.Item.FindControl("hdnDistrictName"), HiddenField)
            Dim districtNameLinkButton As LinkButton = CType(e.Item.FindControl("DistrictNameLinkButton"), LinkButton)
            districtNameLinkButton.Attributes.Add("onclick", "return loadPopupBoxArea(" + hdnDistrictID.Value + ",'" + hdnDistrictName.Value + "');")

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)

        End Try

    End Sub
    Private Sub LoadData()
        Try
            If (Session("userID")) Is Nothing Then
                Exit Sub
            End If

            Dim strUserID As String = Session("userID").ToString()
            If strUserID.Length = 1 Then
                strUserID = "00" & strUserID
            ElseIf strUserID.Length = 2 Then
                strUserID = "0" & strUserID
            End If
            lblBoarderID.Text = "#" & strUserID
            'Dim dv1 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)
            'If dv1.Count > 0 Then
            '    If (Not IsDBNull(dv1(0)("MessageCount"))) Then
            '        msgCountLabel.Text = "(" & dv1(0)("MessageCount") & ")"
            '    End If
            'End If
            Dim dv2 As DataView = CType(sdUserInfo.Select(DataSourceSelectArguments.Empty), DataView)
            If dv2.Count > 0 Then
                Dim watchingInvested As Integer = 0
                If (Not IsDBNull(dv2(0)("crowdboards"))) Then
                    crowdBoardsCount.Text = "(" & dv2(0)("crowdboards") & ")"
                End If
                If (Not IsDBNull(dv2(0)("BoardInvestedIn"))) Then
                    watchingInvested = (watchingInvested + Convert.ToInt16(dv2(0)("BoardInvestedIn")))
                End If
                If (Not IsDBNull(dv2(0)("BoardsWatching"))) Then
                    watchingInvested = (watchingInvested + Convert.ToInt16(dv2(0)("BoardsWatching")))
                End If

                If watchingInvested > 0 Then
                    investmentsSet.Text = "(" & watchingInvested.ToString() & ")"
                    ' investmentsHyperlink.NavigateUrl = "~/BoardFolio.aspx"
                Else
                    investmentsSet.Text = "(0)"
                End If

                'Dim MessageCount As Integer

                'If (Not IsDBNull(dv2(0)("MessageCount"))) Then
                '    MessageCount = dv2(0)("MessageCount")
                'End If

            End If
            lbluserName.Text = " Hi " & Session("userName").ToString().ToUpper() & " !"
            profilePic.ImageUrl = isAvail("~/Upload/ProfilePics/" & Session("userName").ToString() & ".jpg")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub surfBoardsRepeater_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles surfBoardsRepeater.ItemCommand
        Try
            Dim youtubeVideoUrl As String = e.CommandArgument.ToString()
            If (e.CommandName = "ShowVideo") Then
                Dim hdnBoardName = TryCast(e.Item.FindControl("hdnBoardName"), HiddenField)
                RadMediaPlayer1.Sources.Clear()
                RadMediaPlayer1.StartTime = 0
                RadMediaPlayer1.Muted = False
                RadMediaPlayer1.AutoPlay = False
                RadMediaPlayer1.Title = hdnBoardName.Value
                RadMediaPlayer1.Source = youtubeVideoUrl
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxVideo();", True)
            End If

            If (e.CommandName.ToString() = "ToBoard") Then
                Dim directoryName As String = e.CommandArgument.ToString()
                Response.Redirect("~/" & directoryName, False)
                ' Response.Redirect("~/Board.aspx?Name=" & directoryName, False)
            End If

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub
    Protected Sub surfBoardsRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles surfBoardsRepeater.ItemDataBound
        Try
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim hdnBoardName = TryCast(e.Item.FindControl("hdnBoardName"), HiddenField)
            Dim hdnYoutubeVideoUrl = TryCast(e.Item.FindControl("hdnYoutubeVideoUrl"), HiddenField)
            Dim ibtnPlay As ImageButton = TryCast(e.Item.FindControl("ibtnPlay"), ImageButton)
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
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Function CheckRequest(ByVal UserID2 As Integer) As Integer
        Dim status As Integer
        Try
            sdCheckRequest.SelectParameters.Item("UserID2").DefaultValue = UserID2
            sdCheckRequest.SelectParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("userID").ToString())
            Dim dv As Data.DataView = CType(sdCheckRequest.Select(DataSourceSelectArguments.Empty), Data.DataView)
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
    Protected Sub btnCreateBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateBoard.Click
        Response.Redirect("~/CreateCrowdboard.aspx", False)
    End Sub
    Protected Sub postRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles postRadButton.Click
        Try
            If txtPost.InnerText <> "" Then
                Dim message As String = CheckBoarName(txtPost.InnerText)
                sdPosts.SelectParameters.Item("Text").DefaultValue = message
                sdPosts.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If dv.Count > 0 Then
                    SaveAttachment(Convert.ToInt32(dv(0)("PostID")))
                End If
                txtPost.InnerText = ""
                txtPost.Focus()
                'BindAllNews()
                BindNews()

                GlobalModule.SetMessage(messageLabel, True, "Post added successfully")
            Else
                GlobalModule.SetMessage(messageLabel, False, "Post is blank")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Writing Post")
            GlobalModule.ErrorLogFile(ex)

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
                GlobalModule.SetMessage(messageLabel, True, "File attached successfully")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
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
    Protected Sub crowdNewsDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles crowdNewsDataList.ItemCommand

        Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
        Dim lblComment As Label = CType(e.Item.FindControl("lblComment"), Label)
        'If (e.CommandName = "IRecommendPost") Then
        '    Dim lbtnRecommendPost As LinkButton = CType(e.Item.FindControl("lbtnRecommendPost"), LinkButton)
        '    If (lbtnRecommendPost.Text = "Recommend") Then
        '        sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = True
        '    Else
        '        sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = False
        '    End If
        '    sdIRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
        '    sdIRecommend.SelectParameters.Item("PostID").DefaultValue = postID
        '    Dim dv As Data.DataView = CType(sdIRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
        '    ' BindAllNews()
        '    BindNews()
        '    Exit Sub
        ' Else
        If (e.CommandName = "IRecommendPost1") Then
            Try
                Dim lbtnRecommendsPost1 As LinkButton = CType(e.Item.FindControl("lbtnRecommendsPost1"), LinkButton)
                If (lbtnRecommendsPost1.Text = "Recommend") Then
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = True
                Else
                    sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = False
                End If
                sdIRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                sdIRecommend.SelectParameters.Item("PostID").DefaultValue = postID
                Dim dv As Data.DataView = CType(sdIRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
                ' BindAllNews()
                BindNews()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script", "loadPopupBoxPost(" & postID.ToString() & ");", True)
                Exit Sub
            Catch ex As Exception
                GlobalModule.SetMessage(messageLabel, False, "Error in request")
                GlobalModule.ErrorLogFile(ex)
            End Try

        ElseIf (e.CommandName = "IComment") Then
            Try
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleComment"), RadTextBox)
                AddComment(txtSingleComment, postID)
                ' BindAllNews()
                BindNews()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script", "loadPopupBoxPost(" & postID.ToString() & ");", True)
                Exit Sub
            Catch ex As Exception
                GlobalModule.SetMessage(messageLabel, False, "Error in request")
                GlobalModule.ErrorLogFile(ex)
            End Try
        ElseIf (e.CommandName = "IBoostOnFacebook") Then
            Session("IsFbShare") = postID.ToString()
            FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))
        ElseIf (e.CommandName = "IBoostOnTwitter") Then
            If Not TwitterConnect.IsAuthorized Then
                Dim twitter As New TwitterConnect()
                Session("IsTwitterShare") = postID.ToString()
                Session("tweetMessage") = lblComment.Text
                twitter.Authorize(Request.Url.AbsoluteUri.Split("?"c)(0))
            End If
        End If
    End Sub



    'Protected Sub crowdNewsAllDataListFull_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles crowdNewsAllDataListFull.ItemCommand
    '    Try
    '        Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
    '        Dim lblComment As Label = CType(e.Item.FindControl("lblCommentFull"), Label)
    '        If (e.CommandName = "IComment") Then
    '            Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleCommentFull"), RadTextBox)
    '            AddComment(txtSingleComment, postID)
    '            BindAllNews()
    '            ' BindNews()
    '            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
    '            Exit Sub
    '        ElseIf (e.CommandName = "IRecommend") Then
    '            Dim lbtnRecommendsNewsAll As LinkButton = CType(e.Item.FindControl("lbtnRecommendsNewsAllFull"), LinkButton)
    '            If (lbtnRecommendsNewsAll.Text = "Recommend") Then
    '                sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = True
    '            Else
    '                sdIRecommend.SelectParameters.Item("Recommend").DefaultValue = False
    '            End If
    '            sdIRecommend.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
    '            sdIRecommend.SelectParameters.Item("PostID").DefaultValue = postID
    '            Dim dv As Data.DataView = CType(sdIRecommend.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '            BindAllNews()
    '            ' BindNews()
    '            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
    '            Exit Sub
    '        ElseIf (e.CommandName = "IBoostOnFacebook") Then
    '            Session("IsFbShare") = postID.ToString()
    '            FaceBookConnect.Authorize("publish_actions", System.Configuration.ConfigurationManager.AppSettings("returnURL"))
    '            Exit Sub
    '        ElseIf (e.CommandName = "IBoostOnTwitter") Then
    '            If Not TwitterConnect.IsAuthorized Then
    '                Dim twitter As New TwitterConnect()
    '                Session("IsTwitterShare") = postID.ToString()
    '                Session("tweetMessage") = lblComment.Text
    '                twitter.Authorize(Request.Url.AbsoluteUri.Split("?"c)(0))
    '            End If
    '        End If

    '    Catch ex As Exception
    '        GlobalModule.SetMessage(messageLabel, False, "Error in request")
    '        GlobalModule.ErrorLogFile(ex)

    '    End Try
    'End Sub


    Protected Sub SaveBoostEntry()
        Try
            sdCommentOnPost.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            sdCommentOnPost.SelectParameters.Item("PostID").DefaultValue = Session("IsTwitterShare").ToString()
            Dim dv As Data.DataView = CType(sdCommentOnPost.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Session("IsTwitterShare") = Nothing
            Session("tweetMessage") = Nothing
        Catch ex As Exception
            Throw ex

        End Try
    End Sub
    Protected Sub crowdNewsDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles crowdNewsDataList.ItemDataBound
        Try

            Dim hdnPostID = TryCast(e.Item.FindControl("hdnPostID"), HiddenField)

            Dim singlePostRepliesDataList As DataList = TryCast(e.Item.FindControl("singlePostRepliesDataList"), DataList)

            sdPostReplies.SelectParameters.Item("PostID").DefaultValue = hdnPostID.Value
            Dim dv As Data.DataView = CType(sdPostReplies.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then

                singlePostRepliesDataList.DataSource = dv
                singlePostRepliesDataList.DataBind()
            End If


        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub


    'Protected Sub crowdNewsAllDataListFull_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles crowdNewsAllDataListFull.ItemDataBound
    '    Try

    '        Dim hdnPostID = TryCast(e.Item.FindControl("hdnPostIDFull"), HiddenField)

    '        Dim singlePostRepliesDataListFull As DataList = TryCast(e.Item.FindControl("singlePostRepliesDataListFull"), DataList)

    '        sdPostReplies.SelectParameters.Item("PostID").DefaultValue = hdnPostID.Value
    '        Dim dv As Data.DataView = CType(sdPostReplies.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '        If dv.Count > 0 Then

    '            singlePostRepliesDataListFull.DataSource = dv
    '            singlePostRepliesDataListFull.DataBind()
    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '        GlobalModule.ErrorLogFile(ex)

    '    End Try
    'End Sub

    Protected Sub boardersDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles boardersDataList.ItemDataBound
        Try
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("firendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            'Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width: 100%;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub
    Protected Sub btnSearchDistrics_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchDistrics.Click

        Dim searchBoards = areaSeachValueHdn.Value 'searchTextBox.Value
        Response.Redirect("~/Search.aspx?searchValue=" & searchBoards)
    End Sub
    'Protected Sub lbtnImageAddBoarder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnImageAddBoarder.Click
    '    radMultiPageCrowdNewFull.SelectedIndex = 2
    '    txtSearchBoarders.Text = ""
    '    Session("searchKeyWord") = "%"
    '    LoadAllBoarders()
    '    surfBoardsRepeater.DataBind()
    'End Sub



    Protected Sub lbtnShowAddBoarderView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnShowAddBoarderView.Click
        'radMultiPageCrowdNewFull.SelectedIndex = 2
        'txtSearchBoarders.Text = ""
        'Session("searchKeyWord") = "%"
        'LoadAllBoarders()
        'surfBoardsRepeater.DataBind()
        Response.Redirect("~/BoarderLineup.aspx", False)

    End Sub
    'Protected Sub BindAllNews()
    '    Try
    '        Dim dv As Data.DataView = CType(sdCrowdNewsFull.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '        crowdNewsAllDataListFull.DataSource = dv
    '        crowdNewsAllDataListFull.DataBind()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub
    Protected Sub BindNews()
        Try
            Dim dv As Data.DataView = CType(sdCrowdNews.Select(DataSourceSelectArguments.Empty), Data.DataView)
            crowdNewsDataList.DataSource = dv
            crowdNewsDataList.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub lbtnShowAllCrowdNewsView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnShowAllCrowdNewsView.Click
        'radMultiPageCrowdNewFull.SelectedIndex = 0
        'BindAllNews()
        'surfBoardsRepeater.DataBind()
        Response.Redirect("~/CrowdNews.aspx")
    End Sub
    Protected Sub lbtnShowBoarderDetailsViewBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnShowBoarderDetailsViewBack.Click
        radMultiPageCrowdNewFull.SelectedIndex = 0
        surfBoardsRepeater.DataBind()
    End Sub

    'Protected Sub lbtnCloseCrowdNewsAllFull_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnCloseCrowdNewsAllFull.Click
    '    radMultiPageCrowdNewFull.SelectedIndex = 1
    '    surfBoardsRepeater.DataBind()
    'End Sub

    Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
        Dim searchBoards = searchBoardsTextBox.Value
        Response.Redirect("~/SiteSearch.aspx?searchValue=" & searchBoards)
    End Sub

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16) As String
        Try
            Dim GM As New GlobalModule
            Return GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, "thumbnail", "thumbs")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Function

    Public Function CheckBoarName(ByVal postMessage As String) As String
        Try
            If (postMessage.Contains("@")) Then


                Dim boards As String() = postMessage.Split("@")
                For Each brd As String In boards
                    If postMessage.Contains("@" + brd.Trim() + "@") AndAlso brd.Trim() <> "" Then
                        postMessage = postMessage.Replace("@" + brd.Trim() + "@", "$" + brd.Trim() + "$")
                    End If
                Next

                '-------------

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
                                    Dim urlString As String = "<a style='color:#99CCFF;' href='" + s + "/Board.aspx?Name=" + dr(0)("DirectoryName").ToString() + "'>" + "@" + words(i).ToString() + "@</a>"
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
                        Dim urlArStr As String = "<a style='color:#99CCFF;' href='" + strAr + "/Search.aspx?Area=" + areaName + "'>" + "@" + areaName + "incrowd</a>"
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
        postMessage = postMessage.Replace("$", "@")

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
            Throw ex
        End Try
    End Sub

    Public Sub CheckCountOfPhoto()

        Dim dv As Data.DataView = CType(sdBoarders.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If (dv) IsNot Nothing Then
            If dv.Count > 6 Then
                Panel1.Visible = True
            Else
                Panel1.Visible = False
            End If
        Else
            Panel1.Visible = False
        End If


    End Sub

    Protected Sub districtAddDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles districtAddDataList.ItemCommand
        Try
            If (e.CommandName = "IRemoveDistrict") Then
                Dim districtID As String = e.CommandArgument
                AddRemoveDistrict(districtID, "Remove")
            ElseIf (e.CommandName = "IAddDistrict") Then
                Dim districtID As String = e.CommandArgument
                AddRemoveDistrict(districtID, "Add")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub joinArea_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles joinArea.Click
        Try
            Dim areaId As String = hdnAreaID.Value
            Dim type As String = hdnType.Value
            'If areaId <> "" Then
            If type <> "" Then
                If type = "Add" Then
                    AddRemoveArea(areaId, "Add")
                Else
                    AddRemoveArea(areaId, "Remove")
                End If
                'End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub AddRemoveDistrict(ByVal districtID As String, ByVal type As String)
        Try
            If type = "Add" Then
                If districtID <> "" Then
                    sdUsersDistricts.InsertParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                    sdUsersDistricts.InsertParameters.Item("DistrictID").DefaultValue = districtID
                    sdUsersDistricts.Insert()

                End If
            Else
                If districtID <> "" Then
                    sdUsersDistricts.DeleteParameters("DistrictID").DefaultValue = districtID
                    sdUsersDistricts.Delete()
                End If
            End If
            districtsRepeater.DataBind()
            districtDataList.DataBind()
            districtAddDataList.DataBind()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxOnlyDistrict();", True)
        Catch ex As Exception
            Throw ex

        End Try
    End Sub
    Protected Sub AddRemoveArea(ByVal areaID As String, ByVal type As String)
        Try

            If type = "Add" Then
                For Each var As DataListItem In districtDataList.Items
                    Dim areaDatalist As DataList = DirectCast(var.FindControl("areaDataList"), DataList)
                    For Each item As DataListItem In areaDatalist.Items
                        Dim chkArea As CheckBox = DirectCast(item.FindControl("chkArea"), CheckBox)
                        If chkArea.Checked Then
                            'Dim hdnAreaName As HiddenField = DirectCast(item.FindControl("hdnAreaName"), HiddenField)
                            'Dim areaName As String = hdnAreaName.Value
                            Dim hdnAreaID As HiddenField = DirectCast(item.FindControl("hdnAreaID"), HiddenField)
                            Dim id As String = hdnAreaID.Value

                            sdUserAreas.InsertParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                            sdUserAreas.InsertParameters.Item("AreaID").DefaultValue = id
                            sdUserAreas.Insert()

                        End If
                    Next

                Next
                'If areaID <> "" Then
                '    'sdUserAreas.InsertParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
                '    'sdUserAreas.InsertParameters.Item("AreaID").DefaultValue = areaID
                '    'sdUserAreas.Insert()
                'End If
            Else
                If areaID <> "" Then
                    sdUserAreas.DeleteParameters("areaID").DefaultValue = areaID
                    sdUserAreas.Delete()
                End If
            End If
            userAreasRepeater.DataBind()
            districtDataList.DataBind()
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxDiscricts();", True)
        Catch ex As Exception
            Throw ex

        End Try
    End Sub

    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function



    Private Sub LoadMessageCount()
        Try

            Dim dv4 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)

            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("MessageCount"))) Then
                        lblUpdates.Text = "(" & dv4(0)("MessageCount").ToString() & ")"
                    Else
                        lblUpdates.Text = "(" + "0" + ")"
                    End If

                End If
            Else
                lblUpdates.Text = "(" + "0" + ")"
            End If


        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadNotificationData()
        Try
            sdNotifications.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdNotifications.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn") '"06/07/2013"
            sdRecentActivityOnBoards.SelectParameters.Item("userID").DefaultValue = Session("userID")
            sdRecentActivityOnBoards.SelectParameters.Item("DateLastLoggedIn").DefaultValue = Session("DateLastLoggedIn") '"06/07/2013"  
            Dim dv3 As DataView = CType(sdNotifications.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv4 As DataView = CType(sdRecentActivityOnBoards.Select(DataSourceSelectArguments.Empty), DataView)
            If (dv3 Is Nothing) Or (dv4 Is Nothing) Then
                countNotification.Text = "(0)"
                Exit Sub
            End If
            If dv3.Count > 0 Then
                notificationsRepeater.DataSource = dv3
                notificationsRepeater.DataBind()
            End If

            If dv4.Count > 0 Then
                recentActivityOnBoardsRepeater.DataSource = dv4
                recentActivityOnBoardsRepeater.DataBind()
            End If
            countNotification.Text = "(" & dv3.Count + dv4.Count & ")"
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub boardersRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles boardersRepeater.ItemCommand
        Try
            If (e.CommandName = "IAccept") Then
                Dim requesterEmailID As HiddenField = CType(e.Item.FindControl("requesterEmailID"), HiddenField)
                Dim userID1 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdPendingRequests.UpdateParameters.Item("userID1").DefaultValue = userID1
                Dim result As Integer = sdPendingRequests.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request accepted")
                    If (requesterEmailID.Value <> "") Then
                        SendEmailToUser(requesterEmailID.Value)
                    End If

                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in accepting  Request")
                End If
            ElseIf (e.CommandName = "IDecline") Then
                Dim userID1 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdRejectRequest.UpdateParameters.Item("userID1").DefaultValue = userID1
                Dim result As Integer = sdRejectRequest.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request declined")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in rejecting  Request")
                End If

            End If
            boardersRepeater.DataBind()
            LoadData()
            LoadPendingRequestData()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendEmailToUser(ByVal email As String)
        Try
            Dim strSubject As String = "A CrowdBoarder has added you!"
            Dim toAddress As String = email
            Dim strBody As String = "A fellow CrowdBoarder has added you to their Boarders Lineup, login to see who: <a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + ">" + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
            GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub crowdBoardInvitationsRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles crowdBoardInvitationsRepeater.ItemCommand
        Try
            If (e.CommandName = "IAccept") Then
                Dim BoardID As Int32 = Convert.ToInt32(e.CommandArgument())
                sdsCrowdBoardInvites.UpdateParameters.Item("BoardID").DefaultValue = BoardID
                Dim result As Integer = sdsCrowdBoardInvites.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request accepted")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in accepting  Request")
                End If
            ElseIf (e.CommandName = "IDecline") Then
                Dim BoardID As Int32 = Convert.ToInt32(e.CommandArgument())
                sdRejectCrowdboardTeamRequest.UpdateParameters.Item("BoardID").DefaultValue = BoardID
                Dim result As Integer = sdRejectCrowdboardTeamRequest.Update()
                If result = 1 Then
                    GlobalModule.SetMessage(lblMessage, True, "Request declined")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Error in rejecting  Request")
                End If

            End If
            crowdBoardInvitationsRepeater.DataBind()
            LoadData()
            LoadPendingRequestData()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in  Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Private Sub LoadPendingRequestData()
        Try
            Dim dv4 As DataView = CType(sdRejectRequest.Select(DataSourceSelectArguments.Empty), DataView)
            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("RequestCount"))) Then
                        requestsCountLabel.Text = "(" & dv4(0)("RequestCount").ToString() & ")"
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Protected Sub liCrowdNews_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liCrowdNews.Click
        Session("cssNews") = "focus"
        Session("cssSearch") = ""
        Session("cssHome") = ""
        Response.Redirect("CrowdNews.aspx")
    End Sub

    Protected Sub liSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liSearch.Click
        Session("cssSearch") = "focus"
        Session("cssNews") = ""
        Session("cssHome") = ""
        Response.Redirect("Search.aspx")
    End Sub

    Protected Sub liHome_Click(ByVal sender As Object, ByVal e As EventArgs) Handles liHome.Click
        Session("cssHome") = "focus"
        Session("cssNews") = ""
        Session("cssSearch") = ""
        Response.Redirect("Home.aspx")
    End Sub
    Protected Sub lbtlogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtlogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub
End Class