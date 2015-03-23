Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports Telerik.Web.UI
Imports System.IO

Public Class Wordonthestreet
    Inherits System.Web.UI.Page

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
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        TwitterConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("consumerKey")
        TwitterConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("consumerSecret")

        lblMessageSearch.Text = ""
        lblMessage.Text = ""
        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If

        If (Not Page.IsPostBack) Then
            Try
                If Not Session("UserID") Is Nothing Then
                    If Not (Session("District")) Is Nothing Then
                        backLinkButton.Text = "Back to " & Session("District") & " District"
                        districtNameLable.Text = Session("District")
                        If Not (Request.QueryString("s")) Is Nothing Then
                            populationLinkButton.Attributes.Add("style", "text-decoration:underline")
                            wordonStreetMultiview.ActiveViewIndex = 1
                        Else
                            wordonStretLinkButton.Attributes.Add("style", "text-decoration:underline")
                            wordonStreetMultiview.ActiveViewIndex = 0
                        End If
                    End If

                    sdDistricts.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                    districtDataList.DataBind()
                    districtSpecificNewsDataList.DataBind()
                    LoadPopulation()
                    LoadBoardUsers()
                    If Not Session("userName") Is Nothing Then
                        Dim GM As New GlobalModule
                        Dim path As String = GM.GetImageURL(Session("userName") & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")
                        userProfileImage.Src = path
                        userNameLabel.Text = Session("userName").ToString()
                    End If
                    If Not Session("hdnIsExists") Is Nothing Then
                        SetDistrictAddRemoveText(Session("hdnIsExists").ToString())
                    End If
                Else
                    Response.Redirect("~/Default.aspx", False)
                End If
            Catch ex As Exception
                GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
    End Sub

    Protected Sub districtDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles districtDataList.ItemCommand
        Try
            If (e.CommandName.ToString() = "ShowBoards") Then
                Dim hdnUserCount As HiddenField = e.Item.FindControl("hdnUserCount")
                Dim hdnDistrictName As HiddenField = e.Item.FindControl("hdnDistrictName")
                Session("District") = hdnDistrictName.Value
                districtNameLable.Text = hdnDistrictName.Value
                Session("districtID") = CInt(e.CommandArgument.ToString())
                Dim hdnIsExists As HiddenField = e.Item.FindControl("hdnIsExists")
                SetDistrictAddRemoveText(hdnIsExists.Value)
                sdCrowdNewsDistrictSpecific.DataBind()
                LoadPopulation()

            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub



    Protected Sub populationLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles populationLinkButton.Click
        Try
            ResetCss()
            populationLinkButton.Attributes.Add("style", "text-decoration:underline")
            wordonStreetMultiview.ActiveViewIndex = 1
            LoadPopulation()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub wordonStretLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles wordonStretLinkButton.Click
        Try
            ResetCss()
            wordonStretLinkButton.Attributes.Add("style", "text-decoration:underline")
            wordonStreetMultiview.ActiveViewIndex = 0
            sdCrowdNewsDistrictSpecific.DataBind()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub backLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles backLinkButton.Click
        Try
            Response.Redirect("~/Search.aspx", False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub ResetCss()
        Try
            wordonStretLinkButton.Attributes.Add("style", "text-decoration:none")
            populationLinkButton.Attributes.Add("style", "text-decoration:none")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Protected Sub addDistrictSpecificPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addDistrictSpecificPost.Click
        Try
            SubmitPost(districtSpecificPostTextBox.Text)
            districtSpecificPostTextBox.Text = "@" & Session("District").ToString() & "District"
            districtSpecificNewsDataList.DataBind()
            districtSpecificPostTextBox.Text = ""
            districtSpecificPostTextBox.Focus()

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            GlobalModule.SetMessage(lblMessageSearch, False, "Error in request")
        End Try
    End Sub

    Protected Sub SubmitPost(ByVal postText As String)
        Try
            If postText <> "" Then
                LoadBoardUsers()
                sdPosts.SelectParameters.Item("Text").DefaultValue = CheckBoarName(postText)
                sdPosts.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
                'If dv.Count > 0 Then
                If dv.Count > 0 Then
                    SaveAttachment(Convert.ToInt32(dv(0)("PostID")))
                    GlobalModule.SetMessage(lblMessage, True, "Post added Successfully")
                Else
                    GlobalModule.SetMessage(lblMessage, False, "Post not added")
                End If
            Else
                GlobalModule.SetMessage(lblMessage, False, "Post is blank")
            End If
        Catch ex As Exception
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
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub LoadPopulation()
        Try
            sdPopulation.SelectParameters.Item("DistrictID").DefaultValue = Convert.ToInt32(Session("districtID"))
            Dim dv As Data.DataView = CType(sdPopulation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            nonFriendDataList.DataSource = dv
            nonFriendDataList.DataBind()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub SetDistrictAddRemoveText(ByVal isExists As String)
        If (isExists = 0) Then
            addDistrictRemoveButton.Text = "Add to My Districts"
            'postOnDistrictDiv.Visible = False
        Else
            'postOnDistrictDiv.Visible = True
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

            LoadPopulation()
            'areaRepeater.DataBind()
            'If (Me.showResult <> "") Then
            '    LoadBoardByArea(Me.AreaName)
            'Else
            'LoadBoardsRepeater()
            'End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub nonFriendDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles nonFriendDataList.ItemDataBound
        Try
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim addButton = TryCast(e.Item.FindControl("btnAddBoarder"), Button)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("firendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width: 100%;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)
            If (hdnFriend.Value.ToLower = Session("userName").ToString().ToLower()) Then
                addButton.Visible = False
            Else
                addButton.Visible = True
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub nonFriendDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles nonFriendDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                Dim requestStatus As Integer = CheckRequest(userID2)
                If (requestStatus = 3) Then
                    sdBoarders.InsertParameters.Item("userID2").DefaultValue = userID2
                    sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.Insert()
                    GlobalModule.SetMessage(lblMessage, True, "Request Sent Successfully")
                    LoadPopulation()
                Else
                    If requestStatus = 0 Then
                        GlobalModule.SetMessage(lblMessage, False, "You have already sent request")
                    ElseIf requestStatus = 1 Then
                        GlobalModule.SetMessage(lblMessage, False, "You are already friend")
                    Else
                        sdBoarders.UpdateParameters.Item("userID2").DefaultValue = userID2
                        sdBoarders.UpdateParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                        sdBoarders.Update()
                        GlobalModule.SetMessage(lblMessage, True, "Request Sent Successfully")
                        LoadPopulation()

                    End If
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Sending Request")
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
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return status
    End Function

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
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub districtSpecificNewsDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles districtSpecificNewsDataList.ItemCommand
        Try
            Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
            Dim lblComment As Label = CType(e.Item.FindControl("lblCommentFull"), Label)
            If (e.CommandName = "IComment") Then
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleComment"), RadTextBox)
                AddComment(txtSingleComment, postID)
                districtSpecificNewsDataList.DataBind()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAllFull(" & postID.ToString() & ");", True)
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
                districtSpecificNewsDataList.DataBind()
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAllFull(" & postID.ToString() & ");", True)
                Exit Sub
            ElseIf (e.CommandName = "IBoostOnFacebook") Then
                Session("IsFbShare") = postID.ToString()
                Session("PagePrompt") = "Wordonthestreet.aspx"
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
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub districtSpecificNewsDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles districtSpecificNewsDataList.ItemDataBound
        Try

            Dim hdnPostID = TryCast(e.Item.FindControl("hdnPostID"), HiddenField)
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


End Class