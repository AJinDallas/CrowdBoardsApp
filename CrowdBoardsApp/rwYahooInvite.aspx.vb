Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik

Public Class rwYahooInvite
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property contactList() As ArrayList
        Get
            Return CType(ViewState("_englishName"), ArrayList)
        End Get

        Set(ByVal value As ArrayList)
            ViewState("_englishName") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            If Not (Session("yahooContactList")) Is Nothing Then
                Me.contactList = CType(Session("yahooContactList"), ArrayList)
                BindContactList(Me.contactList)
            End If
        End If
    End Sub
    Protected Sub BindContactList(ByVal arr As ArrayList)
        Try
            nonFriendDatalist.DataSource = arr
            nonFriendDatalist.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnSendRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendRequest.Click
        Dim emailsTo As New ArrayList
        Try
            If nonFriendDatalist.Items.Count > 0 Then
                For Each dli As DataListItem In nonFriendDatalist.Items
                    If dli.ItemType = ListItemType.Item OrElse dli.ItemType = ListItemType.AlternatingItem Then
                        Dim cbuser As CheckBox = TryCast(dli.FindControl("cbuser"), CheckBox)
                        Dim hdnFriendEmail As HiddenField = TryCast(dli.FindControl("hdnFriendEmail"), HiddenField)
                        If cbuser.Checked Then
                            emailsTo.Add(hdnFriendEmail.Value)
                        End If
                    End If
                Next
                SendRequest(emailsTo)
                BindContactList(Me.contactList)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendRequest(ByVal Emails As ArrayList)
        Try
            If Not Emails Is Nothing Then

                Dim strSubject As String = "CrowdBoarders Invitation"
                Dim strBody As String = """Hi, your friend " & Session("userName").ToString() & " has invited you to connect with them on CrowdBoarders"" <br>"
                Dim verificationLink As String
                If Not (Session("queryString")) Is Nothing Then
                    verificationLink = "Click  <a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Board.aspx?Name=" & Session("queryString").ToString() & "'>here</a>  to join"
                Else
                    verificationLink = "Click  <a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Default.aspx'>here</a>  to join"
                End If


                strBody = strBody & verificationLink
                For Each strMailTo As String In Emails
                    GlobalModule.SendEmail(strMailTo, strSubject, strBody, True)
                Next
                GlobalModule.SetMessage(lblMessage, True, "Request sent Successfully")
            Else
                GlobalModule.SetMessage(lblMessage, False, "Please Select Contacts")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub cbSelectAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cbSelectAll.CheckedChanged
        Try
            If cbSelectAll.Checked Then
                CheckUncheckAll(True)
            Else
                CheckUncheckAll(False)
            End If
            
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub CheckUncheckAll(ByVal status As Boolean)
        Try
            If nonFriendDatalist.Items.Count > 0 Then
                For Each dli As DataListItem In nonFriendDatalist.Items
                    If dli.ItemType = ListItemType.Item OrElse dli.ItemType = ListItemType.AlternatingItem Then
                        Dim cbuser As CheckBox = TryCast(dli.FindControl("cbuser"), CheckBox)
                        cbuser.Checked = status
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class