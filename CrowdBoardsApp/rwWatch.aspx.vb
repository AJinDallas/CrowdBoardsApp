Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Web.Security
Public Class rwWatch
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property BoardID() As Int32

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
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
    Public Property fromSearchPage() As Int32

        Get
            Return CInt(ViewState("_fromSearchPage"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_fromSearchPage") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("userName") Is Nothing Then
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "Ok('login');", True)
            End If
            If (Not IsPostBack) Then
                If Not Request.QueryString("Name") Is Nothing Then
                    Me.directoryName = Request.QueryString("Name")
                    LoadBoardDescriptionInfo()
                Else
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "Ok('login');", True)
                End If
                If Request.QueryString("fromSearch") = "1" Then
                    Me.fromSearchPage = 1
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Loading Data")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try
            If (Not String.IsNullOrEmpty(Me.directoryName)) Then
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
    Protected Sub btnWatchPublicly_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnWatchPublicly.Click
        Try
            If CheckIsOwner() = 1 Then
                GlobalModule.SetMessage(lblMessage, False, "You cannot watch your own Board")
            Else
                WatchBoard("Public")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in User Login")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnWatchPrivately_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnWatchPrivately.Click
        Try
            If CheckIsOwner() = 1 Then
                GlobalModule.SetMessage(lblMessage, False, "You cannot watch your own Board")
            Else
                WatchBoard("Private")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in User Login")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Protected Sub WatchBoard(ByVal type As String)
        Try
            If type.Trim = "Private" Then
                sdWatchers.SelectParameters.Item("PrivateWatch").DefaultValue = 1
            Else
                sdWatchers.SelectParameters.Item("PrivateWatch").DefaultValue = 0
            End If
            sdWatchers.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
            sdWatchers.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID"))
            Dim dv2 As Data.DataView = CType(sdWatchers.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv2.Count > 0 Then
                If dv2(0)(0) = "0" Then
                    GlobalModule.SetMessage(lblMessage, False, "You are Already Watching this Board")
                Else
                    SendEmailToUser()
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Script", "Ok('Board');", True)
                End If
            End If
        Catch ex As Exception
            Throw ex
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
End Class