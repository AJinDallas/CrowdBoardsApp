Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.IO
Partial Class BoardOld2
    Inherits Telerik.Web.UI.RadAjaxPage
    Public url As String = ""
    Public Property BoardID() As Int32

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If
        If (Not Page.IsPostBack) Then
            Try
                LoadBoardDescriptionInfo()
                LoadBoardInfo()
                LoadBoardLevels()
                ViewBoardRecord()
                LoadChart()
                CheckWatching()
            Catch ex As Exception
                messageLabel.Visible = True
                messageLabel.Text = "Error in Loading Data"
                messageLabel.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
        RadWindow1.VisibleOnPageLoad = False
    End Sub
    Protected Sub CheckWatching()
        Try
            sdWatching.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdWatching.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            Dim dv2 As Data.DataView = CType(sdWatching.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv2.Count > 0 Then
                If dv2(0)("result") = "IsExist" Then
                    btnStopWatching.Visible = True
                Else
                    btnWatch.Visible = True
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub ViewBoardRecord()
        Try
            sdViewBoard.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdViewBoard.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            Dim dv As DataView = CType(sdViewBoard.Select(DataSourceSelectArguments.Empty), DataView)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub LoadChart()
        Try
            Dim maxValue As Integer = 0
            sdInvestment.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As DataView = CType(sdInvestment.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("AmountInvested"))) Then
                    maxValue = dv.Table.Compute("Max(AmountInvested)", String.Empty)
                End If
                RadChart1.PlotArea.YAxis.MaxValue = maxValue + 100
                RadChart1.DataSource = dv
                RadChart1.DataBind()
                RadChart2.PlotArea.YAxis.MaxValue = maxValue + 100
                RadChart2.DataSource = dv
                RadChart2.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadBoardDescriptionInfo()
        Try
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("BoardID"))) Then
                        Me.BoardID = dv(0)("BoardID")
                    End If
                    imgOwnedBy.Src = isAvail("~/thumbnail/" & Request.QueryString("Name") & ".jpg")
                    If (dv(0)("Status") <> 1) And (dv(0)("UserID") <> Session("UserID")) Then
                        hdnGoback.Value = Request.UrlReferrer.ToString()
                        Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:GoBack();", True)
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub rgBoardComments_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rgBoardComments.NeedDataSource
        Try
            Try
                sdBoardComments.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                Dim dv As Data.DataView = CType(sdBoardComments.Select(DataSourceSelectArguments.Empty), Data.DataView)
                rgBoardComments.DataSource = dv
            Catch ex As Exception
                Throw ex
            End Try
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Loading Comments"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub

    Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
        Response.Redirect("~/Home.aspx")
    End Sub

    Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
        Response.Redirect("~/Search.aspx", False)
    End Sub

    Protected Sub LoadBoardInfo()
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv1 As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv1.Count > 0) Then
                If (Not IsDBNull(dv1(0)("Boardname"))) Then
                    lblBoardName.Text = dv1(0)("Boardname")
                End If
                Dim city As String = IIf(IsDBNull(dv1(0)("city")), "", dv1(0)("city"))
                Dim state As String = IIf(IsDBNull(dv1(0)("state")), "", dv1(0)("state"))
                Dim country As String = IIf(IsDBNull(dv1(0)("country")), "", dv1(0)("country"))
                lblLoacation.Text = GlobalModule.GetAdress("", city, state, country)
                If (Not IsDBNull(dv1(0)("District"))) Then
                    hlkdistrict1.NavigateUrl = "~/Search.aspx?searchValue=" & dv1(0)("District")
                End If
                If (Not IsDBNull(dv1(0)("Watches"))) Then
                    lblWatches.Text = dv1(0)("Watches")
                End If
                If (Not IsDBNull(dv1(0)("Comments"))) Then
                    lblComments.Text = dv1(0)("Comments")
                End If
                If (Not IsDBNull(dv1(0)("Investors"))) Then
                    lblInvestors.Text = dv1(0)("Investors")
                End If
                If (Not IsDBNull(dv1(0)("Seeking"))) Then
                    lblSeeking.Text = dv1(0)("Seeking")
                End If
                If (Not IsDBNull(dv1(0)("Offer"))) Then
                    lblOffer.Text = dv1(0)("Offer")
                End If
                If (Not IsDBNull(dv1(0)("AboutMe"))) Then
                    bleAboutMe.Text = dv1(0)("AboutMe")
                End If
                If (Not IsDBNull(dv1(0)("question1"))) Then
                    question1Label.Text = dv1(0)("question1")
                End If
                If (Not IsDBNull(dv1(0)("answer1"))) Then
                    answer1Label.Text = dv1(0)("answer1")
                End If
                If (Not IsDBNull(dv1(0)("question3"))) Then
                    question3Label.Text = dv1(0)("question3")
                End If
                If (Not IsDBNull(dv1(0)("answer3"))) Then
                    answer3Label.Text = dv1(0)("answer3")
                End If
                If (Not IsDBNull(dv1(0)("question2"))) Then
                    question2Label.Text = dv1(0)("question2")
                End If
                If (Not IsDBNull(dv1(0)("answer2"))) Then
                    answer2Label.Text = dv1(0)("answer2")
                End If
                If (Not IsDBNull(dv1(0)("question4"))) Then
                    question4Label.Text = dv1(0)("question4")
                End If
                If (Not IsDBNull(dv1(0)("answer4"))) Then
                    answer4Label.Text = dv1(0)("answer4")
                End If
                If (Not IsDBNull(dv1(0)("District1"))) Then
                    districtPic.ImageUrl = isAvail("~/Upload/DistrictPics/" & dv1(0)("District1") & ".jpg")
                End If
                If (Not IsDBNull(dv1(0)("InvestmentTypeID"))) Then
                    Dim pathBackgoundImage As String = GetImageURL(dv1(0)("InvestmentTypeID") & ".jpg", 150, 184)
                    Dim attributeValue As String = "background-image:url(" & pathBackgoundImage & ");"
                    attributeValue &= "color: Black;Height:150px;Width:184px;;margin-left: 10px; margin-right: 10px; margin-top: 10px;line-height: 144px; text-align: center;"
                    If (Not IsDBNull(dv1(0)("NoOfBoardLevels"))) Then
                        If dv1(0)("NoOfBoardLevels") = 1 Then
                            level1Div.Attributes.Add("style", attributeValue)
                        ElseIf dv1(0)("NoOfBoardLevels") = 2 Then
                            level1Div.Attributes.Add("style", attributeValue)
                            level2Div.Attributes.Add("style", attributeValue)
                        ElseIf dv1(0)("NoOfBoardLevels") > 2 Then
                            level1Div.Attributes.Add("style", attributeValue)
                            level2Div.Attributes.Add("style", attributeValue)
                            level3Div.Attributes.Add("style", attributeValue)
                        End If
                    End If
                End If
            End If
            sdUpdates.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv As Data.DataView = CType(sdUpdates.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("CommentCount"))) Then
                    lblUpdates.Text = "(" & dv(0)("CommentCount") & ")"
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub LoadBoardLevels()
        Try
            sdLevelAmount.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            Dim dv2 As Data.DataView = CType(sdLevelAmount.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv2.Count > 0 Then
                Dim count As Integer = 0
                Dim dr As DataRow
                For Each dr In dv2.Table.Rows
                    If (Not IsDBNull(dr("LevelAmount"))) Then
                        If count = 0 Then
                            level1.Text = dr("LevelAmount")
                        ElseIf count = 1 Then
                            level2.Text = dr("LevelAmount")
                        ElseIf count = 2 Then
                            level3.Text = dr("LevelAmount")
                        End If
                    End If
                    If (Not IsDBNull(dr("LevelName"))) Then
                        If count = 0 Then
                            Level1Name.Text = dr("LevelName")
                            level1Hl.NavigateUrl = "~/Confirm.aspx?Name=" & Request.QueryString("Name") & "&LevelName=" & dr("LevelName")
                        ElseIf count = 1 Then
                            Level2Name.Text = dr("LevelName")
                            level2Hl.NavigateUrl = "~/Confirm.aspx?Name=" & Request.QueryString("Name") & "&LevelName=" & dr("LevelName")
                        ElseIf count = 2 Then
                            Level3Name.Text = dr("LevelName")
                            level3Hl.NavigateUrl = "~/Confirm.aspx?Name=" & Request.QueryString("Name") & "&LevelName=" & dr("LevelName")
                        End If
                    End If
                    If (Not IsDBNull(dr("Description"))) Then
                        If count = 0 Then
                            level1Description.Text = dr("Description")
                        ElseIf count = 1 Then
                            Level2Description.Text = dr("Description")
                        ElseIf count = 2 Then
                            Level3Description.Text = dr("Description")
                        End If
                    End If
                    count += 1
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Protected Sub lbAddComment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbAddComment.Click
        commentDiv.Visible = True
        lbAddComment.Visible = False
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        txtComment.Text = ""
        lbAddComment.Visible = True
        commentDiv.Visible = False
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Try
            If Not Session("userID") Is Nothing Then
                If CheckBoarderStatus() = 1 Then
                    If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                        Try
                            If txtComment.Text.Trim() <> "" Then
                                sdBoardComments.InsertParameters.Item("Text").DefaultValue = txtComment.Text
                                sdBoardComments.InsertParameters.Item("CommentDate").DefaultValue = System.DateTime.Now
                                sdBoardComments.InsertParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                                sdBoardComments.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                                sdBoardComments.Insert()
                                txtComment.Text = ""
                                commentDiv.Visible = False
                                lblMessageGrid.Visible = True
                                lblMessageGrid.Text = "Comment Added Successfully"
                                lblMessageGrid.ForeColor = Drawing.Color.Green

                                rgBoardComments.Rebind()
                            Else
                                lblMessageGrid.Visible = True
                                lblMessageGrid.Text = "Please Enter Comment"
                                lblMessageGrid.ForeColor = Drawing.Color.Red
                            End If

                        Catch ex As Exception
                            lblMessageGrid.Visible = True
                            lblMessageGrid.Text = "Error in Posting Comment"
                            lblMessageGrid.ForeColor = Drawing.Color.Red
                            GlobalModule.ErrorLogFile(ex)
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
            lblMessageGrid.Visible = True
            lblMessageGrid.Text = "Error in Request"
            lblMessageGrid.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnStopWatching_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnStopWatching.Click
        Try
            sdWatching.UpdateParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdWatching.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
            sdWatching.Update()
            messageLabel.Visible = True
            messageLabel.Text = "You are no longer watching this board"
            messageLabel.ForeColor = Drawing.Color.Green
            btnStopWatching.Visible = False
            btnWatch.Visible = True
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Request"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnWatch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWatch.Click
        Try
            If (Session("userID")) IsNot Nothing Then
                If CheckBoarderStatus() = 1 Then
                    If CheckIsOwner() = 1 Then
                        messageLabel.Visible = True
                        messageLabel.Text = "You cannot watch your own Board"
                        messageLabel.ForeColor = Drawing.Color.Red
                    Else
                        sdWatchers.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
                        sdWatchers.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
                        Dim dv2 As Data.DataView = CType(sdWatchers.Select(DataSourceSelectArguments.Empty), Data.DataView)
                        If dv2.Count > 0 Then
                            If dv2(0)(0) = "0" Then
                                messageLabel.Visible = True
                                messageLabel.Text = "You are Already Watching this Board"
                                messageLabel.ForeColor = Drawing.Color.Red
                            Else
                                btnStopWatching.Visible = True
                                btnWatch.Visible = False
                                messageLabel.Visible = True
                                messageLabel.Text = "Board put on Watch Successfully"
                                messageLabel.ForeColor = Drawing.Color.Green
                            End If
                        End If
                    End If
                Else
                    RadWindow1.NavigateUrl = "~/rwValidateEmail.aspx"
                    RadWindow1.VisibleOnPageLoad = True
                End If
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Request"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
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

    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16) As String
        Try
            Dim fileName As String = fileNameObject.ToString()
            Dim iPath As String = Path.Combine(Server.MapPath("Upload/InvestmentTypePics"), fileName)
            If Not System.IO.File.Exists(iPath) Then
                fileName = "noimage.jpg"
                iPath = Path.Combine(Server.MapPath("Upload/InvestmentTypePics"), fileName)
            End If
            Dim NewPath As String = Path.Combine(Server.MapPath("thumbs"), fileName)
            If Not System.IO.File.Exists(NewPath) Then
                Using img As Image = New Bitmap(iPath)

                    Dim OriginalSize As Size = img.Size
                    Dim NewSize As Size
                    NewSize.Height = desiredHeight 'Maximum desired height
                    NewSize.Width = desiredWidth 'Maximum desired width
                    Dim FinalSize As Size = ProportionalSize(OriginalSize, NewSize)

                    Using img2 As Image = img.GetThumbnailImage(FinalSize.Width, FinalSize.Height, New Image.GetThumbnailImageAbort(AddressOf Abort), IntPtr.Zero)
                        img2.Save(NewPath)
                    End Using
                End Using
            End If
            Return "thumbs/" & fileName
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Function

    Function ProportionalSize(ByVal imageSize As Size, ByVal MaxW_MaxH As Size) As Size
        Try
            Dim ratio = Math.Max(imageSize.Width / MaxW_MaxH.Width, imageSize.Height / MaxW_MaxH.Height)
            imageSize.Width = CInt(imageSize.Width / ratio)
            imageSize.Height = CInt(imageSize.Height / ratio)
            Return imageSize
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Function Abort() As Boolean
        Return False
    End Function
End Class
