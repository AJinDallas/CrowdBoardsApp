Imports Telerik.Web.UI
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports System.IO

Public Class CrowdNews
    Inherits System.Web.UI.Page
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

    Public Property boardDataTable() As DataTable

        Get
            Return CType(ViewState("_boardDataTable"), DataTable)
        End Get

        Set(ByVal value As DataTable)
            ViewState("_boardDataTable") = value
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
        messageLabel.Text = ""
        If Not (Page.IsPostBack) Then

            Response.AddCacheItemDependency("CrowdNews.aspx")
            LoadBoardUsers()
            BindAllNews()
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
        End If

    End Sub

    Protected Sub crowdNewsAllDataListFull_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles crowdNewsAllDataListFull.ItemCommand
        Try
            Dim postID As Int32 = Convert.ToInt32(e.CommandArgument())
            Dim lblComment As Label = CType(e.Item.FindControl("lblCommentFull"), Label)
            If (e.CommandName = "IComment") Then
                Dim txtSingleComment As RadTextBox = CType(e.Item.FindControl("txtSingleCommentFull"), RadTextBox)
                AddComment(txtSingleComment, postID)
                BindAllNews()
                ' BindNews()
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
                BindAllNews()
                ' BindNews()
                'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxPostAllFull(" & postID.ToString() & ");", True)
                'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script1", "loadPopupBoxPostAll(" & postID.ToString() & ");", True)
            ElseIf (e.CommandName = "IBoostOnFacebook") Then
                Session("IsFbShare") = postID.ToString()
                Session("PagePrompt") = "CrowdNews.aspx"
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
    Protected Sub BindAllNews()
        Try
            searchValueLabel.Text = ""
            searchValueLabel.Attributes.Add("Style", "color:#48a88d; font-size:18px;")
            Dim dv As Data.DataView = CType(sdCrowdNewsFull.Select(DataSourceSelectArguments.Empty), Data.DataView)
            crowdNewsAllDataListFull.DataSource = dv
            crowdNewsAllDataListFull.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

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
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Protected Sub crowdNewsAllDataListFull_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles crowdNewsAllDataListFull.ItemDataBound
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
                BindAllNews()

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
    'Protected Sub BindNews()
    '    Try
    '        Dim dv As Data.DataView = CType(sdCrowdNews.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '        crowdNewsDataList.DataSource = dv
    '        crowdNewsDataList.DataBind()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub

    Protected Sub districtsRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles districtsRepeater.ItemCommand
        Try
            If (e.CommandName.ToString() = "districtFilter") Then
                Dim districtName As String = e.CommandArgument.ToString()
                searchValueLabel.Text = districtName
                searchValueLabel.Attributes.Add("Style", "color:#75b4c6; font-size:18px;")
                Dim dv As Data.DataView = CType(sdCrowdNewsFull.Select(DataSourceSelectArguments.Empty), Data.DataView)
                dv.RowFilter = "Text like '%" + districtName + "District%'"
                crowdNewsAllDataListFull.DataSource = dv
                crowdNewsAllDataListFull.DataBind()
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub


    Protected Sub userAreasRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles userAreasRepeater.ItemCommand
        Try
            If (e.CommandName.ToString() = "areaFilter") Then
                Dim areaName As String = e.CommandArgument.ToString()
                searchValueLabel.Text = areaName
                searchValueLabel.Attributes.Add("Style", "color:#48a88d; font-size:18px;")
                Dim dv As Data.DataView = CType(sdCrowdNewsFull.Select(DataSourceSelectArguments.Empty), Data.DataView)
                dv.RowFilter = "Text like '%" + areaName + "incrowd%'"
                crowdNewsAllDataListFull.DataSource = dv
                crowdNewsAllDataListFull.DataBind()
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub
    Protected Sub viewAllPostLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles viewAllPostLinkButton.Click
        Try
           
            BindAllNews()
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub


End Class