Public Class InsiderNews
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property boardID() As Integer

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
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
    Public Property CurrentPageOwner() As Integer
        Get
            Dim pageNumber As Object = Me.ViewState("CurrentPageOwner")
            If pageNumber Is Nothing Then

                Return 0

            Else
                Return CInt(pageNumber)
            End If
        End Get
        Set(ByVal value As Integer)
            Me.ViewState("CurrentPageOwner") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageOwnerPost.Visible = False
        lblMessageOwnerPost.Visible = False
        lblmessage.Visible = False
        If (Not Page.IsPostBack) Then
            If Request.QueryString.Count > 0 Then
                If Request.QueryString("Name") IsNot Nothing Then
                    Try
                        Me.boardID = getBoardId()
                        Me.DirectoryName = Request.QueryString("Name")
                        'lblCrowdboardName.Text = Me.DirectoryName
                        boardNameLink.Text = Me.DirectoryName
                        boardNameLink.NavigateUrl = "~/Board.aspx?Name=" & Me.DirectoryName
                        If (CheckIsOwner()) Then
                            ownerPostDiv.Visible = True
                        Else
                            investorPostDiv.Visible = True
                        End If
                        LoadInvestorsPosts()
                        LoadOwnerPosts()
                        LoadRecentActivityOnBoard()
                    Catch ex As Exception
                        GlobalModule.SetMessage(lblmessage, False, "Error in Loading Data")
                        GlobalModule.ErrorLogFile(ex)
                    End Try

                End If
            End If
        End If
    End Sub
    Protected Sub LoadRecentActivityOnBoard()
        Try
            sdRecentActivityOnBoard.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadInvestorsPosts()
        Try
            sdBoardInsiderPosts.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoardInsiderPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
            dv.RowFilter = "PostBy='IsInvesterPost'"
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 1
            pagedDataSource.CurrentPageIndex = CurrentPage
            If Not (dv) Is Nothing Then
                If (dv.Count = 0 Or dv.Count < 2) Then
                    btnPrevious.Visible = False
                    btnNext.Visible = False
                Else
                    btnPrevious.Visible = True
                    btnNext.Visible = True
                End If
            Else
                btnPrevious.Visible = False
                btnNext.Visible = False
            End If
            btnPrevious.Enabled = Not pagedDataSource.IsFirstPage
            btnNext.Enabled = Not pagedDataSource.IsLastPage
            investorsPosts.DataSource = pagedDataSource
            investorsPosts.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub LoadOwnerPosts()
        Try
            sdBoardInsiderPosts.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoardInsiderPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
            dv.RowFilter = "PostBy='IsOwnerPost'"
            Dim pagedDataSource As New PagedDataSource()
            pagedDataSource.DataSource = dv
            pagedDataSource.AllowPaging = True
            pagedDataSource.PageSize = 1
            pagedDataSource.CurrentPageIndex = CurrentPageOwner
            If Not (dv) Is Nothing Then
                If (dv.Count = 0 Or dv.Count < 2) Then
                    lbtnPreviousOwnerPosts.Visible = False
                    lbtnNextOwnerPosts.Visible = False
                Else
                    lbtnPreviousOwnerPosts.Visible = True
                    lbtnNextOwnerPosts.Visible = True
                End If
            Else
                lbtnPreviousOwnerPosts.Visible = False
                lbtnNextOwnerPosts.Visible = False
            End If
            lbtnPreviousOwnerPosts.Enabled = Not pagedDataSource.IsFirstPage
            lbtnNextOwnerPosts.Enabled = Not pagedDataSource.IsLastPage
            ownerPosts.DataSource = pagedDataSource
            ownerPosts.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnInvestorPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInvestorPost.Click
        Try
            investorPostTable.Visible = True
            btnInvestorPost.Visible = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtInsiderNews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtInsiderNews.Click
        Try
            Response.Redirect("~/InsiderNews.aspx?Name=" & Me.DirectoryName, False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtInsiderDetails_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtInsiderDetails.Click
        Try
            Response.Redirect("~/InsiderDetails.aspx?Name=" & Me.DirectoryName, False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnSendInvestorPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendInvestorPost.Click
        Try
            If txtInvestorPost.Text <> "" Then
                If (AddInsiderPost(txtInvestorPost.Text) = 1) Then
                    GlobalModule.SetMessage(lblMessageInvestorPost, True, "Post Added Successfully")
                    investorPostTable.Visible = False
                    btnInvestorPost.Visible = True
                    txtInvestorPost.Text = ""
                    LoadInvestorsPosts()
                End If
            Else
                GlobalModule.SetMessage(lblMessageInvestorPost, False, "Please enter text")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnOwnerPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOwnerPost.Click
        Try
            ownerPostTable.Visible = True
            btnOwnerPost.Visible = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageOwnerPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnSendOwnerPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendOwnerPost.Click
        Try
            If txtOwnerPost.Text <> "" Then
                If (AddInsiderPost(txtOwnerPost.Text) = 1) Then
                    GlobalModule.SetMessage(lblMessageOwnerPost, True, "Post Added Successfully")
                    ownerPostTable.Visible = False
                    btnOwnerPost.Visible = True
                    txtOwnerPost.Text = ""
                    LoadOwnerPosts()
                End If
            Else
                GlobalModule.SetMessage(lblMessageOwnerPost, False, "Please enter text")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageOwnerPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCancelInvestorPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelInvestorPost.Click
        Try
            investorPostTable.Visible = False
            txtInvestorPost.Text = ""
            btnInvestorPost.Visible = True
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCancelOwnerPost_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelOwnerPost.Click
        Try
            ownerPostTable.Visible = False
            txtOwnerPost.Text = ""
            btnOwnerPost.Visible = True
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
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
    Protected Sub btnPrevious_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPrevious.Click
        Try
            CurrentPage -= 1
            LoadInvestorsPosts()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNext.Click
        Try
            CurrentPage += 1
            LoadInvestorsPosts()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageInvestorPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnPreviousOwnerPosts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnPreviousOwnerPosts.Click
        Try
            CurrentPageOwner -= 1
            LoadOwnerPosts()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageOwnerPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub lbtnNextOwnerPosts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnNextOwnerPosts.Click
        Try
            CurrentPageOwner += 1
            LoadOwnerPosts()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageOwnerPost, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    'Protected Sub lbtnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLogout.Click
    '    Session.Abandon()
    '    Response.Redirect("~/Default.aspx")
    'End Sub
    'Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
    '    Dim searchBoards = searchBoardsTextBox.Text
    '    Response.Redirect("~/Search.aspx?searchValue=" & searchBoards)
    'End Sub
    'Protected Sub lbtnHome_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnHome.Click
    '    Response.Redirect("~/Home.aspx")
    'End Sub
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
    Private Function CheckIsOwner() As Boolean
        Dim result As Boolean = False
        Try
            sdCheckIsOwner.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdCheckIsOwner.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    If (Convert.ToInt32(dv(0)("UserID")) = Convert.ToInt32(Session("UserID"))) Then
                        result = True
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
End Class