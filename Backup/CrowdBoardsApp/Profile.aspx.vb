Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Imports System.Drawing
Public Class Profile
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property UserID() As Integer

        Get
            Return CInt(ViewState("_UserID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_UserID") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        'Remove Page Caching…
        Response.Expires = -1
        Response.ExpiresAbsolute = Now()
        Response.CacheControl = "no-cache"

        Try
            If Session("userName") Is Nothing Then

                If (Request.QueryString.Count > 0) Then
                    Dim returnURL As String = "~/Profile.aspx?User=" & Request.QueryString("User")
                    Response.Redirect("~/Default.aspx?returnURL=" & HttpUtility.UrlEncode(returnURL), False)
                    Exit Sub
                End If
                Response.Redirect("~/Default.aspx", False)
                Exit Sub
            End If
            messageLabel.Visible = False
            sendMessageLabel.Text = String.Empty
            If Request.QueryString("user") IsNot Nothing Then
                Me.UserID = GetUserID(Request.QueryString("user"))
                userNameLabel.Text = Request.QueryString("user").ToUpper()
                userNameLabelActivity.Text = Request.QueryString("user").ToUpper() & "'s Activity"
                createdBoardNameLable.Text = userNameLabel.Text
            End If
            If (Not Page.IsPostBack) Then

                BoardsFriendsInvestmentsOfUser()
                LoadUserInfo()
                RecentComment()
                RecentInvestment()
                RecentWatched()
                RecentPost()
                LoadBoardfolio()
                LoadAllBoardsRepeater()
                SetLabels()
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Loading")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    'Private Sub LoadUserInfo()
    '    Try
    '        SetProfileAndBackgroundImage()
    '        RecentActivities()
    '        Dim dv As Data.DataView = CType(sdUserInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '        Dim dv1 As Data.DataView = CType(sdBoarders.Select(DataSourceSelectArguments.Empty), Data.DataView)


    '        If (dv.Count > 0) Then
    '            nameLabel.Text = dv(0)("Name")
    '            If Request.QueryString("user") IsNot Nothing Then
    '                If Not (Session("UserName").ToString().ToLower() = Request.QueryString("user").ToLower()) Then
    '                    sdBoarderStatus.SelectParameters.Item("UserID1").DefaultValue = Session("UserID").ToString()
    '                    sdBoarderStatus.SelectParameters.Item("UserID2").DefaultValue = dv(0)("userid")
    '                    Dim dvBoarderStatus As Data.DataView = CType(sdBoarderStatus.Select(DataSourceSelectArguments.Empty), Data.DataView)
    '                    If (dvBoarderStatus.Count > 0) Then
    '                        If (dvBoarderStatus(0)("Status") = 1) Then
    '                            pendingLabel.Visible = False
    '                            addUsers.Visible = False
    '                            messageUser.Visible = True
    '                            messageUser.Text = "Message" & " " & dv(0)("FirstName")
    '                        End If

    '                    Else
    '                        pendingLabel.Visible = False
    '                        messageUser.Visible = False
    '                        addUsers.Visible = True
    '                        addUsers.Text = "Add" & " " & dv(0)("FirstName")
    '                    End If
    '                End If
    '            End If
    '            If (Not IsDBNull(dv(0)("MyDistricts"))) Then
    '                myDistrictsLabel.Text = "(" & dv(0)("MyDistricts") & ")"
    '            End If
    '            If (Not IsDBNull(dv(0)("Job"))) Then
    '                jobLabel.Text = dv(0)("Job")
    '            End If

    '            If (Not IsDBNull(dv(0)("DOB"))) Then
    '                birthdateLabel.Text = dv(0)("DOB")
    '            End If

    '            If (Not IsDBNull(dv(0)("AboutMe"))) Then
    '                aboutMeLabel.Text = dv(0)("AboutMe")
    '            End If

    '            If (Not IsDBNull(dv(0)("MyDreams"))) Then
    '                myDreamsLabel.Text = dv(0)("MyDreams")
    '            End If
    '            If (Not IsDBNull(dv(0)("Passions"))) Then
    '                myPassionsLabel.Text = dv(0)("Passions")
    '            End If

    '            If (Not IsDBNull(dv(0)("address"))) Then
    '                residesInLabel.Text = dv(0)("address")
    '            End If
    '            If (Not IsDBNull(dv(0)("city"))) Then
    '                homeTownLabel.Text = dv(0)("city")
    '            End If
    '            If (Not IsDBNull(dv(0)("ActiveCrowdboards"))) Then
    '                MyBoardsLabel.Text = "(" & dv(0)("ActiveCrowdboards") & ")"
    '            End If
    '            If (Not IsDBNull(dv(0)("MyAreas"))) Then
    '                myAreasLabel.Text = "(" & dv(0)("MyAreas") & ")"
    '            End If
    '            If (Not IsDBNull(dv(0)("NetwordSize"))) Then
    '                BoardersLineupLabel.Text = "(" & dv(0)("NetwordSize") & ")"
    '            End If

    '            Dim PendingRequestCount As Integer
    '            Dim MessageCount As Integer
    '            If (Not IsDBNull(dv(0)("PendingRequestCount"))) Then
    '                PendingRequestCount = dv(0)("PendingRequestCount")
    '            End If
    '            If (Not IsDBNull(dv(0)("MessageCount"))) Then
    '                MessageCount = dv(0)("MessageCount")
    '            End If

    '            Dim userName As String = ""
    '            Dim BackgroundImageStyle As String = ""
    '            If (Not IsDBNull(dv(0)("UserName"))) Then
    '                userName = dv(0)("UserName")
    '            End If

    '            If (Not IsDBNull(dv(0)("BackgroundImageStyle"))) Then
    '                BackgroundImageStyle = dv(0)("BackgroundImageStyle")
    '            End If

    '            If (Not IsDBNull(dv(0)("Skills"))) Then
    '                skillsLabel.Text = dv(0)("Skills")
    '            End If
    '            If (Not IsDBNull(dv(0)("WebSite"))) Then
    '                websiteLabel.Text = dv(0)("WebSite")
    '            End If
    '            SetBackgroundImageStyle(userName, BackgroundImageStyle)
    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub

    Private Sub LoadUserInfo()
        Try
            SetProfileAndBackgroundImage()
            RecentActivities()
            Dim dv As Data.DataView = CType(sdUserInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim dv1 As Data.DataView = CType(sdBoarders.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("Name"))) Then
                        nameLabel.Text = dv(0)("Name")
                    End If
                    Dim FirstName As String = ""
                    If (Not IsDBNull(dv(0)("FirstName"))) Then
                        FirstName = dv(0)("FirstName").ToString
                    End If
                    If Request.QueryString("user") IsNot Nothing Then
                        If Not (dv1) Is Nothing Then
                            If (dv1.Count > 0) Then
                                Dim dr As DataRow
                                For Each dr In dv1.Table.Rows
                                    If Session("userName") Is Nothing Then
                                        Response.Redirect("~/Default.aspx", False)
                                        Exit Sub
                                    End If
                                    Dim users As String = ""
                                    If (Not IsDBNull(dr("Users"))) Then
                                        users = dr("Users").ToString().ToUpper()
                                    End If
                                    Dim userID1 As String = Request.QueryString("user").ToLower()
                                    Dim userID2 As String = Session("userName").ToString().ToLower()
                                    If Not userID1 = userID2 Then

                                        If ((Session("userName").ToString().ToUpper() = users) And dr("IsFriend") = 1) Then
                                            pendingLabel.Visible = False
                                            addUsers.Visible = False
                                            messageUser.Visible = True
                                            'messageUser.Text = "Message" & " " & dv(0)("FirstName")
                                            messageUser.Text = "Message"
                                            Exit For
                                        ElseIf (Session("userName").ToString().ToUpper() = users) And dr("IsPending") = 1 Then
                                            pendingLabel.Visible = True
                                            addUsers.Visible = False
                                            messageUser.Visible = False
                                            Exit For
                                        ElseIf (Session("userName").ToString().ToUpper() = users) And dr("IsRejected") = 1 Then
                                            pendingLabel.Visible = False
                                            messageUser.Visible = False
                                            addUsers.Visible = True
                                            'addUsers.Text = "Add" & " " & FirstName
                                            addUsers.Text = "Add"
                                            Exit For
                                        Else
                                            pendingLabel.Visible = False
                                            messageUser.Visible = False
                                            addUsers.Visible = True
                                            'addUsers.Text = "Add" & " " & FirstName
                                            addUsers.Text = "Add"
                                        End If
                                    Else
                                        Exit For
                                    End If
                                Next
                            Else
                                pendingLabel.Visible = False
                                messageUser.Visible = False
                                addUsers.Visible = True
                                'addUsers.Text = "Add" & " " & FirstName
                                addUsers.Text = "Add"
                            End If
                        End If
                    End If
                    If (Not IsDBNull(dv(0)("MyDistricts"))) Then
                        myDistrictsLabel.Text = "(" & dv(0)("MyDistricts") & ")"
                    End If
                    If (Not IsDBNull(dv(0)("Job"))) Then
                        jobLabel.Text = dv(0)("Job")
                    End If
                    If (Not IsDBNull(dv(0)("DOB"))) Then
                        birthdateLabel.Text = dv(0)("DOB")
                    End If
                    If (Not IsDBNull(dv(0)("AboutMe"))) Then
                        aboutMeLabel.Text = dv(0)("AboutMe")
                    End If
                    If (Not IsDBNull(dv(0)("MyDreams"))) Then
                        myDreamsLabel.Text = dv(0)("MyDreams")
                    End If
                    If (Not IsDBNull(dv(0)("Passions"))) Then
                        myPassionsLabel.Text = dv(0)("Passions")
                    End If

                    If Request.QueryString("user") IsNot Nothing Then

                        If ((GetUserID(Request.QueryString("user"))).ToString() = Convert.ToInt32(Session("UserID").ToString())) Then
                            residesInLabel.Visible = True
                            divResides.Visible = True
                            If (Not IsDBNull(dv(0)("address"))) Then
                                residesInLabel.Text = dv(0)("address")
                            End If
                        Else
                            divResides.Visible = False
                            residesInLabel.Visible = False

                        End If

                    Else
                        divResides.Visible = True
                        residesInLabel.Visible = True
                        If (Not IsDBNull(dv(0)("address"))) Then
                            residesInLabel.Text = dv(0)("address")
                        End If
                    End If


                    If (Not IsDBNull(dv(0)("city"))) Then
                        homeTownLabel.Text = dv(0)("city")
                    End If
                    If (Not IsDBNull(dv(0)("ActiveCrowdboards"))) Then
                        MyBoardsLabel.Text = "(" & dv(0)("ActiveCrowdboards") & ")"
                    End If
                    If (Not IsDBNull(dv(0)("MyAreas"))) Then
                        myAreasLabel.Text = "(" & dv(0)("MyAreas") & ")"
                    End If
                    If (Not IsDBNull(dv(0)("NetwordSize"))) Then
                        BoardersLineupLabel.Text = "(" & dv(0)("NetwordSize") & ")"
                    End If

                    Dim PendingRequestCount As Integer
                    Dim MessageCount As Integer
                    If (Not IsDBNull(dv(0)("PendingRequestCount"))) Then
                        PendingRequestCount = dv(0)("PendingRequestCount")
                    End If
                    If (Not IsDBNull(dv(0)("MessageCount"))) Then
                        MessageCount = dv(0)("MessageCount")
                    End If

                    Dim userName As String = ""
                    Dim BackgroundImageStyle As String = ""
                    If (Not IsDBNull(dv(0)("UserName"))) Then
                        userName = dv(0)("UserName")
                    End If

                    If (Not IsDBNull(dv(0)("BackgroundImageStyle"))) Then
                        BackgroundImageStyle = dv(0)("BackgroundImageStyle")
                    End If

                    If (Not IsDBNull(dv(0)("Skills"))) Then
                        skillsLabel.Text = dv(0)("Skills")
                    End If
                    If (Not IsDBNull(dv(0)("WebSite"))) Then
                        websiteLabel.Text = dv(0)("WebSite")
                    End If
                    SetBackgroundImageStyle(userName, BackgroundImageStyle)
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub SetProfileAndBackgroundImage()
        Try
            If Request.QueryString("user") Is Nothing Then
                If Session("userName") Is Nothing Then
                    Response.Redirect("~/Default.aspx", False)
                    Exit Sub
                Else
                    Dim coverPath As String = "~/Upload/BackgroundPics/" & Session("userName").ToString() & ".jpg"
                    If System.IO.File.Exists(Server.MapPath(coverPath)) Then
                        coverPic.ImageUrl = isAvail(coverPath)
                    Else
                        coverPic.ImageUrl = "../WebContent/images/profilebanner.jpeg"
                    End If
                    Dim path As String = "~/Upload/ProfilePics/" & Session("userName").ToString() & ".jpg"
                    profilePic.ImageUrl = isAvail(path)
                    watchProfileImage.ImageUrl = isAvail(path)
                    createProfileImage.ImageUrl = isAvail(path)
                    investedProfileImage.ImageUrl = isAvail(path)
                    commentedProfileImage.ImageUrl = isAvail(path)
                    sdUserInformation.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdRecentPost.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdRcentlyAddedFriend.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoardersLineUp.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdUsersDistricts.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdUserAreas.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())

                    sdsComment.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdsCreatedBoard.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdsInvested.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdsWatched.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())

                    userNameLabel.Text = Session("userName").ToString()
                    userNameLabelActivity.Text = Session("userName").ToString() & "'s Activity"
                    createdBoardNameLable.Text = userNameLabel.Text

                End If
            Else
                Dim coverPath As String = "~/Upload/BackgroundPics/" & Request.QueryString("user").ToString() & ".jpg"
                If System.IO.File.Exists(Server.MapPath(coverPath)) Then
                    coverPic.ImageUrl = isAvail(coverPath)
                Else
                    coverPic.ImageUrl = "../WebContent/images/profilebanner.jpeg"
                End If
                Dim path As String = "~/Upload/ProfilePics/" & Request.QueryString("User") & ".jpg"
                profilePic.ImageUrl = isAvail(path)
                watchProfileImage.ImageUrl = isAvail(path)
                createProfileImage.ImageUrl = isAvail(path)
                investedProfileImage.ImageUrl = isAvail(path)
                commentedProfileImage.ImageUrl = isAvail(path)
                sdUserInformation.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdRecentPost.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdRcentlyAddedFriend.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdBoardersLineUp.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdUsersDistricts.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdUserAreas.SelectParameters.Item("UserID").DefaultValue = Me.UserID

                sdsComment.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdsCreatedBoard.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdsInvested.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdsWatched.SelectParameters.Item("UserID").DefaultValue = Me.UserID
            End If

            Dim dv As Data.DataView = CType(sdsCreatedBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count = 0 Then
                createdBoardDiv.Visible = False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub BoardsFriendsInvestmentsOfUser()
        Try
            If Request.QueryString("user") Is Nothing Then
                If Session("userName") Is Nothing Then
                    Response.Redirect("~/Default.aspx", False)
                    Exit Sub
                Else
                    sdBoardFolio.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdActiveBoards.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoardsInvestedByUser.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                End If
            Else
                sdBoardFolio.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdActiveBoards.SelectParameters.Item("UserID").DefaultValue = Me.UserID

                sdBoarders.SelectParameters.Item("UserID").DefaultValue = Me.UserID
                sdBoardsInvestedByUser.SelectParameters.Item("UserID").DefaultValue = Me.UserID
            End If
            'Dim dv As Data.DataView = CType(sdBoardFolio.Select(DataSourceSelectArguments.Empty), Data.DataView)
            'If Not dv Is Nothing Then
            '    If dv.Count > 0 Then
            '        myBoardfolioLabel.Text = "(" & dv.Count.ToString() & ")"
            '    Else
            '        myBoardfolioLabel.Text = "(0)"
            '    End If
            'Else
            '    myBoardfolioLabel.Text = "(0)"
            'End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub RecentActivities()
        Try
            Dim dv As Data.DataView = CType(sdBoardsInvestedByUser.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("UserName"))) Then
                        investmentLabel.Text = dv(0)("UserName").ToString() & " just invested in "
                    End If
                    If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                        boardLink.NavigateUrl = "~/" & dv(0)("DirectoryName").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("BoardName"))) Then
                        boardLink.Text = dv(0)("BoardName").ToString()
                    End If
                End If
            End If
            Dim dv1 As Data.DataView = CType(sdRcentlyAddedFriend.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv1) Is Nothing Then
                If (dv1.Count > 0) Then
                    Dim recentFriend As String = ""
                    If Not Request.QueryString("user") Is Nothing Then

                        If (Not IsDBNull(dv1(0)("Friends"))) Then
                            recentFriend = dv1(0)("Friends").ToString()
                            userLabel.Text = Request.QueryString("user") & " added " & recentFriend & " as a friend"
                            userLabel.Text = userLabel.Text.Replace(recentFriend, "<a href=Profile.aspx?User=" & dv1(0)("Friends").ToString() & ">" & dv1(0)("Friends").ToString() & "</a>")
                        End If
                    Else
                        If (Not IsDBNull(dv1(0)("Friends"))) Then
                            recentFriend = dv1(0)("Friends").ToString()
                            userLabel.Text = Session("userName").ToString() & " added " & recentFriend & " as a friend"
                            userLabel.Text = userLabel.Text.Replace(recentFriend, "<a href=Profile.aspx?User=" & dv1(0)("Friends").ToString() & ">" & dv1(0)("Friends").ToString() & "</a>")
                        End If
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub addUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addUsers.Click
        Try
            Dim status As Integer = CheckRequest(Me.UserID)
            If status = 3 Then
                sdBoarders.InsertParameters.Item("userID2").DefaultValue = Me.UserID
                sdBoarders.InsertParameters.Item("DateRequested").DefaultValue = System.DateTime.Now
                sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdBoarders.InsertParameters.Item("Status").DefaultValue = False
                sdBoarders.Insert()
                GlobalModule.SetMessage(messageLabel, True, "Request Sent")
                pendingLabel.Visible = True
                addUsers.Visible = False
            ElseIf status = 2 Then
                sdBoarders.UpdateParameters.Item("userID2").DefaultValue = Me.UserID
                sdBoarders.UpdateParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdBoarders.Update()
                GlobalModule.SetMessage(messageLabel, True, "Request Sent")
                pendingLabel.Visible = True
                addUsers.Visible = False
            Else

            End If
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Sending Request")
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
    Protected Sub messageUser_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles messageUser.Click
        messageDiv.Visible = True
    End Sub


    Protected Sub cancelRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cancelRadButton.Click
        Try
            sendMessageRadTexBox.Text = String.Empty
            messageDiv.Visible = False
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub sendMessageRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles sendMessageRadButton.Click
        Try
            If (sendMessageRadTexBox.Text.Trim <> "") Then

                sdMessages.InsertParameters.Item("FromUser").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdMessages.InsertParameters.Item("ToUser").DefaultValue = Me.UserID
                sdMessages.InsertParameters.Item("DateSent").DefaultValue = System.DateTime.Now
                sdMessages.InsertParameters.Item("Text").DefaultValue = sendMessageRadTexBox.Text
                sdMessages.InsertParameters.Item("Unread").DefaultValue = True
                Dim result As Integer = sdMessages.Insert()
                If (result = 1) Then
                    SendUserEmail(Me.UserID)
                    sendMessageRadTexBox.Text = String.Empty
                End If
                messageDiv.Visible = False
            Else
                GlobalModule.SetMessage(sendMessageLabel, False, "Message should not blank")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(sendMessageLabel, False, "Error in Sending Message")
            GlobalModule.ErrorLogFile(ex)
            Exit Sub
        End Try
    End Sub

    Protected Sub activityLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles activityLinkbutton.Click
        surfBoardsRepeater.DataBind()
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Activity"
        ' radMultiPage.SelectedIndex = 0
    End Sub
    Protected Sub boardfolioLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles boardfolioLinkbutton.Click
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Boardfolio"
        ' radMultiPage.SelectedIndex = 1
    End Sub

    Protected Sub districtsLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles districtsLinkbutton.Click
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Districts"
        'radMultiPage.SelectedIndex = 2
    End Sub
    Protected Sub areasLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles areasLinkbutton.Click
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Areas"
        'radMultiPage.SelectedIndex = 3
    End Sub
    Protected Sub crowdboardsLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles crowdboardsLinkbutton.Click
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s CrowdBoards"
        ' radMultiPage.SelectedIndex = 4
    End Sub
    Protected Sub crowdboardsLineupLinkbutton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles crowdboardsLineupLinkbutton.Click
        userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Boarders Lineup"
        ' radMultiPage.SelectedIndex = 5
    End Sub


    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Public Sub SetBackgroundImageStyle(ByVal userName As String, ByVal BackgroundImageStyle As String)
        Try
            Dim pathBackgoundImage As String = "Upload/BackgroundPics/" & userName & ".jpg"
            Dim attributeValue As String = "background-image:url(" & pathBackgoundImage & ");"
            'If Not System.IO.File.Exists(Server.MapPath(pathBackgoundImage)) Then
            '    '  userBody.Attributes.Add("style", "background-color:Black;min-height:664px; width:100%;")
            'Else
            '    'If BackgroundImageStyle = "Stretch" Then

            '    'Else
            '    '    attributeValue &= "background-repeat:repeat;"
            '    'End If
            '    '' userBody.Attributes.Add("style", attributeValue)

            '    attributeValue &= "background-repeat:no-repeat;overflow: hidden; background-size: 100% 100%; height:100%; width:100%;"
            'End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            Dim dv As Data.DataView = CType(sdGetUserId.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    userID = dv(0)("UserID")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function

    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16) As String
        Try

            Dim GM As New GlobalModule
            Return GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, "thumbnail", "thumbs")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Function

    Private Sub RecentComment()
        Try

            Dim dv As Data.DataView = CType(sdsComment.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserName"))) Then
                    commentUserNameLabel.Text = dv(0)("UserName").ToString() & " Commented On "
                    userNameLabelActivity.Text = dv(0)("UserName").ToString().ToUpper & "'s Activity"
                    userNameLabel.Text = dv(0)("UserName").ToString().ToUpper
                End If
                If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                    commentBordNameLinkButton.Text = dv(0)("DirectoryName").ToString()
                    commentBordNameLinkButton.NavigateUrl = "~/" & dv(0)("DirectoryName").ToString()
                End If

                If (Not IsDBNull(dv(0)("Text"))) Then
                    commentTextLabel.Text = dv(0)("Text").ToString()
                End If
                If (Not IsDBNull(dv(0)("CommentDate"))) Then
                    lblCommentDate.Text = Convert.ToDateTime(dv(0)("CommentDate")).ToString("MM/dd/yyyy")
                End If
            Else
                recentCommentTr.Visible = False
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub RecentInvestment()
        Try

            Dim dv As Data.DataView = CType(sdsInvested.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserName"))) Then
                    '  investedUserNameLabel.Text = dv(0)("UserName").ToString() & " Invested " & GetAmount(dv(0)("AmountInvested"), dv(0)("BankLocation")) & " in"
                End If
                If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                    'investedHyperLink.Text = dv(0)("DirectoryName").ToString()
                    'investedHyperLink.NavigateUrl = "~/" & dv(0)("DirectoryName").ToString()
                End If
                If (Not IsDBNull(dv(0)("DateInvested"))) Then
                    ' lblDateInvested.Text = Convert.ToDateTime(dv(0)("DateInvested")).ToString("MM/dd/yyyy")
                End If
            Else
                recentInvestedTr.Visible = False
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Private Sub RecentWatched()
        Try

            Dim dv As Data.DataView = CType(sdsWatched.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserName"))) Then
                    watchUserNameLabel.Text = dv(0)("UserName")
                End If
                If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                    watchBoradNameHyperLink.Text = dv(0)("DirectoryName").ToString()
                    watchBoradNameHyperLink.NavigateUrl = "~/" & dv(0)("DirectoryName").ToString()
                End If

                If (Not IsDBNull(dv(0)("WatchDate"))) Then
                    watchDateLabel.Text = Convert.ToDateTime(dv(0)("WatchDate")).ToString("MM/dd/yyyy")
                End If

            Else
                watchBoardTr.Visible = False
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Private Sub RecentPost()
        Try

            Dim dv As Data.DataView = CType(sdRecentPost.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then

                recentPostTr.Visible = True
            Else
                recentPostTr.Visible = False
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub LoadBoardfolio()
        Try
            If (Me.UserID <> 0) Then
                sdInvestments.SelectParameters.Item("userID").DefaultValue = Me.UserID
            Else
                sdInvestments.SelectParameters.Item("userID").DefaultValue = Convert.ToInt32(Session("UserID"))
            End If

            Dim dv As Data.DataView = CType(sdInvestments.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    myBoardfolioLabel.Text = "(" & dv.Count.ToString() & ")"
                Else
                    myBoardfolioLabel.Text = "(0)"
                End If
            Else
                myBoardfolioLabel.Text = "(0)"
            End If

            boardsInvestedDataList.DataSource = dv
            boardsInvestedDataList.DataBind()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Sub LoadAllBoardsRepeater()
        Try
            If (Me.UserID <> 0) Then
                sdAllBoards.SelectParameters.Item("userID").DefaultValue = Me.UserID
            Else
                sdAllBoards.SelectParameters.Item("userID").DefaultValue = Convert.ToInt32(Session("UserID"))
            End If
            Dim dv As Data.DataView = CType(sdAllBoards.Select(DataSourceSelectArguments.Empty), Data.DataView)
            crowdboardCommandRepeater.DataSource = dv
            crowdboardCommandRepeater.DataBind()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub crowdboardCommandRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles crowdboardCommandRepeater.ItemDataBound
        Try
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("covPicLineup"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If
        Catch ex As Exception

            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub boardsInvestedDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles boardsInvestedDataList.ItemDataBound
        Try
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("boardInvertCoverDiv"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If
        Catch ex As Exception

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

            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName1"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicDiv"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If

            'If hdnYoutubeVideoUrl.Value <> "" Then
            '    ibtnPlay.OnClientClick = "return ShowVideo('" & hdnBoardName.Value & "','" & hdnYoutubeVideoUrl.Value & "');"

            'End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function


    Private Sub SendUserEmail(ByVal userID As String)

        sdsUserEmail.SelectParameters.Item("ToUser").DefaultValue = userID
        Dim dv As Data.DataView = CType(sdsUserEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("userEmail"))) Then
                    If (Not dv(0)("userEmail") = "") Then
                        GlobalModule.SendEmail(dv(0)("userEmail"), "You Have a Message!", "A fellow CrowdBoarder has sent you a message. Login to see what they said:<a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>", True)
                        GlobalModule.SetMessage(sendMessageLabel, True, "Message sent Successfully")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub boardersRepeater_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles boardersRepeater.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                Dim hdnisFriend = TryCast(e.Item.FindControl("hdnisFriend"), HiddenField)
                Dim requestStatus As Integer = Convert.ToInt32(hdnisFriend.Value)
                If (requestStatus = 3) Then
                    sdBoarders.InsertParameters.Item("userID2").DefaultValue = userID2
                    sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.InsertParameters.Item("DateRequested").DefaultValue = System.DateTime.Now()
                    sdBoarders.Insert()
                    GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                    boardersRepeater.DataBind()
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
                        boardersRepeater.DataBind()
                    End If

                End If
            ElseIf (e.CommandName = "IRemoveBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdBoardersLineUp.DeleteParameters.Item("userID2").DefaultValue = userID2
                sdBoardersLineUp.DeleteParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdBoardersLineUp.Delete()
                GlobalModule.SetMessage(lblMessageAddBoarder, True, "Boarder Removed")
                boardersRepeater.DataBind()
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Private Sub SetLabels()
        Try
            userNameLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Activity"
            boardFolioLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Boardfolio"
            districtLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Districts"
            areaLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Areas"
            crowdboarderseLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s CrowdBoards"
            boarderLineupLabelActivity.Text = userNameLabel.Text.ToUpper() & "'s Boarders Lineup"
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub



End Class