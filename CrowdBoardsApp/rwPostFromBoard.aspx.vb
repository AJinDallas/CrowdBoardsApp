Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwPostFromBoard
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property BoardID() As Int32

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
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
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("userName") Is Nothing Then
                Response.Redirect("~/Default.aspx", False)
            End If
            If (Not IsPostBack) Then
                LoadBoardUsers()
                LoadBoardInfo()
            End If
            lblErrorMessage.Text = ""
            lblSuccessMessage.Text = ""
        Catch ex As Exception
            GlobalModule.SetMessage(lblSuccessMessage, False, "Error in Loading Data")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub LoadBoardInfo()
        Try
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("BoardID"))) Then
                        Me.BoardID = dv(0)("BoardID")
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Try
            If Not Session("userID") Is Nothing Then
                If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                    AddBoardComment()
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblSuccessMessage, False, "Error in Posting Comment")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    'Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
    '    RadAjaxManager1.ResponseScripts.Add(" Ok();")
    'End Sub
    Protected Sub AddBoardComment()
        Try
            If txtComment.Text.Trim() <> "" Then
                'sdBoardComments.InsertParameters.Item("Text").DefaultValue = txtComment.Text
                'sdBoardComments.InsertParameters.Item("CommentDate").DefaultValue = System.DateTime.Now
                'sdBoardComments.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
                'sdBoardComments.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                'sdBoardComments.Insert()
                Dim message As String = CheckBoarName(txtComment.Text)
                sdPosts.SelectParameters.Item("Text").DefaultValue = message
                sdPosts.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
                Dim dv As Data.DataView = CType(sdPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If Not dv Is Nothing Then
                    If dv.Count > 0 Then
                        GlobalModule.SetMessage(lblSuccessMessage, True, "Post added Successfully")
                        txtComment.Text = ""
                    Else
                        GlobalModule.SetMessage(lblSuccessMessage, False, "Post not added")
                    End If
                Else
                    GlobalModule.SetMessage(lblSuccessMessage, False, "Error in request")
                End If
               
            Else
                GlobalModule.SetMessage(lblSuccessMessage, False, "Please Enter Post")
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



                'Dim words As String() = postMessage.Split("#")
                'For Each brd As String In boards
                '    If postMessage.Contains("#" + brd.Trim() + "#") AndAlso brd.Trim() <> "" Then


                '    End If
                'Next


                Dim words As String() = postMessage.Split("$")
                If Not (words) Is Nothing Then
                    If (words.Length <> 0) Then
                        For i As Integer = 0 To words.Length - 1
                            'If (i Mod 2 = 0) Then
                            'If Not (words(i).Contains("color:#99CCFF")) Then
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

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class