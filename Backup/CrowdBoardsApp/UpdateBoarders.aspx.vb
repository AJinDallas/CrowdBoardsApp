Imports Telerik.Web.UI
Imports System.IO
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI

Public Class UpdateBoarders
    Inherits System.Web.UI.Page
    Public Property DirectoryName() As String

        Get
            Return CStr(ViewState("_directoryName"))
        End Get

        Set(ByVal value As String)
            ViewState("_directoryName") = value
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
    Public Property boardID() As Integer
        Get
            Return CInt(ViewState("_boardID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessage.Text = ""
        lblMessageAddBoarder.Text = ""
        messageLabel.Text = ""
        If Not (Page.IsPostBack) Then
            If Request.QueryString.Count > 0 Then
                If Request.QueryString("Name") IsNot Nothing Then
                    Me.boardID = getBoardId()
                    Me.DirectoryName = Request.QueryString("Name")
                    lblCrowdboardName.Text = Me.DirectoryName

                    Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
                    If (dv.Count > 0) Then
                        If (Not IsDBNull(dv(0)("BoardName"))) Then
                            lblCrowdboardName.Text = dv(0)("BoardName")
                        End If
                    End If

                End If
            End If

            lbtnUpdates.Attributes.Add("style", "text-decoration:underline")
            LoadBoardUsers()
            LoadAllBoarders()
            '  BindNews()
            LoadWatchBoarders()
            profilePic.ImageUrl = isAvail("~/Upload/ProfilePics/" & Session("userName").ToString() & ".jpg")
            LoadOwnerPosts()
        End If
    End Sub

    Protected Sub lbtnUpdates_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnUpdates.Click
        rmpUpdates.SelectedIndex = 0
        ResetCss()
        lbtnUpdates.Attributes.Add("style", "text-decoration:underline")

    End Sub

    Protected Sub lbtnBodersin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBodersin.Click
        rmpUpdates.SelectedIndex = 1
        ResetCss()
        lbtnBodersin.Attributes.Add("style", "text-decoration:underline")

    End Sub

    Protected Sub lbtnWatching_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnWatching.Click
        rmpUpdates.SelectedIndex = 2
        ResetCss()
        lbtnWatching.Attributes.Add("style", "text-decoration:underline")

    End Sub

    Protected Sub ResetCss()
        Try
            lbtnUpdates.Attributes.Add("style", "text-decoration:none")
            lbtnBodersin.Attributes.Add("style", "text-decoration:none")
            lbtnWatching.Attributes.Add("style", "text-decoration:none")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub LoadAllBoarders()
        Try
            sdAllBoardersList.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            Dim dv As Data.DataView = CType(sdAllBoardersList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            nonFriendDataList.DataSource = dv
            nonFriendDataList.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub LoadWatchBoarders()
        Try
            sdWatchBoarders.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            Dim dv As Data.DataView = CType(sdWatchBoarders.Select(DataSourceSelectArguments.Empty), Data.DataView)
            watchBoardDataList.DataSource = dv
            watchBoardDataList.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub boardersDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles nonFriendDataList.ItemDataBound
        Try
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("firendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width: 100%;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub watchBoardDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles watchBoardDataList.ItemDataBound
        Try
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("firendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "thumbnail", "thumbs")
            Dim attributeValue As String = "background-image:url(" & path & ");height:97%; width: 97%;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub watchBoardDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles watchBoardDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim boardID As Integer = Convert.ToInt32(e.CommandArgument)
                If CheckIsOwner(boardID) = 1 Then
                    GlobalModule.SetMessage(lblMessage, False, "You cannot watch your own Board")
                Else
                    WatchBoard("Private", boardID)
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub WatchBoard(ByVal type As String, ByVal boardID As Integer)
        Try
            If type.Trim = "Private" Then
                sdWatchers.SelectParameters.Item("PrivateWatch").DefaultValue = 1
            Else
                sdWatchers.SelectParameters.Item("PrivateWatch").DefaultValue = 0
            End If
            sdWatchers.SelectParameters.Item("BoardID").DefaultValue = boardID
            sdWatchers.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            Dim dv2 As Data.DataView = CType(sdWatchers.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv2.Count > 0 Then
                If dv2(0)(0) = "0" Then
                    GlobalModule.SetMessage(lblMessage, False, "You are Already Watching this Board")
                Else
                    SendEmailToUser(boardID)

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub SendEmailToUser(ByVal boardID As Integer)
        Try
            sdUserInfo.SelectParameters.Item("BoardID").DefaultValue = boardID
            Dim dv3 As Data.DataView = CType(sdUserInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv3.Count > 0 Then
                If (Not IsDBNull(dv3(0)("Email"))) Then
                    If (Not dv3(0)("Email") = "") Then
                        Dim receiverEmail As String = dv3(0)("Email")
                        Dim strSubject As String = "Your CrowdBoard is being watched!"
                        Dim toAddress As String = receiverEmail.Trim
                        Dim strBody As String = "A CrowdBoarder has watched your CrowdBoard, login to see who: <a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>"
                        GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function CheckIsOwner(ByVal boardID As Integer) As Integer
        Dim isOwner As Integer = 0
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = boardID
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

    'Protected Sub BindNews()
    '    Try
    '        Dim dv As Data.DataView = CType(sdCrowdNews.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '        crowdNewsDataList.DataSource = dv
    '        crowdNewsDataList.DataBind()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Protected Sub nonFriendDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles nonFriendDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                Dim requestStatus As Integer = CheckRequest(userID2)
                If (requestStatus = 3) Then
                    sdBoarders.InsertParameters.Item("userID2").DefaultValue = userID2
                    sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.Insert()
                    GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                    LoadAllBoarders()
                Else
                    If requestStatus = 0 Then
                        GlobalModule.SetMessage(lblMessageAddBoarder, False, "You have already send request")
                    ElseIf requestStatus = 1 Then
                        GlobalModule.SetMessage(lblMessageAddBoarder, False, "You are already friend")
                    Else
                        sdBoarders.UpdateParameters.Item("userID2").DefaultValue = userID2
                        sdBoarders.UpdateParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                        sdBoarders.Update()
                        GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                        LoadAllBoarders()
                    End If

                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
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

    Protected Sub postRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles postRadButton.Click
        Try


            If txtPost.InnerText <> "" Then
                If (AddInsiderPost(txtPost.InnerText) = 1) Then
                    GlobalModule.SetMessage(messageLabel, True, "Post Added Successfully")
                    txtPost.InnerText = ""
                    LoadOwnerPosts()
                End If
            Else
                GlobalModule.SetMessage(messageLabel, False, "Please enter text")
            End If


            'If txtPost.InnerText <> "" Then
            '    Dim message As String = CheckBoarName(txtPost.InnerText)
            '    sdPosts.SelectParameters.Item("Text").DefaultValue = message
            '    sdPosts.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            '    Dim dv As Data.DataView = CType(sdPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
            '    If dv.Count > 0 Then
            '        SaveAttachment(Convert.ToInt32(dv(0)("PostID")))
            '    End If
            '    txtPost.InnerText = ""
            '    txtPost.Focus()
            '    ' BindAllNews()
            '    BindNews()

            '    GlobalModule.SetMessage(messageLabel, True, "Post added successfully")
            'Else
            '    GlobalModule.SetMessage(messageLabel, False, "Post is blank")
            'End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Writing Post")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Function AddInsiderPost(ByVal text As String) As Integer
        Dim result As Integer = 0
        Try
            sdInsiderPosts.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
            sdInsiderPosts.InsertParameters.Item("UserID").DefaultValue = Session("userID")
            sdInsiderPosts.InsertParameters.Item("Text").DefaultValue = text
            result = sdInsiderPosts.Insert()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function

    Protected Sub LoadOwnerPosts()
        Try
            sdBoardInsiderPosts.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoardInsiderPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
            dv.RowFilter = "PostBy='IsOwnerPost'"
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            ownerPosts.DataSource = dv
            ownerPosts.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Private Function getBoardId() As Integer
        Dim Id As Integer = 0
        Try
            sdGetBoardIdDataSource.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                Id = dv(0)("BoardID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return Id
    End Function



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

    Protected Sub lbtnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnEdit.Click

        Response.Redirect("BoardDetails.aspx?Name=" + Me.DirectoryName)
    End Sub

    Protected Sub lbtnManage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnManage.Click

        Response.Redirect("CrowdBoardManagement.aspx?Name=" + Me.DirectoryName)
    End Sub

    Protected Sub lbtnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnUpdate.Click

        Response.Redirect("UpdateBoarders.aspx?Name=" + Me.DirectoryName)
    End Sub

    Protected Sub ownerPosts_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles ownerPosts.ItemDataBound
        Try

            Dim hdnPostID = TryCast(e.Item.FindControl("hdnPostIDFull"), HiddenField)
            Dim recommendImg = TryCast(e.Item.FindControl("recommendImg"), Image)
            Dim lbtnRecommendsNewsAllFull = TryCast(e.Item.FindControl("lbtnRecommendsNewsAllFull"), LinkButton)
            Dim singlePostRepliesDataListFull As DataList = TryCast(e.Item.FindControl("singlePostRepliesDataListFull"), DataList)

            recommendImg.Attributes("onclick") = String.Format("ClickRecommend(" & lbtnRecommendsNewsAllFull.ClientID & ");")

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


    Protected Sub ownerPosts_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles ownerPosts.ItemCommand
        Try
            Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
            Dim lblComment As Label = CType(e.Item.FindControl("lblComment"), Label)
            If (e.CommandName = "IComment") Then
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleCommentFull"), RadTextBox)
                AddComment(txtSingleComment, postID)
                'BindAllNews()
                ' BindNews()
                LoadOwnerPosts()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxPostAllFull(" & postID.ToString() & ");", True)
                'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAllFull(" & postID.ToString() & ")", True)
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
                'BindAllNews()
                ' BindNews()
                LoadOwnerPosts()
                'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxPostAllFull(" & postID.ToString() & ");", True)
                'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
            ElseIf (e.CommandName = "IBoostOnFacebook") Then
                Session("IsFbShare") = postID.ToString()
                Session("PagePrompt") = "UpdateBoarders.aspx"
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
End Class