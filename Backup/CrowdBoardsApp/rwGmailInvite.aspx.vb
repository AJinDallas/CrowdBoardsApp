Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik
Imports Google.GData.Contacts
Imports Google.GData.Client
Imports Google.GData.Extensions
Imports Google.Contacts
Imports System.IO
Imports System.Drawing


Public Class rwGmailInvite
    Inherits Telerik.Web.UI.RadAjaxPage
    Public Property contactList() As DataSet
        Get
            Return CType(ViewState("_englishName"), DataSet)
        End Get

        Set(ByVal value As DataSet)
            ViewState("_englishName") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then

        End If
    End Sub
    Protected Sub BindContactList(ByVal arr As DataSet)
        Try
            nonFriendDatalist.DataSource = arr
            nonFriendDatalist.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnGetContacts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGetContacts.Click
        Try

            Dim ds As DataSet = GetGmailContacts("MyNetwork Web Application!", txtgmailusername.Text, txtpassword.Text)
            Me.contactList = ds
            BindContactList(Me.contactList)
            contactListDiv.Visible = True
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
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
                Dim strBody As String = "Please click the link below to Join CrowdBoarders<br><br>"
                Dim verificationLink As String = "<a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Default.aspx'>Join Now</a>"
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
    Public Shared Function GetGmailContacts(ByVal App_Name As String, ByVal Uname As String, ByVal UPassword As String) As DataSet
        Dim ds As New DataSet()
        Dim dt As New DataTable()
        Dim C2 As New DataColumn()
        C2.DataType = Type.[GetType]("System.String")
        C2.ColumnName = "EmailID"
        dt.Columns.Add(C2)
        Dim rs As New RequestSettings(App_Name, Uname, UPassword)
        rs.AutoPaging = True
        Dim cr As New ContactsRequest(rs)
        Dim f As Feed(Of Contact) = cr.GetContacts()
        For Each t As Contact In f.Entries
            For Each email As EMail In t.Emails
                Dim dr1 As DataRow = dt.NewRow()
                dr1("EmailID") = email.Address.ToString()
                dt.Rows.Add(dr1)
            Next
        Next
        ds.Tables.Add(dt)
        Return ds
    End Function
End Class